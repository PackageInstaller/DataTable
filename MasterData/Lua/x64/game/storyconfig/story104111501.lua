return {
	Play411151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411151001
		arg_1_1.duration_ = 8.67

		local var_1_0 = {
			zh = 7.266,
			ja = 8.666
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
				arg_1_0:Play411151002(arg_1_1)
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

			local var_4_8 = "1095ui_story"

			if arg_1_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1095ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1095ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.98, -6.1)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1095ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1095ui_story == nil then
				arg_1_1.var_.characterEffect1095ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1095ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1095ui_story then
				arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.7

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(411151001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 28 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 28)

				if (28 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 28)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151001", "story_v_out_411151.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_411151", "411151001", "story_v_out_411151.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_411151", "411151001", "story_v_out_411151.awb")

						arg_1_1:RecordAudio("411151001", var_4_28)
						arg_1_1:RecordAudio("411151001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_411151", "411151001", "story_v_out_411151.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_411151", "411151001", "story_v_out_411151.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
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

		arg_1_1:InitPlayNodeList()
	end,
	Play411151002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 411151002
		arg_8_1.duration_ = 5.9

		local var_8_0 = {
			zh = 3.433,
			ja = 5.9
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play411151003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.4

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(411151002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 16)

				if (16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 16)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151002", "story_v_out_411151.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151002", "story_v_out_411151.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_411151", "411151002", "story_v_out_411151.awb")

						arg_8_1:RecordAudio("411151002", var_11_6)
						arg_8_1:RecordAudio("411151002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_411151", "411151002", "story_v_out_411151.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_411151", "411151002", "story_v_out_411151.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play411151003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 411151003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play411151004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1095ui_story"]) and arg_12_1.var_.characterEffect1095ui_story == nil then
				arg_12_1.var_.characterEffect1095ui_story = arg_12_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1095ui_story"]) then
				if arg_12_1.var_.characterEffect1095ui_story and not isNil(arg_12_1.actors_["1095ui_story"]) then
					arg_12_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1095ui_story"]) and arg_12_1.var_.characterEffect1095ui_story then
				arg_12_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_15_1 = arg_12_1.actors_["1095ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1095ui_story = var_15_1.localPosition
			end

			local var_15_2 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_2 then
				var_15_1.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_2)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_2 and arg_12_1.time_ < 0 + var_15_2 + arg_15_0 then
				var_15_1.localPosition = Vector3.New(0, 100, 0)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles
			end

			local var_15_3 = 0
			local var_15_4 = 0.65

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_3 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_5 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(411151003).content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 26 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_5) / 26)

				if (26 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_5) / 26)) > 0 and var_15_4 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_3 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_3
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_4, arg_12_1.talkMaxDuration)

			if var_15_3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_3 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_3) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_3 + var_15_8 and arg_12_1.time_ < var_15_3 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play411151004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 411151004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play411151005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.725

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(411151004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 29 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 29)

				if (29 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 29)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play411151005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 411151005
		arg_20_1.duration_ = 5.3

		local var_20_0 = {
			zh = 5.3,
			ja = 4.2
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play411151006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1095ui_story"]) and arg_20_1.var_.characterEffect1095ui_story == nil then
				arg_20_1.var_.characterEffect1095ui_story = arg_20_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1095ui_story"]) then
				if arg_20_1.var_.characterEffect1095ui_story and not isNil(arg_20_1.actors_["1095ui_story"]) then
					arg_20_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1095ui_story"]) and arg_20_1.var_.characterEffect1095ui_story then
				arg_20_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_23_2 = 0
			local var_23_3 = 0.45

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_4 = arg_20_1:GetWordFromCfg(411151005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 18 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 18)

				if (18 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 18)) > 0 and var_23_3 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151005", "story_v_out_411151.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_411151", "411151005", "story_v_out_411151.awb") / 1000

					if var_23_8 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_2
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_411151", "411151005", "story_v_out_411151.awb")

						arg_20_1:RecordAudio("411151005", var_23_9)
						arg_20_1:RecordAudio("411151005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_411151", "411151005", "story_v_out_411151.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_411151", "411151005", "story_v_out_411151.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_10 and arg_20_1.time_ < var_23_2 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play411151006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 411151006
		arg_24_1.duration_ = 9

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play411151007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.bgs_.ST74a == nil then
				local var_27_0 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74a")
				var_27_0.name = "ST74a"
				var_27_0.transform.parent = arg_24_1.stage_.transform
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_.ST74a = var_27_0
			end

			if 2 < arg_24_1.time_ and arg_24_1.time_ <= 2 + arg_27_0 then
				local var_27_1 = arg_24_1.bgs_.ST74a

				arg_24_1.bgs_.ST74a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_2 = var_27_1:GetComponent("SpriteRenderer")

				if var_27_2 and var_27_2.sprite then
					local var_27_3 = 2 * (var_27_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_1.transform.localScale = Vector3.New(var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "ST74a" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_4 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_5 = 2

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_5 then
				local var_27_6 = Color.New(0, 0, 0)

				var_27_6.a = Mathf.Lerp(0, 1, (arg_24_1.time_ - var_27_4) / var_27_5)
				arg_24_1.mask_.color = var_27_6
			end

			if arg_24_1.time_ >= var_27_4 + var_27_5 and arg_24_1.time_ < var_27_4 + var_27_5 + arg_27_0 then
				local var_27_7 = Color.New(0, 0, 0)

				var_27_7.a = 1
				arg_24_1.mask_.color = var_27_7
			end

			local var_27_8 = 2

			if 2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_9 = 2

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_9 then
				local var_27_10 = Color.New(0, 0, 0)

				var_27_10.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_8) / var_27_9)
				arg_24_1.mask_.color = var_27_10
			end

			if arg_24_1.time_ >= var_27_8 + var_27_9 and arg_24_1.time_ < var_27_8 + var_27_9 + arg_27_0 then
				local var_27_11 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_11.a = 0
				arg_24_1.mask_.color = var_27_11
			end

			local var_27_12 = arg_24_1.actors_["1095ui_story"].transform

			if 2 < arg_24_1.time_ and arg_24_1.time_ <= 2 + arg_27_0 then
				arg_24_1.var_.moveOldPos1095ui_story = var_27_12.localPosition
			end

			local var_27_13 = 0.001

			if 2 <= arg_24_1.time_ and arg_24_1.time_ < 2 + var_27_13 then
				var_27_12.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 2) / var_27_13)
				var_27_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_12.position).x, (manager.ui.mainCamera.transform.position - var_27_12.position).y, (manager.ui.mainCamera.transform.position - var_27_12.position).z)
				var_27_12.localEulerAngles.z = 0
				var_27_12.localEulerAngles.x = 0
				var_27_12.localEulerAngles = var_27_12.localEulerAngles
			end

			if arg_24_1.time_ >= 2 + var_27_13 and arg_24_1.time_ < 2 + var_27_13 + arg_27_0 then
				var_27_12.localPosition = Vector3.New(0, 100, 0)
				var_27_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_12.position).x, (manager.ui.mainCamera.transform.position - var_27_12.position).y, (manager.ui.mainCamera.transform.position - var_27_12.position).z)
				var_27_12.localEulerAngles.z = 0
				var_27_12.localEulerAngles.x = 0
				var_27_12.localEulerAngles = var_27_12.localEulerAngles
			end

			local var_27_14 = arg_24_1.actors_["1095ui_story"]

			if 2 < arg_24_1.time_ and arg_24_1.time_ <= 2 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect1095ui_story == nil then
				arg_24_1.var_.characterEffect1095ui_story = var_27_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_15 = 0.200000002980232

			if 2 <= arg_24_1.time_ and arg_24_1.time_ < 2 + var_27_15 and not isNil(var_27_14) then
				if arg_24_1.var_.characterEffect1095ui_story and not isNil(var_27_14) then
					arg_24_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 2) / var_27_15)
				end
			end

			if arg_24_1.time_ >= 2 + var_27_15 and arg_24_1.time_ < 2 + var_27_15 + arg_27_0 and not isNil(var_27_14) and arg_24_1.var_.characterEffect1095ui_story then
				arg_24_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_27_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_18 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_18

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_18
						arg_24_1.bgmTxt2_.text = var_27_18
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_24_1.time_ and arg_24_1.time_ <= 0.233333333333333 + arg_27_0 then
				arg_24_1:AudioAction("play", "music", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_27_21 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

				if "" ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_21 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_21

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_21
						arg_24_1.bgmTxt2_.text = var_27_21
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_22 = 4
			local var_27_23 = 0.95

			if 4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_24 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_24:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_24_1.dialogCg_.alpha = arg_30_0
				end))
				var_27_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_25 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(411151006).content)

				arg_24_1.text_.text = var_27_25

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_27 = 38 <= 0 and var_27_23 or var_27_23 * (utf8.len(var_27_25) / 38)

				if (38 <= 0 and var_27_23 or var_27_23 * (utf8.len(var_27_25) / 38)) > 0 and var_27_23 < var_27_27 then
					arg_24_1.talkMaxDuration = var_27_27
					var_27_22 = var_27_22 + 0.3

					if var_27_27 + var_27_22 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_27 + var_27_22
					end
				end

				arg_24_1.text_.text = var_27_25
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_28 = var_27_22 + 0.3
			local var_27_29 = math.max(var_27_23, arg_24_1.talkMaxDuration)

			if var_27_22 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_28 + var_27_29 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_28) / var_27_29

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_28 + var_27_29 and arg_24_1.time_ < var_27_28 + var_27_29 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play411151007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 411151007
		arg_32_1.duration_ = 5.2

		local var_32_0 = {
			zh = 3.833,
			ja = 5.2
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play411151008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1095ui_story = arg_32_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1095ui_story"].transform.position).z)
				arg_32_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1095ui_story"].transform.localEulerAngles = arg_32_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_32_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1095ui_story"].transform.position).z)
				arg_32_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1095ui_story"].transform.localEulerAngles = arg_32_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1095ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1095ui_story == nil then
				arg_32_1.var_.characterEffect1095ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect1095ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1095ui_story then
				arg_32_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.5

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(411151007)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 20 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 20)

				if (20 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 20)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151007", "story_v_out_411151.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151007", "story_v_out_411151.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_411151", "411151007", "story_v_out_411151.awb")

						arg_32_1:RecordAudio("411151007", var_35_11)
						arg_32_1:RecordAudio("411151007", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_411151", "411151007", "story_v_out_411151.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_411151", "411151007", "story_v_out_411151.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play411151008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 411151008
		arg_36_1.duration_ = 4.3

		local var_36_0 = {
			zh = 4.3,
			ja = 4.133
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play411151009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.625

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(411151008)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 25 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 25)

				if (25 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 25)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151008", "story_v_out_411151.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151008", "story_v_out_411151.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_411151", "411151008", "story_v_out_411151.awb")

						arg_36_1:RecordAudio("411151008", var_39_6)
						arg_36_1:RecordAudio("411151008", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_411151", "411151008", "story_v_out_411151.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_411151", "411151008", "story_v_out_411151.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play411151009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 411151009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play411151010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1095ui_story"]) and arg_40_1.var_.characterEffect1095ui_story == nil then
				arg_40_1.var_.characterEffect1095ui_story = arg_40_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1095ui_story"]) then
				if arg_40_1.var_.characterEffect1095ui_story and not isNil(arg_40_1.actors_["1095ui_story"]) then
					arg_40_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1095ui_story"]) and arg_40_1.var_.characterEffect1095ui_story then
				arg_40_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 1.35

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(411151009).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 54 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 54)

				if (54 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 54)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play411151010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 411151010
		arg_44_1.duration_ = 6.6

		local var_44_0 = {
			zh = 4.866,
			ja = 6.6
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play411151011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1095ui_story"]) and arg_44_1.var_.characterEffect1095ui_story == nil then
				arg_44_1.var_.characterEffect1095ui_story = arg_44_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1095ui_story"]) then
				if arg_44_1.var_.characterEffect1095ui_story and not isNil(arg_44_1.actors_["1095ui_story"]) then
					arg_44_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1095ui_story"]) and arg_44_1.var_.characterEffect1095ui_story then
				arg_44_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_47_2 = 0
			local var_47_3 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(411151010)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 20 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 20)

				if (20 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 20)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151010", "story_v_out_411151.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_411151", "411151010", "story_v_out_411151.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_411151", "411151010", "story_v_out_411151.awb")

						arg_44_1:RecordAudio("411151010", var_47_9)
						arg_44_1:RecordAudio("411151010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_411151", "411151010", "story_v_out_411151.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_411151", "411151010", "story_v_out_411151.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play411151011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 411151011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play411151012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1095ui_story"]) and arg_48_1.var_.characterEffect1095ui_story == nil then
				arg_48_1.var_.characterEffect1095ui_story = arg_48_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1095ui_story"]) then
				if arg_48_1.var_.characterEffect1095ui_story and not isNil(arg_48_1.actors_["1095ui_story"]) then
					arg_48_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1095ui_story"]) and arg_48_1.var_.characterEffect1095ui_story then
				arg_48_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_51_1 = arg_48_1.actors_["1095ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1095ui_story = var_51_1.localPosition
			end

			local var_51_2 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 then
				var_51_1.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_2)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 then
				var_51_1.localPosition = Vector3.New(0, 100, 0)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			local var_51_3 = 0
			local var_51_4 = 1.025

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_3 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_5 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(411151011).content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 41 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 41)

				if (41 <= 0 and var_51_4 or var_51_4 * (utf8.len(var_51_5) / 41)) > 0 and var_51_4 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_3 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_3
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_4, arg_48_1.talkMaxDuration)

			if var_51_3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_3 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_3) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_3 + var_51_8 and arg_48_1.time_ < var_51_3 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play411151012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 411151012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play411151013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.825

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(411151012).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 33 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 33)

				if (33 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 33)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play411151013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 411151013
		arg_56_1.duration_ = 3.07

		local var_56_0 = {
			zh = 3.066,
			ja = 1.566
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play411151014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1095ui_story"]) and arg_56_1.var_.characterEffect1095ui_story == nil then
				arg_56_1.var_.characterEffect1095ui_story = arg_56_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1095ui_story"]) then
				if arg_56_1.var_.characterEffect1095ui_story and not isNil(arg_56_1.actors_["1095ui_story"]) then
					arg_56_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1095ui_story"]) and arg_56_1.var_.characterEffect1095ui_story then
				arg_56_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1095ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1095ui_story = var_59_2.localPosition
			end

			local var_59_3 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 then
				var_59_2.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_56_1.time_ - 0) / var_59_3)
				var_59_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_2.position).x, (manager.ui.mainCamera.transform.position - var_59_2.position).y, (manager.ui.mainCamera.transform.position - var_59_2.position).z)
				var_59_2.localEulerAngles.z = 0
				var_59_2.localEulerAngles.x = 0
				var_59_2.localEulerAngles = var_59_2.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 then
				var_59_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_59_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_2.position).x, (manager.ui.mainCamera.transform.position - var_59_2.position).y, (manager.ui.mainCamera.transform.position - var_59_2.position).z)
				var_59_2.localEulerAngles.z = 0
				var_59_2.localEulerAngles.x = 0
				var_59_2.localEulerAngles = var_59_2.localEulerAngles
			end

			local var_59_4 = 0
			local var_59_5 = 0.225

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(411151013)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 9 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 9)

				if (9 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 9)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151013", "story_v_out_411151.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151013", "story_v_out_411151.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_411151", "411151013", "story_v_out_411151.awb")

						arg_56_1:RecordAudio("411151013", var_59_11)
						arg_56_1:RecordAudio("411151013", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_411151", "411151013", "story_v_out_411151.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_411151", "411151013", "story_v_out_411151.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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

		arg_56_1:InitPlayNodeList()
	end,
	Play411151014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 411151014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play411151015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1095ui_story = arg_60_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1095ui_story"].transform.position).z)
				arg_60_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1095ui_story"].transform.localEulerAngles = arg_60_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1095ui_story"].transform.position).z)
				arg_60_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1095ui_story"].transform.localEulerAngles = arg_60_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1095ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1095ui_story == nil then
				arg_60_1.var_.characterEffect1095ui_story = var_63_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 and not isNil(var_63_1) then
				if arg_60_1.var_.characterEffect1095ui_story and not isNil(var_63_1) then
					arg_60_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_2)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 and not isNil(var_63_1) and arg_60_1.var_.characterEffect1095ui_story then
				arg_60_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_63_3 = 0
			local var_63_4 = 0.95

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_5 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(411151014).content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 38 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 38)

				if (38 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_5) / 38)) > 0 and var_63_4 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_3
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_4, arg_60_1.talkMaxDuration)

			if var_63_3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_3 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_3) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_3 + var_63_8 and arg_60_1.time_ < var_63_3 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play411151015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 411151015
		arg_64_1.duration_ = 6.13

		local var_64_0 = {
			zh = 3.166,
			ja = 6.133
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play411151016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.425

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_1")

				arg_64_1.callingController_:SetSelectedState("calling")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(411151015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 17 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 17)

				if (17 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 17)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151015", "story_v_out_411151.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151015", "story_v_out_411151.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_411151", "411151015", "story_v_out_411151.awb")

						arg_64_1:RecordAudio("411151015", var_67_6)
						arg_64_1:RecordAudio("411151015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_411151", "411151015", "story_v_out_411151.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_411151", "411151015", "story_v_out_411151.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play411151016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 411151016
		arg_68_1.duration_ = 2

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play411151017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if arg_68_1.actors_["1052ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1052ui_story"))) then
				local var_71_0 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_68_1.stage_.transform)

				var_71_0.name = "1052ui_story"
				var_71_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["1052ui_story"] = var_71_0

				local var_71_1 = var_71_0:GetComponentInChildren(typeof(CharacterEffect))

				var_71_1.enabled = true

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end

				arg_68_1:ShowWeapon(var_71_1.transform, false)

				arg_68_1.var_["1052ui_story" .. "Animator"] = var_71_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_68_1.var_["1052ui_story" .. "Animator"].applyRootMotion = true
				arg_68_1.var_["1052ui_story" .. "LipSync"] = var_71_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_71_3 = arg_68_1.actors_["1052ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1052ui_story = var_71_3.localPosition
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_3.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1052ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_68_1.time_ - 0) / var_71_4)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_3.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_71_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_3.position).x, (manager.ui.mainCamera.transform.position - var_71_3.position).y, (manager.ui.mainCamera.transform.position - var_71_3.position).z)
				var_71_3.localEulerAngles.z = 0
				var_71_3.localEulerAngles.x = 0
				var_71_3.localEulerAngles = var_71_3.localEulerAngles
			end

			local var_71_5 = arg_68_1.actors_["1052ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1052ui_story == nil then
				arg_68_1.var_.characterEffect1052ui_story = var_71_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_6 and not isNil(var_71_5) then
				if arg_68_1.var_.characterEffect1052ui_story and not isNil(var_71_5) then
					arg_68_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_6)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_6 and arg_68_1.time_ < 0 + var_71_6 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1052ui_story then
				arg_68_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				if arg_68_1.var_.characterEffect1052ui_story == nil then
					arg_68_1.var_.characterEffect1052ui_story = arg_68_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_71_7 = arg_68_1.var_.characterEffect1052ui_story

				arg_68_1.var_.characterEffect1052ui_story.imageEffect:turnOff()

				var_71_7.interferenceEffect.enabled = true
				var_71_7.interferenceEffect.noise = 0.01
				var_71_7.interferenceEffect.simTimeScale = 1
				var_71_7.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				if arg_68_1.var_.characterEffect1052ui_story == nil then
					arg_68_1.var_.characterEffect1052ui_story = arg_68_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_68_1.var_.characterEffect1052ui_story.imageEffect:turnOn(false)
			end

			local var_71_9 = arg_68_1.actors_["1095ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1095ui_story = var_71_9.localPosition
			end

			local var_71_10 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_10 then
				var_71_9.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_68_1.time_ - 0) / var_71_10)
				var_71_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_9.position).x, (manager.ui.mainCamera.transform.position - var_71_9.position).y, (manager.ui.mainCamera.transform.position - var_71_9.position).z)
				var_71_9.localEulerAngles.z = 0
				var_71_9.localEulerAngles.x = 0
				var_71_9.localEulerAngles = var_71_9.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_10 and arg_68_1.time_ < 0 + var_71_10 + arg_71_0 then
				var_71_9.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_71_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_9.position).x, (manager.ui.mainCamera.transform.position - var_71_9.position).y, (manager.ui.mainCamera.transform.position - var_71_9.position).z)
				var_71_9.localEulerAngles.z = 0
				var_71_9.localEulerAngles.x = 0
				var_71_9.localEulerAngles = var_71_9.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_71_11 = arg_68_1.actors_["1095ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1095ui_story == nil then
				arg_68_1.var_.characterEffect1095ui_story = var_71_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_12 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_12 and not isNil(var_71_11) then
				if arg_68_1.var_.characterEffect1095ui_story and not isNil(var_71_11) then
					arg_68_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_12 and arg_68_1.time_ < 0 + var_71_12 + arg_71_0 and not isNil(var_71_11) and arg_68_1.var_.characterEffect1095ui_story then
				arg_68_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_71_14 = 0
			local var_71_15 = 0.075

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_16 = arg_68_1:GetWordFromCfg(411151016)
				local var_71_17 = arg_68_1:FormatText(var_71_16.content)

				arg_68_1.text_.text = var_71_17

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_19 = 3 <= 0 and var_71_15 or var_71_15 * (utf8.len(var_71_17) / 3)

				if (3 <= 0 and var_71_15 or var_71_15 * (utf8.len(var_71_17) / 3)) > 0 and var_71_15 < var_71_19 then
					arg_68_1.talkMaxDuration = var_71_19

					if var_71_19 + var_71_14 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_14
					end
				end

				arg_68_1.text_.text = var_71_17
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151016", "story_v_out_411151.awb") ~= 0 then
					local var_71_20 = manager.audio:GetVoiceLength("story_v_out_411151", "411151016", "story_v_out_411151.awb") / 1000

					if var_71_20 + var_71_14 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_20 + var_71_14
					end

					if var_71_16.prefab_name ~= "" and arg_68_1.actors_[var_71_16.prefab_name] ~= nil then
						local var_71_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_16.prefab_name].transform, "story_v_out_411151", "411151016", "story_v_out_411151.awb")

						arg_68_1:RecordAudio("411151016", var_71_21)
						arg_68_1:RecordAudio("411151016", var_71_21)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_411151", "411151016", "story_v_out_411151.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_411151", "411151016", "story_v_out_411151.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_22 = math.max(var_71_15, arg_68_1.talkMaxDuration)

			if var_71_14 <= arg_68_1.time_ and arg_68_1.time_ < var_71_14 + var_71_22 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_14) / var_71_22

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_14 + var_71_22 and arg_68_1.time_ < var_71_14 + var_71_22 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
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

		arg_68_1:InitPlayNodeList()
	end,
	Play411151017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 411151017
		arg_72_1.duration_ = 5.53

		local var_72_0 = {
			zh = 5.533,
			ja = 3.233
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play411151018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1052ui_story = arg_72_1.actors_["1052ui_story"].transform.localPosition

				arg_72_1:ShowWeapon(arg_72_1.var_["1052ui_story" .. "Animator"].transform, false)
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1052ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1052ui_story"].transform.position).z)
				arg_72_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1052ui_story"].transform.localEulerAngles = arg_72_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_72_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1052ui_story"].transform.position).z)
				arg_72_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1052ui_story"].transform.localEulerAngles = arg_72_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["1052ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1052ui_story == nil then
				arg_72_1.var_.characterEffect1052ui_story = var_75_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 and not isNil(var_75_1) then
				if arg_72_1.var_.characterEffect1052ui_story and not isNil(var_75_1) then
					arg_72_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1052ui_story then
				arg_72_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_75_4 = arg_72_1.actors_["1095ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1095ui_story = var_75_4.localPosition
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_72_1.time_ - 0) / var_75_5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			local var_75_6 = arg_72_1.actors_["1095ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_6) and arg_72_1.var_.characterEffect1095ui_story == nil then
				arg_72_1.var_.characterEffect1095ui_story = var_75_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_7 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 and not isNil(var_75_6) then
				if arg_72_1.var_.characterEffect1095ui_story and not isNil(var_75_6) then
					arg_72_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_7)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 and not isNil(var_75_6) and arg_72_1.var_.characterEffect1095ui_story then
				arg_72_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_75_8 = 0
			local var_75_9 = 0.725

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:GetWordFromCfg(411151017)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 29 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 29)

				if (29 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 29)) > 0 and var_75_9 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151017", "story_v_out_411151.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_411151", "411151017", "story_v_out_411151.awb") / 1000

					if var_75_14 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_8
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_out_411151", "411151017", "story_v_out_411151.awb")

						arg_72_1:RecordAudio("411151017", var_75_15)
						arg_72_1:RecordAudio("411151017", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_411151", "411151017", "story_v_out_411151.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_411151", "411151017", "story_v_out_411151.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_16 and arg_72_1.time_ < var_75_8 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
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

		arg_72_1:InitPlayNodeList()
	end,
	Play411151018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 411151018
		arg_76_1.duration_ = 2.87

		local var_76_0 = {
			zh = 2.4,
			ja = 2.866
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
				arg_76_0:Play411151019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(411151018)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 8 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 8)

				if (8 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 8)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151018", "story_v_out_411151.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151018", "story_v_out_411151.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_411151", "411151018", "story_v_out_411151.awb")

						arg_76_1:RecordAudio("411151018", var_79_6)
						arg_76_1:RecordAudio("411151018", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_411151", "411151018", "story_v_out_411151.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_411151", "411151018", "story_v_out_411151.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play411151019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 411151019
		arg_80_1.duration_ = 6.03

		local var_80_0 = {
			zh = 4.4,
			ja = 6.033
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
				arg_80_0:Play411151020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1052ui_story"]) and arg_80_1.var_.characterEffect1052ui_story == nil then
				arg_80_1.var_.characterEffect1052ui_story = arg_80_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1052ui_story"]) then
				if arg_80_1.var_.characterEffect1052ui_story and not isNil(arg_80_1.actors_["1052ui_story"]) then
					arg_80_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1052ui_story"]) and arg_80_1.var_.characterEffect1052ui_story then
				arg_80_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1052ui_story.fillRatio = 0.5
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
			local var_83_5 = 0.6

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

				local var_83_6 = arg_80_1:GetWordFromCfg(411151019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 24 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 24)

				if (24 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 24)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151019", "story_v_out_411151.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151019", "story_v_out_411151.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_411151", "411151019", "story_v_out_411151.awb")

						arg_80_1:RecordAudio("411151019", var_83_11)
						arg_80_1:RecordAudio("411151019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_411151", "411151019", "story_v_out_411151.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_411151", "411151019", "story_v_out_411151.awb")
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

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play411151020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 411151020
		arg_84_1.duration_ = 3.23

		local var_84_0 = {
			zh = 2.733,
			ja = 3.233
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
				arg_84_0:Play411151021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1052ui_story"]) and arg_84_1.var_.characterEffect1052ui_story == nil then
				arg_84_1.var_.characterEffect1052ui_story = arg_84_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1052ui_story"]) then
				if arg_84_1.var_.characterEffect1052ui_story and not isNil(arg_84_1.actors_["1052ui_story"]) then
					arg_84_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1052ui_story"]) and arg_84_1.var_.characterEffect1052ui_story then
				arg_84_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["1095ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1095ui_story == nil then
				arg_84_1.var_.characterEffect1095ui_story = var_87_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.characterEffect1095ui_story and not isNil(var_87_2) then
					arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_3)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1095ui_story then
				arg_84_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_2")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_4 = 0
			local var_87_5 = 0.3

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(411151020)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 12 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 12)

				if (12 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 12)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151020", "story_v_out_411151.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151020", "story_v_out_411151.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_411151", "411151020", "story_v_out_411151.awb")

						arg_84_1:RecordAudio("411151020", var_87_11)
						arg_84_1:RecordAudio("411151020", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_411151", "411151020", "story_v_out_411151.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_411151", "411151020", "story_v_out_411151.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play411151021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 411151021
		arg_88_1.duration_ = 3.47

		local var_88_0 = {
			zh = 1.766,
			ja = 3.466
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
				arg_88_0:Play411151022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1052ui_story"]) and arg_88_1.var_.characterEffect1052ui_story == nil then
				arg_88_1.var_.characterEffect1052ui_story = arg_88_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1052ui_story"]) then
				if arg_88_1.var_.characterEffect1052ui_story and not isNil(arg_88_1.actors_["1052ui_story"]) then
					arg_88_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1052ui_story"]) and arg_88_1.var_.characterEffect1052ui_story then
				arg_88_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_91_1 = arg_88_1.actors_["1095ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1095ui_story == nil then
				arg_88_1.var_.characterEffect1095ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect1095ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1095ui_story then
				arg_88_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_91_4 = 0
			local var_91_5 = 0.2

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
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

				local var_91_6 = arg_88_1:GetWordFromCfg(411151021)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 8 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 8)

				if (8 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 8)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151021", "story_v_out_411151.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151021", "story_v_out_411151.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_411151", "411151021", "story_v_out_411151.awb")

						arg_88_1:RecordAudio("411151021", var_91_11)
						arg_88_1:RecordAudio("411151021", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_411151", "411151021", "story_v_out_411151.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_411151", "411151021", "story_v_out_411151.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play411151022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 411151022
		arg_92_1.duration_ = 10.2

		local var_92_0 = {
			zh = 7.966,
			ja = 10.2
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
				arg_92_0:Play411151023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_95_0 = 0
			local var_95_1 = 1.075

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(411151022)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 43 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 43)

				if (43 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 43)) > 0 and var_95_1 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151022", "story_v_out_411151.awb") ~= 0 then
					local var_95_6 = manager.audio:GetVoiceLength("story_v_out_411151", "411151022", "story_v_out_411151.awb") / 1000

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end

					if var_95_2.prefab_name ~= "" and arg_92_1.actors_[var_95_2.prefab_name] ~= nil then
						local var_95_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_2.prefab_name].transform, "story_v_out_411151", "411151022", "story_v_out_411151.awb")

						arg_92_1:RecordAudio("411151022", var_95_7)
						arg_92_1:RecordAudio("411151022", var_95_7)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_411151", "411151022", "story_v_out_411151.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_411151", "411151022", "story_v_out_411151.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_8 and arg_92_1.time_ < var_95_0 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play411151023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 411151023
		arg_96_1.duration_ = 12.4

		local var_96_0 = {
			zh = 7.433,
			ja = 12.4
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
				arg_96_0:Play411151024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1052ui_story"]) and arg_96_1.var_.characterEffect1052ui_story == nil then
				arg_96_1.var_.characterEffect1052ui_story = arg_96_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1052ui_story"]) then
				if arg_96_1.var_.characterEffect1052ui_story and not isNil(arg_96_1.actors_["1052ui_story"]) then
					arg_96_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1052ui_story"]) and arg_96_1.var_.characterEffect1052ui_story then
				arg_96_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["1095ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1095ui_story == nil then
				arg_96_1.var_.characterEffect1095ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect1095ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect1095ui_story then
				arg_96_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_99_4 = 0
			local var_99_5 = 0.725

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(411151023)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 29 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 29)

				if (29 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 29)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151023", "story_v_out_411151.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151023", "story_v_out_411151.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_411151", "411151023", "story_v_out_411151.awb")

						arg_96_1:RecordAudio("411151023", var_99_11)
						arg_96_1:RecordAudio("411151023", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_411151", "411151023", "story_v_out_411151.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_411151", "411151023", "story_v_out_411151.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play411151024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 411151024
		arg_100_1.duration_ = 7.37

		local var_100_0 = {
			zh = 4.6,
			ja = 7.366
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
				arg_100_0:Play411151025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1052ui_story"]) and arg_100_1.var_.characterEffect1052ui_story == nil then
				arg_100_1.var_.characterEffect1052ui_story = arg_100_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1052ui_story"]) then
				if arg_100_1.var_.characterEffect1052ui_story and not isNil(arg_100_1.actors_["1052ui_story"]) then
					arg_100_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1052ui_story"]) and arg_100_1.var_.characterEffect1052ui_story then
				arg_100_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_103_1 = arg_100_1.actors_["1095ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1095ui_story == nil then
				arg_100_1.var_.characterEffect1095ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect1095ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1095ui_story then
				arg_100_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_103_4 = 0
			local var_103_5 = 0.55

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(411151024)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 22 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 22)

				if (22 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 22)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151024", "story_v_out_411151.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151024", "story_v_out_411151.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_411151", "411151024", "story_v_out_411151.awb")

						arg_100_1:RecordAudio("411151024", var_103_11)
						arg_100_1:RecordAudio("411151024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_411151", "411151024", "story_v_out_411151.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_411151", "411151024", "story_v_out_411151.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play411151025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 411151025
		arg_104_1.duration_ = 3.83

		local var_104_0 = {
			zh = 2.366,
			ja = 3.833
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
				arg_104_0:Play411151026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1052ui_story"]) and arg_104_1.var_.characterEffect1052ui_story == nil then
				arg_104_1.var_.characterEffect1052ui_story = arg_104_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1052ui_story"]) then
				if arg_104_1.var_.characterEffect1052ui_story and not isNil(arg_104_1.actors_["1052ui_story"]) then
					arg_104_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1052ui_story"]) and arg_104_1.var_.characterEffect1052ui_story then
				arg_104_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["1095ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1095ui_story == nil then
				arg_104_1.var_.characterEffect1095ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect1095ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1095ui_story then
				arg_104_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_107_4 = 0
			local var_107_5 = 0.225

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(411151025)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 9 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 9)

				if (9 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 9)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151025", "story_v_out_411151.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151025", "story_v_out_411151.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_411151", "411151025", "story_v_out_411151.awb")

						arg_104_1:RecordAudio("411151025", var_107_11)
						arg_104_1:RecordAudio("411151025", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_411151", "411151025", "story_v_out_411151.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_411151", "411151025", "story_v_out_411151.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play411151026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 411151026
		arg_108_1.duration_ = 3.1

		local var_108_0 = {
			zh = 1.766,
			ja = 3.1
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
				arg_108_0:Play411151027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1052ui_story"]) and arg_108_1.var_.characterEffect1052ui_story == nil then
				arg_108_1.var_.characterEffect1052ui_story = arg_108_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1052ui_story"]) then
				if arg_108_1.var_.characterEffect1052ui_story and not isNil(arg_108_1.actors_["1052ui_story"]) then
					arg_108_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1052ui_story"]) and arg_108_1.var_.characterEffect1052ui_story then
				arg_108_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_111_1 = arg_108_1.actors_["1095ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1095ui_story == nil then
				arg_108_1.var_.characterEffect1095ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1095ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1095ui_story then
				arg_108_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_111_4 = 0
			local var_111_5 = 0.225

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(411151026)
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

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151026", "story_v_out_411151.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151026", "story_v_out_411151.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_411151", "411151026", "story_v_out_411151.awb")

						arg_108_1:RecordAudio("411151026", var_111_11)
						arg_108_1:RecordAudio("411151026", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_411151", "411151026", "story_v_out_411151.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_411151", "411151026", "story_v_out_411151.awb")
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

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play411151027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 411151027
		arg_112_1.duration_ = 7

		local var_112_0 = {
			zh = 3.766,
			ja = 7
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
				arg_112_0:Play411151028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1052ui_story"]) and arg_112_1.var_.characterEffect1052ui_story == nil then
				arg_112_1.var_.characterEffect1052ui_story = arg_112_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1052ui_story"]) then
				if arg_112_1.var_.characterEffect1052ui_story and not isNil(arg_112_1.actors_["1052ui_story"]) then
					arg_112_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1052ui_story"]) and arg_112_1.var_.characterEffect1052ui_story then
				arg_112_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["1095ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1095ui_story == nil then
				arg_112_1.var_.characterEffect1095ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect1095ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect1095ui_story then
				arg_112_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_115_4 = 0
			local var_115_5 = 0.45

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(411151027)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 18 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 18)

				if (18 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 18)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151027", "story_v_out_411151.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151027", "story_v_out_411151.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_411151", "411151027", "story_v_out_411151.awb")

						arg_112_1:RecordAudio("411151027", var_115_11)
						arg_112_1:RecordAudio("411151027", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_411151", "411151027", "story_v_out_411151.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_411151", "411151027", "story_v_out_411151.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play411151028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 411151028
		arg_116_1.duration_ = 3.73

		local var_116_0 = {
			zh = 2.233,
			ja = 3.733
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
				arg_116_0:Play411151029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1052ui_story"]) and arg_116_1.var_.characterEffect1052ui_story == nil then
				arg_116_1.var_.characterEffect1052ui_story = arg_116_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1052ui_story"]) then
				if arg_116_1.var_.characterEffect1052ui_story and not isNil(arg_116_1.actors_["1052ui_story"]) then
					arg_116_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1052ui_story"]) and arg_116_1.var_.characterEffect1052ui_story then
				arg_116_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_119_1 = arg_116_1.actors_["1095ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1095ui_story == nil then
				arg_116_1.var_.characterEffect1095ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1095ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1095ui_story then
				arg_116_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_119_4 = 0
			local var_119_5 = 0.225

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(411151028)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 9 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 9)

				if (9 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 9)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151028", "story_v_out_411151.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151028", "story_v_out_411151.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_411151", "411151028", "story_v_out_411151.awb")

						arg_116_1:RecordAudio("411151028", var_119_11)
						arg_116_1:RecordAudio("411151028", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_411151", "411151028", "story_v_out_411151.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_411151", "411151028", "story_v_out_411151.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play411151029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 411151029
		arg_120_1.duration_ = 6.6

		local var_120_0 = {
			zh = 5.8,
			ja = 6.6
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
				arg_120_0:Play411151030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1052ui_story"]) and arg_120_1.var_.characterEffect1052ui_story == nil then
				arg_120_1.var_.characterEffect1052ui_story = arg_120_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1052ui_story"]) then
				if arg_120_1.var_.characterEffect1052ui_story and not isNil(arg_120_1.actors_["1052ui_story"]) then
					arg_120_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1052ui_story"]) and arg_120_1.var_.characterEffect1052ui_story then
				arg_120_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_123_2 = arg_120_1.actors_["1095ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1095ui_story == nil then
				arg_120_1.var_.characterEffect1095ui_story = var_123_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_3 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.characterEffect1095ui_story and not isNil(var_123_2) then
					arg_120_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_3)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1095ui_story then
				arg_120_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_123_4 = 0
			local var_123_5 = 0.7

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(411151029)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 28 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 28)

				if (28 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 28)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151029", "story_v_out_411151.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151029", "story_v_out_411151.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_411151", "411151029", "story_v_out_411151.awb")

						arg_120_1:RecordAudio("411151029", var_123_11)
						arg_120_1:RecordAudio("411151029", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_411151", "411151029", "story_v_out_411151.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_411151", "411151029", "story_v_out_411151.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play411151030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 411151030
		arg_124_1.duration_ = 8.23

		local var_124_0 = {
			zh = 8.233,
			ja = 5.333
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play411151031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_0 = 0
			local var_127_1 = 1.025

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(411151030)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 42 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 42)

				if (42 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 42)) > 0 and var_127_1 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151030", "story_v_out_411151.awb") ~= 0 then
					local var_127_6 = manager.audio:GetVoiceLength("story_v_out_411151", "411151030", "story_v_out_411151.awb") / 1000

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end

					if var_127_2.prefab_name ~= "" and arg_124_1.actors_[var_127_2.prefab_name] ~= nil then
						local var_127_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_2.prefab_name].transform, "story_v_out_411151", "411151030", "story_v_out_411151.awb")

						arg_124_1:RecordAudio("411151030", var_127_7)
						arg_124_1:RecordAudio("411151030", var_127_7)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_411151", "411151030", "story_v_out_411151.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_411151", "411151030", "story_v_out_411151.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play411151031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 411151031
		arg_128_1.duration_ = 6.8

		local var_128_0 = {
			zh = 6.8,
			ja = 4.966
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play411151032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.8

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(411151031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 32 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 32)

				if (32 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 32)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151031", "story_v_out_411151.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151031", "story_v_out_411151.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_411151", "411151031", "story_v_out_411151.awb")

						arg_128_1:RecordAudio("411151031", var_131_6)
						arg_128_1:RecordAudio("411151031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_411151", "411151031", "story_v_out_411151.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_411151", "411151031", "story_v_out_411151.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play411151032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 411151032
		arg_132_1.duration_ = 10.77

		local var_132_0 = {
			zh = 9.133,
			ja = 10.766
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play411151033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1052ui_story"]) and arg_132_1.var_.characterEffect1052ui_story == nil then
				arg_132_1.var_.characterEffect1052ui_story = arg_132_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1052ui_story"]) then
				if arg_132_1.var_.characterEffect1052ui_story and not isNil(arg_132_1.actors_["1052ui_story"]) then
					arg_132_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1052ui_story"]) and arg_132_1.var_.characterEffect1052ui_story then
				arg_132_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_135_1 = arg_132_1.actors_["1095ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1095ui_story == nil then
				arg_132_1.var_.characterEffect1095ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1095ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1095ui_story then
				arg_132_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_135_4 = 0
			local var_135_5 = 1.175

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(411151032)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 47 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 47)

				if (47 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 47)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151032", "story_v_out_411151.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151032", "story_v_out_411151.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_411151", "411151032", "story_v_out_411151.awb")

						arg_132_1:RecordAudio("411151032", var_135_11)
						arg_132_1:RecordAudio("411151032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_411151", "411151032", "story_v_out_411151.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_411151", "411151032", "story_v_out_411151.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play411151033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 411151033
		arg_136_1.duration_ = 12.1

		local var_136_0 = {
			zh = 7.8,
			ja = 12.1
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
				arg_136_0:Play411151034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.95

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(411151033)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 38 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 38)

				if (38 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 38)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151033", "story_v_out_411151.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151033", "story_v_out_411151.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_411151", "411151033", "story_v_out_411151.awb")

						arg_136_1:RecordAudio("411151033", var_139_6)
						arg_136_1:RecordAudio("411151033", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_411151", "411151033", "story_v_out_411151.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_411151", "411151033", "story_v_out_411151.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play411151034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 411151034
		arg_140_1.duration_ = 8.47

		local var_140_0 = {
			zh = 6.7,
			ja = 8.466
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play411151035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1052ui_story"]) and arg_140_1.var_.characterEffect1052ui_story == nil then
				arg_140_1.var_.characterEffect1052ui_story = arg_140_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1052ui_story"]) then
				if arg_140_1.var_.characterEffect1052ui_story and not isNil(arg_140_1.actors_["1052ui_story"]) then
					arg_140_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1052ui_story"]) and arg_140_1.var_.characterEffect1052ui_story then
				arg_140_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_143_2 = arg_140_1.actors_["1095ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1095ui_story == nil then
				arg_140_1.var_.characterEffect1095ui_story = var_143_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_3 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.characterEffect1095ui_story and not isNil(var_143_2) then
					arg_140_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_3)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1095ui_story then
				arg_140_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_2")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_143_4 = 0
			local var_143_5 = 0.75

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_6 = arg_140_1:GetWordFromCfg(411151034)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 30 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 30)

				if (30 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 30)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151034", "story_v_out_411151.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151034", "story_v_out_411151.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_411151", "411151034", "story_v_out_411151.awb")

						arg_140_1:RecordAudio("411151034", var_143_11)
						arg_140_1:RecordAudio("411151034", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_411151", "411151034", "story_v_out_411151.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_411151", "411151034", "story_v_out_411151.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_12 and arg_140_1.time_ < var_143_4 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play411151035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 411151035
		arg_144_1.duration_ = 4.8

		local var_144_0 = {
			zh = 4.333,
			ja = 4.8
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play411151036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1052ui_story"]) and arg_144_1.var_.characterEffect1052ui_story == nil then
				arg_144_1.var_.characterEffect1052ui_story = arg_144_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1052ui_story"]) then
				if arg_144_1.var_.characterEffect1052ui_story and not isNil(arg_144_1.actors_["1052ui_story"]) then
					arg_144_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1052ui_story"]) and arg_144_1.var_.characterEffect1052ui_story then
				arg_144_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_147_1 = arg_144_1.actors_["1095ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1095ui_story == nil then
				arg_144_1.var_.characterEffect1095ui_story = var_147_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 and not isNil(var_147_1) then
				if arg_144_1.var_.characterEffect1095ui_story and not isNil(var_147_1) then
					arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1095ui_story then
				arg_144_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 0.5

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(411151035)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 20 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 20)

				if (20 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 20)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151035", "story_v_out_411151.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151035", "story_v_out_411151.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_411151", "411151035", "story_v_out_411151.awb")

						arg_144_1:RecordAudio("411151035", var_147_11)
						arg_144_1:RecordAudio("411151035", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_411151", "411151035", "story_v_out_411151.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_411151", "411151035", "story_v_out_411151.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_12 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_12 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_12

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_12 and arg_144_1.time_ < var_147_4 + var_147_12 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play411151036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 411151036
		arg_148_1.duration_ = 3.77

		local var_148_0 = {
			zh = 3.6,
			ja = 3.766
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
				arg_148_0:Play411151037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.525

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(411151036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 21 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 21)

				if (21 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 21)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151036", "story_v_out_411151.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151036", "story_v_out_411151.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_411151", "411151036", "story_v_out_411151.awb")

						arg_148_1:RecordAudio("411151036", var_151_6)
						arg_148_1:RecordAudio("411151036", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_411151", "411151036", "story_v_out_411151.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_411151", "411151036", "story_v_out_411151.awb")
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
	Play411151037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 411151037
		arg_152_1.duration_ = 4.87

		local var_152_0 = {
			zh = 4.866,
			ja = 4
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
				arg_152_0:Play411151038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1052ui_story"]) and arg_152_1.var_.characterEffect1052ui_story == nil then
				arg_152_1.var_.characterEffect1052ui_story = arg_152_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1052ui_story"]) then
				if arg_152_1.var_.characterEffect1052ui_story and not isNil(arg_152_1.actors_["1052ui_story"]) then
					arg_152_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1052ui_story"]) and arg_152_1.var_.characterEffect1052ui_story then
				arg_152_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_155_2 = arg_152_1.actors_["1095ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect1095ui_story == nil then
				arg_152_1.var_.characterEffect1095ui_story = var_155_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_3 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 and not isNil(var_155_2) then
				if arg_152_1.var_.characterEffect1095ui_story and not isNil(var_155_2) then
					arg_152_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_3)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 and not isNil(var_155_2) and arg_152_1.var_.characterEffect1095ui_story then
				arg_152_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_155_4 = 0
			local var_155_5 = 0.525

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(411151037)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 21 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 21)

				if (21 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 21)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151037", "story_v_out_411151.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151037", "story_v_out_411151.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_411151", "411151037", "story_v_out_411151.awb")

						arg_152_1:RecordAudio("411151037", var_155_11)
						arg_152_1:RecordAudio("411151037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_411151", "411151037", "story_v_out_411151.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_411151", "411151037", "story_v_out_411151.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play411151038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 411151038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play411151039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1052ui_story = arg_156_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1052ui_story"].transform.position).z)
				arg_156_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1052ui_story"].transform.localEulerAngles = arg_156_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1052ui_story"].transform.position).z)
				arg_156_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1052ui_story"].transform.localEulerAngles = arg_156_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1052ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1052ui_story == nil then
				arg_156_1.var_.characterEffect1052ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1052ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_2)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1052ui_story then
				arg_156_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_159_3 = arg_156_1.actors_["1095ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1095ui_story = var_159_3.localPosition
			end

			local var_159_4 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				var_159_3.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_4)
				var_159_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_3.position).x, (manager.ui.mainCamera.transform.position - var_159_3.position).y, (manager.ui.mainCamera.transform.position - var_159_3.position).z)
				var_159_3.localEulerAngles.z = 0
				var_159_3.localEulerAngles.x = 0
				var_159_3.localEulerAngles = var_159_3.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				var_159_3.localPosition = Vector3.New(0, 100, 0)
				var_159_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_3.position).x, (manager.ui.mainCamera.transform.position - var_159_3.position).y, (manager.ui.mainCamera.transform.position - var_159_3.position).z)
				var_159_3.localEulerAngles.z = 0
				var_159_3.localEulerAngles.x = 0
				var_159_3.localEulerAngles = var_159_3.localEulerAngles
			end

			local var_159_5 = arg_156_1.actors_["1052ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_5) and arg_156_1.var_.characterEffect1052ui_story == nil then
				arg_156_1.var_.characterEffect1052ui_story = var_159_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_6 and not isNil(var_159_5) then
				if arg_156_1.var_.characterEffect1052ui_story and not isNil(var_159_5) then
					arg_156_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_6)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_6 and arg_156_1.time_ < 0 + var_159_6 + arg_159_0 and not isNil(var_159_5) and arg_156_1.var_.characterEffect1052ui_story then
				arg_156_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_159_7 = 0
			local var_159_8 = 0.975

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_7 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_9 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(411151038).content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 39 <= 0 and var_159_8 or var_159_8 * (utf8.len(var_159_9) / 39)

				if (39 <= 0 and var_159_8 or var_159_8 * (utf8.len(var_159_9) / 39)) > 0 and var_159_8 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_7 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_7
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_8, arg_156_1.talkMaxDuration)

			if var_159_7 <= arg_156_1.time_ and arg_156_1.time_ < var_159_7 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_7) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_7 + var_159_12 and arg_156_1.time_ < var_159_7 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
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

		arg_156_1:InitPlayNodeList()
	end,
	Play411151039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 411151039
		arg_160_1.duration_ = 14.7

		local var_160_0 = {
			zh = 14.6996666666667,
			ja = 14.0666666666667
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
				arg_160_0:Play411151040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 3.06666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 3.06666666666667 + arg_163_0 then
				arg_160_1.var_.moveOldPos1095ui_story = arg_160_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 3.06666666666667 <= arg_160_1.time_ and arg_160_1.time_ < 3.06666666666667 + var_163_0 then
				arg_160_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_160_1.time_ - 3.06666666666667) / var_163_0)
				arg_160_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).z)
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles = arg_160_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 3.06666666666667 + var_163_0 and arg_160_1.time_ < 3.06666666666667 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_160_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1095ui_story"].transform.position).z)
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1095ui_story"].transform.localEulerAngles = arg_160_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["1095ui_story"]

			if 3.06666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 3.06666666666667 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect1095ui_story == nil then
				arg_160_1.var_.characterEffect1095ui_story = var_163_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if 3.06666666666667 <= arg_160_1.time_ and arg_160_1.time_ < 3.06666666666667 + var_163_2 and not isNil(var_163_1) then
				if arg_160_1.var_.characterEffect1095ui_story and not isNil(var_163_1) then
					arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 3.06666666666667 + var_163_2 and arg_160_1.time_ < 3.06666666666667 + var_163_2 + arg_163_0 and not isNil(var_163_1) and arg_160_1.var_.characterEffect1095ui_story then
				arg_160_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 3.06666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 3.06666666666667 + arg_163_0 then
				arg_160_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 3.06666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 3.06666666666667 + arg_163_0 then
				arg_160_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_4 = arg_160_1.bgs_.ST74a

				arg_160_1.bgs_.ST74a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_5 = var_163_4:GetComponent("SpriteRenderer")

				if var_163_5 and var_163_5.sprite then
					local var_163_6 = 2 * (var_163_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_4.transform.localScale = Vector3.New(var_163_6 / var_163_5.sprite.bounds.size.y < var_163_6 * manager.ui.mainCameraCom_.aspect / var_163_5.sprite.bounds.size.x and var_163_6 * manager.ui.mainCameraCom_.aspect / var_163_5.sprite.bounds.size.x or var_163_6 / var_163_5.sprite.bounds.size.y, var_163_6 / var_163_5.sprite.bounds.size.y < var_163_6 * manager.ui.mainCameraCom_.aspect / var_163_5.sprite.bounds.size.x and var_163_6 * manager.ui.mainCameraCom_.aspect / var_163_5.sprite.bounds.size.x or var_163_6 / var_163_5.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "ST74a" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_7 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_8 = 2

			if var_163_7 <= arg_160_1.time_ and arg_160_1.time_ < var_163_7 + var_163_8 then
				local var_163_9 = Color.New(0, 0, 0)

				var_163_9.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_7) / var_163_8)
				arg_160_1.mask_.color = var_163_9
			end

			if arg_160_1.time_ >= var_163_7 + var_163_8 and arg_160_1.time_ < var_163_7 + var_163_8 + arg_163_0 then
				local var_163_10 = Color.New(0, 0, 0)

				var_163_10.a = 1
				arg_160_1.mask_.color = var_163_10
			end

			local var_163_11 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_12 = 2

			if var_163_11 <= arg_160_1.time_ and arg_160_1.time_ < var_163_11 + var_163_12 then
				local var_163_13 = Color.New(0, 0, 0)

				var_163_13.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_11) / var_163_12)
				arg_160_1.mask_.color = var_163_13
			end

			if arg_160_1.time_ >= var_163_11 + var_163_12 and arg_160_1.time_ < var_163_11 + var_163_12 + arg_163_0 then
				local var_163_14 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_14.a = 0
				arg_160_1.mask_.color = var_163_14
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_15 = 3.06666666666667
			local var_163_16 = 0.925

			if 3.06666666666667 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_17 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_17:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_18 = arg_160_1:GetWordFromCfg(411151039)
				local var_163_19 = arg_160_1:FormatText(var_163_18.content)

				arg_160_1.text_.text = var_163_19

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_21 = 37 <= 0 and var_163_16 or var_163_16 * (utf8.len(var_163_19) / 37)

				if (37 <= 0 and var_163_16 or var_163_16 * (utf8.len(var_163_19) / 37)) > 0 and var_163_16 < var_163_21 then
					arg_160_1.talkMaxDuration = var_163_21
					var_163_15 = var_163_15 + 0.3

					if var_163_21 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_21 + var_163_15
					end
				end

				arg_160_1.text_.text = var_163_19
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151039", "story_v_out_411151.awb") ~= 0 then
					local var_163_22 = manager.audio:GetVoiceLength("story_v_out_411151", "411151039", "story_v_out_411151.awb") / 1000

					if var_163_22 + var_163_15 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_22 + var_163_15
					end

					if var_163_18.prefab_name ~= "" and arg_160_1.actors_[var_163_18.prefab_name] ~= nil then
						local var_163_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_18.prefab_name].transform, "story_v_out_411151", "411151039", "story_v_out_411151.awb")

						arg_160_1:RecordAudio("411151039", var_163_23)
						arg_160_1:RecordAudio("411151039", var_163_23)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_411151", "411151039", "story_v_out_411151.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_411151", "411151039", "story_v_out_411151.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_24 = var_163_15 + 0.3
			local var_163_25 = math.max(var_163_16, arg_160_1.talkMaxDuration)

			if var_163_15 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_24 + var_163_25 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_24) / var_163_25

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_24 + var_163_25 and arg_160_1.time_ < var_163_24 + var_163_25 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play411151040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 411151040
		arg_166_1.duration_ = 4.27

		local var_166_0 = {
			zh = 4.266,
			ja = 3.7
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
				arg_166_0:Play411151041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_169_0 = 0
			local var_169_1 = 0.275

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_2 = arg_166_1:GetWordFromCfg(411151040)
				local var_169_3 = arg_166_1:FormatText(var_169_2.content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 11 <= 0 and var_169_1 or var_169_1 * (utf8.len(var_169_3) / 11)

				if (11 <= 0 and var_169_1 or var_169_1 * (utf8.len(var_169_3) / 11)) > 0 and var_169_1 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151040", "story_v_out_411151.awb") ~= 0 then
					local var_169_6 = manager.audio:GetVoiceLength("story_v_out_411151", "411151040", "story_v_out_411151.awb") / 1000

					if var_169_6 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_0
					end

					if var_169_2.prefab_name ~= "" and arg_166_1.actors_[var_169_2.prefab_name] ~= nil then
						local var_169_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_2.prefab_name].transform, "story_v_out_411151", "411151040", "story_v_out_411151.awb")

						arg_166_1:RecordAudio("411151040", var_169_7)
						arg_166_1:RecordAudio("411151040", var_169_7)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_411151", "411151040", "story_v_out_411151.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_411151", "411151040", "story_v_out_411151.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_8 and arg_166_1.time_ < var_169_0 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play411151041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 411151041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play411151042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1095ui_story"]) and arg_170_1.var_.characterEffect1095ui_story == nil then
				arg_170_1.var_.characterEffect1095ui_story = arg_170_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1095ui_story"]) then
				if arg_170_1.var_.characterEffect1095ui_story and not isNil(arg_170_1.actors_["1095ui_story"]) then
					arg_170_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_0)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1095ui_story"]) and arg_170_1.var_.characterEffect1095ui_story then
				arg_170_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_173_1 = 0
			local var_173_2 = 0.55

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_3 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(411151041).content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 22 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 22)

				if (22 <= 0 and var_173_2 or var_173_2 * (utf8.len(var_173_3) / 22)) > 0 and var_173_2 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_1 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_1
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_6 = math.max(var_173_2, arg_170_1.talkMaxDuration)

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_6 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_1) / var_173_6

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_1 + var_173_6 and arg_170_1.time_ < var_173_1 + var_173_6 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play411151042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 411151042
		arg_174_1.duration_ = 3.07

		local var_174_0 = {
			zh = 0.999999999999,
			ja = 3.066
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
				arg_174_0:Play411151043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1095ui_story"]) and arg_174_1.var_.characterEffect1095ui_story == nil then
				arg_174_1.var_.characterEffect1095ui_story = arg_174_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1095ui_story"]) then
				if arg_174_1.var_.characterEffect1095ui_story and not isNil(arg_174_1.actors_["1095ui_story"]) then
					arg_174_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1095ui_story"]) and arg_174_1.var_.characterEffect1095ui_story then
				arg_174_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_177_2 = 0
			local var_177_3 = 0.1

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_2 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_4 = arg_174_1:GetWordFromCfg(411151042)
				local var_177_5 = arg_174_1:FormatText(var_177_4.content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 4 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 4)

				if (4 <= 0 and var_177_3 or var_177_3 * (utf8.len(var_177_5) / 4)) > 0 and var_177_3 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_2
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151042", "story_v_out_411151.awb") ~= 0 then
					local var_177_8 = manager.audio:GetVoiceLength("story_v_out_411151", "411151042", "story_v_out_411151.awb") / 1000

					if var_177_8 + var_177_2 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_2
					end

					if var_177_4.prefab_name ~= "" and arg_174_1.actors_[var_177_4.prefab_name] ~= nil then
						local var_177_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_4.prefab_name].transform, "story_v_out_411151", "411151042", "story_v_out_411151.awb")

						arg_174_1:RecordAudio("411151042", var_177_9)
						arg_174_1:RecordAudio("411151042", var_177_9)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_411151", "411151042", "story_v_out_411151.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_411151", "411151042", "story_v_out_411151.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_3, arg_174_1.talkMaxDuration)

			if var_177_2 <= arg_174_1.time_ and arg_174_1.time_ < var_177_2 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_2) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_2 + var_177_10 and arg_174_1.time_ < var_177_2 + var_177_10 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play411151043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 411151043
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play411151044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1095ui_story"]) and arg_178_1.var_.characterEffect1095ui_story == nil then
				arg_178_1.var_.characterEffect1095ui_story = arg_178_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1095ui_story"]) then
				if arg_178_1.var_.characterEffect1095ui_story and not isNil(arg_178_1.actors_["1095ui_story"]) then
					arg_178_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_0)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1095ui_story"]) and arg_178_1.var_.characterEffect1095ui_story then
				arg_178_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_181_1 = arg_178_1.actors_["1095ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1095ui_story = var_181_1.localPosition
			end

			local var_181_2 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 then
				var_181_1.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_2)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 then
				var_181_1.localPosition = Vector3.New(0, 100, 0)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			local var_181_3 = 0
			local var_181_4 = 0.9

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_3 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_5 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(411151043).content)

				arg_178_1.text_.text = var_181_5

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_7 = 36 <= 0 and var_181_4 or var_181_4 * (utf8.len(var_181_5) / 36)

				if (36 <= 0 and var_181_4 or var_181_4 * (utf8.len(var_181_5) / 36)) > 0 and var_181_4 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_3 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_3
					end
				end

				arg_178_1.text_.text = var_181_5
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_4, arg_178_1.talkMaxDuration)

			if var_181_3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_3 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_3) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_3 + var_181_8 and arg_178_1.time_ < var_181_3 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play411151044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 411151044
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play411151045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.85

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(411151044).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 34 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 34)

				if (34 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 34)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play411151045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 411151045
		arg_186_1.duration_ = 3.73

		local var_186_0 = {
			zh = 1.999999999999,
			ja = 3.733
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play411151046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1095ui_story"]) and arg_186_1.var_.characterEffect1095ui_story == nil then
				arg_186_1.var_.characterEffect1095ui_story = arg_186_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1095ui_story"]) then
				if arg_186_1.var_.characterEffect1095ui_story and not isNil(arg_186_1.actors_["1095ui_story"]) then
					arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1095ui_story"]) and arg_186_1.var_.characterEffect1095ui_story then
				arg_186_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_189_2 = arg_186_1.actors_["1095ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1095ui_story = var_189_2.localPosition
			end

			local var_189_3 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 then
				var_189_2.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_186_1.time_ - 0) / var_189_3)
				var_189_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_2.position).x, (manager.ui.mainCamera.transform.position - var_189_2.position).y, (manager.ui.mainCamera.transform.position - var_189_2.position).z)
				var_189_2.localEulerAngles.z = 0
				var_189_2.localEulerAngles.x = 0
				var_189_2.localEulerAngles = var_189_2.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 then
				var_189_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_189_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_2.position).x, (manager.ui.mainCamera.transform.position - var_189_2.position).y, (manager.ui.mainCamera.transform.position - var_189_2.position).z)
				var_189_2.localEulerAngles.z = 0
				var_189_2.localEulerAngles.x = 0
				var_189_2.localEulerAngles = var_189_2.localEulerAngles
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_189_4 = 0
			local var_189_5 = 0.275

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(411151045)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 11 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 11)

				if (11 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 11)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151045", "story_v_out_411151.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151045", "story_v_out_411151.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_out_411151", "411151045", "story_v_out_411151.awb")

						arg_186_1:RecordAudio("411151045", var_189_11)
						arg_186_1:RecordAudio("411151045", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_411151", "411151045", "story_v_out_411151.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_411151", "411151045", "story_v_out_411151.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play411151046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 411151046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play411151047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) and arg_190_1.var_.characterEffect1095ui_story == nil then
				arg_190_1.var_.characterEffect1095ui_story = arg_190_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) then
				if arg_190_1.var_.characterEffect1095ui_story and not isNil(arg_190_1.actors_["1095ui_story"]) then
					arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1095ui_story"]) and arg_190_1.var_.characterEffect1095ui_story then
				arg_190_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.825

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(411151046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 33 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 33)

				if (33 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 33)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play411151047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 411151047
		arg_194_1.duration_ = 5.7

		local var_194_0 = {
			zh = 4.433,
			ja = 5.7
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
				arg_194_0:Play411151048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1095ui_story"]) and arg_194_1.var_.characterEffect1095ui_story == nil then
				arg_194_1.var_.characterEffect1095ui_story = arg_194_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1095ui_story"]) then
				if arg_194_1.var_.characterEffect1095ui_story and not isNil(arg_194_1.actors_["1095ui_story"]) then
					arg_194_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1095ui_story"]) and arg_194_1.var_.characterEffect1095ui_story then
				arg_194_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_197_2 = 0
			local var_197_3 = 0.525

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(411151047)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 21 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 21)

				if (21 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 21)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151047", "story_v_out_411151.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_411151", "411151047", "story_v_out_411151.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_411151", "411151047", "story_v_out_411151.awb")

						arg_194_1:RecordAudio("411151047", var_197_9)
						arg_194_1:RecordAudio("411151047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_411151", "411151047", "story_v_out_411151.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_411151", "411151047", "story_v_out_411151.awb")
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
	Play411151048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 411151048
		arg_198_1.duration_ = 3.3

		local var_198_0 = {
			zh = 1.466,
			ja = 3.3
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play411151049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.2

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_1 = arg_198_1:GetWordFromCfg(411151048)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 8 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 8)

				if (8 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 8)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151048", "story_v_out_411151.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_411151", "411151048", "story_v_out_411151.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_411151", "411151048", "story_v_out_411151.awb")

						arg_198_1:RecordAudio("411151048", var_201_6)
						arg_198_1:RecordAudio("411151048", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_411151", "411151048", "story_v_out_411151.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_411151", "411151048", "story_v_out_411151.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play411151049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 411151049
		arg_202_1.duration_ = 5.77

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play411151050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1095ui_story = arg_202_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).z)
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles = arg_202_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1095ui_story"].transform.position).z)
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1095ui_story"].transform.localEulerAngles = arg_202_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1095ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1095ui_story == nil then
				arg_202_1.var_.characterEffect1095ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1095ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_2)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1095ui_story then
				arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_205_3 = 0

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.mask_.enabled = true
				arg_202_1.mask_.raycastTarget = false

				arg_202_1:SetGaussion(false)
			end

			local var_205_4 = 0.4

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_4 then
				local var_205_5 = Color.New(1, 1, 1)

				var_205_5.a = Mathf.Lerp(1, 0, (arg_202_1.time_ - var_205_3) / var_205_4)
				arg_202_1.mask_.color = var_205_5
			end

			if arg_202_1.time_ >= var_205_3 + var_205_4 and arg_202_1.time_ < var_205_3 + var_205_4 + arg_205_0 then
				local var_205_6 = Color.New(1, 1, 1)

				arg_202_1.mask_.enabled = false
				var_205_6.a = 0
				arg_202_1.mask_.color = var_205_6
			end

			if arg_202_1.frameCnt_ <= 1 then
				arg_202_1.dialog_:SetActive(false)
			end

			local var_205_7 = 0.766666666666667
			local var_205_8 = 0.8

			if 0.766666666666667 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				arg_202_1.dialog_:SetActive(true)

				arg_202_1.dialogCg_.alpha = 0

				local var_205_9 = LeanTween.value(arg_202_1.dialog_, 0, 1, 0.3)

				var_205_9:setOnUpdate(LuaHelper.FloatAction(function(arg_206_0)
					arg_202_1.dialogCg_.alpha = arg_206_0
				end))
				var_205_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_202_1.dialog_)
					var_205_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_202_1.duration_ = arg_202_1.duration_ + 0.3

				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_10 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(411151049).content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_12 = 32 <= 0 and var_205_8 or var_205_8 * (utf8.len(var_205_10) / 32)

				if (32 <= 0 and var_205_8 or var_205_8 * (utf8.len(var_205_10) / 32)) > 0 and var_205_8 < var_205_12 then
					arg_202_1.talkMaxDuration = var_205_12
					var_205_7 = var_205_7 + 0.3

					if var_205_12 + var_205_7 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_12 + var_205_7
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_13 = var_205_7 + 0.3
			local var_205_14 = math.max(var_205_8, arg_202_1.talkMaxDuration)

			if var_205_7 + 0.3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_13 + var_205_14 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_13) / var_205_14

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_13 + var_205_14 and arg_202_1.time_ < var_205_13 + var_205_14 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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

		arg_202_1:InitPlayNodeList()
	end,
	Play411151050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 411151050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play411151051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.9

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_1")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(411151050).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 36 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 36)

				if (36 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 36)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play411151051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 411151051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play411151052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.625

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052_split_1")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_1 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(411151051).content)

				arg_212_1.text_.text = var_215_1

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_3 = 25 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 25)

				if (25 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 25)) > 0 and var_215_0 < var_215_3 then
					arg_212_1.talkMaxDuration = var_215_3

					if var_215_3 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_3 + 0
					end
				end

				arg_212_1.text_.text = var_215_1
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_4 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_4

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play411151052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 411151052
		arg_216_1.duration_ = 2

		local var_216_0 = {
			zh = 2,
			ja = 1.999999999999
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
			arg_216_1.auto_ = false
		end

		function arg_216_1.playNext_(arg_218_0)
			arg_216_1.onStoryFinished_()
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1095ui_story = arg_216_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1095ui_story"].transform.position).z)
				arg_216_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1095ui_story"].transform.localEulerAngles = arg_216_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_216_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1095ui_story"].transform.position).z)
				arg_216_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1095ui_story"].transform.localEulerAngles = arg_216_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["1095ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1095ui_story == nil then
				arg_216_1.var_.characterEffect1095ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect1095ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1095ui_story then
				arg_216_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_219_4 = 0
			local var_219_5 = 0.25

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(411151052)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 10 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 10)

				if (10 <= 0 and var_219_5 or var_219_5 * (utf8.len(var_219_7) / 10)) > 0 and var_219_5 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411151", "411151052", "story_v_out_411151.awb") ~= 0 then
					local var_219_10 = manager.audio:GetVoiceLength("story_v_out_411151", "411151052", "story_v_out_411151.awb") / 1000

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end

					if var_219_6.prefab_name ~= "" and arg_216_1.actors_[var_219_6.prefab_name] ~= nil then
						local var_219_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_6.prefab_name].transform, "story_v_out_411151", "411151052", "story_v_out_411151.awb")

						arg_216_1:RecordAudio("411151052", var_219_11)
						arg_216_1:RecordAudio("411151052", var_219_11)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_411151", "411151052", "story_v_out_411151.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_411151", "411151052", "story_v_out_411151.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_12 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_12 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_12

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_12 and arg_216_1.time_ < var_219_4 + var_219_12 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
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

		arg_216_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ST74a"
	},
	voices = {
		"story_v_out_411151.awb"
	}
}
