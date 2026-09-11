return {
	Play113072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113072001
		arg_1_1.duration_ = 4.8

		local var_1_0 = {
			ja = 4.7,
			ko = 4.8,
			zh = 4.2,
			en = 4.7
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
				arg_1_0:Play113072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F02_1 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F02_1")
				var_4_0.name = "F02_1"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F02_1 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F02_1

				arg_1_1.bgs_.F02_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F02_1" then
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

			local var_4_8 = "1041ui_story"

			if arg_1_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1041ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1041ui_story = var_4_12.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_4_14 = arg_1_1.actors_["1041ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story == nil then
				arg_1_1.var_.characterEffect1041ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1041ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story then
				arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 1.53333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.53333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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
			local var_4_21 = 0.275

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(113072001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 11 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 11)

				if (11 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 11)) > 0 and var_4_21 < var_4_26 then
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

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072001", "story_v_out_113072.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_113072", "113072001", "story_v_out_113072.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_113072", "113072001", "story_v_out_113072.awb")

						arg_1_1:RecordAudio("113072001", var_4_28)
						arg_1_1:RecordAudio("113072001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113072", "113072001", "story_v_out_113072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113072", "113072001", "story_v_out_113072.awb")
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113072002
		arg_8_1.duration_ = 4.27

		local var_8_0 = {
			ja = 3.6,
			ko = 3.2,
			zh = 4.266,
			en = 2.6
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
				arg_8_0:Play113072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.shakeOldPosF02 = manager.ui.mainCamera.transform.localPosition
			end

			local var_11_0 = 0.6

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 then
				local var_11_1, var_11_2 = math.modf((arg_8_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_11_2 * 0.13, var_11_2 * 0.13, var_11_2 * 0.13) + arg_8_1.var_.shakeOldPosF02
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 then
				manager.ui.mainCamera.transform.localPosition = arg_8_1.var_.shakeOldPosF02
			end

			local var_11_3 = arg_8_1.actors_["1041ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1041ui_story == nil then
				arg_8_1.var_.characterEffect1041ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1041ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1041ui_story then
				arg_8_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_11_5 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			if arg_8_1.time_ >= var_11_5 + 0.6 and arg_8_1.time_ < var_11_5 + 0.6 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_10", "se_story_10_monster", "")
			end

			local var_11_7 = 0
			local var_11_8 = 0.1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[217].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3025")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(113072002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_12 = 4 <= 0 and var_11_8 or var_11_8 * (utf8.len(var_11_10) / 4)

				if (4 <= 0 and var_11_8 or var_11_8 * (utf8.len(var_11_10) / 4)) > 0 and var_11_8 < var_11_12 then
					arg_8_1.talkMaxDuration = var_11_12

					if var_11_12 + var_11_7 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_7
					end
				end

				arg_8_1.text_.text = var_11_10
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072002", "story_v_out_113072.awb") ~= 0 then
					local var_11_13 = manager.audio:GetVoiceLength("story_v_out_113072", "113072002", "story_v_out_113072.awb") / 1000

					if var_11_13 + var_11_7 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_7
					end

					if var_11_9.prefab_name ~= "" and arg_8_1.actors_[var_11_9.prefab_name] ~= nil then
						local var_11_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_9.prefab_name].transform, "story_v_out_113072", "113072002", "story_v_out_113072.awb")

						arg_8_1:RecordAudio("113072002", var_11_14)
						arg_8_1:RecordAudio("113072002", var_11_14)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_113072", "113072002", "story_v_out_113072.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_113072", "113072002", "story_v_out_113072.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_15 = math.max(var_11_8, arg_8_1.talkMaxDuration)

			if var_11_7 <= arg_8_1.time_ and arg_8_1.time_ < var_11_7 + var_11_15 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_7) / var_11_15

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_7 + var_11_15 and arg_8_1.time_ < var_11_7 + var_11_15 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play113072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113072003
		arg_12_1.duration_ = 2.73

		local var_12_0 = {
			ja = 2.2,
			ko = 2.4,
			zh = 1.999999999999,
			en = 2.733
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play113072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1038ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1038ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1038ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1038ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1038ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1038ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_5 = arg_12_1.actors_["1038ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1038ui_story == nil then
				arg_12_1.var_.characterEffect1038ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1038ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1038ui_story then
				arg_12_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_15_8 = 0
			local var_15_9 = 0.2

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(113072003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 8 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 8)

				if (8 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 8)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072003", "story_v_out_113072.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_113072", "113072003", "story_v_out_113072.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_113072", "113072003", "story_v_out_113072.awb")

						arg_12_1:RecordAudio("113072003", var_15_15)
						arg_12_1:RecordAudio("113072003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_113072", "113072003", "story_v_out_113072.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_113072", "113072003", "story_v_out_113072.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play113072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 113072004
		arg_16_1.duration_ = 2

		local var_16_0 = {
			ja = 2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play113072005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1041ui_story = arg_16_1.actors_["1041ui_story"].transform.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1041ui_story" .. "Animator"].transform, false)
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1041ui_story"].transform.position).z)
				arg_16_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1041ui_story"].transform.localEulerAngles = arg_16_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1041ui_story"].transform.position).z)
				arg_16_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1041ui_story"].transform.localEulerAngles = arg_16_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1038ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1038ui_story = var_19_1.localPosition
			end

			local var_19_2 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 then
				var_19_1.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_2)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 then
				var_19_1.localPosition = Vector3.New(0, 100, 0)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			local var_19_3 = "1042ui_story"

			if arg_16_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_19_4 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_16_1.stage_.transform)

				var_19_4.name = var_19_3
				var_19_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_3] = var_19_4

				local var_19_5 = var_19_4:GetComponentInChildren(typeof(CharacterEffect))

				var_19_5.enabled = true

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_4, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_5.transform, false)

				arg_16_1.var_[var_19_3 .. "Animator"] = var_19_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_3 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_3 .. "LipSync"] = var_19_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_7 = arg_16_1.actors_["1042ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1042ui_story = var_19_7.localPosition
			end

			local var_19_8 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 then
				var_19_7.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_16_1.time_ - 0) / var_19_8)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 then
				var_19_7.localPosition = Vector3.New(0, -1.06, -6.2)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action3_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_9 = arg_16_1.actors_["1042ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1042ui_story == nil then
				arg_16_1.var_.characterEffect1042ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_10 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_10 and not isNil(var_19_9) then
				if arg_16_1.var_.characterEffect1042ui_story and not isNil(var_19_9) then
					arg_16_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_10 and arg_16_1.time_ < 0 + var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1042ui_story then
				arg_16_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_19_12 = 0
			local var_19_13 = 0.15

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:GetWordFromCfg(113072004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 6 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 6)

				if (6 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 6)) > 0 and var_19_13 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072004", "story_v_out_113072.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_113072", "113072004", "story_v_out_113072.awb") / 1000

					if var_19_18 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_12
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_113072", "113072004", "story_v_out_113072.awb")

						arg_16_1:RecordAudio("113072004", var_19_19)
						arg_16_1:RecordAudio("113072004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_113072", "113072004", "story_v_out_113072.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_113072", "113072004", "story_v_out_113072.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_20 = math.max(var_19_13, arg_16_1.talkMaxDuration)

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_20 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_12) / var_19_20

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_12 + var_19_20 and arg_16_1.time_ < var_19_12 + var_19_20 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play113072005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 113072005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play113072006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1042ui_story = arg_20_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_23_0 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				arg_20_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1042ui_story"].transform.position).z)
				arg_20_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1042ui_story"].transform.localEulerAngles = arg_20_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				arg_20_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1042ui_story"].transform.position).z)
				arg_20_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1042ui_story"].transform.localEulerAngles = arg_20_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_23_1 = "6045_story"

			if arg_20_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_20_1.stage_.transform)

				var_23_2.name = var_23_1
				var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_1] = var_23_2

				local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

				var_23_3.enabled = true

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_3.transform, false)

				arg_20_1.var_[var_23_1 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_1 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_1 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_5 = arg_20_1.actors_["6045_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos6045_story = var_23_5.localPosition

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(false)
				end
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos6045_story, Vector3.New(0.7, -0.5, -6.3), (arg_20_1.time_ - 0) / var_23_7)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_23_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_5.position).x, (manager.ui.mainCamera.transform.position - var_23_5.position).y, (manager.ui.mainCamera.transform.position - var_23_5.position).z)
				var_23_5.localEulerAngles.z = 0
				var_23_5.localEulerAngles.x = 0
				var_23_5.localEulerAngles = var_23_5.localEulerAngles

				local var_23_8 = GameObjectTools.GetOrAddComponent(var_23_5.gameObject, typeof(DynamicBoneHelper))

				if var_23_8 then
					var_23_8:EnableDynamicBone(true)
				end
			end

			local var_23_9 = "6046_story"

			if arg_20_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_23_10 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_20_1.stage_.transform)

				var_23_10.name = var_23_9
				var_23_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_9] = var_23_10

				local var_23_11 = var_23_10:GetComponentInChildren(typeof(CharacterEffect))

				var_23_11.enabled = true

				local var_23_12 = GameObjectTools.GetOrAddComponent(var_23_10, typeof(DynamicBoneHelper))

				if var_23_12 then
					var_23_12:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_11.transform, false)

				arg_20_1.var_[var_23_9 .. "Animator"] = var_23_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_9 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_9 .. "LipSync"] = var_23_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_13 = arg_20_1.actors_["6046_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos6046_story = var_23_13.localPosition

				local var_23_14 = GameObjectTools.GetOrAddComponent(var_23_13.gameObject, typeof(DynamicBoneHelper))

				if var_23_14 then
					var_23_14:EnableDynamicBone(false)
				end
			end

			local var_23_15 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_15 then
				var_23_13.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_20_1.time_ - 0) / var_23_15)
				var_23_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_13.position).x, (manager.ui.mainCamera.transform.position - var_23_13.position).y, (manager.ui.mainCamera.transform.position - var_23_13.position).z)
				var_23_13.localEulerAngles.z = 0
				var_23_13.localEulerAngles.x = 0
				var_23_13.localEulerAngles = var_23_13.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_15 and arg_20_1.time_ < 0 + var_23_15 + arg_23_0 then
				var_23_13.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_23_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_13.position).x, (manager.ui.mainCamera.transform.position - var_23_13.position).y, (manager.ui.mainCamera.transform.position - var_23_13.position).z)
				var_23_13.localEulerAngles.z = 0
				var_23_13.localEulerAngles.x = 0
				var_23_13.localEulerAngles = var_23_13.localEulerAngles

				local var_23_16 = GameObjectTools.GetOrAddComponent(var_23_13.gameObject, typeof(DynamicBoneHelper))

				if var_23_16 then
					var_23_16:EnableDynamicBone(true)
				end
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_17 = arg_20_1.actors_["6046_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_17) and arg_20_1.var_.characterEffect6046_story == nil then
				arg_20_1.var_.characterEffect6046_story = var_23_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_18 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_18 and not isNil(var_23_17) then
				if arg_20_1.var_.characterEffect6046_story and not isNil(var_23_17) then
					arg_20_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_18 and arg_20_1.time_ < 0 + var_23_18 + arg_23_0 and not isNil(var_23_17) and arg_20_1.var_.characterEffect6046_story then
				arg_20_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_23_20 = arg_20_1.actors_["6045_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect6045_story == nil then
				arg_20_1.var_.characterEffect6045_story = var_23_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_21 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_21 and not isNil(var_23_20) then
				if arg_20_1.var_.characterEffect6045_story and not isNil(var_23_20) then
					arg_20_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_21 and arg_20_1.time_ < 0 + var_23_21 + arg_23_0 and not isNil(var_23_20) and arg_20_1.var_.characterEffect6045_story then
				arg_20_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_23_23 = 0
			local var_23_24 = 0.075

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[233].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_25 = arg_20_1:GetWordFromCfg(113072005)
				local var_23_26 = arg_20_1:FormatText(var_23_25.content)

				arg_20_1.text_.text = var_23_26

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_28 = 3 <= 0 and var_23_24 or var_23_24 * (utf8.len(var_23_26) / 3)

				if (3 <= 0 and var_23_24 or var_23_24 * (utf8.len(var_23_26) / 3)) > 0 and var_23_24 < var_23_28 then
					arg_20_1.talkMaxDuration = var_23_28

					if var_23_28 + var_23_23 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_23
					end
				end

				arg_20_1.text_.text = var_23_26
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072005", "story_v_out_113072.awb") ~= 0 then
					local var_23_29 = manager.audio:GetVoiceLength("story_v_out_113072", "113072005", "story_v_out_113072.awb") / 1000

					if var_23_29 + var_23_23 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_29 + var_23_23
					end

					if var_23_25.prefab_name ~= "" and arg_20_1.actors_[var_23_25.prefab_name] ~= nil then
						local var_23_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_25.prefab_name].transform, "story_v_out_113072", "113072005", "story_v_out_113072.awb")

						arg_20_1:RecordAudio("113072005", var_23_30)
						arg_20_1:RecordAudio("113072005", var_23_30)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_113072", "113072005", "story_v_out_113072.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_113072", "113072005", "story_v_out_113072.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_31 = math.max(var_23_24, arg_20_1.talkMaxDuration)

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_31 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_23) / var_23_31

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_23 + var_23_31 and arg_20_1.time_ < var_23_23 + var_23_31 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play113072006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 113072006
		arg_24_1.duration_ = 2.5

		local var_24_0 = {
			ja = 2.5,
			ko = 2.466,
			zh = 2.3,
			en = 1.2
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play113072007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos6045_story = arg_24_1.actors_["6045_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6045_story"].transform.position).z)
				arg_24_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["6045_story"].transform.localEulerAngles = arg_24_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6045_story"].transform.position).z)
				arg_24_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["6045_story"].transform.localEulerAngles = arg_24_1.actors_["6045_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["6046_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos6046_story = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, 100, 0)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = 0
			local var_27_8 = 0.175

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_7 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(113072006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_12 = 7 <= 0 and var_27_8 or var_27_8 * (utf8.len(var_27_10) / 7)

				if (7 <= 0 and var_27_8 or var_27_8 * (utf8.len(var_27_10) / 7)) > 0 and var_27_8 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_7 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_7
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072006", "story_v_out_113072.awb") ~= 0 then
					local var_27_13 = manager.audio:GetVoiceLength("story_v_out_113072", "113072006", "story_v_out_113072.awb") / 1000

					if var_27_13 + var_27_7 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_7
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_113072", "113072006", "story_v_out_113072.awb")

						arg_24_1:RecordAudio("113072006", var_27_14)
						arg_24_1:RecordAudio("113072006", var_27_14)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_113072", "113072006", "story_v_out_113072.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_113072", "113072006", "story_v_out_113072.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_15 = math.max(var_27_8, arg_24_1.talkMaxDuration)

			if var_27_7 <= arg_24_1.time_ and arg_24_1.time_ < var_27_7 + var_27_15 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_7) / var_27_15

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_7 + var_27_15 and arg_24_1.time_ < var_27_7 + var_27_15 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play113072007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 113072007
		arg_28_1.duration_ = 2.7

		local var_28_0 = {
			ja = 2.3,
			ko = 2.7,
			zh = 2.333,
			en = 2.2
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play113072008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(113072007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 8 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 8)

				if (8 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 8)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072007", "story_v_out_113072.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_113072", "113072007", "story_v_out_113072.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_113072", "113072007", "story_v_out_113072.awb")

						arg_28_1:RecordAudio("113072007", var_31_6)
						arg_28_1:RecordAudio("113072007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_113072", "113072007", "story_v_out_113072.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_113072", "113072007", "story_v_out_113072.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play113072008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 113072008
		arg_32_1.duration_ = 2

		local var_32_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
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
				arg_32_0:Play113072009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos6045_story = arg_32_1.actors_["6045_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6045_story, Vector3.New(0.7, -0.5, -6.3), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6045_story"].transform.position).z)
				arg_32_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6045_story"].transform.localEulerAngles = arg_32_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["6045_story"].transform.localPosition = Vector3.New(0.7, -0.5, -6.3)
				arg_32_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6045_story"].transform.position).z)
				arg_32_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6045_story"].transform.localEulerAngles = arg_32_1.actors_["6045_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["6046_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos6046_story = var_35_3.localPosition

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(false)
				end
			end

			local var_35_5 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_5 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_32_1.time_ - 0) / var_35_5)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_5 and arg_32_1.time_ < 0 + var_35_5 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_3.gameObject, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_35_7 = 0
			local var_35_8 = 0.125

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[233].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(113072008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_12 = 5 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_10) / 5)

				if (5 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_10) / 5)) > 0 and var_35_8 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_7
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072008", "story_v_out_113072.awb") ~= 0 then
					local var_35_13 = manager.audio:GetVoiceLength("story_v_out_113072", "113072008", "story_v_out_113072.awb") / 1000

					if var_35_13 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_7
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_113072", "113072008", "story_v_out_113072.awb")

						arg_32_1:RecordAudio("113072008", var_35_14)
						arg_32_1:RecordAudio("113072008", var_35_14)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_113072", "113072008", "story_v_out_113072.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_113072", "113072008", "story_v_out_113072.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_15 = math.max(var_35_8, arg_32_1.talkMaxDuration)

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_15 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_7) / var_35_15

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_7 + var_35_15 and arg_32_1.time_ < var_35_7 + var_35_15 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play113072009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 113072009
		arg_36_1.duration_ = 4.2

		local var_36_0 = {
			ja = 1.3,
			ko = 2.8,
			zh = 4.2,
			en = 3.1
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
				arg_36_0:Play113072010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos6046_story = arg_36_1.actors_["6046_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6046_story"].transform.position).z)
				arg_36_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["6046_story"].transform.localEulerAngles = arg_36_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["6046_story"].transform.position).z)
				arg_36_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["6046_story"].transform.localEulerAngles = arg_36_1.actors_["6046_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = arg_36_1.actors_["6045_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos6045_story = var_39_3.localPosition

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(false)
				end
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, 100, 0)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles

				local var_39_6 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_6 then
					var_39_6:EnableDynamicBone(true)
				end
			end

			local var_39_7 = manager.ui.mainCamera.transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.shakeOldPos = var_39_7.localPosition
			end

			local var_39_8 = 0.6

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 then
				local var_39_9, var_39_10 = math.modf((arg_36_1.time_ - 0) / 0.066)

				var_39_7.localPosition = Vector3.New(var_39_10 * 0.13, var_39_10 * 0.13, var_39_10 * 0.13) + arg_36_1.var_.shakeOldPos
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 then
				var_39_7.localPosition = arg_36_1.var_.shakeOldPos
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_10", "se_story_10_monster", "")
			end

			local var_39_12 = 0
			local var_39_13 = 0.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[217].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3025")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_14 = arg_36_1:GetWordFromCfg(113072009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 4 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 4)

				if (4 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 4)) > 0 and var_39_13 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072009", "story_v_out_113072.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_113072", "113072009", "story_v_out_113072.awb") / 1000

					if var_39_18 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_12
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_113072", "113072009", "story_v_out_113072.awb")

						arg_36_1:RecordAudio("113072009", var_39_19)
						arg_36_1:RecordAudio("113072009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_113072", "113072009", "story_v_out_113072.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_113072", "113072009", "story_v_out_113072.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_20 and arg_36_1.time_ < var_39_12 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play113072010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 113072010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play113072011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0.3 < arg_40_1.time_ and arg_40_1.time_ <= 0.3 + arg_43_0 then
				arg_40_1:AudioAction("play", "effect", "se_story_10", "se_story_10_hit", "")
			end

			local var_43_1 = 0
			local var_43_2 = 1.425

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

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(113072010).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 57 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 57)

				if (57 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 57)) > 0 and var_43_2 < var_43_5 then
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
	Play113072011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 113072011
		arg_44_1.duration_ = 3

		local var_44_0 = {
			ja = 2.6,
			ko = 2,
			zh = 3,
			en = 2.2
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
				arg_44_0:Play113072012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_47_0 = arg_44_1.actors_["6046_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos6046_story = var_47_0.localPosition

				local var_47_1 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_1 then
					var_47_1:EnableDynamicBone(false)
				end
			end

			local var_47_2 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 then
				var_47_0.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_44_1.time_ - 0) / var_47_2)
				var_47_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_0.position).x, (manager.ui.mainCamera.transform.position - var_47_0.position).y, (manager.ui.mainCamera.transform.position - var_47_0.position).z)
				var_47_0.localEulerAngles.z = 0
				var_47_0.localEulerAngles.x = 0
				var_47_0.localEulerAngles = var_47_0.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 then
				var_47_0.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_47_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_0.position).x, (manager.ui.mainCamera.transform.position - var_47_0.position).y, (manager.ui.mainCamera.transform.position - var_47_0.position).z)
				var_47_0.localEulerAngles.z = 0
				var_47_0.localEulerAngles.x = 0
				var_47_0.localEulerAngles = var_47_0.localEulerAngles

				local var_47_3 = GameObjectTools.GetOrAddComponent(var_47_0.gameObject, typeof(DynamicBoneHelper))

				if var_47_3 then
					var_47_3:EnableDynamicBone(true)
				end
			end

			local var_47_4 = arg_44_1.actors_["6046_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect6046_story == nil then
				arg_44_1.var_.characterEffect6046_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_5 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 and not isNil(var_47_4) then
				if arg_44_1.var_.characterEffect6046_story and not isNil(var_47_4) then
					arg_44_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect6046_story then
				arg_44_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_7 = 0
			local var_47_8 = 0.175

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_7 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:GetWordFromCfg(113072011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_12 = 7 <= 0 and var_47_8 or var_47_8 * (utf8.len(var_47_10) / 7)

				if (7 <= 0 and var_47_8 or var_47_8 * (utf8.len(var_47_10) / 7)) > 0 and var_47_8 < var_47_12 then
					arg_44_1.talkMaxDuration = var_47_12

					if var_47_12 + var_47_7 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_7
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072011", "story_v_out_113072.awb") ~= 0 then
					local var_47_13 = manager.audio:GetVoiceLength("story_v_out_113072", "113072011", "story_v_out_113072.awb") / 1000

					if var_47_13 + var_47_7 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_7
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_113072", "113072011", "story_v_out_113072.awb")

						arg_44_1:RecordAudio("113072011", var_47_14)
						arg_44_1:RecordAudio("113072011", var_47_14)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_113072", "113072011", "story_v_out_113072.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_113072", "113072011", "story_v_out_113072.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_15 = math.max(var_47_8, arg_44_1.talkMaxDuration)

			if var_47_7 <= arg_44_1.time_ and arg_44_1.time_ < var_47_7 + var_47_15 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_7) / var_47_15

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_7 + var_47_15 and arg_44_1.time_ < var_47_7 + var_47_15 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play113072012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 113072012
		arg_48_1.duration_ = 8.1

		local var_48_0 = {
			ja = 8.1,
			ko = 5.8,
			zh = 6.7,
			en = 4.2
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play113072013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_0 = arg_48_1.actors_["6045_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect6045_story == nil then
				arg_48_1.var_.characterEffect6045_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_1 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 and not isNil(var_51_0) then
				if arg_48_1.var_.characterEffect6045_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect6045_story then
				arg_48_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_51_3 = arg_48_1.actors_["6045_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos6045_story = var_51_3.localPosition

				local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_3.gameObject, typeof(DynamicBoneHelper))

				if var_51_4 then
					var_51_4:EnableDynamicBone(false)
				end
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_3.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6045_story, Vector3.New(0.7, -0.5, -6.3), (arg_48_1.time_ - 0) / var_51_5)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_3.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles

				local var_51_6 = GameObjectTools.GetOrAddComponent(var_51_3.gameObject, typeof(DynamicBoneHelper))

				if var_51_6 then
					var_51_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_51_7 = arg_48_1.actors_["6046_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect6046_story == nil then
				arg_48_1.var_.characterEffect6046_story = var_51_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_8 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_8 and not isNil(var_51_7) then
				if arg_48_1.var_.characterEffect6046_story and not isNil(var_51_7) then
					arg_48_1.var_.characterEffect6046_story.fillFlat = true
					arg_48_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_8)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_8 and arg_48_1.time_ < 0 + var_51_8 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect6046_story then
				arg_48_1.var_.characterEffect6046_story.fillFlat = true
				arg_48_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_51_9 = 0
			local var_51_10 = 0.55

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_11 = arg_48_1:GetWordFromCfg(113072012)
				local var_51_12 = arg_48_1:FormatText(var_51_11.content)

				arg_48_1.text_.text = var_51_12

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_14 = 22 <= 0 and var_51_10 or var_51_10 * (utf8.len(var_51_12) / 22)

				if (22 <= 0 and var_51_10 or var_51_10 * (utf8.len(var_51_12) / 22)) > 0 and var_51_10 < var_51_14 then
					arg_48_1.talkMaxDuration = var_51_14

					if var_51_14 + var_51_9 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_9
					end
				end

				arg_48_1.text_.text = var_51_12
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072012", "story_v_out_113072.awb") ~= 0 then
					local var_51_15 = manager.audio:GetVoiceLength("story_v_out_113072", "113072012", "story_v_out_113072.awb") / 1000

					if var_51_15 + var_51_9 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_9
					end

					if var_51_11.prefab_name ~= "" and arg_48_1.actors_[var_51_11.prefab_name] ~= nil then
						local var_51_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_11.prefab_name].transform, "story_v_out_113072", "113072012", "story_v_out_113072.awb")

						arg_48_1:RecordAudio("113072012", var_51_16)
						arg_48_1:RecordAudio("113072012", var_51_16)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_113072", "113072012", "story_v_out_113072.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_113072", "113072012", "story_v_out_113072.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_17 = math.max(var_51_10, arg_48_1.talkMaxDuration)

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_17 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_9) / var_51_17

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_9 + var_51_17 and arg_48_1.time_ < var_51_9 + var_51_17 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play113072013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 113072013
		arg_52_1.duration_ = 6.03

		local var_52_0 = {
			ja = 6.033,
			ko = 4.5,
			zh = 4.4,
			en = 3.666
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play113072014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action424")
			end

			local var_55_0 = arg_52_1.actors_["6046_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect6046_story == nil then
				arg_52_1.var_.characterEffect6046_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_1 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 and not isNil(var_55_0) then
				if arg_52_1.var_.characterEffect6046_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect6046_story then
				arg_52_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_55_3 = arg_52_1.actors_["6045_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect6045_story == nil then
				arg_52_1.var_.characterEffect6045_story = var_55_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_4 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 and not isNil(var_55_3) then
				if arg_52_1.var_.characterEffect6045_story and not isNil(var_55_3) then
					arg_52_1.var_.characterEffect6045_story.fillFlat = true
					arg_52_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_4)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect6045_story then
				arg_52_1.var_.characterEffect6045_story.fillFlat = true
				arg_52_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_55_5 = 0
			local var_55_6 = 0.425

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_7 = arg_52_1:GetWordFromCfg(113072013)
				local var_55_8 = arg_52_1:FormatText(var_55_7.content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 17 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 17)

				if (17 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 17)) > 0 and var_55_6 < var_55_10 then
					arg_52_1.talkMaxDuration = var_55_10

					if var_55_10 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_5
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072013", "story_v_out_113072.awb") ~= 0 then
					local var_55_11 = manager.audio:GetVoiceLength("story_v_out_113072", "113072013", "story_v_out_113072.awb") / 1000

					if var_55_11 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_5
					end

					if var_55_7.prefab_name ~= "" and arg_52_1.actors_[var_55_7.prefab_name] ~= nil then
						local var_55_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_7.prefab_name].transform, "story_v_out_113072", "113072013", "story_v_out_113072.awb")

						arg_52_1:RecordAudio("113072013", var_55_12)
						arg_52_1:RecordAudio("113072013", var_55_12)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_113072", "113072013", "story_v_out_113072.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_113072", "113072013", "story_v_out_113072.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_13 = math.max(var_55_6, arg_52_1.talkMaxDuration)

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_13 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_5) / var_55_13

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_5 + var_55_13 and arg_52_1.time_ < var_55_5 + var_55_13 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play113072014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 113072014
		arg_56_1.duration_ = 2.2

		local var_56_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_56_0:Play113072015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos6045_story = arg_56_1.actors_["6045_story"].transform.localPosition

				local var_59_0 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_0 then
					var_59_0:EnableDynamicBone(false)
				end
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				arg_56_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_1)
				arg_56_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6045_story"].transform.position).z)
				arg_56_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["6045_story"].transform.localEulerAngles = arg_56_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				arg_56_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6045_story"].transform.position).z)
				arg_56_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["6045_story"].transform.localEulerAngles = arg_56_1.actors_["6045_story"].transform.localEulerAngles

				local var_59_2 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(true)
				end
			end

			local var_59_3 = arg_56_1.actors_["6046_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos6046_story = var_59_3.localPosition

				local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_4 then
					var_59_4:EnableDynamicBone(false)
				end
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_5)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0, 100, 0)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(true)
				end
			end

			local var_59_7 = "1084ui_story"

			if arg_56_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_59_8 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_56_1.stage_.transform)

				var_59_8.name = var_59_7
				var_59_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_[var_59_7] = var_59_8

				local var_59_9 = var_59_8:GetComponentInChildren(typeof(CharacterEffect))

				var_59_9.enabled = true

				local var_59_10 = GameObjectTools.GetOrAddComponent(var_59_8, typeof(DynamicBoneHelper))

				if var_59_10 then
					var_59_10:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_9.transform, false)

				arg_56_1.var_[var_59_7 .. "Animator"] = var_59_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_[var_59_7 .. "Animator"].applyRootMotion = true
				arg_56_1.var_[var_59_7 .. "LipSync"] = var_59_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_11 = arg_56_1.actors_["1084ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_11.localPosition
			end

			local var_59_12 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_12 then
				var_59_11.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_56_1.time_ - 0) / var_59_12)
				var_59_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_11.position).x, (manager.ui.mainCamera.transform.position - var_59_11.position).y, (manager.ui.mainCamera.transform.position - var_59_11.position).z)
				var_59_11.localEulerAngles.z = 0
				var_59_11.localEulerAngles.x = 0
				var_59_11.localEulerAngles = var_59_11.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_12 and arg_56_1.time_ < 0 + var_59_12 + arg_59_0 then
				var_59_11.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_59_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_11.position).x, (manager.ui.mainCamera.transform.position - var_59_11.position).y, (manager.ui.mainCamera.transform.position - var_59_11.position).z)
				var_59_11.localEulerAngles.z = 0
				var_59_11.localEulerAngles.x = 0
				var_59_11.localEulerAngles = var_59_11.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_59_13 = arg_56_1.actors_["1084ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_13) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_14 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_14 and not isNil(var_59_13) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_13) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_14 and arg_56_1.time_ < 0 + var_59_14 + arg_59_0 and not isNil(var_59_13) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_59_16 = 0
			local var_59_17 = 0.15

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(113072014)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_21 = 6 <= 0 and var_59_17 or var_59_17 * (utf8.len(var_59_19) / 6)

				if (6 <= 0 and var_59_17 or var_59_17 * (utf8.len(var_59_19) / 6)) > 0 and var_59_17 < var_59_21 then
					arg_56_1.talkMaxDuration = var_59_21

					if var_59_21 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_21 + var_59_16
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072014", "story_v_out_113072.awb") ~= 0 then
					local var_59_22 = manager.audio:GetVoiceLength("story_v_out_113072", "113072014", "story_v_out_113072.awb") / 1000

					if var_59_22 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_16
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_113072", "113072014", "story_v_out_113072.awb")

						arg_56_1:RecordAudio("113072014", var_59_23)
						arg_56_1:RecordAudio("113072014", var_59_23)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_113072", "113072014", "story_v_out_113072.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_113072", "113072014", "story_v_out_113072.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_24 = math.max(var_59_17, arg_56_1.talkMaxDuration)

			if var_59_16 <= arg_56_1.time_ and arg_56_1.time_ < var_59_16 + var_59_24 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_16) / var_59_24

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_16 + var_59_24 and arg_56_1.time_ < var_59_16 + var_59_24 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play113072015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 113072015
		arg_60_1.duration_ = 6.7

		local var_60_0 = {
			ja = 3.1,
			ko = 5.5,
			zh = 5.633,
			en = 6.7
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play113072016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = arg_60_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) then
				if arg_60_1.var_.characterEffect1084ui_story and not isNil(arg_60_1.actors_["1084ui_story"]) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_63_1 = arg_60_1.actors_["1042ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1042ui_story = var_63_1.localPosition
			end

			local var_63_2 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_2 then
				var_63_1.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_60_1.time_ - 0) / var_63_2)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_2 and arg_60_1.time_ < 0 + var_63_2 + arg_63_0 then
				var_63_1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_63_3 = arg_60_1.actors_["1042ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1042ui_story == nil then
				arg_60_1.var_.characterEffect1042ui_story = var_63_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_4 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 and not isNil(var_63_3) then
				if arg_60_1.var_.characterEffect1042ui_story and not isNil(var_63_3) then
					arg_60_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1042ui_story then
				arg_60_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_63_6 = 0
			local var_63_7 = 0.475

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_8 = arg_60_1:GetWordFromCfg(113072015)
				local var_63_9 = arg_60_1:FormatText(var_63_8.content)

				arg_60_1.text_.text = var_63_9

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 19 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 19)

				if (19 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 19)) > 0 and var_63_7 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_9
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072015", "story_v_out_113072.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_113072", "113072015", "story_v_out_113072.awb") / 1000

					if var_63_12 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_6
					end

					if var_63_8.prefab_name ~= "" and arg_60_1.actors_[var_63_8.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_8.prefab_name].transform, "story_v_out_113072", "113072015", "story_v_out_113072.awb")

						arg_60_1:RecordAudio("113072015", var_63_13)
						arg_60_1:RecordAudio("113072015", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_113072", "113072015", "story_v_out_113072.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_113072", "113072015", "story_v_out_113072.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play113072016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 113072016
		arg_64_1.duration_ = 7.1

		local var_64_0 = {
			ja = 4.633,
			ko = 5.1,
			zh = 7.1,
			en = 4.4
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
				arg_64_0:Play113072017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = arg_64_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).z)
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles = arg_64_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1084ui_story"].transform.position).z)
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1084ui_story"].transform.localEulerAngles = arg_64_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1042ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1042ui_story = var_67_1.localPosition
			end

			local var_67_2 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 then
				var_67_1.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_2)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 then
				var_67_1.localPosition = Vector3.New(0, 100, 0)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			local var_67_3 = 0
			local var_67_4 = 0.25

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[217].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3025")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_5 = arg_64_1:GetWordFromCfg(113072016)
				local var_67_6 = arg_64_1:FormatText(var_67_5.content)

				arg_64_1.text_.text = var_67_6

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_8 = 10 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_6) / 10)

				if (10 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_6) / 10)) > 0 and var_67_4 < var_67_8 then
					arg_64_1.talkMaxDuration = var_67_8

					if var_67_8 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_3
					end
				end

				arg_64_1.text_.text = var_67_6
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072016", "story_v_out_113072.awb") ~= 0 then
					local var_67_9 = manager.audio:GetVoiceLength("story_v_out_113072", "113072016", "story_v_out_113072.awb") / 1000

					if var_67_9 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_3
					end

					if var_67_5.prefab_name ~= "" and arg_64_1.actors_[var_67_5.prefab_name] ~= nil then
						local var_67_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_5.prefab_name].transform, "story_v_out_113072", "113072016", "story_v_out_113072.awb")

						arg_64_1:RecordAudio("113072016", var_67_10)
						arg_64_1:RecordAudio("113072016", var_67_10)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_113072", "113072016", "story_v_out_113072.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_113072", "113072016", "story_v_out_113072.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_11 = math.max(var_67_4, arg_64_1.talkMaxDuration)

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_11 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_3) / var_67_11

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_3 + var_67_11 and arg_64_1.time_ < var_67_3 + var_67_11 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play113072017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 113072017
		arg_68_1.duration_ = 2

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play113072018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1041ui_story = arg_68_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1041ui_story"].transform.position).z)
				arg_68_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1041ui_story"].transform.localEulerAngles = arg_68_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_68_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1041ui_story"].transform.position).z)
				arg_68_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1041ui_story"].transform.localEulerAngles = arg_68_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_1 = arg_68_1.actors_["1041ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1041ui_story == nil then
				arg_68_1.var_.characterEffect1041ui_story = var_71_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 and not isNil(var_71_1) then
				if arg_68_1.var_.characterEffect1041ui_story and not isNil(var_71_1) then
					arg_68_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1041ui_story then
				arg_68_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_71_4 = 0
			local var_71_5 = 0.05

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(113072017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 2 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 2)

				if (2 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 2)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072017", "story_v_out_113072.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072017", "story_v_out_113072.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_113072", "113072017", "story_v_out_113072.awb")

						arg_68_1:RecordAudio("113072017", var_71_11)
						arg_68_1:RecordAudio("113072017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_113072", "113072017", "story_v_out_113072.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_113072", "113072017", "story_v_out_113072.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play113072018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 113072018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play113072019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1041ui_story"]) and arg_72_1.var_.characterEffect1041ui_story == nil then
				arg_72_1.var_.characterEffect1041ui_story = arg_72_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1041ui_story"]) then
				if arg_72_1.var_.characterEffect1041ui_story and not isNil(arg_72_1.actors_["1041ui_story"]) then
					arg_72_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1041ui_story"]) and arg_72_1.var_.characterEffect1041ui_story then
				arg_72_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.725

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(113072018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 29 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 29)

				if (29 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 29)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play113072019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 113072019
		arg_76_1.duration_ = 1.03

		local var_76_0 = {
			ja = 1,
			ko = 0.999999999999,
			zh = 0.999999999999,
			en = 1.033
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
				arg_76_0:Play113072020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.1

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:GetWordFromCfg(113072019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 4 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 4)

				if (4 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 4)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072019", "story_v_out_113072.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_113072", "113072019", "story_v_out_113072.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_113072", "113072019", "story_v_out_113072.awb")

						arg_76_1:RecordAudio("113072019", var_79_6)
						arg_76_1:RecordAudio("113072019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_113072", "113072019", "story_v_out_113072.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_113072", "113072019", "story_v_out_113072.awb")
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
	Play113072020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 113072020
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play113072021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_83_0 = arg_80_1.actors_["1041ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1041ui_story == nil then
				arg_80_1.var_.characterEffect1041ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_1 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 and not isNil(var_83_0) then
				if arg_80_1.var_.characterEffect1041ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1041ui_story then
				arg_80_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_83_3 = 0
			local var_83_4 = 0.125

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:GetWordFromCfg(113072020)
				local var_83_6 = arg_80_1:FormatText(var_83_5.content)

				arg_80_1.text_.text = var_83_6

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_8 = 6 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_6) / 6)

				if (6 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_6) / 6)) > 0 and var_83_4 < var_83_8 then
					arg_80_1.talkMaxDuration = var_83_8

					if var_83_8 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_3
					end
				end

				arg_80_1.text_.text = var_83_6
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072020", "story_v_out_113072.awb") ~= 0 then
					local var_83_9 = manager.audio:GetVoiceLength("story_v_out_113072", "113072020", "story_v_out_113072.awb") / 1000

					if var_83_9 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_3
					end

					if var_83_5.prefab_name ~= "" and arg_80_1.actors_[var_83_5.prefab_name] ~= nil then
						local var_83_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_5.prefab_name].transform, "story_v_out_113072", "113072020", "story_v_out_113072.awb")

						arg_80_1:RecordAudio("113072020", var_83_10)
						arg_80_1:RecordAudio("113072020", var_83_10)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_113072", "113072020", "story_v_out_113072.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_113072", "113072020", "story_v_out_113072.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = math.max(var_83_4, arg_80_1.talkMaxDuration)

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_3) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_3 + var_83_11 and arg_80_1.time_ < var_83_3 + var_83_11 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play113072021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 113072021
		arg_84_1.duration_ = 8

		local var_84_0 = {
			ja = 5.8,
			ko = 8,
			zh = 6.3,
			en = 7.266
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
				arg_84_0:Play113072022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1041ui_story"]) and arg_84_1.var_.characterEffect1041ui_story == nil then
				arg_84_1.var_.characterEffect1041ui_story = arg_84_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1041ui_story"]) then
				if arg_84_1.var_.characterEffect1041ui_story and not isNil(arg_84_1.actors_["1041ui_story"]) then
					arg_84_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1041ui_story"]) and arg_84_1.var_.characterEffect1041ui_story then
				arg_84_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.875

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(113072021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 35 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 35)

				if (35 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_4) / 35)) > 0 and var_87_2 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072021", "story_v_out_113072.awb") ~= 0 then
					local var_87_7 = manager.audio:GetVoiceLength("story_v_out_113072", "113072021", "story_v_out_113072.awb") / 1000

					if var_87_7 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_1
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_out_113072", "113072021", "story_v_out_113072.awb")

						arg_84_1:RecordAudio("113072021", var_87_8)
						arg_84_1:RecordAudio("113072021", var_87_8)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_113072", "113072021", "story_v_out_113072.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_113072", "113072021", "story_v_out_113072.awb")
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
	Play113072022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 113072022
		arg_88_1.duration_ = 3.7

		local var_88_0 = {
			ja = 3.1,
			ko = 3.7,
			zh = 3.4,
			en = 3.266
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
				arg_88_0:Play113072023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_91_0 = arg_88_1.actors_["1041ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1041ui_story == nil then
				arg_88_1.var_.characterEffect1041ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_1 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 and not isNil(var_91_0) then
				if arg_88_1.var_.characterEffect1041ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1041ui_story then
				arg_88_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_91_3 = 0
			local var_91_4 = 0.275

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_5 = arg_88_1:GetWordFromCfg(113072022)
				local var_91_6 = arg_88_1:FormatText(var_91_5.content)

				arg_88_1.text_.text = var_91_6

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_8 = 16 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_6) / 16)

				if (16 <= 0 and var_91_4 or var_91_4 * (utf8.len(var_91_6) / 16)) > 0 and var_91_4 < var_91_8 then
					arg_88_1.talkMaxDuration = var_91_8

					if var_91_8 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_3
					end
				end

				arg_88_1.text_.text = var_91_6
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072022", "story_v_out_113072.awb") ~= 0 then
					local var_91_9 = manager.audio:GetVoiceLength("story_v_out_113072", "113072022", "story_v_out_113072.awb") / 1000

					if var_91_9 + var_91_3 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_3
					end

					if var_91_5.prefab_name ~= "" and arg_88_1.actors_[var_91_5.prefab_name] ~= nil then
						local var_91_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_5.prefab_name].transform, "story_v_out_113072", "113072022", "story_v_out_113072.awb")

						arg_88_1:RecordAudio("113072022", var_91_10)
						arg_88_1:RecordAudio("113072022", var_91_10)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_113072", "113072022", "story_v_out_113072.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_113072", "113072022", "story_v_out_113072.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_11 = math.max(var_91_4, arg_88_1.talkMaxDuration)

			if var_91_3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_3 + var_91_11 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_3) / var_91_11

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_3 + var_91_11 and arg_88_1.time_ < var_91_3 + var_91_11 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play113072023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 113072023
		arg_92_1.duration_ = 8.6

		local var_92_0 = {
			ja = 7.333,
			ko = 8.6,
			zh = 7.066,
			en = 7
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
				arg_92_0:Play113072024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1041ui_story = arg_92_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_95_0 = 0.5

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1041ui_story"].transform.position).z)
				arg_92_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1041ui_story"].transform.localEulerAngles = arg_92_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_92_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1041ui_story"].transform.position).z)
				arg_92_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1041ui_story"].transform.localEulerAngles = arg_92_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_95_1 = arg_92_1.actors_["1041ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1041ui_story == nil then
				arg_92_1.var_.characterEffect1041ui_story = var_95_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 and not isNil(var_95_1) then
				if arg_92_1.var_.characterEffect1041ui_story and not isNil(var_95_1) then
					arg_92_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_2)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 and not isNil(var_95_1) and arg_92_1.var_.characterEffect1041ui_story then
				arg_92_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_95_3 = arg_92_1.actors_["1084ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_3.localPosition
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_92_1.time_ - 0) / var_95_4)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_95_5 = arg_92_1.actors_["1084ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 and not isNil(var_95_5) then
				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_5) then
					arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1084ui_story then
				arg_92_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_95_8 = 0
			local var_95_9 = 0.95

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(113072023)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 38 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 38)

				if (38 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 38)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072023", "story_v_out_113072.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_113072", "113072023", "story_v_out_113072.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_113072", "113072023", "story_v_out_113072.awb")

						arg_92_1:RecordAudio("113072023", var_95_15)
						arg_92_1:RecordAudio("113072023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_113072", "113072023", "story_v_out_113072.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_113072", "113072023", "story_v_out_113072.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play113072024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 113072024
		arg_96_1.duration_ = 2.2

		local var_96_0 = {
			ja = 2.2,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_96_0:Play113072025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story == nil then
				arg_96_1.var_.characterEffect1084ui_story = arg_96_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) then
				if arg_96_1.var_.characterEffect1084ui_story and not isNil(arg_96_1.actors_["1084ui_story"]) then
					arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1084ui_story"]) and arg_96_1.var_.characterEffect1084ui_story then
				arg_96_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_99_1 = arg_96_1.actors_["1041ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1041ui_story == nil then
				arg_96_1.var_.characterEffect1041ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1041ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1041ui_story then
				arg_96_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_99_4 = 0
			local var_99_5 = 0.15

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(113072024)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 6 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 6)

				if (6 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 6)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072024", "story_v_out_113072.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072024", "story_v_out_113072.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_113072", "113072024", "story_v_out_113072.awb")

						arg_96_1:RecordAudio("113072024", var_99_11)
						arg_96_1:RecordAudio("113072024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_113072", "113072024", "story_v_out_113072.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_113072", "113072024", "story_v_out_113072.awb")
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
	Play113072025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 113072025
		arg_100_1.duration_ = 2

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play113072026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) and arg_100_1.var_.characterEffect1084ui_story == nil then
				arg_100_1.var_.characterEffect1084ui_story = arg_100_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) then
				if arg_100_1.var_.characterEffect1084ui_story and not isNil(arg_100_1.actors_["1084ui_story"]) then
					arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1084ui_story"]) and arg_100_1.var_.characterEffect1084ui_story then
				arg_100_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["1041ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1041ui_story == nil then
				arg_100_1.var_.characterEffect1041ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect1041ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect1041ui_story then
				arg_100_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_103_4 = 0
			local var_103_5 = 0.05

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
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

				local var_103_6 = arg_100_1:GetWordFromCfg(113072025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 2 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 2)

				if (2 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 2)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072025", "story_v_out_113072.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072025", "story_v_out_113072.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_113072", "113072025", "story_v_out_113072.awb")

						arg_100_1:RecordAudio("113072025", var_103_11)
						arg_100_1:RecordAudio("113072025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_113072", "113072025", "story_v_out_113072.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_113072", "113072025", "story_v_out_113072.awb")
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
	Play113072026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 113072026
		arg_104_1.duration_ = 11.8

		local var_104_0 = {
			ja = 8.1,
			ko = 6.7,
			zh = 7.533,
			en = 11.8
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
				arg_104_0:Play113072027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1084ui_story"]) and arg_104_1.var_.characterEffect1084ui_story == nil then
				arg_104_1.var_.characterEffect1084ui_story = arg_104_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.2

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

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_107_1 = arg_104_1.actors_["1041ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1041ui_story == nil then
				arg_104_1.var_.characterEffect1041ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect1041ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1041ui_story then
				arg_104_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_107_4 = 0
			local var_107_5 = 1.05

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(113072026)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 42 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 42)

				if (42 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 42)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072026", "story_v_out_113072.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072026", "story_v_out_113072.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_113072", "113072026", "story_v_out_113072.awb")

						arg_104_1:RecordAudio("113072026", var_107_11)
						arg_104_1:RecordAudio("113072026", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_113072", "113072026", "story_v_out_113072.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_113072", "113072026", "story_v_out_113072.awb")
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
	Play113072027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 113072027
		arg_108_1.duration_ = 6.8

		local var_108_0 = {
			ja = 4.466,
			ko = 6.6,
			zh = 6.066,
			en = 6.8
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
				arg_108_0:Play113072028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_1")
			end

			local var_111_0 = 0
			local var_111_1 = 0.7

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_2 = arg_108_1:GetWordFromCfg(113072027)
				local var_111_3 = arg_108_1:FormatText(var_111_2.content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 28 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 28)

				if (28 <= 0 and var_111_1 or var_111_1 * (utf8.len(var_111_3) / 28)) > 0 and var_111_1 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072027", "story_v_out_113072.awb") ~= 0 then
					local var_111_6 = manager.audio:GetVoiceLength("story_v_out_113072", "113072027", "story_v_out_113072.awb") / 1000

					if var_111_6 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_0
					end

					if var_111_2.prefab_name ~= "" and arg_108_1.actors_[var_111_2.prefab_name] ~= nil then
						local var_111_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_2.prefab_name].transform, "story_v_out_113072", "113072027", "story_v_out_113072.awb")

						arg_108_1:RecordAudio("113072027", var_111_7)
						arg_108_1:RecordAudio("113072027", var_111_7)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_113072", "113072027", "story_v_out_113072.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_113072", "113072027", "story_v_out_113072.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play113072028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 113072028
		arg_112_1.duration_ = 12.7

		local var_112_0 = {
			ja = 12.466,
			ko = 11.966,
			zh = 9.333,
			en = 12.7
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
				arg_112_0:Play113072029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1038ui_story = arg_112_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1038ui_story"].transform.position).z)
				arg_112_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1038ui_story"].transform.localEulerAngles = arg_112_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.9)
				arg_112_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1038ui_story"].transform.position).z)
				arg_112_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1038ui_story"].transform.localEulerAngles = arg_112_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1084ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1084ui_story = var_115_1.localPosition
			end

			local var_115_2 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 then
				var_115_1.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_2)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 then
				var_115_1.localPosition = Vector3.New(0, 100, 0)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_115_3 = arg_112_1.actors_["1038ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1038ui_story == nil then
				arg_112_1.var_.characterEffect1038ui_story = var_115_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_4 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 and not isNil(var_115_3) then
				if arg_112_1.var_.characterEffect1038ui_story and not isNil(var_115_3) then
					arg_112_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1038ui_story then
				arg_112_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_115_6 = arg_112_1.actors_["1041ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1041ui_story == nil then
				arg_112_1.var_.characterEffect1041ui_story = var_115_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 and not isNil(var_115_6) then
				if arg_112_1.var_.characterEffect1041ui_story and not isNil(var_115_6) then
					arg_112_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_7)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1041ui_story then
				arg_112_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_115_8 = 0
			local var_115_9 = 1.2

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:GetWordFromCfg(113072028)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 48 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 48)

				if (48 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 48)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072028", "story_v_out_113072.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_113072", "113072028", "story_v_out_113072.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_113072", "113072028", "story_v_out_113072.awb")

						arg_112_1:RecordAudio("113072028", var_115_15)
						arg_112_1:RecordAudio("113072028", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_113072", "113072028", "story_v_out_113072.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_113072", "113072028", "story_v_out_113072.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_16 and arg_112_1.time_ < var_115_8 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play113072029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 113072029
		arg_116_1.duration_ = 4.17

		local var_116_0 = {
			ja = 2.466,
			ko = 3.3,
			zh = 2.2,
			en = 4.166
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
				arg_116_0:Play113072030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1038ui_story"]) and arg_116_1.var_.characterEffect1038ui_story == nil then
				arg_116_1.var_.characterEffect1038ui_story = arg_116_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1038ui_story"]) then
				if arg_116_1.var_.characterEffect1038ui_story and not isNil(arg_116_1.actors_["1038ui_story"]) then
					arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1038ui_story"]) and arg_116_1.var_.characterEffect1038ui_story then
				arg_116_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_2")
			end

			local var_119_1 = arg_116_1.actors_["1041ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1041ui_story == nil then
				arg_116_1.var_.characterEffect1041ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1041ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1041ui_story then
				arg_116_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_119_4 = 0
			local var_119_5 = 0.275

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(113072029)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)

				if (11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072029", "story_v_out_113072.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072029", "story_v_out_113072.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_113072", "113072029", "story_v_out_113072.awb")

						arg_116_1:RecordAudio("113072029", var_119_11)
						arg_116_1:RecordAudio("113072029", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_113072", "113072029", "story_v_out_113072.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_113072", "113072029", "story_v_out_113072.awb")
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
	Play113072030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 113072030
		arg_120_1.duration_ = 10

		local var_120_0 = {
			ja = 7.733,
			ko = 10,
			zh = 6.266,
			en = 7.6
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
				arg_120_0:Play113072031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1041ui_story"]) and arg_120_1.var_.characterEffect1041ui_story == nil then
				arg_120_1.var_.characterEffect1041ui_story = arg_120_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1041ui_story"]) then
				if arg_120_1.var_.characterEffect1041ui_story and not isNil(arg_120_1.actors_["1041ui_story"]) then
					arg_120_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1041ui_story"]) and arg_120_1.var_.characterEffect1041ui_story then
				arg_120_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_123_1 = arg_120_1.actors_["1038ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1038ui_story == nil then
				arg_120_1.var_.characterEffect1038ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect1038ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1038ui_story then
				arg_120_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_123_4 = 0
			local var_123_5 = 0.875

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(113072030)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 33 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 33)

				if (33 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 33)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072030", "story_v_out_113072.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072030", "story_v_out_113072.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_113072", "113072030", "story_v_out_113072.awb")

						arg_120_1:RecordAudio("113072030", var_123_11)
						arg_120_1:RecordAudio("113072030", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_113072", "113072030", "story_v_out_113072.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_113072", "113072030", "story_v_out_113072.awb")
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
	Play113072031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 113072031
		arg_124_1.duration_ = 9.4

		local var_124_0 = {
			ja = 7.766,
			ko = 9.4,
			zh = 7.533,
			en = 9.066
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
				arg_124_0:Play113072032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_127_0 = 0
			local var_127_1 = 0.95

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(113072031)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 38 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 38)

				if (38 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 38)) > 0 and var_127_1 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072031", "story_v_out_113072.awb") ~= 0 then
					local var_127_6 = manager.audio:GetVoiceLength("story_v_out_113072", "113072031", "story_v_out_113072.awb") / 1000

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end

					if var_127_2.prefab_name ~= "" and arg_124_1.actors_[var_127_2.prefab_name] ~= nil then
						local var_127_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_2.prefab_name].transform, "story_v_out_113072", "113072031", "story_v_out_113072.awb")

						arg_124_1:RecordAudio("113072031", var_127_7)
						arg_124_1:RecordAudio("113072031", var_127_7)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_113072", "113072031", "story_v_out_113072.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_113072", "113072031", "story_v_out_113072.awb")
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
	Play113072032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 113072032
		arg_128_1.duration_ = 5.57

		local var_128_0 = {
			ja = 4.933,
			ko = 4.6,
			zh = 4.666,
			en = 5.566
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
				arg_128_0:Play113072033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1038ui_story"]) and arg_128_1.var_.characterEffect1038ui_story == nil then
				arg_128_1.var_.characterEffect1038ui_story = arg_128_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1038ui_story"]) then
				if arg_128_1.var_.characterEffect1038ui_story and not isNil(arg_128_1.actors_["1038ui_story"]) then
					arg_128_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1038ui_story"]) and arg_128_1.var_.characterEffect1038ui_story then
				arg_128_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_131_1 = arg_128_1.actors_["1041ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1041ui_story == nil then
				arg_128_1.var_.characterEffect1041ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1041ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1041ui_story then
				arg_128_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_131_4 = 0
			local var_131_5 = 0.65

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(113072032)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 26 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 26)

				if (26 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 26)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072032", "story_v_out_113072.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072032", "story_v_out_113072.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_113072", "113072032", "story_v_out_113072.awb")

						arg_128_1:RecordAudio("113072032", var_131_11)
						arg_128_1:RecordAudio("113072032", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_113072", "113072032", "story_v_out_113072.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_113072", "113072032", "story_v_out_113072.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play113072033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 113072033
		arg_132_1.duration_ = 2.63

		local var_132_0 = {
			ja = 2.633,
			ko = 1.999999999999,
			zh = 2.1,
			en = 2.433
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
				arg_132_0:Play113072034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_135_0 = arg_132_1.actors_["1038ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1038ui_story == nil then
				arg_132_1.var_.characterEffect1038ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_1 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 and not isNil(var_135_0) then
				if arg_132_1.var_.characterEffect1038ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1038ui_story then
				arg_132_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_135_3 = arg_132_1.actors_["1041ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1041ui_story == nil then
				arg_132_1.var_.characterEffect1041ui_story = var_135_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_4 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 and not isNil(var_135_3) then
				if arg_132_1.var_.characterEffect1041ui_story and not isNil(var_135_3) then
					arg_132_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_4)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1041ui_story then
				arg_132_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_135_5 = 0
			local var_135_6 = 0.1

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_7 = arg_132_1:GetWordFromCfg(113072033)
				local var_135_8 = arg_132_1:FormatText(var_135_7.content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 4 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 4)

				if (4 <= 0 and var_135_6 or var_135_6 * (utf8.len(var_135_8) / 4)) > 0 and var_135_6 < var_135_10 then
					arg_132_1.talkMaxDuration = var_135_10

					if var_135_10 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_5
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072033", "story_v_out_113072.awb") ~= 0 then
					local var_135_11 = manager.audio:GetVoiceLength("story_v_out_113072", "113072033", "story_v_out_113072.awb") / 1000

					if var_135_11 + var_135_5 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_5
					end

					if var_135_7.prefab_name ~= "" and arg_132_1.actors_[var_135_7.prefab_name] ~= nil then
						local var_135_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_7.prefab_name].transform, "story_v_out_113072", "113072033", "story_v_out_113072.awb")

						arg_132_1:RecordAudio("113072033", var_135_12)
						arg_132_1:RecordAudio("113072033", var_135_12)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_113072", "113072033", "story_v_out_113072.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_113072", "113072033", "story_v_out_113072.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_13 = math.max(var_135_6, arg_132_1.talkMaxDuration)

			if var_135_5 <= arg_132_1.time_ and arg_132_1.time_ < var_135_5 + var_135_13 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_5) / var_135_13

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_5 + var_135_13 and arg_132_1.time_ < var_135_5 + var_135_13 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play113072034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 113072034
		arg_136_1.duration_ = 12.43

		local var_136_0 = {
			ja = 7.9,
			ko = 7.533,
			zh = 7.033,
			en = 12.433
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
				arg_136_0:Play113072035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1038ui_story"]) and arg_136_1.var_.characterEffect1038ui_story == nil then
				arg_136_1.var_.characterEffect1038ui_story = arg_136_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1038ui_story"]) then
				if arg_136_1.var_.characterEffect1038ui_story and not isNil(arg_136_1.actors_["1038ui_story"]) then
					arg_136_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1038ui_story"]) and arg_136_1.var_.characterEffect1038ui_story then
				arg_136_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_139_1 = arg_136_1.actors_["1041ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1041ui_story = var_139_1.localPosition
			end

			local var_139_2 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 then
				var_139_1.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_2)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 then
				var_139_1.localPosition = Vector3.New(0, 100, 0)
				var_139_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_1.position).x, (manager.ui.mainCamera.transform.position - var_139_1.position).y, (manager.ui.mainCamera.transform.position - var_139_1.position).z)
				var_139_1.localEulerAngles.z = 0
				var_139_1.localEulerAngles.x = 0
				var_139_1.localEulerAngles = var_139_1.localEulerAngles
			end

			local var_139_3 = arg_136_1.actors_["1042ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1042ui_story = var_139_3.localPosition
			end

			local var_139_4 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_136_1.time_ - 0) / var_139_4)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_139_5 = arg_136_1.actors_["1042ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1042ui_story == nil then
				arg_136_1.var_.characterEffect1042ui_story = var_139_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_6 and not isNil(var_139_5) then
				if arg_136_1.var_.characterEffect1042ui_story and not isNil(var_139_5) then
					arg_136_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_6 and arg_136_1.time_ < 0 + var_139_6 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1042ui_story then
				arg_136_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_139_8 = 0
			local var_139_9 = 0.725

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(113072034)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 29 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 29)

				if (29 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 29)) > 0 and var_139_9 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072034", "story_v_out_113072.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_113072", "113072034", "story_v_out_113072.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_113072", "113072034", "story_v_out_113072.awb")

						arg_136_1:RecordAudio("113072034", var_139_15)
						arg_136_1:RecordAudio("113072034", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_113072", "113072034", "story_v_out_113072.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_113072", "113072034", "story_v_out_113072.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_16 and arg_136_1.time_ < var_139_8 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play113072035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 113072035
		arg_140_1.duration_ = 6.53

		local var_140_0 = {
			ja = 6.166,
			ko = 3,
			zh = 3.366,
			en = 6.533
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
				arg_140_0:Play113072036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1042ui_story = arg_140_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1042ui_story"].transform.position).z)
				arg_140_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1042ui_story"].transform.localEulerAngles = arg_140_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1042ui_story"].transform.position).z)
				arg_140_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1042ui_story"].transform.localEulerAngles = arg_140_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["1041ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1041ui_story = var_143_1.localPosition
			end

			local var_143_2 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_140_1.time_ - 0) / var_143_2)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_143_3 = arg_140_1.actors_["1041ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1041ui_story == nil then
				arg_140_1.var_.characterEffect1041ui_story = var_143_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_4 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 and not isNil(var_143_3) then
				if arg_140_1.var_.characterEffect1041ui_story and not isNil(var_143_3) then
					arg_140_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1041ui_story then
				arg_140_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_143_6 = 0
			local var_143_7 = 0.45

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(113072035)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 18 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 18)

				if (18 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 18)) > 0 and var_143_7 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072035", "story_v_out_113072.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_113072", "113072035", "story_v_out_113072.awb") / 1000

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_out_113072", "113072035", "story_v_out_113072.awb")

						arg_140_1:RecordAudio("113072035", var_143_13)
						arg_140_1:RecordAudio("113072035", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_113072", "113072035", "story_v_out_113072.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_113072", "113072035", "story_v_out_113072.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play113072036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 113072036
		arg_144_1.duration_ = 10.13

		local var_144_0 = {
			ja = 8.366,
			ko = 10.133,
			zh = 6.633,
			en = 7.466
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
				arg_144_0:Play113072037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1041ui_story"]) and arg_144_1.var_.characterEffect1041ui_story == nil then
				arg_144_1.var_.characterEffect1041ui_story = arg_144_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1041ui_story"]) then
				if arg_144_1.var_.characterEffect1041ui_story and not isNil(arg_144_1.actors_["1041ui_story"]) then
					arg_144_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1041ui_story"]) and arg_144_1.var_.characterEffect1041ui_story then
				arg_144_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			local var_147_1 = arg_144_1.actors_["1038ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1038ui_story == nil then
				arg_144_1.var_.characterEffect1038ui_story = var_147_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 and not isNil(var_147_1) then
				if arg_144_1.var_.characterEffect1038ui_story and not isNil(var_147_1) then
					arg_144_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1038ui_story then
				arg_144_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 0.9

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(113072036)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 36 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 36)

				if (36 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 36)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072036", "story_v_out_113072.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072036", "story_v_out_113072.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_113072", "113072036", "story_v_out_113072.awb")

						arg_144_1:RecordAudio("113072036", var_147_11)
						arg_144_1:RecordAudio("113072036", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_113072", "113072036", "story_v_out_113072.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_113072", "113072036", "story_v_out_113072.awb")
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
	Play113072037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 113072037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play113072038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1038ui_story = arg_148_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1038ui_story"].transform.position).z)
				arg_148_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1038ui_story"].transform.localEulerAngles = arg_148_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1038ui_story"].transform.position).z)
				arg_148_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1038ui_story"].transform.localEulerAngles = arg_148_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1041ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1041ui_story = var_151_1.localPosition
			end

			local var_151_2 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 then
				var_151_1.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_2)
				var_151_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_1.position).x, (manager.ui.mainCamera.transform.position - var_151_1.position).y, (manager.ui.mainCamera.transform.position - var_151_1.position).z)
				var_151_1.localEulerAngles.z = 0
				var_151_1.localEulerAngles.x = 0
				var_151_1.localEulerAngles = var_151_1.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 then
				var_151_1.localPosition = Vector3.New(0, 100, 0)
				var_151_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_1.position).x, (manager.ui.mainCamera.transform.position - var_151_1.position).y, (manager.ui.mainCamera.transform.position - var_151_1.position).z)
				var_151_1.localEulerAngles.z = 0
				var_151_1.localEulerAngles.x = 0
				var_151_1.localEulerAngles = var_151_1.localEulerAngles
			end

			local var_151_3 = 0
			local var_151_4 = 0.675

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_5 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(113072037).content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 27 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 27)

				if (27 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_5) / 27)) > 0 and var_151_4 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_3
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_4, arg_148_1.talkMaxDuration)

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_3) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_3 + var_151_8 and arg_148_1.time_ < var_151_3 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play113072038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 113072038
		arg_152_1.duration_ = 6.1

		local var_152_0 = {
			ja = 2.766,
			ko = 4.3,
			zh = 5.266,
			en = 6.1
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
				arg_152_0:Play113072039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1084ui_story = arg_152_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).z)
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles = arg_152_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_152_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1084ui_story"].transform.position).z)
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1084ui_story"].transform.localEulerAngles = arg_152_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_155_1 = arg_152_1.actors_["1084ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1084ui_story == nil then
				arg_152_1.var_.characterEffect1084ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1084ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1084ui_story then
				arg_152_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_155_4 = 0
			local var_155_5 = 0.5

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(113072038)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 20 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 20)

				if (20 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 20)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072038", "story_v_out_113072.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_113072", "113072038", "story_v_out_113072.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_113072", "113072038", "story_v_out_113072.awb")

						arg_152_1:RecordAudio("113072038", var_155_11)
						arg_152_1:RecordAudio("113072038", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_113072", "113072038", "story_v_out_113072.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_113072", "113072038", "story_v_out_113072.awb")
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

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play113072039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 113072039
		arg_156_1.duration_ = 0.2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"

			SetActive(arg_156_1.choicesGo_, true)

			for iter_157_0, iter_157_1 in ipairs(arg_156_1.choices_) do
				SetActive(iter_157_1.go, iter_157_0 <= 2)
			end

			arg_156_1.choices_[1].txt.text = arg_156_1:FormatText(StoryChoiceCfg[191].name)
			arg_156_1.choices_[2].txt.text = arg_156_1:FormatText(StoryChoiceCfg[192].name)
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play113072040(arg_156_1)
			end

			if arg_158_0 == 2 then
				arg_156_0:Play113072041(arg_156_1)
			end

			arg_156_1:RecordChoiceLog(113072039, 191, 192)
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1084ui_story"]) and arg_156_1.var_.characterEffect1084ui_story == nil then
				arg_156_1.var_.characterEffect1084ui_story = arg_156_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1084ui_story"]) then
				if arg_156_1.var_.characterEffect1084ui_story and not isNil(arg_156_1.actors_["1084ui_story"]) then
					arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1084ui_story"]) and arg_156_1.var_.characterEffect1084ui_story then
				arg_156_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play113072040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 113072040
		arg_160_1.duration_ = 7.57

		local var_160_0 = {
			ja = 7.566,
			ko = 4.433,
			zh = 3.766,
			en = 4.233
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
				arg_160_0:Play113072042(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_163_0 = arg_160_1.actors_["1084ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story == nil then
				arg_160_1.var_.characterEffect1084ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_1 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 and not isNil(var_163_0) then
				if arg_160_1.var_.characterEffect1084ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1084ui_story then
				arg_160_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_163_3 = 0
			local var_163_4 = 0.425

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:GetWordFromCfg(113072040)
				local var_163_6 = arg_160_1:FormatText(var_163_5.content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_8 = 17 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_6) / 17)

				if (17 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_6) / 17)) > 0 and var_163_4 < var_163_8 then
					arg_160_1.talkMaxDuration = var_163_8

					if var_163_8 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_3
					end
				end

				arg_160_1.text_.text = var_163_6
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072040", "story_v_out_113072.awb") ~= 0 then
					local var_163_9 = manager.audio:GetVoiceLength("story_v_out_113072", "113072040", "story_v_out_113072.awb") / 1000

					if var_163_9 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_3
					end

					if var_163_5.prefab_name ~= "" and arg_160_1.actors_[var_163_5.prefab_name] ~= nil then
						local var_163_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_5.prefab_name].transform, "story_v_out_113072", "113072040", "story_v_out_113072.awb")

						arg_160_1:RecordAudio("113072040", var_163_10)
						arg_160_1:RecordAudio("113072040", var_163_10)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_113072", "113072040", "story_v_out_113072.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_113072", "113072040", "story_v_out_113072.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_11 = math.max(var_163_4, arg_160_1.talkMaxDuration)

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_11 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_3) / var_163_11

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_3 + var_163_11 and arg_160_1.time_ < var_163_3 + var_163_11 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play113072042 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 113072042
		arg_164_1.duration_ = 7.6

		local var_164_0 = {
			ja = 6.2,
			ko = 7.3,
			zh = 5.666,
			en = 7.6
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
			arg_164_1.auto_ = false
		end

		function arg_164_1.playNext_(arg_166_0)
			arg_164_1.onStoryFinished_()
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = arg_164_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).z)
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles = arg_164_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1084ui_story"].transform.position).z)
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1084ui_story"].transform.localEulerAngles = arg_164_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_167_1 = arg_164_1.actors_["1041ui_story"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1041ui_story = var_167_1.localPosition
			end

			local var_167_2 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 then
				var_167_1.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_164_1.time_ - 0) / var_167_2)
				var_167_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_1.position).x, (manager.ui.mainCamera.transform.position - var_167_1.position).y, (manager.ui.mainCamera.transform.position - var_167_1.position).z)
				var_167_1.localEulerAngles.z = 0
				var_167_1.localEulerAngles.x = 0
				var_167_1.localEulerAngles = var_167_1.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 then
				var_167_1.localPosition = Vector3.New(0, -1.11, -5.9)
				var_167_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_1.position).x, (manager.ui.mainCamera.transform.position - var_167_1.position).y, (manager.ui.mainCamera.transform.position - var_167_1.position).z)
				var_167_1.localEulerAngles.z = 0
				var_167_1.localEulerAngles.x = 0
				var_167_1.localEulerAngles = var_167_1.localEulerAngles
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_167_3 = arg_164_1.actors_["1041ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1041ui_story == nil then
				arg_164_1.var_.characterEffect1041ui_story = var_167_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_4 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 and not isNil(var_167_3) then
				if arg_164_1.var_.characterEffect1041ui_story and not isNil(var_167_3) then
					arg_164_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 and not isNil(var_167_3) and arg_164_1.var_.characterEffect1041ui_story then
				arg_164_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_167_6 = 0
			local var_167_7 = 0.6

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(113072042)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_11 = 24 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 24)

				if (24 <= 0 and var_167_7 or var_167_7 * (utf8.len(var_167_9) / 24)) > 0 and var_167_7 < var_167_11 then
					arg_164_1.talkMaxDuration = var_167_11

					if var_167_11 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072042", "story_v_out_113072.awb") ~= 0 then
					local var_167_12 = manager.audio:GetVoiceLength("story_v_out_113072", "113072042", "story_v_out_113072.awb") / 1000

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end

					if var_167_8.prefab_name ~= "" and arg_164_1.actors_[var_167_8.prefab_name] ~= nil then
						local var_167_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_8.prefab_name].transform, "story_v_out_113072", "113072042", "story_v_out_113072.awb")

						arg_164_1:RecordAudio("113072042", var_167_13)
						arg_164_1:RecordAudio("113072042", var_167_13)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_113072", "113072042", "story_v_out_113072.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_113072", "113072042", "story_v_out_113072.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_14 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_14 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_14

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_14 and arg_164_1.time_ < var_167_6 + var_167_14 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play113072041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 113072041
		arg_168_1.duration_ = 2.9

		local var_168_0 = {
			ja = 2.433,
			ko = 2.166,
			zh = 2.333,
			en = 2.9
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play113072042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if arg_168_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_171_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_168_1.stage_.transform)

				var_171_0.name = "1084ui_story"
				var_171_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.actors_["1084ui_story"] = var_171_0

				local var_171_1 = var_171_0:GetComponentInChildren(typeof(CharacterEffect))

				var_171_1.enabled = true

				local var_171_2 = GameObjectTools.GetOrAddComponent(var_171_0, typeof(DynamicBoneHelper))

				if var_171_2 then
					var_171_2:EnableDynamicBone(false)
				end

				arg_168_1:ShowWeapon(var_171_1.transform, false)

				arg_168_1.var_["1084ui_story" .. "Animator"] = var_171_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_168_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_168_1.var_["1084ui_story" .. "LipSync"] = var_171_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			local var_171_3 = "1084ui_story"

			if arg_168_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_171_4 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_168_1.stage_.transform)

				var_171_4.name = var_171_3
				var_171_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.actors_[var_171_3] = var_171_4

				local var_171_5 = var_171_4:GetComponentInChildren(typeof(CharacterEffect))

				var_171_5.enabled = true

				local var_171_6 = GameObjectTools.GetOrAddComponent(var_171_4, typeof(DynamicBoneHelper))

				if var_171_6 then
					var_171_6:EnableDynamicBone(false)
				end

				arg_168_1:ShowWeapon(var_171_5.transform, false)

				arg_168_1.var_[var_171_3 .. "Animator"] = var_171_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_168_1.var_[var_171_3 .. "Animator"].applyRootMotion = true
				arg_168_1.var_[var_171_3 .. "LipSync"] = var_171_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_171_7 = arg_168_1.actors_["1084ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_7) and arg_168_1.var_.characterEffect1084ui_story == nil then
				arg_168_1.var_.characterEffect1084ui_story = var_171_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_8 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_8 and not isNil(var_171_7) then
				if arg_168_1.var_.characterEffect1084ui_story and not isNil(var_171_7) then
					arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_8 and arg_168_1.time_ < 0 + var_171_8 + arg_171_0 and not isNil(var_171_7) and arg_168_1.var_.characterEffect1084ui_story then
				arg_168_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_171_10 = 0
			local var_171_11 = 0.15

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_12 = arg_168_1:GetWordFromCfg(113072041)
				local var_171_13 = arg_168_1:FormatText(var_171_12.content)

				arg_168_1.text_.text = var_171_13

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_15 = 6 <= 0 and var_171_11 or var_171_11 * (utf8.len(var_171_13) / 6)

				if (6 <= 0 and var_171_11 or var_171_11 * (utf8.len(var_171_13) / 6)) > 0 and var_171_11 < var_171_15 then
					arg_168_1.talkMaxDuration = var_171_15

					if var_171_15 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_15 + var_171_10
					end
				end

				arg_168_1.text_.text = var_171_13
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113072", "113072041", "story_v_out_113072.awb") ~= 0 then
					local var_171_16 = manager.audio:GetVoiceLength("story_v_out_113072", "113072041", "story_v_out_113072.awb") / 1000

					if var_171_16 + var_171_10 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_16 + var_171_10
					end

					if var_171_12.prefab_name ~= "" and arg_168_1.actors_[var_171_12.prefab_name] ~= nil then
						local var_171_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_12.prefab_name].transform, "story_v_out_113072", "113072041", "story_v_out_113072.awb")

						arg_168_1:RecordAudio("113072041", var_171_17)
						arg_168_1:RecordAudio("113072041", var_171_17)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_113072", "113072041", "story_v_out_113072.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_113072", "113072041", "story_v_out_113072.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_18 = math.max(var_171_11, arg_168_1.talkMaxDuration)

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_18 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_10) / var_171_18

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_10 + var_171_18 and arg_168_1.time_ < var_171_10 + var_171_18 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F02_1"
	},
	voices = {
		"story_v_out_113072.awb"
	}
}
