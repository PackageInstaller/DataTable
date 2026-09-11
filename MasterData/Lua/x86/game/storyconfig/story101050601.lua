return {
	Play105061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105061001
		arg_1_1.duration_ = 3.73

		local var_1_0 = {
			ja = 3.533,
			ko = 3.733,
			zh = 3.166,
			en = 3.333
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
				arg_1_0:Play105061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_4.name = var_4_3
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_3] = var_4_4

				local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

				var_4_5.enabled = true

				local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

				if var_4_6 then
					var_4_6:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_5.transform, false)

				arg_1_1.var_[var_4_3 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_3 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_3 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_7 = arg_1_1.actors_["1084ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_8 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_8 and not isNil(var_4_7) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_7) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_8 and arg_1_1.time_ < 2 + var_4_8 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_10 = "B12a"

			if arg_1_1.bgs_.B12a == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.bgs_.B12a:GetComponent("SpriteRenderer")

				if var_4_12 then
					arg_1_1.var_.alphaOldValueB12a = var_4_12.color.a
					arg_1_1.var_.alphaMatValueB12a = var_4_12
				end

				arg_1_1.var_.alphaOldValueB12a = 0
			end

			local var_4_13 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				if arg_1_1.var_.alphaMatValueB12a then
					arg_1_1.var_.alphaMatValueB12a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB12a, 1, (arg_1_1.time_ - 0) / var_4_13)
					arg_1_1.var_.alphaMatValueB12a.color = arg_1_1.var_.alphaMatValueB12a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and arg_1_1.var_.alphaMatValueB12a then
				arg_1_1.var_.alphaMatValueB12a.color.a = 1
				arg_1_1.var_.alphaMatValueB12a.color = arg_1_1.var_.alphaMatValueB12a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.B12a

				arg_1_1.bgs_.B12a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = 2 * (var_4_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_14.transform.localScale = Vector3.New(var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B12a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_17 = arg_1_1.actors_["1084ui_story"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_17.localPosition
			end

			local var_4_18 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 1.79999995231628) / var_4_18)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_18 and arg_1_1.time_ < 1.79999995231628 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(0, -0.97, -6)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_4_19 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_19 + 2 and arg_1_1.time_ < var_4_19 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.1

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(105061001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 4 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 4)

				if (4 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 4)) > 0 and var_4_21 < var_4_26 then
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

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061001", "story_v_out_105061.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_105061", "105061001", "story_v_out_105061.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_105061", "105061001", "story_v_out_105061.awb")

						arg_1_1:RecordAudio("105061001", var_4_28)
						arg_1_1:RecordAudio("105061001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105061", "105061001", "story_v_out_105061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105061", "105061001", "story_v_out_105061.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play105061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105061002
		arg_8_1.duration_ = 14.77

		local var_8_0 = {
			ja = 14.766,
			ko = 11.233,
			zh = 13.4,
			en = 11.4
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
				arg_8_0:Play105061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = arg_8_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(arg_8_1.actors_["1084ui_story"]) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1084ui_story"]) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(105061002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 48 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 48)

				if (48 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 48)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061002", "story_v_out_105061.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_105061", "105061002", "story_v_out_105061.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_105061", "105061002", "story_v_out_105061.awb")

						arg_8_1:RecordAudio("105061002", var_11_8)
						arg_8_1:RecordAudio("105061002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_105061", "105061002", "story_v_out_105061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_105061", "105061002", "story_v_out_105061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_9 and arg_8_1.time_ < var_11_1 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play105061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105061003
		arg_12_1.duration_ = 4.7

		local var_12_0 = {
			ja = 4.7,
			ko = 4.166,
			zh = 3.066,
			en = 4.6
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
				arg_12_0:Play105061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1036ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1036ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1036ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1036ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1036ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1036ui_story == nil then
				arg_12_1.var_.characterEffect1036ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1036ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1036ui_story then
				arg_12_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, -0.97, -6)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			local var_15_8 = arg_12_1.actors_["1084ui_story"].transform

			if 0.033 < arg_12_1.time_ and arg_12_1.time_ <= 0.033 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_8.localPosition
			end

			local var_15_9 = 0.5

			if 0.033 <= arg_12_1.time_ and arg_12_1.time_ < 0.033 + var_15_9 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_12_1.time_ - 0.033) / var_15_9)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0.033 + var_15_9 and arg_12_1.time_ < 0.033 + var_15_9 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			local var_15_10 = arg_12_1.actors_["1036ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1036ui_story = var_15_10.localPosition
			end

			local var_15_11 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_11 then
				var_15_10.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1036ui_story, Vector3.New(0.7, -1.09, -5.78), (arg_12_1.time_ - 0) / var_15_11)
				var_15_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_10.position).x, (manager.ui.mainCamera.transform.position - var_15_10.position).y, (manager.ui.mainCamera.transform.position - var_15_10.position).z)
				var_15_10.localEulerAngles.z = 0
				var_15_10.localEulerAngles.x = 0
				var_15_10.localEulerAngles = var_15_10.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_11 and arg_12_1.time_ < 0 + var_15_11 + arg_15_0 then
				var_15_10.localPosition = Vector3.New(0.7, -1.09, -5.78)
				var_15_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_10.position).x, (manager.ui.mainCamera.transform.position - var_15_10.position).y, (manager.ui.mainCamera.transform.position - var_15_10.position).z)
				var_15_10.localEulerAngles.z = 0
				var_15_10.localEulerAngles.x = 0
				var_15_10.localEulerAngles = var_15_10.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_15_12 = 0
			local var_15_13 = 0.45

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_14 = arg_12_1:GetWordFromCfg(105061003)
				local var_15_15 = arg_12_1:FormatText(var_15_14.content)

				arg_12_1.text_.text = var_15_15

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_17 = 18 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 18)

				if (18 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 18)) > 0 and var_15_13 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_12
					end
				end

				arg_12_1.text_.text = var_15_15
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061003", "story_v_out_105061.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_105061", "105061003", "story_v_out_105061.awb") / 1000

					if var_15_18 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_12
					end

					if var_15_14.prefab_name ~= "" and arg_12_1.actors_[var_15_14.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_14.prefab_name].transform, "story_v_out_105061", "105061003", "story_v_out_105061.awb")

						arg_12_1:RecordAudio("105061003", var_15_19)
						arg_12_1:RecordAudio("105061003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_105061", "105061003", "story_v_out_105061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_105061", "105061003", "story_v_out_105061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_13, arg_12_1.talkMaxDuration)

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_12) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_12 + var_15_20 and arg_12_1.time_ < var_15_12 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play105061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105061004
		arg_16_1.duration_ = 19.4

		local var_16_0 = {
			ja = 19.4,
			ko = 8.3,
			zh = 12,
			en = 11.233
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
				arg_16_0:Play105061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1036ui_story"]) and arg_16_1.var_.characterEffect1036ui_story == nil then
				arg_16_1.var_.characterEffect1036ui_story = arg_16_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1036ui_story"]) then
				if arg_16_1.var_.characterEffect1036ui_story and not isNil(arg_16_1.actors_["1036ui_story"]) then
					arg_16_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_0)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1036ui_story"]) and arg_16_1.var_.characterEffect1036ui_story then
				arg_16_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_19_1 = 0
			local var_19_2 = 1.2

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(105061004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 48 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 48)

				if (48 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 48)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061004", "story_v_out_105061.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_105061", "105061004", "story_v_out_105061.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_105061", "105061004", "story_v_out_105061.awb")

						arg_16_1:RecordAudio("105061004", var_19_8)
						arg_16_1:RecordAudio("105061004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_105061", "105061004", "story_v_out_105061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_105061", "105061004", "story_v_out_105061.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_9 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_9 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_9

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_9 and arg_16_1.time_ < var_19_1 + var_19_9 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play105061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105061005
		arg_20_1.duration_ = 14.8

		local var_20_0 = {
			ja = 10.7,
			ko = 12.7,
			zh = 14.8,
			en = 12.533
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
				arg_20_0:Play105061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.35

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(105061005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 54 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 54)

				if (54 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 54)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061005", "story_v_out_105061.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_105061", "105061005", "story_v_out_105061.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_105061", "105061005", "story_v_out_105061.awb")

						arg_20_1:RecordAudio("105061005", var_23_6)
						arg_20_1:RecordAudio("105061005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105061", "105061005", "story_v_out_105061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105061", "105061005", "story_v_out_105061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play105061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105061006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play105061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story", "se_story_roar", "")
			end

			local var_27_1 = manager.ui.mainCamera.transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.shakeOldPosMainCamera = var_27_1.localPosition
			end

			local var_27_2 = 0.600000023841858

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 then
				local var_27_3, var_27_4 = math.modf((arg_24_1.time_ - 0) / 0.066)

				var_27_1.localPosition = Vector3.New(var_27_4 * 0.13, var_27_4 * 0.13, var_27_4 * 0.13) + arg_24_1.var_.shakeOldPosMainCamera
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 then
				var_27_1.localPosition = arg_24_1.var_.shakeOldPosMainCamera
			end

			local var_27_5 = arg_24_1.actors_["1084ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_5.localPosition
			end

			local var_27_6 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 then
				var_27_5.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_6)
				var_27_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_5.position).x, (manager.ui.mainCamera.transform.position - var_27_5.position).y, (manager.ui.mainCamera.transform.position - var_27_5.position).z)
				var_27_5.localEulerAngles.z = 0
				var_27_5.localEulerAngles.x = 0
				var_27_5.localEulerAngles = var_27_5.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 then
				var_27_5.localPosition = Vector3.New(0, 100, 0)
				var_27_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_5.position).x, (manager.ui.mainCamera.transform.position - var_27_5.position).y, (manager.ui.mainCamera.transform.position - var_27_5.position).z)
				var_27_5.localEulerAngles.z = 0
				var_27_5.localEulerAngles.x = 0
				var_27_5.localEulerAngles = var_27_5.localEulerAngles
			end

			local var_27_7 = arg_24_1.actors_["1036ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1036ui_story = var_27_7.localPosition
			end

			local var_27_8 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 then
				var_27_7.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_8)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 then
				var_27_7.localPosition = Vector3.New(0, 100, 0)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			local var_27_9 = 0
			local var_27_10 = 0.1

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3012")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_11 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(105061006).content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 4 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 4)

				if (4 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 4)) > 0 and var_27_10 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_9 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_9
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_10, arg_24_1.talkMaxDuration)

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_9) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_9 + var_27_14 and arg_24_1.time_ < var_27_9 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play105061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105061007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story", "se_story_roar", "")
			end

			local var_31_1 = 0
			local var_31_2 = 0.1

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3012")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(105061007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 4 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 4)

				if (4 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 4)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play105061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105061008
		arg_32_1.duration_ = 2.83

		local var_32_0 = {
			ja = 2.833,
			ko = 1.433,
			zh = 1.4,
			en = 1.566
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
				arg_32_0:Play105061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.1

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(105061008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 4 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 4)

				if (4 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 4)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061008", "story_v_out_105061.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_105061", "105061008", "story_v_out_105061.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_105061", "105061008", "story_v_out_105061.awb")

						arg_32_1:RecordAudio("105061008", var_35_6)
						arg_32_1:RecordAudio("105061008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_105061", "105061008", "story_v_out_105061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_105061", "105061008", "story_v_out_105061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play105061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 105061009
		arg_36_1.duration_ = 2.8

		local var_36_0 = {
			ja = 2.8,
			ko = 2.2,
			zh = 2.666,
			en = 2.533
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
				arg_36_0:Play105061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.275

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(105061009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 11 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 11)

				if (11 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 11)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061009", "story_v_out_105061.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_105061", "105061009", "story_v_out_105061.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_105061", "105061009", "story_v_out_105061.awb")

						arg_36_1:RecordAudio("105061009", var_39_6)
						arg_36_1:RecordAudio("105061009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_105061", "105061009", "story_v_out_105061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_105061", "105061009", "story_v_out_105061.awb")
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
	Play105061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 105061010
		arg_40_1.duration_ = 7.07

		local var_40_0 = {
			ja = 7.066,
			ko = 4.733,
			zh = 6,
			en = 6.1
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
			arg_40_1.auto_ = false
		end

		function arg_40_1.playNext_(arg_42_0)
			arg_40_1.onStoryFinished_()
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.7

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(105061010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 28 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 28)

				if (28 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 28)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105061", "105061010", "story_v_out_105061.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_105061", "105061010", "story_v_out_105061.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_105061", "105061010", "story_v_out_105061.awb")

						arg_40_1:RecordAudio("105061010", var_43_6)
						arg_40_1:RecordAudio("105061010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_105061", "105061010", "story_v_out_105061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_105061", "105061010", "story_v_out_105061.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B12a"
	},
	voices = {
		"story_v_out_105061.awb"
	}
}
