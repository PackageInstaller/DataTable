return {
	Play411091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411091001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B03e == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B03e")
				var_4_0.name = "B03e"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B03e = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B03e

				arg_1_1.bgs_.B03e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03e" then
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
			local var_4_15 = 1.425

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411091001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 57 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 57)

				if (57 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 57)) > 0 and var_4_15 < var_4_19 then
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
	Play411091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411091002
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
				arg_9_0:Play411091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1095ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1095ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1095ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1095ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1095ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1095ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1095ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1095ui_story == nil then
				arg_9_1.var_.characterEffect1095ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1095ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1095ui_story then
				arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(411091002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 10 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 10)

				if (10 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 10)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091002", "story_v_out_411091.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_411091", "411091002", "story_v_out_411091.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_411091", "411091002", "story_v_out_411091.awb")

						arg_9_1:RecordAudio("411091002", var_12_15)
						arg_9_1:RecordAudio("411091002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_411091", "411091002", "story_v_out_411091.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_411091", "411091002", "story_v_out_411091.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play411091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411091003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) and arg_13_1.var_.characterEffect1095ui_story == nil then
				arg_13_1.var_.characterEffect1095ui_story = arg_13_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) then
				if arg_13_1.var_.characterEffect1095ui_story and not isNil(arg_13_1.actors_["1095ui_story"]) then
					arg_13_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1095ui_story"]) and arg_13_1.var_.characterEffect1095ui_story then
				arg_13_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 1.375

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(411091003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 55 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 55)

				if (55 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 55)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play411091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411091004
		arg_17_1.duration_ = 2.97

		local var_17_0 = {
			zh = 2.966,
			ja = 1.999999999999
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
				arg_17_0:Play411091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1095ui_story = arg_17_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1095ui_story"].transform.position).z)
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1095ui_story"].transform.localEulerAngles = arg_17_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
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
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.15

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
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

				local var_20_6 = arg_17_1:GetWordFromCfg(411091004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 6 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 6)

				if (6 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 6)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091004", "story_v_out_411091.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091004", "story_v_out_411091.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_411091", "411091004", "story_v_out_411091.awb")

						arg_17_1:RecordAudio("411091004", var_20_11)
						arg_17_1:RecordAudio("411091004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_411091", "411091004", "story_v_out_411091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_411091", "411091004", "story_v_out_411091.awb")
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
	Play411091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411091005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411091006(arg_21_1)
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
			local var_24_2 = 1.025

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(411091005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 41 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 41)

				if (41 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 41)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play411091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411091006
		arg_25_1.duration_ = 5.57

		local var_25_0 = {
			zh = 4.066,
			ja = 5.566
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
				arg_25_0:Play411091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = arg_25_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(arg_25_1.actors_["1095ui_story"]) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_28_2 = 0
			local var_28_3 = 0.575

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
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

				local var_28_4 = arg_25_1:GetWordFromCfg(411091006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 23 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 23)

				if (23 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 23)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091006", "story_v_out_411091.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_411091", "411091006", "story_v_out_411091.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_411091", "411091006", "story_v_out_411091.awb")

						arg_25_1:RecordAudio("411091006", var_28_9)
						arg_25_1:RecordAudio("411091006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411091", "411091006", "story_v_out_411091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411091", "411091006", "story_v_out_411091.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411091007
		arg_29_1.duration_ = 7.1

		local var_29_0 = {
			zh = 5.133,
			ja = 7.1
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
				arg_29_0:Play411091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.75

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
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

				local var_32_1 = arg_29_1:GetWordFromCfg(411091007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 30 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 30)

				if (30 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 30)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091007", "story_v_out_411091.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091007", "story_v_out_411091.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_411091", "411091007", "story_v_out_411091.awb")

						arg_29_1:RecordAudio("411091007", var_32_6)
						arg_29_1:RecordAudio("411091007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411091", "411091007", "story_v_out_411091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411091", "411091007", "story_v_out_411091.awb")
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
	Play411091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411091008
		arg_33_1.duration_ = 10.47

		local var_33_0 = {
			zh = 6.566,
			ja = 10.466
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
				arg_33_0:Play411091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_0 = arg_33_1.actors_["1095ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_1 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(var_36_0) then
				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_36_3 = 0
			local var_36_4 = 0.75

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
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

				local var_36_5 = arg_33_1:GetWordFromCfg(411091008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 30 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 30)

				if (30 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 30)) > 0 and var_36_4 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091008", "story_v_out_411091.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_out_411091", "411091008", "story_v_out_411091.awb") / 1000

					if var_36_9 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_3
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_411091", "411091008", "story_v_out_411091.awb")

						arg_33_1:RecordAudio("411091008", var_36_10)
						arg_33_1:RecordAudio("411091008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411091", "411091008", "story_v_out_411091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411091", "411091008", "story_v_out_411091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_11 and arg_33_1.time_ < var_36_3 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play411091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411091009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411091010(arg_37_1)
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

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			local var_40_2 = 0
			local var_40_3 = 1.775

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(411091009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 71 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 71)

				if (71 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 71)) > 0 and var_40_3 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_7 and arg_37_1.time_ < var_40_2 + var_40_7 + arg_40_0 then
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
	Play411091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411091010
		arg_41_1.duration_ = 2.93

		local var_41_0 = {
			zh = 2.933,
			ja = 2.833
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
				arg_41_0:Play411091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_44_0 = 0.533333333333333

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				local var_44_1, var_44_2 = math.modf((arg_41_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_44_2 * 0.13, var_44_2 * 0.13, var_44_2 * 0.13) + arg_41_1.var_.shakeOldPos
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				manager.ui.mainCamera.transform.localPosition = arg_41_1.var_.shakeOldPos
			end

			local var_44_3 = 0
			local var_44_4 = 0.35

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_5 = arg_41_1:GetWordFromCfg(411091010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 14 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 14)

				if (14 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 14)) > 0 and var_44_4 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091010", "story_v_out_411091.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_411091", "411091010", "story_v_out_411091.awb") / 1000

					if var_44_9 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_3
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_411091", "411091010", "story_v_out_411091.awb")

						arg_41_1:RecordAudio("411091010", var_44_10)
						arg_41_1:RecordAudio("411091010", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411091", "411091010", "story_v_out_411091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411091", "411091010", "story_v_out_411091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_11 and arg_41_1.time_ < var_44_3 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play411091011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411091011
		arg_45_1.duration_ = 7

		local var_45_0 = {
			zh = 5.7,
			ja = 7
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
				arg_45_0:Play411091012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1095ui_story = arg_45_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1095ui_story"].transform.position).z)
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1095ui_story"].transform.localEulerAngles = arg_45_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
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
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = 0
			local var_48_5 = 0.65

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
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

				local var_48_6 = arg_45_1:GetWordFromCfg(411091011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 26 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 26)

				if (26 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 26)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091011", "story_v_out_411091.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091011", "story_v_out_411091.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_411091", "411091011", "story_v_out_411091.awb")

						arg_45_1:RecordAudio("411091011", var_48_11)
						arg_45_1:RecordAudio("411091011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_411091", "411091011", "story_v_out_411091.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_411091", "411091011", "story_v_out_411091.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
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
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play411091012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411091012
		arg_49_1.duration_ = 9.03

		local var_49_0 = {
			zh = 8.7,
			ja = 9.033
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
				arg_49_0:Play411091013(arg_49_1)
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
			local var_52_2 = 1.15

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(411091012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 46 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 46)

				if (46 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 46)) > 0 and var_52_2 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091012", "story_v_out_411091.awb") ~= 0 then
					local var_52_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091012", "story_v_out_411091.awb") / 1000

					if var_52_7 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_1
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_411091", "411091012", "story_v_out_411091.awb")

						arg_49_1:RecordAudio("411091012", var_52_8)
						arg_49_1:RecordAudio("411091012", var_52_8)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_411091", "411091012", "story_v_out_411091.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_411091", "411091012", "story_v_out_411091.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_9 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_9 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_9

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_9 and arg_49_1.time_ < var_52_1 + var_52_9 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play411091013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411091013
		arg_53_1.duration_ = 9.33

		local var_53_0 = {
			zh = 9.333,
			ja = 9.066
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
				arg_53_0:Play411091014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(411091013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 42 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 42)

				if (42 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 42)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091013", "story_v_out_411091.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091013", "story_v_out_411091.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_411091", "411091013", "story_v_out_411091.awb")

						arg_53_1:RecordAudio("411091013", var_56_6)
						arg_53_1:RecordAudio("411091013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_411091", "411091013", "story_v_out_411091.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_411091", "411091013", "story_v_out_411091.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play411091014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411091014
		arg_57_1.duration_ = 5.87

		local var_57_0 = {
			zh = 4.666,
			ja = 5.866
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
				arg_57_0:Play411091015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1095ui_story = arg_57_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1095ui_story"].transform.position).z)
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1095ui_story"].transform.localEulerAngles = arg_57_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
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
					arg_57_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1095ui_story then
				arg_57_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.55

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(411091014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 22 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 22)

				if (22 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 22)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091014", "story_v_out_411091.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091014", "story_v_out_411091.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_411091", "411091014", "story_v_out_411091.awb")

						arg_57_1:RecordAudio("411091014", var_60_11)
						arg_57_1:RecordAudio("411091014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_411091", "411091014", "story_v_out_411091.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_411091", "411091014", "story_v_out_411091.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
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
	Play411091015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411091015
		arg_61_1.duration_ = 5.97

		local var_61_0 = {
			zh = 3.266,
			ja = 5.966
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
				arg_61_0:Play411091016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = arg_61_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) then
				if arg_61_1.var_.characterEffect1095ui_story and not isNil(arg_61_1.actors_["1095ui_story"]) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1095ui_story"]) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.275

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(411091015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 11 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 11)

				if (11 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 11)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091015", "story_v_out_411091.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091015", "story_v_out_411091.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_411091", "411091015", "story_v_out_411091.awb")

						arg_61_1:RecordAudio("411091015", var_64_8)
						arg_61_1:RecordAudio("411091015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_411091", "411091015", "story_v_out_411091.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_411091", "411091015", "story_v_out_411091.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play411091016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411091016
		arg_65_1.duration_ = 5.8

		local var_65_0 = {
			zh = 3.833,
			ja = 5.8
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
				arg_65_0:Play411091017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.525

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(411091016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 21 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 21)

				if (21 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 21)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091016", "story_v_out_411091.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091016", "story_v_out_411091.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_411091", "411091016", "story_v_out_411091.awb")

						arg_65_1:RecordAudio("411091016", var_68_6)
						arg_65_1:RecordAudio("411091016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_411091", "411091016", "story_v_out_411091.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_411091", "411091016", "story_v_out_411091.awb")
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
	Play411091017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411091017
		arg_69_1.duration_ = 9

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play411091018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.B01b == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01b")
				var_72_0.name = "B01b"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.B01b = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.B01b

				arg_69_1.bgs_.B01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "B01b" then
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

			local var_72_12 = arg_69_1.actors_["1095ui_story"].transform

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				arg_69_1.var_.moveOldPos1095ui_story = var_72_12.localPosition
			end

			local var_72_13 = 0.001

			if 2 <= arg_69_1.time_ and arg_69_1.time_ < 2 + var_72_13 then
				var_72_12.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 2) / var_72_13)
				var_72_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_12.position).x, (manager.ui.mainCamera.transform.position - var_72_12.position).y, (manager.ui.mainCamera.transform.position - var_72_12.position).z)
				var_72_12.localEulerAngles.z = 0
				var_72_12.localEulerAngles.x = 0
				var_72_12.localEulerAngles = var_72_12.localEulerAngles
			end

			if arg_69_1.time_ >= 2 + var_72_13 and arg_69_1.time_ < 2 + var_72_13 + arg_72_0 then
				var_72_12.localPosition = Vector3.New(0, 100, 0)
				var_72_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_12.position).x, (manager.ui.mainCamera.transform.position - var_72_12.position).y, (manager.ui.mainCamera.transform.position - var_72_12.position).z)
				var_72_12.localEulerAngles.z = 0
				var_72_12.localEulerAngles.x = 0
				var_72_12.localEulerAngles = var_72_12.localEulerAngles
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_72_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_16 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_16

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_16
						arg_69_1.bgmTxt2_.text = var_72_16
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_earthquake_loop", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_18 = 4
			local var_72_19 = 0.625

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_20 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_20:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_69_1.dialogCg_.alpha = arg_74_0
				end))
				var_72_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_21 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(411091017).content)

				arg_69_1.text_.text = var_72_21

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_23 = 25 <= 0 and var_72_19 or var_72_19 * (utf8.len(var_72_21) / 25)

				if (25 <= 0 and var_72_19 or var_72_19 * (utf8.len(var_72_21) / 25)) > 0 and var_72_19 < var_72_23 then
					arg_69_1.talkMaxDuration = var_72_23
					var_72_18 = var_72_18 + 0.3

					if var_72_23 + var_72_18 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_18
					end
				end

				arg_69_1.text_.text = var_72_21
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_24 = var_72_18 + 0.3
			local var_72_25 = math.max(var_72_19, arg_69_1.talkMaxDuration)

			if var_72_18 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_24 + var_72_25 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_24) / var_72_25

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_24 + var_72_25 and arg_69_1.time_ < var_72_24 + var_72_25 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play411091018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 411091018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play411091019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.225

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(411091018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 49 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 49)

				if (49 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 49)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play411091019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411091019
		arg_80_1.duration_ = 2.53

		local var_80_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play411091020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1095ui_story = arg_80_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1095ui_story"].transform.position).z)
				arg_80_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1095ui_story"].transform.localEulerAngles = arg_80_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_80_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1095ui_story"].transform.position).z)
				arg_80_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1095ui_story"].transform.localEulerAngles = arg_80_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1095ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1095ui_story == nil then
				arg_80_1.var_.characterEffect1095ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect1095ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1095ui_story then
				arg_80_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_83_4 = 0
			local var_83_5 = 0.15

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(411091019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 6 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 6)

				if (6 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 6)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091019", "story_v_out_411091.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091019", "story_v_out_411091.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_411091", "411091019", "story_v_out_411091.awb")

						arg_80_1:RecordAudio("411091019", var_83_11)
						arg_80_1:RecordAudio("411091019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_411091", "411091019", "story_v_out_411091.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_411091", "411091019", "story_v_out_411091.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play411091020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411091020
		arg_84_1.duration_ = 3

		local var_84_0 = {
			zh = 3,
			ja = 2.966
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
				arg_84_0:Play411091021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1095ui_story"]) and arg_84_1.var_.characterEffect1095ui_story == nil then
				arg_84_1.var_.characterEffect1095ui_story = arg_84_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1095ui_story"]) then
				if arg_84_1.var_.characterEffect1095ui_story and not isNil(arg_84_1.actors_["1095ui_story"]) then
					arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1095ui_story"]) and arg_84_1.var_.characterEffect1095ui_story then
				arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.2

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(411091020)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 8 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 8)

				if (8 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 8)) > 0 and var_87_2 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091020", "story_v_out_411091.awb") ~= 0 then
					local var_87_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091020", "story_v_out_411091.awb") / 1000

					if var_87_7 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_1
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_411091", "411091020", "story_v_out_411091.awb")

						arg_84_1:RecordAudio("411091020", var_87_8)
						arg_84_1:RecordAudio("411091020", var_87_8)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_411091", "411091020", "story_v_out_411091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_411091", "411091020", "story_v_out_411091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_9 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_9 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_9

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_9 and arg_84_1.time_ < var_87_1 + var_87_9 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play411091021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411091021
		arg_88_1.duration_ = 3.7

		local var_88_0 = {
			zh = 2.4,
			ja = 3.7
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
				arg_88_0:Play411091022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1095ui_story"]) and arg_88_1.var_.characterEffect1095ui_story == nil then
				arg_88_1.var_.characterEffect1095ui_story = arg_88_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1095ui_story"]) then
				if arg_88_1.var_.characterEffect1095ui_story and not isNil(arg_88_1.actors_["1095ui_story"]) then
					arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1095ui_story"]) and arg_88_1.var_.characterEffect1095ui_story then
				arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_91_2 = 0
			local var_91_3 = 0.3

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(411091021)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 12 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 12)

				if (12 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 12)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091021", "story_v_out_411091.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_411091", "411091021", "story_v_out_411091.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_411091", "411091021", "story_v_out_411091.awb")

						arg_88_1:RecordAudio("411091021", var_91_9)
						arg_88_1:RecordAudio("411091021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_411091", "411091021", "story_v_out_411091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_411091", "411091021", "story_v_out_411091.awb")
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
	Play411091022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411091022
		arg_92_1.duration_ = 15.23

		local var_92_0 = {
			zh = 7,
			ja = 15.233
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
				arg_92_0:Play411091023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1095ui_story"]) and arg_92_1.var_.characterEffect1095ui_story == nil then
				arg_92_1.var_.characterEffect1095ui_story = arg_92_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1095ui_story"]) then
				if arg_92_1.var_.characterEffect1095ui_story and not isNil(arg_92_1.actors_["1095ui_story"]) then
					arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1095ui_story"]) and arg_92_1.var_.characterEffect1095ui_story then
				arg_92_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_95_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_92_1.bgmTxt_.text ~= var_95_3 and arg_92_1.bgmTxt_.text ~= "" then
						if arg_92_1.bgmTxt2_.text ~= "" then
							arg_92_1.bgmTxt_.text = arg_92_1.bgmTxt2_.text
						end

						arg_92_1.bgmTxt2_.text = var_95_3

						arg_92_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_92_1.bgmTxt_.text = var_95_3
						arg_92_1.bgmTxt2_.text = var_95_3
					end

					if arg_92_1.bgmTimer then
						arg_92_1.bgmTimer:Stop()

						arg_92_1.bgmTimer = nil
					end

					if arg_92_1.settingData.show_music_name == 1 then
						arg_92_1.musicController:SetSelectedState("show")
						arg_92_1.musicAnimator_:Play("open", 0, 0)

						if arg_92_1.settingData.music_time ~= 0 then
							arg_92_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_92_1.settingData.music_time), function()
								if arg_92_1 == nil or isNil(arg_92_1.bgmTxt_) then
									return
								end

								arg_92_1.musicController:SetSelectedState("hide")
								arg_92_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_92_1.time_ and arg_92_1.time_ <= 0.133333333333333 + arg_95_0 then
				arg_92_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_95_6 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_92_1.bgmTxt_.text ~= var_95_6 and arg_92_1.bgmTxt_.text ~= "" then
						if arg_92_1.bgmTxt2_.text ~= "" then
							arg_92_1.bgmTxt_.text = arg_92_1.bgmTxt2_.text
						end

						arg_92_1.bgmTxt2_.text = var_95_6

						arg_92_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_92_1.bgmTxt_.text = var_95_6
						arg_92_1.bgmTxt2_.text = var_95_6
					end

					if arg_92_1.bgmTimer then
						arg_92_1.bgmTimer:Stop()

						arg_92_1.bgmTimer = nil
					end

					if arg_92_1.settingData.show_music_name == 1 then
						arg_92_1.musicController:SetSelectedState("show")
						arg_92_1.musicAnimator_:Play("open", 0, 0)

						if arg_92_1.settingData.music_time ~= 0 then
							arg_92_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_92_1.settingData.music_time), function()
								if arg_92_1 == nil or isNil(arg_92_1.bgmTxt_) then
									return
								end

								arg_92_1.musicController:SetSelectedState("hide")
								arg_92_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_95_7 = 0
			local var_95_8 = 0.525

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(411091022)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_12 = 21 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 21)

				if (21 <= 0 and var_95_8 or var_95_8 * (utf8.len(var_95_10) / 21)) > 0 and var_95_8 < var_95_12 then
					arg_92_1.talkMaxDuration = var_95_12

					if var_95_12 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_12 + var_95_7
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091022", "story_v_out_411091.awb") ~= 0 then
					local var_95_13 = manager.audio:GetVoiceLength("story_v_out_411091", "411091022", "story_v_out_411091.awb") / 1000

					if var_95_13 + var_95_7 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_7
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_411091", "411091022", "story_v_out_411091.awb")

						arg_92_1:RecordAudio("411091022", var_95_14)
						arg_92_1:RecordAudio("411091022", var_95_14)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_411091", "411091022", "story_v_out_411091.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_411091", "411091022", "story_v_out_411091.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_15 = math.max(var_95_8, arg_92_1.talkMaxDuration)

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_15 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_7) / var_95_15

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_7 + var_95_15 and arg_92_1.time_ < var_95_7 + var_95_15 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play411091023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 411091023
		arg_98_1.duration_ = 7.9

		local var_98_0 = {
			zh = 7.9,
			ja = 4.933
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play411091024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.775

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_1 = arg_98_1:GetWordFromCfg(411091023)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 31 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 31)

				if (31 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 31)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091023", "story_v_out_411091.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091023", "story_v_out_411091.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_411091", "411091023", "story_v_out_411091.awb")

						arg_98_1:RecordAudio("411091023", var_101_6)
						arg_98_1:RecordAudio("411091023", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_411091", "411091023", "story_v_out_411091.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_411091", "411091023", "story_v_out_411091.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play411091024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 411091024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play411091025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.65

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(411091024).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 26 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 26)

				if (26 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 26)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play411091025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 411091025
		arg_106_1.duration_ = 4.47

		local var_106_0 = {
			zh = 4.466,
			ja = 4.266
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play411091026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.425

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(411091025)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 17 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 17)

				if (17 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 17)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091025", "story_v_out_411091.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091025", "story_v_out_411091.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_411091", "411091025", "story_v_out_411091.awb")

						arg_106_1:RecordAudio("411091025", var_109_6)
						arg_106_1:RecordAudio("411091025", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_411091", "411091025", "story_v_out_411091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_411091", "411091025", "story_v_out_411091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play411091026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 411091026
		arg_110_1.duration_ = 7.87

		local var_110_0 = {
			zh = 7.866,
			ja = 7.333
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play411091027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.5

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:GetWordFromCfg(411091026)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 20 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 20)

				if (20 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 20)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091026", "story_v_out_411091.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091026", "story_v_out_411091.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_411091", "411091026", "story_v_out_411091.awb")

						arg_110_1:RecordAudio("411091026", var_113_6)
						arg_110_1:RecordAudio("411091026", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_411091", "411091026", "story_v_out_411091.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_411091", "411091026", "story_v_out_411091.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play411091027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 411091027
		arg_114_1.duration_ = 9.8

		local var_114_0 = {
			zh = 9.8,
			ja = 6.366
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play411091028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.475

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:GetWordFromCfg(411091027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 19 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 19)

				if (19 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 19)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091027", "story_v_out_411091.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091027", "story_v_out_411091.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_411091", "411091027", "story_v_out_411091.awb")

						arg_114_1:RecordAudio("411091027", var_117_6)
						arg_114_1:RecordAudio("411091027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_411091", "411091027", "story_v_out_411091.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_411091", "411091027", "story_v_out_411091.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play411091028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 411091028
		arg_118_1.duration_ = 6.77

		local var_118_0 = {
			zh = 6.766,
			ja = 5.366
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play411091029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.35

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_1 = arg_118_1:GetWordFromCfg(411091028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 14 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 14)

				if (14 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 14)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091028", "story_v_out_411091.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091028", "story_v_out_411091.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_411091", "411091028", "story_v_out_411091.awb")

						arg_118_1:RecordAudio("411091028", var_121_6)
						arg_118_1:RecordAudio("411091028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_411091", "411091028", "story_v_out_411091.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_411091", "411091028", "story_v_out_411091.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play411091029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 411091029
		arg_122_1.duration_ = 3.53

		local var_122_0 = {
			zh = 3.2,
			ja = 3.533
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play411091030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1095ui_story = arg_122_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1095ui_story"].transform.position).z)
				arg_122_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1095ui_story"].transform.localEulerAngles = arg_122_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_122_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1095ui_story"].transform.position).z)
				arg_122_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1095ui_story"].transform.localEulerAngles = arg_122_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["1095ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1095ui_story == nil then
				arg_122_1.var_.characterEffect1095ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect1095ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1095ui_story then
				arg_122_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_125_4 = 0
			local var_125_5 = 0.275

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(411091029)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 11 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 11)

				if (11 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 11)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091029", "story_v_out_411091.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091029", "story_v_out_411091.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_411091", "411091029", "story_v_out_411091.awb")

						arg_122_1:RecordAudio("411091029", var_125_11)
						arg_122_1:RecordAudio("411091029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_411091", "411091029", "story_v_out_411091.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_411091", "411091029", "story_v_out_411091.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play411091030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 411091030
		arg_126_1.duration_ = 8.97

		local var_126_0 = {
			zh = 8.966,
			ja = 8.733
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play411091031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.825

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(411091030)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 33 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 33)

				if (33 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 33)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091030", "story_v_out_411091.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091030", "story_v_out_411091.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_411091", "411091030", "story_v_out_411091.awb")

						arg_126_1:RecordAudio("411091030", var_129_6)
						arg_126_1:RecordAudio("411091030", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_411091", "411091030", "story_v_out_411091.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_411091", "411091030", "story_v_out_411091.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play411091031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 411091031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play411091032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1095ui_story"]) and arg_130_1.var_.characterEffect1095ui_story == nil then
				arg_130_1.var_.characterEffect1095ui_story = arg_130_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1095ui_story"]) then
				if arg_130_1.var_.characterEffect1095ui_story and not isNil(arg_130_1.actors_["1095ui_story"]) then
					arg_130_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_0)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1095ui_story"]) and arg_130_1.var_.characterEffect1095ui_story then
				arg_130_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_133_1 = 0
			local var_133_2 = 0.65

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_3 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(411091031).content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 26 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 26)

				if (26 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 26)) > 0 and var_133_2 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_6 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_6 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_6

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_6 and arg_130_1.time_ < var_133_1 + var_133_6 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play411091032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 411091032
		arg_134_1.duration_ = 5.97

		local var_134_0 = {
			zh = 5.966,
			ja = 3.266
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play411091033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1095ui_story"]) and arg_134_1.var_.characterEffect1095ui_story == nil then
				arg_134_1.var_.characterEffect1095ui_story = arg_134_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1095ui_story"]) then
				if arg_134_1.var_.characterEffect1095ui_story and not isNil(arg_134_1.actors_["1095ui_story"]) then
					arg_134_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1095ui_story"]) and arg_134_1.var_.characterEffect1095ui_story then
				arg_134_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_137_2 = 0
			local var_137_3 = 0.55

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:GetWordFromCfg(411091032)
				local var_137_5 = arg_134_1:FormatText(var_137_4.content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 22 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 22)

				if (22 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 22)) > 0 and var_137_3 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091032", "story_v_out_411091.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_411091", "411091032", "story_v_out_411091.awb") / 1000

					if var_137_8 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_2
					end

					if var_137_4.prefab_name ~= "" and arg_134_1.actors_[var_137_4.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_4.prefab_name].transform, "story_v_out_411091", "411091032", "story_v_out_411091.awb")

						arg_134_1:RecordAudio("411091032", var_137_9)
						arg_134_1:RecordAudio("411091032", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_411091", "411091032", "story_v_out_411091.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_411091", "411091032", "story_v_out_411091.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_10 and arg_134_1.time_ < var_137_2 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play411091033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 411091033
		arg_138_1.duration_ = 6.33

		local var_138_0 = {
			zh = 4.266,
			ja = 6.333
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play411091034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1095ui_story"]) and arg_138_1.var_.characterEffect1095ui_story == nil then
				arg_138_1.var_.characterEffect1095ui_story = arg_138_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1095ui_story"]) then
				if arg_138_1.var_.characterEffect1095ui_story and not isNil(arg_138_1.actors_["1095ui_story"]) then
					arg_138_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1095ui_story"]) and arg_138_1.var_.characterEffect1095ui_story then
				arg_138_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.175

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:GetWordFromCfg(411091033)
				local var_141_4 = arg_138_1:FormatText(var_141_3.content)

				arg_138_1.text_.text = var_141_4

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 7 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 7)

				if (7 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_4) / 7)) > 0 and var_141_2 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_4
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091033", "story_v_out_411091.awb") ~= 0 then
					local var_141_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091033", "story_v_out_411091.awb") / 1000

					if var_141_7 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_1
					end

					if var_141_3.prefab_name ~= "" and arg_138_1.actors_[var_141_3.prefab_name] ~= nil then
						local var_141_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_3.prefab_name].transform, "story_v_out_411091", "411091033", "story_v_out_411091.awb")

						arg_138_1:RecordAudio("411091033", var_141_8)
						arg_138_1:RecordAudio("411091033", var_141_8)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_411091", "411091033", "story_v_out_411091.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_411091", "411091033", "story_v_out_411091.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_9 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_9 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_9

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_9 and arg_138_1.time_ < var_141_1 + var_141_9 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play411091034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 411091034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play411091035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1095ui_story = arg_142_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_145_0 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 then
				arg_142_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_0)
				arg_142_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1095ui_story"].transform.position).z)
				arg_142_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1095ui_story"].transform.localEulerAngles = arg_142_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 then
				arg_142_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_142_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1095ui_story"].transform.position).z)
				arg_142_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1095ui_story"].transform.localEulerAngles = arg_142_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_145_1 = 0
			local var_145_2 = 1.075

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(411091034).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 43 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 43)

				if (43 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 43)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play411091035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 411091035
		arg_146_1.duration_ = 11.97

		local var_146_0 = {
			zh = 11.9666666666667,
			ja = 8.53266666666667
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play411091036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_0 = 2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				local var_149_1 = Color.New(0, 0, 0)

				var_149_1.a = Mathf.Lerp(0, 1, (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.mask_.color = var_149_1
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				local var_149_2 = Color.New(0, 0, 0)

				var_149_2.a = 1
				arg_146_1.mask_.color = var_149_2
			end

			local var_149_3 = 2

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= var_149_3 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_4 = 1.36666666666667

			if var_149_3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_3 + var_149_4 then
				local var_149_5 = Color.New(0, 0, 0)

				var_149_5.a = Mathf.Lerp(1, 0, (arg_146_1.time_ - var_149_3) / var_149_4)
				arg_146_1.mask_.color = var_149_5
			end

			if arg_146_1.time_ >= var_149_3 + var_149_4 and arg_146_1.time_ < var_149_3 + var_149_4 + arg_149_0 then
				local var_149_6 = Color.New(0, 0, 0)

				arg_146_1.mask_.enabled = false
				var_149_6.a = 0
				arg_146_1.mask_.color = var_149_6
			end

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= 2 + arg_149_0 then
				local var_149_7 = arg_146_1.bgs_.B01b

				arg_146_1.bgs_.B01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_149_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_149_8 = var_149_7:GetComponent("SpriteRenderer")

				if var_149_8 and var_149_8.sprite then
					local var_149_9 = 2 * (var_149_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_149_7.transform.localScale = Vector3.New(var_149_9 / var_149_8.sprite.bounds.size.y < var_149_9 * manager.ui.mainCameraCom_.aspect / var_149_8.sprite.bounds.size.x and var_149_9 * manager.ui.mainCameraCom_.aspect / var_149_8.sprite.bounds.size.x or var_149_9 / var_149_8.sprite.bounds.size.y, var_149_9 / var_149_8.sprite.bounds.size.y < var_149_9 * manager.ui.mainCameraCom_.aspect / var_149_8.sprite.bounds.size.x and var_149_9 * manager.ui.mainCameraCom_.aspect / var_149_8.sprite.bounds.size.x or var_149_9 / var_149_8.sprite.bounds.size.y, 0)
				end

				for iter_149_0, iter_149_1 in pairs(arg_146_1.bgs_) do
					if iter_149_0 ~= "B01b" then
						iter_149_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_10 = 3.36666666666667
			local var_149_11 = 0.6

			if 3.36666666666667 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_12 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_12:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_13 = arg_146_1:GetWordFromCfg(411091035)
				local var_149_14 = arg_146_1:FormatText(var_149_13.content)

				arg_146_1.text_.text = var_149_14

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_16 = 24 <= 0 and var_149_11 or var_149_11 * (utf8.len(var_149_14) / 24)

				if (24 <= 0 and var_149_11 or var_149_11 * (utf8.len(var_149_14) / 24)) > 0 and var_149_11 < var_149_16 then
					arg_146_1.talkMaxDuration = var_149_16
					var_149_10 = var_149_10 + 0.3

					if var_149_16 + var_149_10 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_16 + var_149_10
					end
				end

				arg_146_1.text_.text = var_149_14
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091035", "story_v_out_411091.awb") ~= 0 then
					local var_149_17 = manager.audio:GetVoiceLength("story_v_out_411091", "411091035", "story_v_out_411091.awb") / 1000

					if var_149_17 + var_149_10 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_17 + var_149_10
					end

					if var_149_13.prefab_name ~= "" and arg_146_1.actors_[var_149_13.prefab_name] ~= nil then
						local var_149_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_13.prefab_name].transform, "story_v_out_411091", "411091035", "story_v_out_411091.awb")

						arg_146_1:RecordAudio("411091035", var_149_18)
						arg_146_1:RecordAudio("411091035", var_149_18)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_411091", "411091035", "story_v_out_411091.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_411091", "411091035", "story_v_out_411091.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_19 = var_149_10 + 0.3
			local var_149_20 = math.max(var_149_11, arg_146_1.talkMaxDuration)

			if var_149_10 + 0.3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_19 + var_149_20 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_19) / var_149_20

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_19 + var_149_20 and arg_146_1.time_ < var_149_19 + var_149_20 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play411091036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411091036
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play411091037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.675

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(411091036).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 27)

				if (27 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 27)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play411091037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 411091037
		arg_156_1.duration_ = 2.67

		local var_156_0 = {
			zh = 2.666,
			ja = 1.5
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play411091038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.125

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:GetWordFromCfg(411091037)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 5 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 5)

				if (5 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 5)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091037", "story_v_out_411091.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091037", "story_v_out_411091.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_411091", "411091037", "story_v_out_411091.awb")

						arg_156_1:RecordAudio("411091037", var_159_6)
						arg_156_1:RecordAudio("411091037", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_411091", "411091037", "story_v_out_411091.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_411091", "411091037", "story_v_out_411091.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play411091038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 411091038
		arg_160_1.duration_ = 5.9

		local var_160_0 = {
			zh = 5.2,
			ja = 5.9
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play411091039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.525

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:GetWordFromCfg(411091038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 21 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 21)

				if (21 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 21)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091038", "story_v_out_411091.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091038", "story_v_out_411091.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_411091", "411091038", "story_v_out_411091.awb")

						arg_160_1:RecordAudio("411091038", var_163_6)
						arg_160_1:RecordAudio("411091038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_411091", "411091038", "story_v_out_411091.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_411091", "411091038", "story_v_out_411091.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play411091039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 411091039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play411091040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.1

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(411091039).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 44 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 44)

				if (44 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 44)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play411091040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 411091040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play411091041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.925

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(411091040).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 37 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 37)

				if (37 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 37)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play411091041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 411091041
		arg_172_1.duration_ = 6.07

		local var_172_0 = {
			zh = 6.066,
			ja = 5.9
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
				arg_172_0:Play411091042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1095ui_story = arg_172_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1095ui_story"].transform.position).z)
				arg_172_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1095ui_story"].transform.localEulerAngles = arg_172_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_172_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1095ui_story"].transform.position).z)
				arg_172_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1095ui_story"].transform.localEulerAngles = arg_172_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_175_1 = arg_172_1.actors_["1095ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1095ui_story == nil then
				arg_172_1.var_.characterEffect1095ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 and not isNil(var_175_1) then
				if arg_172_1.var_.characterEffect1095ui_story and not isNil(var_175_1) then
					arg_172_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1095ui_story then
				arg_172_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_175_4 = 0
			local var_175_5 = 0.625

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:GetWordFromCfg(411091041)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 25 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 25)

				if (25 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 25)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091041", "story_v_out_411091.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091041", "story_v_out_411091.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_out_411091", "411091041", "story_v_out_411091.awb")

						arg_172_1:RecordAudio("411091041", var_175_11)
						arg_172_1:RecordAudio("411091041", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_411091", "411091041", "story_v_out_411091.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_411091", "411091041", "story_v_out_411091.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
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

		arg_172_1:InitPlayNodeList()
	end,
	Play411091042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 411091042
		arg_176_1.duration_ = 7.93

		local var_176_0 = {
			zh = 7.933,
			ja = 7.9
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
				arg_176_0:Play411091043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1095ui_story"]) and arg_176_1.var_.characterEffect1095ui_story == nil then
				arg_176_1.var_.characterEffect1095ui_story = arg_176_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1095ui_story"]) then
				if arg_176_1.var_.characterEffect1095ui_story and not isNil(arg_176_1.actors_["1095ui_story"]) then
					arg_176_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1095ui_story"]) and arg_176_1.var_.characterEffect1095ui_story then
				arg_176_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_179_2 = 0
			local var_179_3 = 0.85

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(411091042)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 34 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 34)

				if (34 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 34)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091042", "story_v_out_411091.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_411091", "411091042", "story_v_out_411091.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_411091", "411091042", "story_v_out_411091.awb")

						arg_176_1:RecordAudio("411091042", var_179_9)
						arg_176_1:RecordAudio("411091042", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_411091", "411091042", "story_v_out_411091.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_411091", "411091042", "story_v_out_411091.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play411091043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 411091043
		arg_180_1.duration_ = 2.9

		local var_180_0 = {
			zh = 2.9,
			ja = 2.5
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play411091044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.325

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:GetWordFromCfg(411091043)
				local var_183_2 = arg_180_1:FormatText(var_183_1.content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 13 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 13)

				if (13 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 13)) > 0 and var_183_0 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091043", "story_v_out_411091.awb") ~= 0 then
					local var_183_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091043", "story_v_out_411091.awb") / 1000

					if var_183_5 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + 0
					end

					if var_183_1.prefab_name ~= "" and arg_180_1.actors_[var_183_1.prefab_name] ~= nil then
						local var_183_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_1.prefab_name].transform, "story_v_out_411091", "411091043", "story_v_out_411091.awb")

						arg_180_1:RecordAudio("411091043", var_183_6)
						arg_180_1:RecordAudio("411091043", var_183_6)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_411091", "411091043", "story_v_out_411091.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_411091", "411091043", "story_v_out_411091.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play411091044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 411091044
		arg_184_1.duration_ = 2

		local var_184_0 = {
			zh = 2,
			ja = 1.733
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play411091045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1095ui_story"]) and arg_184_1.var_.characterEffect1095ui_story == nil then
				arg_184_1.var_.characterEffect1095ui_story = arg_184_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1095ui_story"]) then
				if arg_184_1.var_.characterEffect1095ui_story and not isNil(arg_184_1.actors_["1095ui_story"]) then
					arg_184_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1095ui_story"]) and arg_184_1.var_.characterEffect1095ui_story then
				arg_184_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.2

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(411091044)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_6 = 8 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_4) / 8)

				if (8 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_4) / 8)) > 0 and var_187_2 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091044", "story_v_out_411091.awb") ~= 0 then
					local var_187_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091044", "story_v_out_411091.awb") / 1000

					if var_187_7 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_1
					end

					if var_187_3.prefab_name ~= "" and arg_184_1.actors_[var_187_3.prefab_name] ~= nil then
						local var_187_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_3.prefab_name].transform, "story_v_out_411091", "411091044", "story_v_out_411091.awb")

						arg_184_1:RecordAudio("411091044", var_187_8)
						arg_184_1:RecordAudio("411091044", var_187_8)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_411091", "411091044", "story_v_out_411091.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_411091", "411091044", "story_v_out_411091.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_9 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_9 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_9

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_9 and arg_184_1.time_ < var_187_1 + var_187_9 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play411091045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 411091045
		arg_188_1.duration_ = 11.27

		local var_188_0 = {
			zh = 9.4,
			ja = 11.266
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play411091046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1095ui_story = arg_188_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_191_0 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 then
				arg_188_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_188_1.time_ - 0) / var_191_0)
				arg_188_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).z)
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles = arg_188_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 then
				arg_188_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_188_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).z)
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles = arg_188_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_191_1 = arg_188_1.actors_["1095ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect1095ui_story == nil then
				arg_188_1.var_.characterEffect1095ui_story = var_191_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_2 and not isNil(var_191_1) then
				if arg_188_1.var_.characterEffect1095ui_story and not isNil(var_191_1) then
					arg_188_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_2 and arg_188_1.time_ < 0 + var_191_2 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect1095ui_story then
				arg_188_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_191_4 = 0
			local var_191_5 = 0.95

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_4 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_6 = arg_188_1:GetWordFromCfg(411091045)
				local var_191_7 = arg_188_1:FormatText(var_191_6.content)

				arg_188_1.text_.text = var_191_7

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_9 = 38 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 38)

				if (38 <= 0 and var_191_5 or var_191_5 * (utf8.len(var_191_7) / 38)) > 0 and var_191_5 < var_191_9 then
					arg_188_1.talkMaxDuration = var_191_9

					if var_191_9 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_4
					end
				end

				arg_188_1.text_.text = var_191_7
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091045", "story_v_out_411091.awb") ~= 0 then
					local var_191_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091045", "story_v_out_411091.awb") / 1000

					if var_191_10 + var_191_4 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_4
					end

					if var_191_6.prefab_name ~= "" and arg_188_1.actors_[var_191_6.prefab_name] ~= nil then
						local var_191_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_6.prefab_name].transform, "story_v_out_411091", "411091045", "story_v_out_411091.awb")

						arg_188_1:RecordAudio("411091045", var_191_11)
						arg_188_1:RecordAudio("411091045", var_191_11)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_411091", "411091045", "story_v_out_411091.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_411091", "411091045", "story_v_out_411091.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_12 = math.max(var_191_5, arg_188_1.talkMaxDuration)

			if var_191_4 <= arg_188_1.time_ and arg_188_1.time_ < var_191_4 + var_191_12 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_4) / var_191_12

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_4 + var_191_12 and arg_188_1.time_ < var_191_4 + var_191_12 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
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

		arg_188_1:InitPlayNodeList()
	end,
	Play411091046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 411091046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play411091047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1095ui_story = arg_192_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_195_0 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 then
				arg_192_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_0)
				arg_192_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1095ui_story"].transform.position).z)
				arg_192_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1095ui_story"].transform.localEulerAngles = arg_192_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 then
				arg_192_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1095ui_story"].transform.position).z)
				arg_192_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1095ui_story"].transform.localEulerAngles = arg_192_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_195_1 = 0
			local var_195_2 = 0.75

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(411091046).content)

				arg_192_1.text_.text = var_195_3

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 30 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 30)

				if (30 <= 0 and var_195_2 or var_195_2 * (utf8.len(var_195_3) / 30)) > 0 and var_195_2 < var_195_5 then
					arg_192_1.talkMaxDuration = var_195_5

					if var_195_5 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + var_195_1
					end
				end

				arg_192_1.text_.text = var_195_3
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_6 = math.max(var_195_2, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_6 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_1) / var_195_6

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_6 and arg_192_1.time_ < var_195_1 + var_195_6 + arg_195_0 then
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
	Play411091047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 411091047
		arg_196_1.duration_ = 9.1

		local var_196_0 = {
			zh = 6.566,
			ja = 9.1
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play411091048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1095ui_story = arg_196_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_199_0 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				arg_196_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).z)
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles = arg_196_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				arg_196_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_196_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1095ui_story"].transform.position).z)
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1095ui_story"].transform.localEulerAngles = arg_196_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_199_1 = arg_196_1.actors_["1095ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1095ui_story == nil then
				arg_196_1.var_.characterEffect1095ui_story = var_199_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_2 and not isNil(var_199_1) then
				if arg_196_1.var_.characterEffect1095ui_story and not isNil(var_199_1) then
					arg_196_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_2 and arg_196_1.time_ < 0 + var_199_2 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1095ui_story then
				arg_196_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_199_4 = 0
			local var_199_5 = 0.775

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(411091047)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 31 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 31)

				if (31 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 31)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091047", "story_v_out_411091.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091047", "story_v_out_411091.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_out_411091", "411091047", "story_v_out_411091.awb")

						arg_196_1:RecordAudio("411091047", var_199_11)
						arg_196_1:RecordAudio("411091047", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_411091", "411091047", "story_v_out_411091.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_411091", "411091047", "story_v_out_411091.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
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

		arg_196_1:InitPlayNodeList()
	end,
	Play411091048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 411091048
		arg_200_1.duration_ = 3.53

		local var_200_0 = {
			zh = 3.533,
			ja = 3.5
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
				arg_200_0:Play411091049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1095ui_story"]) and arg_200_1.var_.characterEffect1095ui_story == nil then
				arg_200_1.var_.characterEffect1095ui_story = arg_200_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1095ui_story"]) then
				if arg_200_1.var_.characterEffect1095ui_story and not isNil(arg_200_1.actors_["1095ui_story"]) then
					arg_200_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1095ui_story"]) and arg_200_1.var_.characterEffect1095ui_story then
				arg_200_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_203_1 = 0
			local var_203_2 = 0.35

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(411091048)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_6 = 14 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_4) / 14)

				if (14 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_4) / 14)) > 0 and var_203_2 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_1
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091048", "story_v_out_411091.awb") ~= 0 then
					local var_203_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091048", "story_v_out_411091.awb") / 1000

					if var_203_7 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_1
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_411091", "411091048", "story_v_out_411091.awb")

						arg_200_1:RecordAudio("411091048", var_203_8)
						arg_200_1:RecordAudio("411091048", var_203_8)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_411091", "411091048", "story_v_out_411091.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_411091", "411091048", "story_v_out_411091.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_9 = math.max(var_203_2, arg_200_1.talkMaxDuration)

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_9 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_1) / var_203_9

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_1 + var_203_9 and arg_200_1.time_ < var_203_1 + var_203_9 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play411091049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 411091049
		arg_204_1.duration_ = 3.2

		local var_204_0 = {
			zh = 3.1,
			ja = 3.2
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
				arg_204_0:Play411091050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos1095ui_story = arg_204_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_207_0 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 then
				arg_204_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_204_1.time_ - 0) / var_207_0)
				arg_204_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1095ui_story"].transform.position).z)
				arg_204_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1095ui_story"].transform.localEulerAngles = arg_204_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 then
				arg_204_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_204_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["1095ui_story"].transform.position).z)
				arg_204_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["1095ui_story"].transform.localEulerAngles = arg_204_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_207_1 = arg_204_1.actors_["1095ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1095ui_story == nil then
				arg_204_1.var_.characterEffect1095ui_story = var_207_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_2 and not isNil(var_207_1) then
				if arg_204_1.var_.characterEffect1095ui_story and not isNil(var_207_1) then
					arg_204_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_2 and arg_204_1.time_ < 0 + var_207_2 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect1095ui_story then
				arg_204_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_207_4 = 0
			local var_207_5 = 0.325

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
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

				local var_207_6 = arg_204_1:GetWordFromCfg(411091049)
				local var_207_7 = arg_204_1:FormatText(var_207_6.content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 13 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 13)

				if (13 <= 0 and var_207_5 or var_207_5 * (utf8.len(var_207_7) / 13)) > 0 and var_207_5 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_4
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091049", "story_v_out_411091.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091049", "story_v_out_411091.awb") / 1000

					if var_207_10 + var_207_4 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_4
					end

					if var_207_6.prefab_name ~= "" and arg_204_1.actors_[var_207_6.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_6.prefab_name].transform, "story_v_out_411091", "411091049", "story_v_out_411091.awb")

						arg_204_1:RecordAudio("411091049", var_207_11)
						arg_204_1:RecordAudio("411091049", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_411091", "411091049", "story_v_out_411091.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_411091", "411091049", "story_v_out_411091.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_5, arg_204_1.talkMaxDuration)

			if var_207_4 <= arg_204_1.time_ and arg_204_1.time_ < var_207_4 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_4) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_4 + var_207_12 and arg_204_1.time_ < var_207_4 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play411091050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 411091050
		arg_208_1.duration_ = 8.33

		local var_208_0 = {
			zh = 8.333,
			ja = 7.266
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
				arg_208_0:Play411091051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1095ui_story"]) and arg_208_1.var_.characterEffect1095ui_story == nil then
				arg_208_1.var_.characterEffect1095ui_story = arg_208_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1095ui_story"]) then
				if arg_208_1.var_.characterEffect1095ui_story and not isNil(arg_208_1.actors_["1095ui_story"]) then
					arg_208_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1095ui_story"]) and arg_208_1.var_.characterEffect1095ui_story then
				arg_208_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 0.85

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:GetWordFromCfg(411091050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_6 = 34 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 34)

				if (34 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_4) / 34)) > 0 and var_211_2 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091050", "story_v_out_411091.awb") ~= 0 then
					local var_211_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091050", "story_v_out_411091.awb") / 1000

					if var_211_7 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_1
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_411091", "411091050", "story_v_out_411091.awb")

						arg_208_1:RecordAudio("411091050", var_211_8)
						arg_208_1:RecordAudio("411091050", var_211_8)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_411091", "411091050", "story_v_out_411091.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_411091", "411091050", "story_v_out_411091.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_9 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_9 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_9

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_9 and arg_208_1.time_ < var_211_1 + var_211_9 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play411091051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 411091051
		arg_212_1.duration_ = 9.1

		local var_212_0 = {
			zh = 8.166,
			ja = 9.1
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
				arg_212_0:Play411091052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1095ui_story"]) and arg_212_1.var_.characterEffect1095ui_story == nil then
				arg_212_1.var_.characterEffect1095ui_story = arg_212_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1095ui_story"]) then
				if arg_212_1.var_.characterEffect1095ui_story and not isNil(arg_212_1.actors_["1095ui_story"]) then
					arg_212_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1095ui_story"]) and arg_212_1.var_.characterEffect1095ui_story then
				arg_212_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_215_2 = 0
			local var_215_3 = 0.975

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
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

				local var_215_4 = arg_212_1:GetWordFromCfg(411091051)
				local var_215_5 = arg_212_1:FormatText(var_215_4.content)

				arg_212_1.text_.text = var_215_5

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_7 = 39 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 39)

				if (39 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 39)) > 0 and var_215_3 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_2
					end
				end

				arg_212_1.text_.text = var_215_5
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091051", "story_v_out_411091.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_411091", "411091051", "story_v_out_411091.awb") / 1000

					if var_215_8 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_2
					end

					if var_215_4.prefab_name ~= "" and arg_212_1.actors_[var_215_4.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_4.prefab_name].transform, "story_v_out_411091", "411091051", "story_v_out_411091.awb")

						arg_212_1:RecordAudio("411091051", var_215_9)
						arg_212_1:RecordAudio("411091051", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_411091", "411091051", "story_v_out_411091.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_411091", "411091051", "story_v_out_411091.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_3, arg_212_1.talkMaxDuration)

			if var_215_2 <= arg_212_1.time_ and arg_212_1.time_ < var_215_2 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_2) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_2 + var_215_10 and arg_212_1.time_ < var_215_2 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play411091052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 411091052
		arg_216_1.duration_ = 6.87

		local var_216_0 = {
			zh = 6.866,
			ja = 3
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
				arg_216_0:Play411091053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1095ui_story"]) and arg_216_1.var_.characterEffect1095ui_story == nil then
				arg_216_1.var_.characterEffect1095ui_story = arg_216_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1095ui_story"]) then
				if arg_216_1.var_.characterEffect1095ui_story and not isNil(arg_216_1.actors_["1095ui_story"]) then
					arg_216_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1095ui_story"]) and arg_216_1.var_.characterEffect1095ui_story then
				arg_216_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 0.6

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:GetWordFromCfg(411091052)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_6 = 24 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_4) / 24)

				if (24 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_4) / 24)) > 0 and var_219_2 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091052", "story_v_out_411091.awb") ~= 0 then
					local var_219_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091052", "story_v_out_411091.awb") / 1000

					if var_219_7 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_1
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_411091", "411091052", "story_v_out_411091.awb")

						arg_216_1:RecordAudio("411091052", var_219_8)
						arg_216_1:RecordAudio("411091052", var_219_8)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_411091", "411091052", "story_v_out_411091.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_411091", "411091052", "story_v_out_411091.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_9 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_9 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_9

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_9 and arg_216_1.time_ < var_219_1 + var_219_9 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play411091053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 411091053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play411091054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1095ui_story = arg_220_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1095ui_story"].transform.position).z)
				arg_220_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1095ui_story"].transform.localEulerAngles = arg_220_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1095ui_story"].transform.position).z)
				arg_220_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1095ui_story"].transform.localEulerAngles = arg_220_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_223_1 = 0
			local var_223_2 = 1.325

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_3 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(411091053).content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 53 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 53)

				if (53 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 53)) > 0 and var_223_2 < var_223_5 then
					arg_220_1.talkMaxDuration = var_223_5

					if var_223_5 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + var_223_1
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_6 = math.max(var_223_2, arg_220_1.talkMaxDuration)

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_6 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_1) / var_223_6

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_1 + var_223_6 and arg_220_1.time_ < var_223_1 + var_223_6 + arg_223_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play411091054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 411091054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play411091055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if arg_224_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_227_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_224_1.stage_.transform)

				var_227_0.name = "10014ui_story"
				var_227_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_["10014ui_story"] = var_227_0

				local var_227_1 = var_227_0:GetComponentInChildren(typeof(CharacterEffect))

				var_227_1.enabled = true

				local var_227_2 = GameObjectTools.GetOrAddComponent(var_227_0, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(false)
				end

				arg_224_1:ShowWeapon(var_227_1.transform, false)

				arg_224_1.var_["10014ui_story" .. "Animator"] = var_227_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_224_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_224_1.var_["10014ui_story" .. "LipSync"] = var_227_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_227_3 = arg_224_1.actors_["10014ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10014ui_story = var_227_3.localPosition
			end

			local var_227_4 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				var_227_3.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_224_1.time_ - 0) / var_227_4)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				var_227_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles
			end

			local var_227_5 = arg_224_1.actors_["10014ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect10014ui_story == nil then
				arg_224_1.var_.characterEffect10014ui_story = var_227_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 and not isNil(var_227_5) then
				if arg_224_1.var_.characterEffect10014ui_story and not isNil(var_227_5) then
					arg_224_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect10014ui_story then
				arg_224_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_227_8 = arg_224_1.actors_["1095ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1095ui_story = var_227_8.localPosition
			end

			local var_227_9 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_9 then
				var_227_8.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_224_1.time_ - 0) / var_227_9)
				var_227_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_8.position).x, (manager.ui.mainCamera.transform.position - var_227_8.position).y, (manager.ui.mainCamera.transform.position - var_227_8.position).z)
				var_227_8.localEulerAngles.z = 0
				var_227_8.localEulerAngles.x = 0
				var_227_8.localEulerAngles = var_227_8.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_9 and arg_224_1.time_ < 0 + var_227_9 + arg_227_0 then
				var_227_8.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_227_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_8.position).x, (manager.ui.mainCamera.transform.position - var_227_8.position).y, (manager.ui.mainCamera.transform.position - var_227_8.position).z)
				var_227_8.localEulerAngles.z = 0
				var_227_8.localEulerAngles.x = 0
				var_227_8.localEulerAngles = var_227_8.localEulerAngles
			end

			local var_227_10 = arg_224_1.actors_["1095ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_10) and arg_224_1.var_.characterEffect1095ui_story == nil then
				arg_224_1.var_.characterEffect1095ui_story = var_227_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_11 and not isNil(var_227_10) then
				if arg_224_1.var_.characterEffect1095ui_story and not isNil(var_227_10) then
					arg_224_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_11)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_11 and arg_224_1.time_ < 0 + var_227_11 + arg_227_0 and not isNil(var_227_10) and arg_224_1.var_.characterEffect1095ui_story then
				arg_224_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				if arg_224_1.var_.characterEffect10014ui_story == nil then
					arg_224_1.var_.characterEffect10014ui_story = arg_224_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_224_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				if arg_224_1.var_.characterEffect10014ui_story == nil then
					arg_224_1.var_.characterEffect10014ui_story = arg_224_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_227_13 = arg_224_1.var_.characterEffect10014ui_story

				arg_224_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_227_13.interferenceEffect.enabled = true
				var_227_13.interferenceEffect.noise = 0.001
				var_227_13.interferenceEffect.simTimeScale = 1
				var_227_13.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_227_14 = 0
			local var_227_15 = 0.475

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_14 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_16 = arg_224_1:GetWordFromCfg(411091054)
				local var_227_17 = arg_224_1:FormatText(var_227_16.content)

				arg_224_1.text_.text = var_227_17

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_19 = 19 <= 0 and var_227_15 or var_227_15 * (utf8.len(var_227_17) / 19)

				if (19 <= 0 and var_227_15 or var_227_15 * (utf8.len(var_227_17) / 19)) > 0 and var_227_15 < var_227_19 then
					arg_224_1.talkMaxDuration = var_227_19

					if var_227_19 + var_227_14 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_14
					end
				end

				arg_224_1.text_.text = var_227_17
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091054", "story_v_out_411091.awb") ~= 0 then
					local var_227_20 = manager.audio:GetVoiceLength("story_v_out_411091", "411091054", "story_v_out_411091.awb") / 1000

					if var_227_20 + var_227_14 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_20 + var_227_14
					end

					if var_227_16.prefab_name ~= "" and arg_224_1.actors_[var_227_16.prefab_name] ~= nil then
						local var_227_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_16.prefab_name].transform, "story_v_out_411091", "411091054", "story_v_out_411091.awb")

						arg_224_1:RecordAudio("411091054", var_227_21)
						arg_224_1:RecordAudio("411091054", var_227_21)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_411091", "411091054", "story_v_out_411091.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_411091", "411091054", "story_v_out_411091.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_15, arg_224_1.talkMaxDuration)

			if var_227_14 <= arg_224_1.time_ and arg_224_1.time_ < var_227_14 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_14) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_14 + var_227_22 and arg_224_1.time_ < var_227_14 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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

		arg_224_1:InitPlayNodeList()
	end,
	Play411091055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 411091055
		arg_228_1.duration_ = 9.47

		local var_228_0 = {
			zh = 7.533,
			ja = 9.466
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play411091056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(411091055)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 40 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 40)

				if (40 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 40)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091055", "story_v_out_411091.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091055", "story_v_out_411091.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_411091", "411091055", "story_v_out_411091.awb")

						arg_228_1:RecordAudio("411091055", var_231_6)
						arg_228_1:RecordAudio("411091055", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_411091", "411091055", "story_v_out_411091.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_411091", "411091055", "story_v_out_411091.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play411091056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 411091056
		arg_232_1.duration_ = 12.07

		local var_232_0 = {
			zh = 6.866,
			ja = 12.066
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play411091057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.875

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:GetWordFromCfg(411091056)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 35 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 35)

				if (35 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 35)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091056", "story_v_out_411091.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091056", "story_v_out_411091.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_411091", "411091056", "story_v_out_411091.awb")

						arg_232_1:RecordAudio("411091056", var_235_6)
						arg_232_1:RecordAudio("411091056", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_411091", "411091056", "story_v_out_411091.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_411091", "411091056", "story_v_out_411091.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play411091057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 411091057
		arg_236_1.duration_ = 11.97

		local var_236_0 = {
			zh = 8.9,
			ja = 11.966
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play411091058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 1.175

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:GetWordFromCfg(411091057)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 47 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 47)

				if (47 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 47)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091057", "story_v_out_411091.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091057", "story_v_out_411091.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_411091", "411091057", "story_v_out_411091.awb")

						arg_236_1:RecordAudio("411091057", var_239_6)
						arg_236_1:RecordAudio("411091057", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_411091", "411091057", "story_v_out_411091.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_411091", "411091057", "story_v_out_411091.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play411091058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 411091058
		arg_240_1.duration_ = 13.1

		local var_240_0 = {
			zh = 10.866,
			ja = 13.1
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play411091059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 1.375

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:GetWordFromCfg(411091058)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 55 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 55)

				if (55 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 55)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091058", "story_v_out_411091.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091058", "story_v_out_411091.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_411091", "411091058", "story_v_out_411091.awb")

						arg_240_1:RecordAudio("411091058", var_243_6)
						arg_240_1:RecordAudio("411091058", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_411091", "411091058", "story_v_out_411091.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_411091", "411091058", "story_v_out_411091.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play411091059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 411091059
		arg_244_1.duration_ = 3.37

		local var_244_0 = {
			zh = 2.233,
			ja = 3.366
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play411091060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1095ui_story = arg_244_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1095ui_story"].transform.position).z)
				arg_244_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1095ui_story"].transform.localEulerAngles = arg_244_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_244_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1095ui_story"].transform.position).z)
				arg_244_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1095ui_story"].transform.localEulerAngles = arg_244_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1095ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1095ui_story == nil then
				arg_244_1.var_.characterEffect1095ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1095ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1095ui_story then
				arg_244_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_247_4 = arg_244_1.actors_["10014ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect10014ui_story == nil then
				arg_244_1.var_.characterEffect10014ui_story = var_247_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_5 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_5 and not isNil(var_247_4) then
				if arg_244_1.var_.characterEffect10014ui_story and not isNil(var_247_4) then
					arg_244_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_5)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_5 and arg_244_1.time_ < 0 + var_247_5 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect10014ui_story then
				arg_244_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_247_6 = 0
			local var_247_7 = 0.325

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_8 = arg_244_1:GetWordFromCfg(411091059)
				local var_247_9 = arg_244_1:FormatText(var_247_8.content)

				arg_244_1.text_.text = var_247_9

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 13 <= 0 and var_247_7 or var_247_7 * (utf8.len(var_247_9) / 13)

				if (13 <= 0 and var_247_7 or var_247_7 * (utf8.len(var_247_9) / 13)) > 0 and var_247_7 < var_247_11 then
					arg_244_1.talkMaxDuration = var_247_11

					if var_247_11 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_9
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091059", "story_v_out_411091.awb") ~= 0 then
					local var_247_12 = manager.audio:GetVoiceLength("story_v_out_411091", "411091059", "story_v_out_411091.awb") / 1000

					if var_247_12 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_12 + var_247_6
					end

					if var_247_8.prefab_name ~= "" and arg_244_1.actors_[var_247_8.prefab_name] ~= nil then
						local var_247_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_8.prefab_name].transform, "story_v_out_411091", "411091059", "story_v_out_411091.awb")

						arg_244_1:RecordAudio("411091059", var_247_13)
						arg_244_1:RecordAudio("411091059", var_247_13)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_411091", "411091059", "story_v_out_411091.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_411091", "411091059", "story_v_out_411091.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play411091060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 411091060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play411091061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1095ui_story = arg_248_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1095ui_story"].transform.position).z)
				arg_248_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1095ui_story"].transform.localEulerAngles = arg_248_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1095ui_story"].transform.position).z)
				arg_248_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1095ui_story"].transform.localEulerAngles = arg_248_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1095ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1095ui_story == nil then
				arg_248_1.var_.characterEffect1095ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect1095ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_2)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1095ui_story then
				arg_248_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_251_3 = arg_248_1.actors_["10014ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10014ui_story = var_251_3.localPosition
			end

			local var_251_4 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				var_251_3.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_4)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				var_251_3.localPosition = Vector3.New(0, 100, 0)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			local var_251_5 = arg_248_1.actors_["10014ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect10014ui_story == nil then
				arg_248_1.var_.characterEffect10014ui_story = var_251_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_6 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_6 and not isNil(var_251_5) then
				if arg_248_1.var_.characterEffect10014ui_story and not isNil(var_251_5) then
					arg_248_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_248_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_6)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_6 and arg_248_1.time_ < 0 + var_251_6 + arg_251_0 and not isNil(var_251_5) and arg_248_1.var_.characterEffect10014ui_story then
				arg_248_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_248_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_251_7 = 0
			local var_251_8 = 0.75

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_7 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_9 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(411091060).content)

				arg_248_1.text_.text = var_251_9

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 30 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_9) / 30)

				if (30 <= 0 and var_251_8 or var_251_8 * (utf8.len(var_251_9) / 30)) > 0 and var_251_8 < var_251_11 then
					arg_248_1.talkMaxDuration = var_251_11

					if var_251_11 + var_251_7 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_7
					end
				end

				arg_248_1.text_.text = var_251_9
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_8, arg_248_1.talkMaxDuration)

			if var_251_7 <= arg_248_1.time_ and arg_248_1.time_ < var_251_7 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_7) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_7 + var_251_12 and arg_248_1.time_ < var_251_7 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play411091061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 411091061
		arg_252_1.duration_ = 8.37

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play411091062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_0 = 2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				local var_255_1 = Color.New(0, 0, 0)

				var_255_1.a = Mathf.Lerp(0, 1, (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.mask_.color = var_255_1
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				local var_255_2 = Color.New(0, 0, 0)

				var_255_2.a = 1
				arg_252_1.mask_.color = var_255_2
			end

			local var_255_3 = 2

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.mask_.enabled = true
				arg_252_1.mask_.raycastTarget = true

				arg_252_1:SetGaussion(false)
			end

			local var_255_4 = 1.36666666666667

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_4 then
				local var_255_5 = Color.New(0, 0, 0)

				var_255_5.a = Mathf.Lerp(1, 0, (arg_252_1.time_ - var_255_3) / var_255_4)
				arg_252_1.mask_.color = var_255_5
			end

			if arg_252_1.time_ >= var_255_3 + var_255_4 and arg_252_1.time_ < var_255_3 + var_255_4 + arg_255_0 then
				local var_255_6 = Color.New(0, 0, 0)

				arg_252_1.mask_.enabled = false
				var_255_6.a = 0
				arg_252_1.mask_.color = var_255_6
			end

			if 2 < arg_252_1.time_ and arg_252_1.time_ <= 2 + arg_255_0 then
				local var_255_7 = arg_252_1.bgs_.B01b

				arg_252_1.bgs_.B01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_255_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_255_8 = var_255_7:GetComponent("SpriteRenderer")

				if var_255_8 and var_255_8.sprite then
					local var_255_9 = 2 * (var_255_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_255_7.transform.localScale = Vector3.New(var_255_9 / var_255_8.sprite.bounds.size.y < var_255_9 * manager.ui.mainCameraCom_.aspect / var_255_8.sprite.bounds.size.x and var_255_9 * manager.ui.mainCameraCom_.aspect / var_255_8.sprite.bounds.size.x or var_255_9 / var_255_8.sprite.bounds.size.y, var_255_9 / var_255_8.sprite.bounds.size.y < var_255_9 * manager.ui.mainCameraCom_.aspect / var_255_8.sprite.bounds.size.x and var_255_9 * manager.ui.mainCameraCom_.aspect / var_255_8.sprite.bounds.size.x or var_255_9 / var_255_8.sprite.bounds.size.y, 0)
				end

				for iter_255_0, iter_255_1 in pairs(arg_252_1.bgs_) do
					if iter_255_0 ~= "B01b" then
						iter_255_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_10 = 3.36666666666667
			local var_255_11 = 0.575

			if 3.36666666666667 < arg_252_1.time_ and arg_252_1.time_ <= var_255_10 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_12 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_12:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_13 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(411091061).content)

				arg_252_1.text_.text = var_255_13

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_15 = 23 <= 0 and var_255_11 or var_255_11 * (utf8.len(var_255_13) / 23)

				if (23 <= 0 and var_255_11 or var_255_11 * (utf8.len(var_255_13) / 23)) > 0 and var_255_11 < var_255_15 then
					arg_252_1.talkMaxDuration = var_255_15
					var_255_10 = var_255_10 + 0.3

					if var_255_15 + var_255_10 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_15 + var_255_10
					end
				end

				arg_252_1.text_.text = var_255_13
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = var_255_10 + 0.3
			local var_255_17 = math.max(var_255_11, arg_252_1.talkMaxDuration)

			if var_255_10 + 0.3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_16 + var_255_17 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_16) / var_255_17

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_16 + var_255_17 and arg_252_1.time_ < var_255_16 + var_255_17 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play411091062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 411091062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play411091063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0.75

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(411091062).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 30 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 30)

				if (30 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 30)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play411091063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 411091063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play411091064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 1.25

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(411091063).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 50 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 50)

				if (50 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 50)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play411091064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 411091064
		arg_266_1.duration_ = 5.8

		local var_266_0 = {
			zh = 4.433,
			ja = 5.8
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play411091065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1095ui_story"]) and arg_266_1.var_.characterEffect1095ui_story == nil then
				arg_266_1.var_.characterEffect1095ui_story = arg_266_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1095ui_story"]) then
				if arg_266_1.var_.characterEffect1095ui_story and not isNil(arg_266_1.actors_["1095ui_story"]) then
					arg_266_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1095ui_story"]) and arg_266_1.var_.characterEffect1095ui_story then
				arg_266_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_269_1 = 0
			local var_269_2 = 0.475

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(411091064)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_6 = 19 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_4) / 19)

				if (19 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_4) / 19)) > 0 and var_269_2 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091064", "story_v_out_411091.awb") ~= 0 then
					local var_269_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091064", "story_v_out_411091.awb") / 1000

					if var_269_7 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_1
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_411091", "411091064", "story_v_out_411091.awb")

						arg_266_1:RecordAudio("411091064", var_269_8)
						arg_266_1:RecordAudio("411091064", var_269_8)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_411091", "411091064", "story_v_out_411091.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_411091", "411091064", "story_v_out_411091.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_9 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_9 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_9

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_9 and arg_266_1.time_ < var_269_1 + var_269_9 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play411091065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 411091065
		arg_270_1.duration_ = 9.8

		local var_270_0 = {
			zh = 6,
			ja = 9.8
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play411091066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1095ui_story = arg_270_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).z)
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles = arg_270_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_270_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1095ui_story"].transform.position).z)
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1095ui_story"].transform.localEulerAngles = arg_270_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_273_1 = arg_270_1.actors_["1095ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1095ui_story == nil then
				arg_270_1.var_.characterEffect1095ui_story = var_273_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_2 and not isNil(var_273_1) then
				if arg_270_1.var_.characterEffect1095ui_story and not isNil(var_273_1) then
					arg_270_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_2 and arg_270_1.time_ < 0 + var_273_2 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1095ui_story then
				arg_270_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_273_4 = 0
			local var_273_5 = 0.825

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(411091065)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 33 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 33)

				if (33 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 33)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091065", "story_v_out_411091.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091065", "story_v_out_411091.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_out_411091", "411091065", "story_v_out_411091.awb")

						arg_270_1:RecordAudio("411091065", var_273_11)
						arg_270_1:RecordAudio("411091065", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_411091", "411091065", "story_v_out_411091.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_411091", "411091065", "story_v_out_411091.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_12 and arg_270_1.time_ < var_273_4 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
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

		arg_270_1:InitPlayNodeList()
	end,
	Play411091066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 411091066
		arg_274_1.duration_ = 10.33

		local var_274_0 = {
			zh = 10.333,
			ja = 5.2
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play411091067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1095ui_story"]) and arg_274_1.var_.characterEffect1095ui_story == nil then
				arg_274_1.var_.characterEffect1095ui_story = arg_274_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1095ui_story"]) then
				if arg_274_1.var_.characterEffect1095ui_story and not isNil(arg_274_1.actors_["1095ui_story"]) then
					arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1095ui_story"]) and arg_274_1.var_.characterEffect1095ui_story then
				arg_274_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 1.075

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(411091066)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_6 = 43 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_4) / 43)

				if (43 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_4) / 43)) > 0 and var_277_2 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091066", "story_v_out_411091.awb") ~= 0 then
					local var_277_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091066", "story_v_out_411091.awb") / 1000

					if var_277_7 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_1
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_411091", "411091066", "story_v_out_411091.awb")

						arg_274_1:RecordAudio("411091066", var_277_8)
						arg_274_1:RecordAudio("411091066", var_277_8)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_411091", "411091066", "story_v_out_411091.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_411091", "411091066", "story_v_out_411091.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_9 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_9 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_9

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_9 and arg_274_1.time_ < var_277_1 + var_277_9 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play411091067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 411091067
		arg_278_1.duration_ = 8.1

		local var_278_0 = {
			zh = 6.433,
			ja = 8.1
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play411091068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1095ui_story"]) and arg_278_1.var_.characterEffect1095ui_story == nil then
				arg_278_1.var_.characterEffect1095ui_story = arg_278_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1095ui_story"]) then
				if arg_278_1.var_.characterEffect1095ui_story and not isNil(arg_278_1.actors_["1095ui_story"]) then
					arg_278_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1095ui_story"]) and arg_278_1.var_.characterEffect1095ui_story then
				arg_278_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_281_2 = 0
			local var_281_3 = 0.6

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_4 = arg_278_1:GetWordFromCfg(411091067)
				local var_281_5 = arg_278_1:FormatText(var_281_4.content)

				arg_278_1.text_.text = var_281_5

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_7 = 24 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_5) / 24)

				if (24 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_5) / 24)) > 0 and var_281_3 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_2
					end
				end

				arg_278_1.text_.text = var_281_5
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091067", "story_v_out_411091.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_411091", "411091067", "story_v_out_411091.awb") / 1000

					if var_281_8 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_2
					end

					if var_281_4.prefab_name ~= "" and arg_278_1.actors_[var_281_4.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_4.prefab_name].transform, "story_v_out_411091", "411091067", "story_v_out_411091.awb")

						arg_278_1:RecordAudio("411091067", var_281_9)
						arg_278_1:RecordAudio("411091067", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_411091", "411091067", "story_v_out_411091.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_411091", "411091067", "story_v_out_411091.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_3, arg_278_1.talkMaxDuration)

			if var_281_2 <= arg_278_1.time_ and arg_278_1.time_ < var_281_2 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_2) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_2 + var_281_10 and arg_278_1.time_ < var_281_2 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play411091068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 411091068
		arg_282_1.duration_ = 11.73

		local var_282_0 = {
			zh = 5.966,
			ja = 11.733
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play411091069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_285_0 = 0
			local var_285_1 = 0.725

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_2 = arg_282_1:GetWordFromCfg(411091068)
				local var_285_3 = arg_282_1:FormatText(var_285_2.content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 29 <= 0 and var_285_1 or var_285_1 * (utf8.len(var_285_3) / 29)

				if (29 <= 0 and var_285_1 or var_285_1 * (utf8.len(var_285_3) / 29)) > 0 and var_285_1 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091068", "story_v_out_411091.awb") ~= 0 then
					local var_285_6 = manager.audio:GetVoiceLength("story_v_out_411091", "411091068", "story_v_out_411091.awb") / 1000

					if var_285_6 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_0
					end

					if var_285_2.prefab_name ~= "" and arg_282_1.actors_[var_285_2.prefab_name] ~= nil then
						local var_285_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_2.prefab_name].transform, "story_v_out_411091", "411091068", "story_v_out_411091.awb")

						arg_282_1:RecordAudio("411091068", var_285_7)
						arg_282_1:RecordAudio("411091068", var_285_7)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_411091", "411091068", "story_v_out_411091.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_411091", "411091068", "story_v_out_411091.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_8 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_8 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_8

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_8 and arg_282_1.time_ < var_285_0 + var_285_8 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play411091069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 411091069
		arg_286_1.duration_ = 3.3

		local var_286_0 = {
			zh = 3,
			ja = 3.3
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play411091070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1095ui_story = arg_286_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_289_0 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				arg_286_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_286_1.time_ - 0) / var_289_0)
				arg_286_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).z)
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles = arg_286_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				arg_286_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_286_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1095ui_story"].transform.position).z)
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1095ui_story"].transform.localEulerAngles = arg_286_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_289_1 = arg_286_1.actors_["1095ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1095ui_story == nil then
				arg_286_1.var_.characterEffect1095ui_story = var_289_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_2 and not isNil(var_289_1) then
				if arg_286_1.var_.characterEffect1095ui_story and not isNil(var_289_1) then
					arg_286_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_2 and arg_286_1.time_ < 0 + var_289_2 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1095ui_story then
				arg_286_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_289_4 = 0
			local var_289_5 = 0.325

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_6 = arg_286_1:GetWordFromCfg(411091069)
				local var_289_7 = arg_286_1:FormatText(var_289_6.content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_9 = 13 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 13)

				if (13 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 13)) > 0 and var_289_5 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091069", "story_v_out_411091.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091069", "story_v_out_411091.awb") / 1000

					if var_289_10 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_4
					end

					if var_289_6.prefab_name ~= "" and arg_286_1.actors_[var_289_6.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_6.prefab_name].transform, "story_v_out_411091", "411091069", "story_v_out_411091.awb")

						arg_286_1:RecordAudio("411091069", var_289_11)
						arg_286_1:RecordAudio("411091069", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_411091", "411091069", "story_v_out_411091.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_411091", "411091069", "story_v_out_411091.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_12 and arg_286_1.time_ < var_289_4 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play411091070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 411091070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play411091071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1095ui_story"]) and arg_290_1.var_.characterEffect1095ui_story == nil then
				arg_290_1.var_.characterEffect1095ui_story = arg_290_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1095ui_story"]) then
				if arg_290_1.var_.characterEffect1095ui_story and not isNil(arg_290_1.actors_["1095ui_story"]) then
					arg_290_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1095ui_story"]) and arg_290_1.var_.characterEffect1095ui_story then
				arg_290_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_293_2 = 0
			local var_293_3 = 1.275

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_4 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(411091070).content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_6 = 51 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 51)

				if (51 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 51)) > 0 and var_293_3 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_7 and arg_290_1.time_ < var_293_2 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play411091071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 411091071
		arg_294_1.duration_ = 2.53

		local var_294_0 = {
			zh = 2.233,
			ja = 2.533
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play411091072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.175

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:GetWordFromCfg(411091071)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 7 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 7)

				if (7 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 7)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091071", "story_v_out_411091.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091071", "story_v_out_411091.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_411091", "411091071", "story_v_out_411091.awb")

						arg_294_1:RecordAudio("411091071", var_297_6)
						arg_294_1:RecordAudio("411091071", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_411091", "411091071", "story_v_out_411091.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_411091", "411091071", "story_v_out_411091.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play411091072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 411091072
		arg_298_1.duration_ = 5.07

		local var_298_0 = {
			zh = 3.133,
			ja = 5.066
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play411091073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.525

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:GetWordFromCfg(411091072)
				local var_301_2 = arg_298_1:FormatText(var_301_1.content)

				arg_298_1.text_.text = var_301_2

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 21 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 21)

				if (21 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 21)) > 0 and var_301_0 < var_301_4 then
					arg_298_1.talkMaxDuration = var_301_4

					if var_301_4 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_4 + 0
					end
				end

				arg_298_1.text_.text = var_301_2
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091072", "story_v_out_411091.awb") ~= 0 then
					local var_301_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091072", "story_v_out_411091.awb") / 1000

					if var_301_5 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + 0
					end

					if var_301_1.prefab_name ~= "" and arg_298_1.actors_[var_301_1.prefab_name] ~= nil then
						local var_301_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_1.prefab_name].transform, "story_v_out_411091", "411091072", "story_v_out_411091.awb")

						arg_298_1:RecordAudio("411091072", var_301_6)
						arg_298_1:RecordAudio("411091072", var_301_6)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_411091", "411091072", "story_v_out_411091.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_411091", "411091072", "story_v_out_411091.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play411091073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 411091073
		arg_302_1.duration_ = 4.37

		local var_302_0 = {
			zh = 4.366,
			ja = 3.7
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play411091074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.575

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, true)
				arg_302_1.iconController_:SetSelectedState("hero")

				arg_302_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_302_1.callingController_:SetSelectedState("normal")

				arg_302_1.keyicon_.color = Color.New(1, 1, 1)
				arg_302_1.icon_.color = Color.New(1, 1, 1)

				local var_305_1 = arg_302_1:GetWordFromCfg(411091073)
				local var_305_2 = arg_302_1:FormatText(var_305_1.content)

				arg_302_1.text_.text = var_305_2

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_4 = 23 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 23)

				if (23 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_2) / 23)) > 0 and var_305_0 < var_305_4 then
					arg_302_1.talkMaxDuration = var_305_4

					if var_305_4 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_4 + 0
					end
				end

				arg_302_1.text_.text = var_305_2
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091073", "story_v_out_411091.awb") ~= 0 then
					local var_305_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091073", "story_v_out_411091.awb") / 1000

					if var_305_5 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_5 + 0
					end

					if var_305_1.prefab_name ~= "" and arg_302_1.actors_[var_305_1.prefab_name] ~= nil then
						local var_305_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_1.prefab_name].transform, "story_v_out_411091", "411091073", "story_v_out_411091.awb")

						arg_302_1:RecordAudio("411091073", var_305_6)
						arg_302_1:RecordAudio("411091073", var_305_6)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_411091", "411091073", "story_v_out_411091.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_411091", "411091073", "story_v_out_411091.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_7 and arg_302_1.time_ < 0 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play411091074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 411091074
		arg_306_1.duration_ = 6.2

		local var_306_0 = {
			zh = 4.433,
			ja = 6.2
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play411091075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.6

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_1 = arg_306_1:GetWordFromCfg(411091074)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 24 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 24)

				if (24 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 24)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091074", "story_v_out_411091.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091074", "story_v_out_411091.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_411091", "411091074", "story_v_out_411091.awb")

						arg_306_1:RecordAudio("411091074", var_309_6)
						arg_306_1:RecordAudio("411091074", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_411091", "411091074", "story_v_out_411091.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_411091", "411091074", "story_v_out_411091.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play411091075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 411091075
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play411091076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1095ui_story = arg_310_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_313_0 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				arg_310_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_310_1.time_ - 0) / var_313_0)
				arg_310_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1095ui_story"].transform.position).z)
				arg_310_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1095ui_story"].transform.localEulerAngles = arg_310_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				arg_310_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1095ui_story"].transform.position).z)
				arg_310_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1095ui_story"].transform.localEulerAngles = arg_310_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_313_1 = 0
			local var_313_2 = 0.6

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_3 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(411091075).content)

				arg_310_1.text_.text = var_313_3

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 24 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_3) / 24)

				if (24 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_3) / 24)) > 0 and var_313_2 < var_313_5 then
					arg_310_1.talkMaxDuration = var_313_5

					if var_313_5 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + var_313_1
					end
				end

				arg_310_1.text_.text = var_313_3
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_6 = math.max(var_313_2, arg_310_1.talkMaxDuration)

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_6 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_1) / var_313_6

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_1 + var_313_6 and arg_310_1.time_ < var_313_1 + var_313_6 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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

		arg_310_1:InitPlayNodeList()
	end,
	Play411091076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 411091076
		arg_314_1.duration_ = 5.53

		local var_314_0 = {
			zh = 2.033,
			ja = 5.533
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
				arg_314_0:Play411091077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.25

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:GetWordFromCfg(411091076)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 10 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 10)

				if (10 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 10)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091076", "story_v_out_411091.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091076", "story_v_out_411091.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_411091", "411091076", "story_v_out_411091.awb")

						arg_314_1:RecordAudio("411091076", var_317_6)
						arg_314_1:RecordAudio("411091076", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_411091", "411091076", "story_v_out_411091.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_411091", "411091076", "story_v_out_411091.awb")
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
	Play411091077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 411091077
		arg_318_1.duration_ = 12.23

		local var_318_0 = {
			zh = 8.13266666666667,
			ja = 12.2326666666667
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
				arg_318_0:Play411091078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_0 = 2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				local var_321_1 = Color.New(0, 0, 0)

				var_321_1.a = Mathf.Lerp(0, 1, (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.mask_.color = var_321_1
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				local var_321_2 = Color.New(0, 0, 0)

				var_321_2.a = 1
				arg_318_1.mask_.color = var_321_2
			end

			local var_321_3 = 2

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_3 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_4 = 1.36666666666667

			if var_321_3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_3 + var_321_4 then
				local var_321_5 = Color.New(0, 0, 0)

				var_321_5.a = Mathf.Lerp(1, 0, (arg_318_1.time_ - var_321_3) / var_321_4)
				arg_318_1.mask_.color = var_321_5
			end

			if arg_318_1.time_ >= var_321_3 + var_321_4 and arg_318_1.time_ < var_321_3 + var_321_4 + arg_321_0 then
				local var_321_6 = Color.New(0, 0, 0)

				arg_318_1.mask_.enabled = false
				var_321_6.a = 0
				arg_318_1.mask_.color = var_321_6
			end

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= 2 + arg_321_0 then
				local var_321_7 = arg_318_1.bgs_.B01b

				arg_318_1.bgs_.B01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_321_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_8 = var_321_7:GetComponent("SpriteRenderer")

				if var_321_8 and var_321_8.sprite then
					local var_321_9 = 2 * (var_321_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_321_7.transform.localScale = Vector3.New(var_321_9 / var_321_8.sprite.bounds.size.y < var_321_9 * manager.ui.mainCameraCom_.aspect / var_321_8.sprite.bounds.size.x and var_321_9 * manager.ui.mainCameraCom_.aspect / var_321_8.sprite.bounds.size.x or var_321_9 / var_321_8.sprite.bounds.size.y, var_321_9 / var_321_8.sprite.bounds.size.y < var_321_9 * manager.ui.mainCameraCom_.aspect / var_321_8.sprite.bounds.size.x and var_321_9 * manager.ui.mainCameraCom_.aspect / var_321_8.sprite.bounds.size.x or var_321_9 / var_321_8.sprite.bounds.size.y, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "B01b" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_10 = 3.36666666666667
			local var_321_11 = 0.575

			if 3.36666666666667 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_12 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_12:setOnUpdate(LuaHelper.FloatAction(function(arg_322_0)
					arg_318_1.dialogCg_.alpha = arg_322_0
				end))
				var_321_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_13 = arg_318_1:GetWordFromCfg(411091077)
				local var_321_14 = arg_318_1:FormatText(var_321_13.content)

				arg_318_1.text_.text = var_321_14

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_16 = 23 <= 0 and var_321_11 or var_321_11 * (utf8.len(var_321_14) / 23)

				if (23 <= 0 and var_321_11 or var_321_11 * (utf8.len(var_321_14) / 23)) > 0 and var_321_11 < var_321_16 then
					arg_318_1.talkMaxDuration = var_321_16
					var_321_10 = var_321_10 + 0.3

					if var_321_16 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_16 + var_321_10
					end
				end

				arg_318_1.text_.text = var_321_14
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091077", "story_v_out_411091.awb") ~= 0 then
					local var_321_17 = manager.audio:GetVoiceLength("story_v_out_411091", "411091077", "story_v_out_411091.awb") / 1000

					if var_321_17 + var_321_10 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_17 + var_321_10
					end

					if var_321_13.prefab_name ~= "" and arg_318_1.actors_[var_321_13.prefab_name] ~= nil then
						local var_321_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_13.prefab_name].transform, "story_v_out_411091", "411091077", "story_v_out_411091.awb")

						arg_318_1:RecordAudio("411091077", var_321_18)
						arg_318_1:RecordAudio("411091077", var_321_18)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_411091", "411091077", "story_v_out_411091.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_411091", "411091077", "story_v_out_411091.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_19 = var_321_10 + 0.3
			local var_321_20 = math.max(var_321_11, arg_318_1.talkMaxDuration)

			if var_321_10 + 0.3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_19 + var_321_20 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_19) / var_321_20

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_19 + var_321_20 and arg_318_1.time_ < var_321_19 + var_321_20 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play411091078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 411091078
		arg_324_1.duration_ = 11

		local var_324_0 = {
			zh = 6.333,
			ja = 11
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play411091079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 0.8

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				arg_324_1.dialog_:SetActive(true)

				arg_324_1.dialogCg_.alpha = 0

				local var_327_2 = LeanTween.value(arg_324_1.dialog_, 0, 1, 0.3)

				var_327_2:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_324_1.dialogCg_.alpha = arg_328_0
				end))
				var_327_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_324_1.dialog_)
					var_327_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_324_1.duration_ = arg_324_1.duration_ + 0.3

				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:GetWordFromCfg(411091078)
				local var_327_4 = arg_324_1:FormatText(var_327_3.content)

				arg_324_1.text_.text = var_327_4

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_6 = 32 <= 0 and var_327_1 or var_327_1 * (utf8.len(var_327_4) / 32)

				if (32 <= 0 and var_327_1 or var_327_1 * (utf8.len(var_327_4) / 32)) > 0 and var_327_1 < var_327_6 then
					arg_324_1.talkMaxDuration = var_327_6
					var_327_0 = var_327_0 + 0.3

					if var_327_6 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_4
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091078", "story_v_out_411091.awb") ~= 0 then
					local var_327_7 = manager.audio:GetVoiceLength("story_v_out_411091", "411091078", "story_v_out_411091.awb") / 1000

					if var_327_7 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_7 + var_327_0
					end

					if var_327_3.prefab_name ~= "" and arg_324_1.actors_[var_327_3.prefab_name] ~= nil then
						local var_327_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_3.prefab_name].transform, "story_v_out_411091", "411091078", "story_v_out_411091.awb")

						arg_324_1:RecordAudio("411091078", var_327_8)
						arg_324_1:RecordAudio("411091078", var_327_8)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_411091", "411091078", "story_v_out_411091.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_411091", "411091078", "story_v_out_411091.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_9 = var_327_0 + 0.3
			local var_327_10 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 + 0.3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_9 + var_327_10 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_9) / var_327_10

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_9 + var_327_10 and arg_324_1.time_ < var_327_9 + var_327_10 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play411091079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 411091079
		arg_330_1.duration_ = 3.8

		local var_330_0 = {
			zh = 1.733,
			ja = 3.8
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
				arg_330_0:Play411091080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.225

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_1 = arg_330_1:GetWordFromCfg(411091079)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 9 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 9)

				if (9 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 9)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091079", "story_v_out_411091.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091079", "story_v_out_411091.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_411091", "411091079", "story_v_out_411091.awb")

						arg_330_1:RecordAudio("411091079", var_333_6)
						arg_330_1:RecordAudio("411091079", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_411091", "411091079", "story_v_out_411091.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_411091", "411091079", "story_v_out_411091.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play411091080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 411091080
		arg_334_1.duration_ = 5.3

		local var_334_0 = {
			zh = 4.733,
			ja = 5.3
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
				arg_334_0:Play411091081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1095ui_story = arg_334_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1095ui_story"].transform.position).z)
				arg_334_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1095ui_story"].transform.localEulerAngles = arg_334_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_334_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1095ui_story"].transform.position).z)
				arg_334_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1095ui_story"].transform.localEulerAngles = arg_334_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["1095ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1095ui_story == nil then
				arg_334_1.var_.characterEffect1095ui_story = var_337_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 and not isNil(var_337_1) then
				if arg_334_1.var_.characterEffect1095ui_story and not isNil(var_337_1) then
					arg_334_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect1095ui_story then
				arg_334_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_337_4 = 0
			local var_337_5 = 0.525

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_6 = arg_334_1:GetWordFromCfg(411091080)
				local var_337_7 = arg_334_1:FormatText(var_337_6.content)

				arg_334_1.text_.text = var_337_7

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_9 = 21 <= 0 and var_337_5 or var_337_5 * (utf8.len(var_337_7) / 21)

				if (21 <= 0 and var_337_5 or var_337_5 * (utf8.len(var_337_7) / 21)) > 0 and var_337_5 < var_337_9 then
					arg_334_1.talkMaxDuration = var_337_9

					if var_337_9 + var_337_4 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_9 + var_337_4
					end
				end

				arg_334_1.text_.text = var_337_7
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091080", "story_v_out_411091.awb") ~= 0 then
					local var_337_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091080", "story_v_out_411091.awb") / 1000

					if var_337_10 + var_337_4 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_4
					end

					if var_337_6.prefab_name ~= "" and arg_334_1.actors_[var_337_6.prefab_name] ~= nil then
						local var_337_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_6.prefab_name].transform, "story_v_out_411091", "411091080", "story_v_out_411091.awb")

						arg_334_1:RecordAudio("411091080", var_337_11)
						arg_334_1:RecordAudio("411091080", var_337_11)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_411091", "411091080", "story_v_out_411091.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_411091", "411091080", "story_v_out_411091.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_12 = math.max(var_337_5, arg_334_1.talkMaxDuration)

			if var_337_4 <= arg_334_1.time_ and arg_334_1.time_ < var_337_4 + var_337_12 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_4) / var_337_12

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_4 + var_337_12 and arg_334_1.time_ < var_337_4 + var_337_12 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
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

		arg_334_1:InitPlayNodeList()
	end,
	Play411091081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 411091081
		arg_338_1.duration_ = 3.73

		local var_338_0 = {
			zh = 3.466,
			ja = 3.733
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
				arg_338_0:Play411091082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.425

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
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

				local var_341_1 = arg_338_1:GetWordFromCfg(411091081)
				local var_341_2 = arg_338_1:FormatText(var_341_1.content)

				arg_338_1.text_.text = var_341_2

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 17 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 17)

				if (17 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 17)) > 0 and var_341_0 < var_341_4 then
					arg_338_1.talkMaxDuration = var_341_4

					if var_341_4 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_4 + 0
					end
				end

				arg_338_1.text_.text = var_341_2
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091081", "story_v_out_411091.awb") ~= 0 then
					local var_341_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091081", "story_v_out_411091.awb") / 1000

					if var_341_5 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + 0
					end

					if var_341_1.prefab_name ~= "" and arg_338_1.actors_[var_341_1.prefab_name] ~= nil then
						local var_341_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_1.prefab_name].transform, "story_v_out_411091", "411091081", "story_v_out_411091.awb")

						arg_338_1:RecordAudio("411091081", var_341_6)
						arg_338_1:RecordAudio("411091081", var_341_6)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_411091", "411091081", "story_v_out_411091.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_411091", "411091081", "story_v_out_411091.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play411091082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 411091082
		arg_342_1.duration_ = 10.6

		local var_342_0 = {
			zh = 10.6,
			ja = 10.433
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
				arg_342_0:Play411091083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 2 < arg_342_1.time_ and arg_342_1.time_ <= 2 + arg_345_0 then
				local var_345_0 = arg_342_1.bgs_.B01b

				arg_342_1.bgs_.B01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_345_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_345_1 = var_345_0:GetComponent("SpriteRenderer")

				if var_345_1 and var_345_1.sprite then
					local var_345_2 = 2 * (var_345_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_345_0.transform.localScale = Vector3.New(var_345_2 / var_345_1.sprite.bounds.size.y < var_345_2 * manager.ui.mainCameraCom_.aspect / var_345_1.sprite.bounds.size.x and var_345_2 * manager.ui.mainCameraCom_.aspect / var_345_1.sprite.bounds.size.x or var_345_2 / var_345_1.sprite.bounds.size.y, var_345_2 / var_345_1.sprite.bounds.size.y < var_345_2 * manager.ui.mainCameraCom_.aspect / var_345_1.sprite.bounds.size.x and var_345_2 * manager.ui.mainCameraCom_.aspect / var_345_1.sprite.bounds.size.x or var_345_2 / var_345_1.sprite.bounds.size.y, 0)
				end

				for iter_345_0, iter_345_1 in pairs(arg_342_1.bgs_) do
					if iter_345_0 ~= "B01b" then
						iter_345_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_345_3 = 0

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_3 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_4 = 2

			if var_345_3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_3 + var_345_4 then
				local var_345_5 = Color.New(0, 0, 0)

				var_345_5.a = Mathf.Lerp(0, 1, (arg_342_1.time_ - var_345_3) / var_345_4)
				arg_342_1.mask_.color = var_345_5
			end

			if arg_342_1.time_ >= var_345_3 + var_345_4 and arg_342_1.time_ < var_345_3 + var_345_4 + arg_345_0 then
				local var_345_6 = Color.New(0, 0, 0)

				var_345_6.a = 1
				arg_342_1.mask_.color = var_345_6
			end

			local var_345_7 = 2

			if 2 < arg_342_1.time_ and arg_342_1.time_ <= var_345_7 + arg_345_0 then
				arg_342_1.mask_.enabled = true
				arg_342_1.mask_.raycastTarget = true

				arg_342_1:SetGaussion(false)
			end

			local var_345_8 = 0.999999999999

			if var_345_7 <= arg_342_1.time_ and arg_342_1.time_ < var_345_7 + var_345_8 then
				local var_345_9 = Color.New(0, 0, 0)

				var_345_9.a = Mathf.Lerp(1, 0, (arg_342_1.time_ - var_345_7) / var_345_8)
				arg_342_1.mask_.color = var_345_9
			end

			if arg_342_1.time_ >= var_345_7 + var_345_8 and arg_342_1.time_ < var_345_7 + var_345_8 + arg_345_0 then
				local var_345_10 = Color.New(0, 0, 0)

				arg_342_1.mask_.enabled = false
				var_345_10.a = 0
				arg_342_1.mask_.color = var_345_10
			end

			local var_345_11 = arg_342_1.actors_["1095ui_story"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1095ui_story = var_345_11.localPosition
			end

			local var_345_12 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_12 then
				var_345_11.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_342_1.time_ - 0) / var_345_12)
				var_345_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_11.position).x, (manager.ui.mainCamera.transform.position - var_345_11.position).y, (manager.ui.mainCamera.transform.position - var_345_11.position).z)
				var_345_11.localEulerAngles.z = 0
				var_345_11.localEulerAngles.x = 0
				var_345_11.localEulerAngles = var_345_11.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_12 and arg_342_1.time_ < 0 + var_345_12 + arg_345_0 then
				var_345_11.localPosition = Vector3.New(0, 100, 0)
				var_345_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_11.position).x, (manager.ui.mainCamera.transform.position - var_345_11.position).y, (manager.ui.mainCamera.transform.position - var_345_11.position).z)
				var_345_11.localEulerAngles.z = 0
				var_345_11.localEulerAngles.x = 0
				var_345_11.localEulerAngles = var_345_11.localEulerAngles
			end

			local var_345_13 = arg_342_1.actors_["1095ui_story"].transform

			if 2.999999999999 < arg_342_1.time_ and arg_342_1.time_ <= 2.999999999999 + arg_345_0 then
				arg_342_1.var_.moveOldPos1095ui_story = var_345_13.localPosition
			end

			local var_345_14 = 0.001

			if 2.999999999999 <= arg_342_1.time_ and arg_342_1.time_ < 2.999999999999 + var_345_14 then
				var_345_13.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_342_1.time_ - 2.999999999999) / var_345_14)
				var_345_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_13.position).x, (manager.ui.mainCamera.transform.position - var_345_13.position).y, (manager.ui.mainCamera.transform.position - var_345_13.position).z)
				var_345_13.localEulerAngles.z = 0
				var_345_13.localEulerAngles.x = 0
				var_345_13.localEulerAngles = var_345_13.localEulerAngles
			end

			if arg_342_1.time_ >= 2.999999999999 + var_345_14 and arg_342_1.time_ < 2.999999999999 + var_345_14 + arg_345_0 then
				var_345_13.localPosition = Vector3.New(0, -0.98, -6.1)
				var_345_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_345_13.position).x, (manager.ui.mainCamera.transform.position - var_345_13.position).y, (manager.ui.mainCamera.transform.position - var_345_13.position).z)
				var_345_13.localEulerAngles.z = 0
				var_345_13.localEulerAngles.x = 0
				var_345_13.localEulerAngles = var_345_13.localEulerAngles
			end

			local var_345_15 = arg_342_1.actors_["1095ui_story"]

			if 2.999999999999 < arg_342_1.time_ and arg_342_1.time_ <= 2.999999999999 + arg_345_0 and not isNil(var_345_15) and arg_342_1.var_.characterEffect1095ui_story == nil then
				arg_342_1.var_.characterEffect1095ui_story = var_345_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_16 = 0.200000002980232

			if 2.999999999999 <= arg_342_1.time_ and arg_342_1.time_ < 2.999999999999 + var_345_16 and not isNil(var_345_15) then
				if arg_342_1.var_.characterEffect1095ui_story and not isNil(var_345_15) then
					arg_342_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 2.999999999999 + var_345_16 and arg_342_1.time_ < 2.999999999999 + var_345_16 + arg_345_0 and not isNil(var_345_15) and arg_342_1.var_.characterEffect1095ui_story then
				arg_342_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2.999999999999 < arg_342_1.time_ and arg_342_1.time_ <= 2.999999999999 + arg_345_0 then
				arg_342_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_342_1.frameCnt_ <= 1 then
				arg_342_1.dialog_:SetActive(false)
			end

			local var_345_18 = 3
			local var_345_19 = 0.775

			if 3 < arg_342_1.time_ and arg_342_1.time_ <= var_345_18 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0

				arg_342_1.dialog_:SetActive(true)

				arg_342_1.dialogCg_.alpha = 0

				local var_345_20 = LeanTween.value(arg_342_1.dialog_, 0, 1, 0.3)

				var_345_20:setOnUpdate(LuaHelper.FloatAction(function(arg_346_0)
					arg_342_1.dialogCg_.alpha = arg_346_0
				end))
				var_345_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_342_1.dialog_)
					var_345_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_342_1.duration_ = arg_342_1.duration_ + 0.3

				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_21 = arg_342_1:GetWordFromCfg(411091082)
				local var_345_22 = arg_342_1:FormatText(var_345_21.content)

				arg_342_1.text_.text = var_345_22

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_24 = 31 <= 0 and var_345_19 or var_345_19 * (utf8.len(var_345_22) / 31)

				if (31 <= 0 and var_345_19 or var_345_19 * (utf8.len(var_345_22) / 31)) > 0 and var_345_19 < var_345_24 then
					arg_342_1.talkMaxDuration = var_345_24
					var_345_18 = var_345_18 + 0.3

					if var_345_24 + var_345_18 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_24 + var_345_18
					end
				end

				arg_342_1.text_.text = var_345_22
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091082", "story_v_out_411091.awb") ~= 0 then
					local var_345_25 = manager.audio:GetVoiceLength("story_v_out_411091", "411091082", "story_v_out_411091.awb") / 1000

					if var_345_25 + var_345_18 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_25 + var_345_18
					end

					if var_345_21.prefab_name ~= "" and arg_342_1.actors_[var_345_21.prefab_name] ~= nil then
						local var_345_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_21.prefab_name].transform, "story_v_out_411091", "411091082", "story_v_out_411091.awb")

						arg_342_1:RecordAudio("411091082", var_345_26)
						arg_342_1:RecordAudio("411091082", var_345_26)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_411091", "411091082", "story_v_out_411091.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_411091", "411091082", "story_v_out_411091.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_27 = var_345_18 + 0.3
			local var_345_28 = math.max(var_345_19, arg_342_1.talkMaxDuration)

			if var_345_18 + 0.3 <= arg_342_1.time_ and arg_342_1.time_ < var_345_27 + var_345_28 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_27) / var_345_28

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_27 + var_345_28 and arg_342_1.time_ < var_345_27 + var_345_28 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play411091083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 411091083
		arg_348_1.duration_ = 10.7

		local var_348_0 = {
			zh = 6.233,
			ja = 10.7
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play411091084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.775

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:GetWordFromCfg(411091083)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 31 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 31)

				if (31 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 31)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091083", "story_v_out_411091.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091083", "story_v_out_411091.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_411091", "411091083", "story_v_out_411091.awb")

						arg_348_1:RecordAudio("411091083", var_351_6)
						arg_348_1:RecordAudio("411091083", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_411091", "411091083", "story_v_out_411091.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_411091", "411091083", "story_v_out_411091.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play411091084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 411091084
		arg_352_1.duration_ = 1.73

		local var_352_0 = {
			zh = 1.066,
			ja = 1.733
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play411091085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.15

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_1 = arg_352_1:GetWordFromCfg(411091084)
				local var_355_2 = arg_352_1:FormatText(var_355_1.content)

				arg_352_1.text_.text = var_355_2

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_4 = 6 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 6)

				if (6 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 6)) > 0 and var_355_0 < var_355_4 then
					arg_352_1.talkMaxDuration = var_355_4

					if var_355_4 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_4 + 0
					end
				end

				arg_352_1.text_.text = var_355_2
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091084", "story_v_out_411091.awb") ~= 0 then
					local var_355_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091084", "story_v_out_411091.awb") / 1000

					if var_355_5 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + 0
					end

					if var_355_1.prefab_name ~= "" and arg_352_1.actors_[var_355_1.prefab_name] ~= nil then
						local var_355_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_1.prefab_name].transform, "story_v_out_411091", "411091084", "story_v_out_411091.awb")

						arg_352_1:RecordAudio("411091084", var_355_6)
						arg_352_1:RecordAudio("411091084", var_355_6)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_411091", "411091084", "story_v_out_411091.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_411091", "411091084", "story_v_out_411091.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_7 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_7

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play411091085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 411091085
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play411091086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1095ui_story = arg_356_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_356_1.time_ - 0) / var_359_0)
				arg_356_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1095ui_story"].transform.position).z)
				arg_356_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1095ui_story"].transform.localEulerAngles = arg_356_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_356_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1095ui_story"].transform.position).z)
				arg_356_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1095ui_story"].transform.localEulerAngles = arg_356_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_359_1 = 0
			local var_359_2 = 1.15

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_3 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(411091085).content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 46 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 46)

				if (46 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 46)) > 0 and var_359_2 < var_359_5 then
					arg_356_1.talkMaxDuration = var_359_5

					if var_359_5 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_6 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_6 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_6

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_6 and arg_356_1.time_ < var_359_1 + var_359_6 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
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

		arg_356_1:InitPlayNodeList()
	end,
	Play411091086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 411091086
		arg_360_1.duration_ = 1.77

		local var_360_0 = {
			zh = 1.133,
			ja = 1.766
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play411091087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos1095ui_story = arg_360_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_363_0 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 then
				arg_360_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_360_1.time_ - 0) / var_363_0)
				arg_360_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1095ui_story"].transform.position).z)
				arg_360_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1095ui_story"].transform.localEulerAngles = arg_360_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 then
				arg_360_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_360_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1095ui_story"].transform.position).z)
				arg_360_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1095ui_story"].transform.localEulerAngles = arg_360_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_363_1 = arg_360_1.actors_["1095ui_story"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1095ui_story == nil then
				arg_360_1.var_.characterEffect1095ui_story = var_363_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_2 and not isNil(var_363_1) then
				if arg_360_1.var_.characterEffect1095ui_story and not isNil(var_363_1) then
					arg_360_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_2 and arg_360_1.time_ < 0 + var_363_2 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect1095ui_story then
				arg_360_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_363_4 = 0
			local var_363_5 = 0.125

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(411091086)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 5 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 5)

				if (5 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 5)) > 0 and var_363_5 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091086", "story_v_out_411091.awb") ~= 0 then
					local var_363_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091086", "story_v_out_411091.awb") / 1000

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end

					if var_363_6.prefab_name ~= "" and arg_360_1.actors_[var_363_6.prefab_name] ~= nil then
						local var_363_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_6.prefab_name].transform, "story_v_out_411091", "411091086", "story_v_out_411091.awb")

						arg_360_1:RecordAudio("411091086", var_363_11)
						arg_360_1:RecordAudio("411091086", var_363_11)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_411091", "411091086", "story_v_out_411091.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_411091", "411091086", "story_v_out_411091.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_12 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_12 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_12

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_12 and arg_360_1.time_ < var_363_4 + var_363_12 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
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

		arg_360_1:InitPlayNodeList()
	end,
	Play411091087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 411091087
		arg_364_1.duration_ = 7.47

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play411091088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if arg_364_1.bgs_.STblack == nil then
				local var_367_0 = Object.Instantiate(arg_364_1.paintGo_)

				var_367_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_367_0.name = "STblack"
				var_367_0.transform.parent = arg_364_1.stage_.transform
				var_367_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_364_1.bgs_.STblack = var_367_0
			end

			if 1.999999999999 < arg_364_1.time_ and arg_364_1.time_ <= 1.999999999999 + arg_367_0 then
				local var_367_1 = arg_364_1.bgs_.STblack

				arg_364_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_367_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_367_2 = var_367_1:GetComponent("SpriteRenderer")

				if var_367_2 and var_367_2.sprite then
					local var_367_3 = 2 * (var_367_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_367_1.transform.localScale = Vector3.New(var_367_3 / var_367_2.sprite.bounds.size.y < var_367_3 * manager.ui.mainCameraCom_.aspect / var_367_2.sprite.bounds.size.x and var_367_3 * manager.ui.mainCameraCom_.aspect / var_367_2.sprite.bounds.size.x or var_367_3 / var_367_2.sprite.bounds.size.y, var_367_3 / var_367_2.sprite.bounds.size.y < var_367_3 * manager.ui.mainCameraCom_.aspect / var_367_2.sprite.bounds.size.x and var_367_3 * manager.ui.mainCameraCom_.aspect / var_367_2.sprite.bounds.size.x or var_367_3 / var_367_2.sprite.bounds.size.y, 0)
				end

				for iter_367_0, iter_367_1 in pairs(arg_364_1.bgs_) do
					if iter_367_0 ~= "STblack" then
						iter_367_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_367_4 = 0

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_4 + arg_367_0 then
				arg_364_1.mask_.enabled = true
				arg_364_1.mask_.raycastTarget = true

				arg_364_1:SetGaussion(false)
			end

			local var_367_5 = 2

			if var_367_4 <= arg_364_1.time_ and arg_364_1.time_ < var_367_4 + var_367_5 then
				local var_367_6 = Color.New(0, 0, 0)

				var_367_6.a = Mathf.Lerp(0, 1, (arg_364_1.time_ - var_367_4) / var_367_5)
				arg_364_1.mask_.color = var_367_6
			end

			if arg_364_1.time_ >= var_367_4 + var_367_5 and arg_364_1.time_ < var_367_4 + var_367_5 + arg_367_0 then
				local var_367_7 = Color.New(0, 0, 0)

				var_367_7.a = 1
				arg_364_1.mask_.color = var_367_7
			end

			local var_367_8 = 2

			if 2 < arg_364_1.time_ and arg_364_1.time_ <= var_367_8 + arg_367_0 then
				arg_364_1.mask_.enabled = true
				arg_364_1.mask_.raycastTarget = true

				arg_364_1:SetGaussion(false)
			end

			local var_367_9 = 2

			if var_367_8 <= arg_364_1.time_ and arg_364_1.time_ < var_367_8 + var_367_9 then
				local var_367_10 = Color.New(0, 0, 0)

				var_367_10.a = Mathf.Lerp(1, 0, (arg_364_1.time_ - var_367_8) / var_367_9)
				arg_364_1.mask_.color = var_367_10
			end

			if arg_364_1.time_ >= var_367_8 + var_367_9 and arg_364_1.time_ < var_367_8 + var_367_9 + arg_367_0 then
				local var_367_11 = Color.New(0, 0, 0)

				arg_364_1.mask_.enabled = false
				var_367_11.a = 0
				arg_364_1.mask_.color = var_367_11
			end

			local var_367_12 = arg_364_1.actors_["1095ui_story"].transform

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1095ui_story = var_367_12.localPosition
			end

			local var_367_13 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_13 then
				var_367_12.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_364_1.time_ - 0) / var_367_13)
				var_367_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_12.position).x, (manager.ui.mainCamera.transform.position - var_367_12.position).y, (manager.ui.mainCamera.transform.position - var_367_12.position).z)
				var_367_12.localEulerAngles.z = 0
				var_367_12.localEulerAngles.x = 0
				var_367_12.localEulerAngles = var_367_12.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_13 and arg_364_1.time_ < 0 + var_367_13 + arg_367_0 then
				var_367_12.localPosition = Vector3.New(0, 100, 0)
				var_367_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_12.position).x, (manager.ui.mainCamera.transform.position - var_367_12.position).y, (manager.ui.mainCamera.transform.position - var_367_12.position).z)
				var_367_12.localEulerAngles.z = 0
				var_367_12.localEulerAngles.x = 0
				var_367_12.localEulerAngles = var_367_12.localEulerAngles
			end

			local var_367_14 = arg_364_1.actors_["1095ui_story"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_14) and arg_364_1.var_.characterEffect1095ui_story == nil then
				arg_364_1.var_.characterEffect1095ui_story = var_367_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_15 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_15 and not isNil(var_367_14) then
				if arg_364_1.var_.characterEffect1095ui_story and not isNil(var_367_14) then
					arg_364_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_364_1.time_ - 0) / var_367_15)
				end
			end

			if arg_364_1.time_ >= 0 + var_367_15 and arg_364_1.time_ < 0 + var_367_15 + arg_367_0 and not isNil(var_367_14) and arg_364_1.var_.characterEffect1095ui_story then
				arg_364_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if arg_364_1.frameCnt_ <= 1 then
				arg_364_1.dialog_:SetActive(false)
			end

			local var_367_16 = 2.46666666666667
			local var_367_17 = 1.2

			if 2.46666666666667 < arg_364_1.time_ and arg_364_1.time_ <= var_367_16 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0

				arg_364_1.dialog_:SetActive(true)

				arg_364_1.dialogCg_.alpha = 0

				local var_367_18 = LeanTween.value(arg_364_1.dialog_, 0, 1, 0.3)

				var_367_18:setOnUpdate(LuaHelper.FloatAction(function(arg_368_0)
					arg_364_1.dialogCg_.alpha = arg_368_0
				end))
				var_367_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_364_1.dialog_)
					var_367_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_364_1.duration_ = arg_364_1.duration_ + 0.3

				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_19 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(411091087).content)

				arg_364_1.text_.text = var_367_19

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_21 = 48 <= 0 and var_367_17 or var_367_17 * (utf8.len(var_367_19) / 48)

				if (48 <= 0 and var_367_17 or var_367_17 * (utf8.len(var_367_19) / 48)) > 0 and var_367_17 < var_367_21 then
					arg_364_1.talkMaxDuration = var_367_21
					var_367_16 = var_367_16 + 0.3

					if var_367_21 + var_367_16 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_21 + var_367_16
					end
				end

				arg_364_1.text_.text = var_367_19
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_22 = var_367_16 + 0.3
			local var_367_23 = math.max(var_367_17, arg_364_1.talkMaxDuration)

			if var_367_16 + 0.3 <= arg_364_1.time_ and arg_364_1.time_ < var_367_22 + var_367_23 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_22) / var_367_23

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_22 + var_367_23 and arg_364_1.time_ < var_367_22 + var_367_23 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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

		arg_364_1:InitPlayNodeList()
	end,
	Play411091088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 411091088
		arg_370_1.duration_ = 10.7

		local var_370_0 = {
			zh = 8.30000000000199,
			ja = 10.700000000002
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play411091089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if arg_370_1.bgs_.ST71a == nil then
				local var_373_0 = Object.Instantiate(arg_370_1.paintGo_)

				var_373_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71a")
				var_373_0.name = "ST71a"
				var_373_0.transform.parent = arg_370_1.stage_.transform
				var_373_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_370_1.bgs_.ST71a = var_373_0
			end

			if 2.000000000001 < arg_370_1.time_ and arg_370_1.time_ <= 2.000000000001 + arg_373_0 then
				local var_373_1 = arg_370_1.bgs_.ST71a

				arg_370_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_373_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_373_2 = var_373_1:GetComponent("SpriteRenderer")

				if var_373_2 and var_373_2.sprite then
					local var_373_3 = 2 * (var_373_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_373_1.transform.localScale = Vector3.New(var_373_3 / var_373_2.sprite.bounds.size.y < var_373_3 * manager.ui.mainCameraCom_.aspect / var_373_2.sprite.bounds.size.x and var_373_3 * manager.ui.mainCameraCom_.aspect / var_373_2.sprite.bounds.size.x or var_373_3 / var_373_2.sprite.bounds.size.y, var_373_3 / var_373_2.sprite.bounds.size.y < var_373_3 * manager.ui.mainCameraCom_.aspect / var_373_2.sprite.bounds.size.x and var_373_3 * manager.ui.mainCameraCom_.aspect / var_373_2.sprite.bounds.size.x or var_373_3 / var_373_2.sprite.bounds.size.y, 0)
				end

				for iter_373_0, iter_373_1 in pairs(arg_370_1.bgs_) do
					if iter_373_0 ~= "ST71a" then
						iter_373_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_373_4 = 1.00008890058234e-12

			if 1.00008890058234e-12 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.mask_.enabled = true
				arg_370_1.mask_.raycastTarget = true

				arg_370_1:SetGaussion(false)
			end

			local var_373_5 = 2

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_5 then
				local var_373_6 = Color.New(0, 0, 0)

				var_373_6.a = Mathf.Lerp(0, 1, (arg_370_1.time_ - var_373_4) / var_373_5)
				arg_370_1.mask_.color = var_373_6
			end

			if arg_370_1.time_ >= var_373_4 + var_373_5 and arg_370_1.time_ < var_373_4 + var_373_5 + arg_373_0 then
				local var_373_7 = Color.New(0, 0, 0)

				var_373_7.a = 1
				arg_370_1.mask_.color = var_373_7
			end

			local var_373_8 = 2.000000000001

			if 2.000000000001 < arg_370_1.time_ and arg_370_1.time_ <= var_373_8 + arg_373_0 then
				arg_370_1.mask_.enabled = true
				arg_370_1.mask_.raycastTarget = true

				arg_370_1:SetGaussion(false)
			end

			local var_373_9 = 2

			if var_373_8 <= arg_370_1.time_ and arg_370_1.time_ < var_373_8 + var_373_9 then
				local var_373_10 = Color.New(0, 0, 0)

				var_373_10.a = Mathf.Lerp(1, 0, (arg_370_1.time_ - var_373_8) / var_373_9)
				arg_370_1.mask_.color = var_373_10
			end

			if arg_370_1.time_ >= var_373_8 + var_373_9 and arg_370_1.time_ < var_373_8 + var_373_9 + arg_373_0 then
				local var_373_11 = Color.New(0, 0, 0)

				arg_370_1.mask_.enabled = false
				var_373_11.a = 0
				arg_370_1.mask_.color = var_373_11
			end

			local var_373_12 = 2.000000000001

			arg_370_1.isInRecall_ = false

			if var_373_12 < arg_370_1.time_ and arg_370_1.time_ <= var_373_12 + arg_373_0 then
				arg_370_1.screenFilterGo_:SetActive(true)

				arg_370_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_373_2, iter_373_3 in pairs(arg_370_1.actors_) do
					for iter_373_4, iter_373_5 in ipairs((iter_373_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_373_5.color = iter_373_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_373_13 = 2.000000000001

			if var_373_12 <= arg_370_1.time_ and arg_370_1.time_ < var_373_12 + var_373_13 then
				arg_370_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_370_1.time_ - var_373_12) / var_373_13)
			end

			if arg_370_1.time_ >= var_373_12 + var_373_13 and arg_370_1.time_ < var_373_12 + var_373_13 + arg_373_0 then
				arg_370_1.screenFilterEffect_.weight = 1
			end

			if arg_370_1.frameCnt_ <= 1 then
				arg_370_1.dialog_:SetActive(false)
			end

			local var_373_14 = 4.00000000000199
			local var_373_15 = 0.45

			if 4.00000000000199 < arg_370_1.time_ and arg_370_1.time_ <= var_373_14 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				arg_370_1.dialog_:SetActive(true)

				arg_370_1.dialogCg_.alpha = 0

				local var_373_16 = LeanTween.value(arg_370_1.dialog_, 0, 1, 0.3)

				var_373_16:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_370_1.dialogCg_.alpha = arg_374_0
				end))
				var_373_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_370_1.dialog_)
					var_373_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_370_1.duration_ = arg_370_1.duration_ + 0.3

				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[684].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_17 = arg_370_1:GetWordFromCfg(411091088)
				local var_373_18 = arg_370_1:FormatText(var_373_17.content)

				arg_370_1.text_.text = var_373_18

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_20 = 18 <= 0 and var_373_15 or var_373_15 * (utf8.len(var_373_18) / 18)

				if (18 <= 0 and var_373_15 or var_373_15 * (utf8.len(var_373_18) / 18)) > 0 and var_373_15 < var_373_20 then
					arg_370_1.talkMaxDuration = var_373_20
					var_373_14 = var_373_14 + 0.3

					if var_373_20 + var_373_14 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_20 + var_373_14
					end
				end

				arg_370_1.text_.text = var_373_18
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091088", "story_v_out_411091.awb") ~= 0 then
					local var_373_21 = manager.audio:GetVoiceLength("story_v_out_411091", "411091088", "story_v_out_411091.awb") / 1000

					if var_373_21 + var_373_14 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_21 + var_373_14
					end

					if var_373_17.prefab_name ~= "" and arg_370_1.actors_[var_373_17.prefab_name] ~= nil then
						local var_373_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_17.prefab_name].transform, "story_v_out_411091", "411091088", "story_v_out_411091.awb")

						arg_370_1:RecordAudio("411091088", var_373_22)
						arg_370_1:RecordAudio("411091088", var_373_22)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_411091", "411091088", "story_v_out_411091.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_411091", "411091088", "story_v_out_411091.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_23 = var_373_14 + 0.3
			local var_373_24 = math.max(var_373_15, arg_370_1.talkMaxDuration)

			if var_373_14 + 0.3 <= arg_370_1.time_ and arg_370_1.time_ < var_373_23 + var_373_24 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_23) / var_373_24

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_23 + var_373_24 and arg_370_1.time_ < var_373_23 + var_373_24 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play411091089 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 411091089
		arg_376_1.duration_ = 3.63

		local var_376_0 = {
			zh = 3.633,
			ja = 2.8
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play411091090(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.275

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[685].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:GetWordFromCfg(411091089)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 11 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 11)

				if (11 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 11)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091089", "story_v_out_411091.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091089", "story_v_out_411091.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_out_411091", "411091089", "story_v_out_411091.awb")

						arg_376_1:RecordAudio("411091089", var_379_6)
						arg_376_1:RecordAudio("411091089", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_411091", "411091089", "story_v_out_411091.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_411091", "411091089", "story_v_out_411091.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play411091090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 411091090
		arg_380_1.duration_ = 7.23

		local var_380_0 = {
			zh = 3.433,
			ja = 7.233
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play411091091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.425

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[684].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:GetWordFromCfg(411091090)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.text_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 17 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 17)

				if (17 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 17)) > 0 and var_383_0 < var_383_4 then
					arg_380_1.talkMaxDuration = var_383_4

					if var_383_4 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_4 + 0
					end
				end

				arg_380_1.text_.text = var_383_2
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091090", "story_v_out_411091.awb") ~= 0 then
					local var_383_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091090", "story_v_out_411091.awb") / 1000

					if var_383_5 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + 0
					end

					if var_383_1.prefab_name ~= "" and arg_380_1.actors_[var_383_1.prefab_name] ~= nil then
						local var_383_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_1.prefab_name].transform, "story_v_out_411091", "411091090", "story_v_out_411091.awb")

						arg_380_1:RecordAudio("411091090", var_383_6)
						arg_380_1:RecordAudio("411091090", var_383_6)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_411091", "411091090", "story_v_out_411091.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_411091", "411091090", "story_v_out_411091.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play411091091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 411091091
		arg_384_1.duration_ = 10.73

		local var_384_0 = {
			zh = 10.0666666666667,
			ja = 10.7326666666667
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play411091092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				local var_387_0 = arg_384_1.bgs_.ST71a

				arg_384_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_387_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_387_1 = var_387_0:GetComponent("SpriteRenderer")

				if var_387_1 and var_387_1.sprite then
					local var_387_2 = 2 * (var_387_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_387_0.transform.localScale = Vector3.New(var_387_2 / var_387_1.sprite.bounds.size.y < var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x and var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x or var_387_2 / var_387_1.sprite.bounds.size.y, var_387_2 / var_387_1.sprite.bounds.size.y < var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x and var_387_2 * manager.ui.mainCameraCom_.aspect / var_387_1.sprite.bounds.size.x or var_387_2 / var_387_1.sprite.bounds.size.y, 0)
				end

				for iter_387_0, iter_387_1 in pairs(arg_384_1.bgs_) do
					if iter_387_0 ~= "ST71a" then
						iter_387_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.36666666666667 < arg_384_1.time_ and arg_384_1.time_ <= 1.36666666666667 + arg_387_0 then
				local var_387_3 = arg_384_1.bgs_.ST71a

				arg_384_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_387_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_387_4 = var_387_3:GetComponent("SpriteRenderer")

				if var_387_4 and var_387_4.sprite then
					local var_387_5 = 2 * (var_387_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_387_3.transform.localScale = Vector3.New(var_387_5 / var_387_4.sprite.bounds.size.y < var_387_5 * manager.ui.mainCameraCom_.aspect / var_387_4.sprite.bounds.size.x and var_387_5 * manager.ui.mainCameraCom_.aspect / var_387_4.sprite.bounds.size.x or var_387_5 / var_387_4.sprite.bounds.size.y, var_387_5 / var_387_4.sprite.bounds.size.y < var_387_5 * manager.ui.mainCameraCom_.aspect / var_387_4.sprite.bounds.size.x and var_387_5 * manager.ui.mainCameraCom_.aspect / var_387_4.sprite.bounds.size.x or var_387_5 / var_387_4.sprite.bounds.size.y, 0)
				end

				for iter_387_2, iter_387_3 in pairs(arg_384_1.bgs_) do
					if iter_387_2 ~= "ST71a" then
						iter_387_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_387_6 = 0

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = true

				arg_384_1:SetGaussion(false)
			end

			local var_387_7 = 1.36666666666667

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_7 then
				local var_387_8 = Color.New(0, 0, 0)

				var_387_8.a = Mathf.Lerp(0, 1, (arg_384_1.time_ - var_387_6) / var_387_7)
				arg_384_1.mask_.color = var_387_8
			end

			if arg_384_1.time_ >= var_387_6 + var_387_7 and arg_384_1.time_ < var_387_6 + var_387_7 + arg_387_0 then
				local var_387_9 = Color.New(0, 0, 0)

				var_387_9.a = 1
				arg_384_1.mask_.color = var_387_9
			end

			local var_387_10 = 1.36666666666667

			if 1.36666666666667 < arg_384_1.time_ and arg_384_1.time_ <= var_387_10 + arg_387_0 then
				arg_384_1.mask_.enabled = true
				arg_384_1.mask_.raycastTarget = true

				arg_384_1:SetGaussion(false)
			end

			local var_387_11 = 1.3

			if var_387_10 <= arg_384_1.time_ and arg_384_1.time_ < var_387_10 + var_387_11 then
				local var_387_12 = Color.New(0, 0, 0)

				var_387_12.a = Mathf.Lerp(1, 0, (arg_384_1.time_ - var_387_10) / var_387_11)
				arg_384_1.mask_.color = var_387_12
			end

			if arg_384_1.time_ >= var_387_10 + var_387_11 and arg_384_1.time_ < var_387_10 + var_387_11 + arg_387_0 then
				local var_387_13 = Color.New(0, 0, 0)

				arg_384_1.mask_.enabled = false
				var_387_13.a = 0
				arg_384_1.mask_.color = var_387_13
			end

			if arg_384_1.frameCnt_ <= 1 then
				arg_384_1.dialog_:SetActive(false)
			end

			local var_387_14 = 2.66666666666667
			local var_387_15 = 0.975

			if 2.66666666666667 < arg_384_1.time_ and arg_384_1.time_ <= var_387_14 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0

				arg_384_1.dialog_:SetActive(true)

				arg_384_1.dialogCg_.alpha = 0

				local var_387_16 = LeanTween.value(arg_384_1.dialog_, 0, 1, 0.3)

				var_387_16:setOnUpdate(LuaHelper.FloatAction(function(arg_388_0)
					arg_384_1.dialogCg_.alpha = arg_388_0
				end))
				var_387_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_384_1.dialog_)
					var_387_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_384_1.duration_ = arg_384_1.duration_ + 0.3

				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[684].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_17 = arg_384_1:GetWordFromCfg(411091091)
				local var_387_18 = arg_384_1:FormatText(var_387_17.content)

				arg_384_1.text_.text = var_387_18

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_20 = 39 <= 0 and var_387_15 or var_387_15 * (utf8.len(var_387_18) / 39)

				if (39 <= 0 and var_387_15 or var_387_15 * (utf8.len(var_387_18) / 39)) > 0 and var_387_15 < var_387_20 then
					arg_384_1.talkMaxDuration = var_387_20
					var_387_14 = var_387_14 + 0.3

					if var_387_20 + var_387_14 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_20 + var_387_14
					end
				end

				arg_384_1.text_.text = var_387_18
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091091", "story_v_out_411091.awb") ~= 0 then
					local var_387_21 = manager.audio:GetVoiceLength("story_v_out_411091", "411091091", "story_v_out_411091.awb") / 1000

					if var_387_21 + var_387_14 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_21 + var_387_14
					end

					if var_387_17.prefab_name ~= "" and arg_384_1.actors_[var_387_17.prefab_name] ~= nil then
						local var_387_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_17.prefab_name].transform, "story_v_out_411091", "411091091", "story_v_out_411091.awb")

						arg_384_1:RecordAudio("411091091", var_387_22)
						arg_384_1:RecordAudio("411091091", var_387_22)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_411091", "411091091", "story_v_out_411091.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_411091", "411091091", "story_v_out_411091.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_23 = var_387_14 + 0.3
			local var_387_24 = math.max(var_387_15, arg_384_1.talkMaxDuration)

			if var_387_14 + 0.3 <= arg_384_1.time_ and arg_384_1.time_ < var_387_23 + var_387_24 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_23) / var_387_24

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_23 + var_387_24 and arg_384_1.time_ < var_387_23 + var_387_24 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play411091092 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 411091092
		arg_390_1.duration_ = 4.5

		local var_390_0 = {
			zh = 3.5,
			ja = 4.5
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play411091093(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.45

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[684].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:GetWordFromCfg(411091092)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 18 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 18)

				if (18 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 18)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091092", "story_v_out_411091.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091092", "story_v_out_411091.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_out_411091", "411091092", "story_v_out_411091.awb")

						arg_390_1:RecordAudio("411091092", var_393_6)
						arg_390_1:RecordAudio("411091092", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_411091", "411091092", "story_v_out_411091.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_411091", "411091092", "story_v_out_411091.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play411091093 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 411091093
		arg_394_1.duration_ = 2.93

		local var_394_0 = {
			zh = 1.333,
			ja = 2.933
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play411091094(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.1

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[685].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:GetWordFromCfg(411091093)
				local var_397_2 = arg_394_1:FormatText(var_397_1.content)

				arg_394_1.text_.text = var_397_2

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 4 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 4)

				if (4 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 4)) > 0 and var_397_0 < var_397_4 then
					arg_394_1.talkMaxDuration = var_397_4

					if var_397_4 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_4 + 0
					end
				end

				arg_394_1.text_.text = var_397_2
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091093", "story_v_out_411091.awb") ~= 0 then
					local var_397_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091093", "story_v_out_411091.awb") / 1000

					if var_397_5 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + 0
					end

					if var_397_1.prefab_name ~= "" and arg_394_1.actors_[var_397_1.prefab_name] ~= nil then
						local var_397_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_1.prefab_name].transform, "story_v_out_411091", "411091093", "story_v_out_411091.awb")

						arg_394_1:RecordAudio("411091093", var_397_6)
						arg_394_1:RecordAudio("411091093", var_397_6)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_411091", "411091093", "story_v_out_411091.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_411091", "411091093", "story_v_out_411091.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play411091094 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 411091094
		arg_398_1.duration_ = 9.33

		local var_398_0 = {
			zh = 6.5,
			ja = 9.333
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play411091095(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.75

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[685].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:GetWordFromCfg(411091094)
				local var_401_2 = arg_398_1:FormatText(var_401_1.content)

				arg_398_1.text_.text = var_401_2

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_4 = 30 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 30)

				if (30 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_2) / 30)) > 0 and var_401_0 < var_401_4 then
					arg_398_1.talkMaxDuration = var_401_4

					if var_401_4 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_4 + 0
					end
				end

				arg_398_1.text_.text = var_401_2
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091094", "story_v_out_411091.awb") ~= 0 then
					local var_401_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091094", "story_v_out_411091.awb") / 1000

					if var_401_5 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_5 + 0
					end

					if var_401_1.prefab_name ~= "" and arg_398_1.actors_[var_401_1.prefab_name] ~= nil then
						local var_401_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_1.prefab_name].transform, "story_v_out_411091", "411091094", "story_v_out_411091.awb")

						arg_398_1:RecordAudio("411091094", var_401_6)
						arg_398_1:RecordAudio("411091094", var_401_6)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_411091", "411091094", "story_v_out_411091.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_411091", "411091094", "story_v_out_411091.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_7 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_7

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play411091095 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 411091095
		arg_402_1.duration_ = 7.43

		local var_402_0 = {
			zh = 6.766,
			ja = 7.433
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play411091096(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.6

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[685].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_1 = arg_402_1:GetWordFromCfg(411091095)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 24 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 24)

				if (24 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 24)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091095", "story_v_out_411091.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091095", "story_v_out_411091.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_out_411091", "411091095", "story_v_out_411091.awb")

						arg_402_1:RecordAudio("411091095", var_405_6)
						arg_402_1:RecordAudio("411091095", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_411091", "411091095", "story_v_out_411091.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_411091", "411091095", "story_v_out_411091.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play411091096 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 411091096
		arg_406_1.duration_ = 7

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play411091097(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				local var_409_0 = arg_406_1.bgs_.B01b

				arg_406_1.bgs_.B01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_409_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_409_1 = var_409_0:GetComponent("SpriteRenderer")

				if var_409_1 and var_409_1.sprite then
					local var_409_2 = 2 * (var_409_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_409_0.transform.localScale = Vector3.New(var_409_2 / var_409_1.sprite.bounds.size.y < var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x and var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x or var_409_2 / var_409_1.sprite.bounds.size.y, var_409_2 / var_409_1.sprite.bounds.size.y < var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x and var_409_2 * manager.ui.mainCameraCom_.aspect / var_409_1.sprite.bounds.size.x or var_409_2 / var_409_1.sprite.bounds.size.y, 0)
				end

				for iter_409_0, iter_409_1 in pairs(arg_406_1.bgs_) do
					if iter_409_0 ~= "B01b" then
						iter_409_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_409_3 = 0

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_3 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_4 = 1

			if var_409_3 <= arg_406_1.time_ and arg_406_1.time_ < var_409_3 + var_409_4 then
				local var_409_5 = Color.New(1, 1, 1)

				var_409_5.a = Mathf.Lerp(1, 0, (arg_406_1.time_ - var_409_3) / var_409_4)
				arg_406_1.mask_.color = var_409_5
			end

			if arg_406_1.time_ >= var_409_3 + var_409_4 and arg_406_1.time_ < var_409_3 + var_409_4 + arg_409_0 then
				local var_409_6 = Color.New(1, 1, 1)

				arg_406_1.mask_.enabled = false
				var_409_6.a = 0
				arg_406_1.mask_.color = var_409_6
			end

			local var_409_7 = 0

			arg_406_1.isInRecall_ = false

			if var_409_7 < arg_406_1.time_ and arg_406_1.time_ <= var_409_7 + arg_409_0 then
				arg_406_1.screenFilterGo_:SetActive(false)

				for iter_409_2, iter_409_3 in pairs(arg_406_1.actors_) do
					for iter_409_4, iter_409_5 in ipairs((iter_409_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_409_5.color = iter_409_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_409_8 = 2.000000000001

			if var_409_7 <= arg_406_1.time_ and arg_406_1.time_ < var_409_7 + var_409_8 then
				arg_406_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_406_1.time_ - var_409_7) / var_409_8)
			end

			if arg_406_1.time_ >= var_409_7 + var_409_8 and arg_406_1.time_ < var_409_7 + var_409_8 + arg_409_0 then
				arg_406_1.screenFilterEffect_.weight = 0
			end

			if arg_406_1.frameCnt_ <= 1 then
				arg_406_1.dialog_:SetActive(false)
			end

			local var_409_9 = 2
			local var_409_10 = 1.125

			if 2 < arg_406_1.time_ and arg_406_1.time_ <= var_409_9 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0

				arg_406_1.dialog_:SetActive(true)

				arg_406_1.dialogCg_.alpha = 0

				local var_409_11 = LeanTween.value(arg_406_1.dialog_, 0, 1, 0.3)

				var_409_11:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_406_1.dialogCg_.alpha = arg_410_0
				end))
				var_409_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_406_1.dialog_)
					var_409_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_406_1.duration_ = arg_406_1.duration_ + 0.3

				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_12 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(411091096).content)

				arg_406_1.text_.text = var_409_12

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_14 = 45 <= 0 and var_409_10 or var_409_10 * (utf8.len(var_409_12) / 45)

				if (45 <= 0 and var_409_10 or var_409_10 * (utf8.len(var_409_12) / 45)) > 0 and var_409_10 < var_409_14 then
					arg_406_1.talkMaxDuration = var_409_14
					var_409_9 = var_409_9 + 0.3

					if var_409_14 + var_409_9 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_14 + var_409_9
					end
				end

				arg_406_1.text_.text = var_409_12
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_15 = var_409_9 + 0.3
			local var_409_16 = math.max(var_409_10, arg_406_1.talkMaxDuration)

			if var_409_9 + 0.3 <= arg_406_1.time_ and arg_406_1.time_ < var_409_15 + var_409_16 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_15) / var_409_16

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_15 + var_409_16 and arg_406_1.time_ < var_409_15 + var_409_16 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play411091097 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 411091097
		arg_412_1.duration_ = 7.47

		local var_412_0 = {
			zh = 7.466,
			ja = 3.5
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play411091098(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos1095ui_story = arg_412_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_415_0 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 then
				arg_412_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_412_1.time_ - 0) / var_415_0)
				arg_412_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1095ui_story"].transform.position).z)
				arg_412_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1095ui_story"].transform.localEulerAngles = arg_412_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 then
				arg_412_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_412_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_412_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_412_1.actors_["1095ui_story"].transform.position).z)
				arg_412_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_412_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_412_1.actors_["1095ui_story"].transform.localEulerAngles = arg_412_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_415_1 = arg_412_1.actors_["1095ui_story"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect1095ui_story == nil then
				arg_412_1.var_.characterEffect1095ui_story = var_415_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_2 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_2 and not isNil(var_415_1) then
				if arg_412_1.var_.characterEffect1095ui_story and not isNil(var_415_1) then
					arg_412_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= 0 + var_415_2 and arg_412_1.time_ < 0 + var_415_2 + arg_415_0 and not isNil(var_415_1) and arg_412_1.var_.characterEffect1095ui_story then
				arg_412_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_415_4 = 0
			local var_415_5 = 0.575

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_4 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_6 = arg_412_1:GetWordFromCfg(411091097)
				local var_415_7 = arg_412_1:FormatText(var_415_6.content)

				arg_412_1.text_.text = var_415_7

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_9 = 23 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 23)

				if (23 <= 0 and var_415_5 or var_415_5 * (utf8.len(var_415_7) / 23)) > 0 and var_415_5 < var_415_9 then
					arg_412_1.talkMaxDuration = var_415_9

					if var_415_9 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_9 + var_415_4
					end
				end

				arg_412_1.text_.text = var_415_7
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091097", "story_v_out_411091.awb") ~= 0 then
					local var_415_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091097", "story_v_out_411091.awb") / 1000

					if var_415_10 + var_415_4 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_10 + var_415_4
					end

					if var_415_6.prefab_name ~= "" and arg_412_1.actors_[var_415_6.prefab_name] ~= nil then
						local var_415_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_6.prefab_name].transform, "story_v_out_411091", "411091097", "story_v_out_411091.awb")

						arg_412_1:RecordAudio("411091097", var_415_11)
						arg_412_1:RecordAudio("411091097", var_415_11)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_411091", "411091097", "story_v_out_411091.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_411091", "411091097", "story_v_out_411091.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_12 = math.max(var_415_5, arg_412_1.talkMaxDuration)

			if var_415_4 <= arg_412_1.time_ and arg_412_1.time_ < var_415_4 + var_415_12 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_4) / var_415_12

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_4 + var_415_12 and arg_412_1.time_ < var_415_4 + var_415_12 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
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

		arg_412_1:InitPlayNodeList()
	end,
	Play411091098 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 411091098
		arg_416_1.duration_ = 10.7

		local var_416_0 = {
			zh = 10.7,
			ja = 10.066
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play411091099(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.9

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_1 = arg_416_1:GetWordFromCfg(411091098)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 36 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 36)

				if (36 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 36)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091098", "story_v_out_411091.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_411091", "411091098", "story_v_out_411091.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_411091", "411091098", "story_v_out_411091.awb")

						arg_416_1:RecordAudio("411091098", var_419_6)
						arg_416_1:RecordAudio("411091098", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_411091", "411091098", "story_v_out_411091.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_411091", "411091098", "story_v_out_411091.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play411091099 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 411091099
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play411091100(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1095ui_story = arg_420_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_423_0 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				arg_420_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1095ui_story"].transform.position).z)
				arg_420_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1095ui_story"].transform.localEulerAngles = arg_420_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				arg_420_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_420_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1095ui_story"].transform.position).z)
				arg_420_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1095ui_story"].transform.localEulerAngles = arg_420_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_423_1 = 0

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_2 = 0.333333333333333

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 then
				local var_423_3 = Color.New(1, 1, 1)

				var_423_3.a = Mathf.Lerp(1, 0, (arg_420_1.time_ - var_423_1) / var_423_2)
				arg_420_1.mask_.color = var_423_3
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 then
				local var_423_4 = Color.New(1, 1, 1)

				arg_420_1.mask_.enabled = false
				var_423_4.a = 0
				arg_420_1.mask_.color = var_423_4
			end

			local var_423_5 = manager.ui.mainCamera.transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.shakeOldPos = var_423_5.localPosition
			end

			local var_423_6 = 0.7

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_6 then
				local var_423_7, var_423_8 = math.modf((arg_420_1.time_ - 0) / 0.066)

				var_423_5.localPosition = Vector3.New(var_423_8 * 0.13, var_423_8 * 0.13, var_423_8 * 0.13) + arg_420_1.var_.shakeOldPos
			end

			if arg_420_1.time_ >= 0 + var_423_6 and arg_420_1.time_ < 0 + var_423_6 + arg_423_0 then
				var_423_5.localPosition = arg_420_1.var_.shakeOldPos
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_423_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_420_1.bgmTxt_.text ~= var_423_11 and arg_420_1.bgmTxt_.text ~= "" then
						if arg_420_1.bgmTxt2_.text ~= "" then
							arg_420_1.bgmTxt_.text = arg_420_1.bgmTxt2_.text
						end

						arg_420_1.bgmTxt2_.text = var_423_11

						arg_420_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_420_1.bgmTxt_.text = var_423_11
						arg_420_1.bgmTxt2_.text = var_423_11
					end

					if arg_420_1.bgmTimer then
						arg_420_1.bgmTimer:Stop()

						arg_420_1.bgmTimer = nil
					end

					if arg_420_1.settingData.show_music_name == 1 then
						arg_420_1.musicController:SetSelectedState("show")
						arg_420_1.musicAnimator_:Play("open", 0, 0)

						if arg_420_1.settingData.music_time ~= 0 then
							arg_420_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_420_1.settingData.music_time), function()
								if arg_420_1 == nil or isNil(arg_420_1.bgmTxt_) then
									return
								end

								arg_420_1.musicController:SetSelectedState("hide")
								arg_420_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:AudioAction("play", "effect", "se_story_131", "se_story_131__wall", "")
			end

			local var_423_13 = 0
			local var_423_14 = 1.425

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_13 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_15 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(411091099).content)

				arg_420_1.text_.text = var_423_15

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_17 = 57 <= 0 and var_423_14 or var_423_14 * (utf8.len(var_423_15) / 57)

				if (57 <= 0 and var_423_14 or var_423_14 * (utf8.len(var_423_15) / 57)) > 0 and var_423_14 < var_423_17 then
					arg_420_1.talkMaxDuration = var_423_17

					if var_423_17 + var_423_13 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_17 + var_423_13
					end
				end

				arg_420_1.text_.text = var_423_15
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_18 = math.max(var_423_14, arg_420_1.talkMaxDuration)

			if var_423_13 <= arg_420_1.time_ and arg_420_1.time_ < var_423_13 + var_423_18 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_13) / var_423_18

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_13 + var_423_18 and arg_420_1.time_ < var_423_13 + var_423_18 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
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

		arg_420_1:InitPlayNodeList()
	end,
	Play411091100 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 411091100
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play411091101(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_428_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_425_1.bgmTxt_.text ~= var_428_2 and arg_425_1.bgmTxt_.text ~= "" then
						if arg_425_1.bgmTxt2_.text ~= "" then
							arg_425_1.bgmTxt_.text = arg_425_1.bgmTxt2_.text
						end

						arg_425_1.bgmTxt2_.text = var_428_2

						arg_425_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_425_1.bgmTxt_.text = var_428_2
						arg_425_1.bgmTxt2_.text = var_428_2
					end

					if arg_425_1.bgmTimer then
						arg_425_1.bgmTimer:Stop()

						arg_425_1.bgmTimer = nil
					end

					if arg_425_1.settingData.show_music_name == 1 then
						arg_425_1.musicController:SetSelectedState("show")
						arg_425_1.musicAnimator_:Play("open", 0, 0)

						if arg_425_1.settingData.music_time ~= 0 then
							arg_425_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_425_1.settingData.music_time), function()
								if arg_425_1 == nil or isNil(arg_425_1.bgmTxt_) then
									return
								end

								arg_425_1.musicController:SetSelectedState("hide")
								arg_425_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:AudioAction("play", "effect", "se_story_15", "se_story_15_roar3", "")
			end

			local var_428_4 = 0
			local var_428_5 = 0.15

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[683].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_robota")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_6 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(411091100).content)

				arg_425_1.text_.text = var_428_6

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_8 = 6 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_6) / 6)

				if (6 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_6) / 6)) > 0 and var_428_5 < var_428_8 then
					arg_425_1.talkMaxDuration = var_428_8

					if var_428_8 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_8 + var_428_4
					end
				end

				arg_425_1.text_.text = var_428_6
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_9 = math.max(var_428_5, arg_425_1.talkMaxDuration)

			if var_428_4 <= arg_425_1.time_ and arg_425_1.time_ < var_428_4 + var_428_9 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_4) / var_428_9

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_4 + var_428_9 and arg_425_1.time_ < var_428_4 + var_428_9 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play411091101 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 411091101
		arg_430_1.duration_ = 3.87

		local var_430_0 = {
			zh = 2.266,
			ja = 3.866
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
			arg_430_1.auto_ = false
		end

		function arg_430_1.playNext_(arg_432_0)
			arg_430_1.onStoryFinished_()
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.var_.moveOldPos1095ui_story = arg_430_1.actors_["1095ui_story"].transform.localPosition

				arg_430_1:ShowWeapon(arg_430_1.var_["1095ui_story" .. "Animator"].transform, true)
			end

			local var_433_0 = 0.001

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 then
				arg_430_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_430_1.time_ - 0) / var_433_0)
				arg_430_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1095ui_story"].transform.position).z)
				arg_430_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1095ui_story"].transform.localEulerAngles = arg_430_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 then
				arg_430_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_430_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_430_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_430_1.actors_["1095ui_story"].transform.position).z)
				arg_430_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_430_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_430_1.actors_["1095ui_story"].transform.localEulerAngles = arg_430_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_433_1 = arg_430_1.actors_["1095ui_story"]

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1095ui_story == nil then
				arg_430_1.var_.characterEffect1095ui_story = var_433_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_2 and not isNil(var_433_1) then
				if arg_430_1.var_.characterEffect1095ui_story and not isNil(var_433_1) then
					arg_430_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_430_1.time_ >= 0 + var_433_2 and arg_430_1.time_ < 0 + var_433_2 + arg_433_0 and not isNil(var_433_1) and arg_430_1.var_.characterEffect1095ui_story then
				arg_430_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_433_4 = 0
			local var_433_5 = 0.3

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_4 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_6 = arg_430_1:GetWordFromCfg(411091101)
				local var_433_7 = arg_430_1:FormatText(var_433_6.content)

				arg_430_1.text_.text = var_433_7

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_9 = 12 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 12)

				if (12 <= 0 and var_433_5 or var_433_5 * (utf8.len(var_433_7) / 12)) > 0 and var_433_5 < var_433_9 then
					arg_430_1.talkMaxDuration = var_433_9

					if var_433_9 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_9 + var_433_4
					end
				end

				arg_430_1.text_.text = var_433_7
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411091", "411091101", "story_v_out_411091.awb") ~= 0 then
					local var_433_10 = manager.audio:GetVoiceLength("story_v_out_411091", "411091101", "story_v_out_411091.awb") / 1000

					if var_433_10 + var_433_4 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_4
					end

					if var_433_6.prefab_name ~= "" and arg_430_1.actors_[var_433_6.prefab_name] ~= nil then
						local var_433_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_6.prefab_name].transform, "story_v_out_411091", "411091101", "story_v_out_411091.awb")

						arg_430_1:RecordAudio("411091101", var_433_11)
						arg_430_1:RecordAudio("411091101", var_433_11)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_411091", "411091101", "story_v_out_411091.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_411091", "411091101", "story_v_out_411091.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_12 = math.max(var_433_5, arg_430_1.talkMaxDuration)

			if var_433_4 <= arg_430_1.time_ and arg_430_1.time_ < var_433_4 + var_433_12 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_4) / var_433_12

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_4 + var_433_12 and arg_430_1.time_ < var_433_4 + var_433_12 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
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

		arg_430_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03e",
		"TextureConfig/Background/B01b",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST71a"
	},
	voices = {
		"story_v_out_411091.awb"
	}
}
