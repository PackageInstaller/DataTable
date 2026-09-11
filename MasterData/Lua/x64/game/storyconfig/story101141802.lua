return {
	Play114182001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114182001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114182002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F06 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F06")
				var_4_0.name = "F06"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F06 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F06

				arg_1_1.bgs_.F06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F06" then
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

			local var_4_8 = manager.ui.mainCamera.transform

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_8.localPosition
			end

			local var_4_9 = 1.5

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_9 then
				local var_4_10, var_4_11 = math.modf((arg_1_1.time_ - 1) / 0.066)

				var_4_8.localPosition = Vector3.New(var_4_11 * 0.13, var_4_11 * 0.13, var_4_11 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1 + var_4_9 and arg_1_1.time_ < 1 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_12 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_12 + 0.5 and arg_1_1.time_ < var_4_12 + 0.5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			local var_4_19 = 2
			local var_4_20 = 1.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(114182001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 54 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 54)

				if (54 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 54)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114182002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114182002
		arg_9_1.duration_ = 7.8

		local var_9_0 = {
			ja = 5.633,
			ko = 6.566,
			zh = 5.733,
			en = 7.8
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
				arg_9_0:Play114182003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1184ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1184ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1184ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1184ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1184ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1184ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1184ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.97, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_12_5 = arg_9_1.actors_["1184ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1184ui_story == nil then
				arg_9_1.var_.characterEffect1184ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1184ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1184ui_story then
				arg_9_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_12_8 = 0
			local var_12_9 = 0.575

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(114182002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 23 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 23)

				if (23 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 23)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182002", "story_v_out_114182.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182002", "story_v_out_114182.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_114182", "114182002", "story_v_out_114182.awb")

						arg_9_1:RecordAudio("114182002", var_12_15)
						arg_9_1:RecordAudio("114182002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114182", "114182002", "story_v_out_114182.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114182", "114182002", "story_v_out_114182.awb")
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
				actorName = "1184ui_story",
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
	Play114182003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114182003
		arg_13_1.duration_ = 5.1

		local var_13_0 = {
			ja = 5.1,
			ko = 3.5,
			zh = 2.033,
			en = 2.633
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
				arg_13_0:Play114182004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1184ui_story = arg_13_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1184ui_story"].transform.position).z)
				arg_13_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1184ui_story"].transform.localEulerAngles = arg_13_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1184ui_story"].transform.position).z)
				arg_13_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1184ui_story"].transform.localEulerAngles = arg_13_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_16_1 = 0
			local var_16_2 = 0.2

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(114182003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 8 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 8)

				if (8 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 8)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182003", "story_v_out_114182.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_114182", "114182003", "story_v_out_114182.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_114182", "114182003", "story_v_out_114182.awb")

						arg_13_1:RecordAudio("114182003", var_16_8)
						arg_13_1:RecordAudio("114182003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114182", "114182003", "story_v_out_114182.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114182", "114182003", "story_v_out_114182.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play114182004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114182004
		arg_17_1.duration_ = 2.67

		local var_17_0 = {
			ja = 2.066,
			ko = 2.666,
			zh = 2.3,
			en = 2.5
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
				arg_17_0:Play114182005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1184ui_story = arg_17_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1184ui_story"].transform.position).z)
				arg_17_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1184ui_story"].transform.localEulerAngles = arg_17_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_17_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1184ui_story"].transform.position).z)
				arg_17_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1184ui_story"].transform.localEulerAngles = arg_17_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4134")
			end

			local var_20_1 = arg_17_1.actors_["1184ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1184ui_story == nil then
				arg_17_1.var_.characterEffect1184ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1184ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1184ui_story then
				arg_17_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.2

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(114182004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 8 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 8)

				if (8 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 8)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182004", "story_v_out_114182.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182004", "story_v_out_114182.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_114182", "114182004", "story_v_out_114182.awb")

						arg_17_1:RecordAudio("114182004", var_20_11)
						arg_17_1:RecordAudio("114182004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114182", "114182004", "story_v_out_114182.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114182", "114182004", "story_v_out_114182.awb")
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
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play114182005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114182005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114182006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1184ui_story = arg_21_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1184ui_story"].transform.position).z)
				arg_21_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1184ui_story"].transform.localEulerAngles = arg_21_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1184ui_story"].transform.position).z)
				arg_21_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1184ui_story"].transform.localEulerAngles = arg_21_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_24_1 = 0
			local var_24_2 = 1.15

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

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(114182005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 46 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 46)

				if (46 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 46)) > 0 and var_24_2 < var_24_5 then
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

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114182006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114182006
		arg_25_1.duration_ = 6.93

		local var_25_0 = {
			ja = 6.033,
			ko = 6.933,
			zh = 4,
			en = 5.466
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
				arg_25_0:Play114182007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "1038ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1038ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["1038ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["1038ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["1038ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1038ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_28_5 = arg_25_1.actors_["1038ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1038ui_story == nil then
				arg_25_1.var_.characterEffect1038ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1038ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1038ui_story then
				arg_25_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_28_8 = 0
			local var_28_9 = 0.5

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(114182006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 20 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 20)

				if (20 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 20)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182006", "story_v_out_114182.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182006", "story_v_out_114182.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_114182", "114182006", "story_v_out_114182.awb")

						arg_25_1:RecordAudio("114182006", var_28_15)
						arg_25_1:RecordAudio("114182006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114182", "114182006", "story_v_out_114182.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114182", "114182006", "story_v_out_114182.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play114182007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114182007
		arg_29_1.duration_ = 4.27

		local var_29_0 = {
			ja = 4.266,
			ko = 3,
			zh = 3.5,
			en = 2.333
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
				arg_29_0:Play114182008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1038ui_story"]) and arg_29_1.var_.characterEffect1038ui_story == nil then
				arg_29_1.var_.characterEffect1038ui_story = arg_29_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1038ui_story"]) then
				if arg_29_1.var_.characterEffect1038ui_story and not isNil(arg_29_1.actors_["1038ui_story"]) then
					arg_29_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1038ui_story"]) and arg_29_1.var_.characterEffect1038ui_story then
				arg_29_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_32_1 = "1041ui_story"

			if arg_29_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_32_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_29_1.stage_.transform)

				var_32_2.name = var_32_1
				var_32_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_[var_32_1] = var_32_2

				local var_32_3 = var_32_2:GetComponentInChildren(typeof(CharacterEffect))

				var_32_3.enabled = true

				local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_2, typeof(DynamicBoneHelper))

				if var_32_4 then
					var_32_4:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_3.transform, false)

				arg_29_1.var_[var_32_1 .. "Animator"] = var_32_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_[var_32_1 .. "Animator"].applyRootMotion = true
				arg_29_1.var_[var_32_1 .. "LipSync"] = var_32_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_5 = arg_29_1.actors_["1041ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1041ui_story = var_32_5.localPosition
			end

			local var_32_6 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_29_1.time_ - 0) / var_32_6)
				var_32_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_5.position).x, (manager.ui.mainCamera.transform.position - var_32_5.position).y, (manager.ui.mainCamera.transform.position - var_32_5.position).z)
				var_32_5.localEulerAngles.z = 0
				var_32_5.localEulerAngles.x = 0
				var_32_5.localEulerAngles = var_32_5.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_32_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_5.position).x, (manager.ui.mainCamera.transform.position - var_32_5.position).y, (manager.ui.mainCamera.transform.position - var_32_5.position).z)
				var_32_5.localEulerAngles.z = 0
				var_32_5.localEulerAngles.x = 0
				var_32_5.localEulerAngles = var_32_5.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action9_2")
			end

			local var_32_7 = arg_29_1.actors_["1041ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1041ui_story == nil then
				arg_29_1.var_.characterEffect1041ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_8 and not isNil(var_32_7) then
				if arg_29_1.var_.characterEffect1041ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_8 and arg_29_1.time_ < 0 + var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1041ui_story then
				arg_29_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_32_10 = 0
			local var_32_11 = 0.2

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_12 = arg_29_1:GetWordFromCfg(114182007)
				local var_32_13 = arg_29_1:FormatText(var_32_12.content)

				arg_29_1.text_.text = var_32_13

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 8 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 8)

				if (8 <= 0 and var_32_11 or var_32_11 * (utf8.len(var_32_13) / 8)) > 0 and var_32_11 < var_32_15 then
					arg_29_1.talkMaxDuration = var_32_15

					if var_32_15 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_15 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_13
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182007", "story_v_out_114182.awb") ~= 0 then
					local var_32_16 = manager.audio:GetVoiceLength("story_v_out_114182", "114182007", "story_v_out_114182.awb") / 1000

					if var_32_16 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_10
					end

					if var_32_12.prefab_name ~= "" and arg_29_1.actors_[var_32_12.prefab_name] ~= nil then
						local var_32_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_12.prefab_name].transform, "story_v_out_114182", "114182007", "story_v_out_114182.awb")

						arg_29_1:RecordAudio("114182007", var_32_17)
						arg_29_1:RecordAudio("114182007", var_32_17)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114182", "114182007", "story_v_out_114182.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114182", "114182007", "story_v_out_114182.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_18 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_18 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_18

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_18 and arg_29_1.time_ < var_32_10 + var_32_18 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play114182008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114182008
		arg_33_1.duration_ = 4.1

		local var_33_0 = {
			ja = 3.4,
			ko = 2.266,
			zh = 3.6,
			en = 4.1
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
				arg_33_0:Play114182009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1038ui_story = arg_33_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1038ui_story"].transform.position).z)
				arg_33_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1038ui_story"].transform.localEulerAngles = arg_33_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1038ui_story"].transform.position).z)
				arg_33_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1038ui_story"].transform.localEulerAngles = arg_33_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1041ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1041ui_story = var_36_1.localPosition
			end

			local var_36_2 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_33_1.time_ - 0) / var_36_2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(0, 100, 0)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			local var_36_3 = 0
			local var_36_4 = 0.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_5 = arg_33_1:GetWordFromCfg(114182008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 8 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 8)

				if (8 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 8)) > 0 and var_36_4 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182008", "story_v_out_114182.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_out_114182", "114182008", "story_v_out_114182.awb") / 1000

					if var_36_9 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_3
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_114182", "114182008", "story_v_out_114182.awb")

						arg_33_1:RecordAudio("114182008", var_36_10)
						arg_33_1:RecordAudio("114182008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114182", "114182008", "story_v_out_114182.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114182", "114182008", "story_v_out_114182.awb")
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

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play114182009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114182009
		arg_37_1.duration_ = 6.5

		local var_37_0 = {
			ja = 3.533,
			ko = 5.8,
			zh = 6.5,
			en = 5.933
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
				arg_37_0:Play114182010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.45

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(114182009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 18 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 18)

				if (18 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 18)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182009", "story_v_out_114182.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_114182", "114182009", "story_v_out_114182.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_114182", "114182009", "story_v_out_114182.awb")

						arg_37_1:RecordAudio("114182009", var_40_6)
						arg_37_1:RecordAudio("114182009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114182", "114182009", "story_v_out_114182.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114182", "114182009", "story_v_out_114182.awb")
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
	Play114182010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114182010
		arg_41_1.duration_ = 9.97

		local var_41_0 = {
			ja = 9.966,
			ko = 5.3,
			zh = 8.533,
			en = 9.7
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
				arg_41_0:Play114182011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.625

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(114182010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 25 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 25)

				if (25 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 25)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182010", "story_v_out_114182.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_114182", "114182010", "story_v_out_114182.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_114182", "114182010", "story_v_out_114182.awb")

						arg_41_1:RecordAudio("114182010", var_44_6)
						arg_41_1:RecordAudio("114182010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114182", "114182010", "story_v_out_114182.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114182", "114182010", "story_v_out_114182.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114182011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114182011
		arg_45_1.duration_ = 7.67

		local var_45_0 = {
			ja = 4.366,
			ko = 6.833,
			zh = 7.533,
			en = 7.666
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
				arg_45_0:Play114182012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(114182011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 20 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 20)

				if (20 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 20)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182011", "story_v_out_114182.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_114182", "114182011", "story_v_out_114182.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_114182", "114182011", "story_v_out_114182.awb")

						arg_45_1:RecordAudio("114182011", var_48_6)
						arg_45_1:RecordAudio("114182011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114182", "114182011", "story_v_out_114182.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114182", "114182011", "story_v_out_114182.awb")
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
	Play114182012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114182012
		arg_49_1.duration_ = 9.37

		local var_49_0 = {
			ja = 5.566,
			ko = 6.5,
			zh = 9.366,
			en = 9.266
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
				arg_49_0:Play114182013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(114182012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 18 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 18)

				if (18 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 18)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182012", "story_v_out_114182.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_114182", "114182012", "story_v_out_114182.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_114182", "114182012", "story_v_out_114182.awb")

						arg_49_1:RecordAudio("114182012", var_52_6)
						arg_49_1:RecordAudio("114182012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114182", "114182012", "story_v_out_114182.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114182", "114182012", "story_v_out_114182.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114182013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114182013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114182014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(114182013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 33 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 33)

				if (33 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 33)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114182014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114182014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114182015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.9

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(114182014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 76 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 76)

				if (76 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 76)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114182015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114182015
		arg_61_1.duration_ = 3.17

		local var_61_0 = {
			ja = 3.166,
			ko = 1.999999999999,
			zh = 2.7,
			en = 2.133
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
				arg_61_0:Play114182016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1041ui_story = arg_61_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1041ui_story"].transform.position).z)
				arg_61_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1041ui_story"].transform.localEulerAngles = arg_61_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_61_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1041ui_story"].transform.position).z)
				arg_61_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1041ui_story"].transform.localEulerAngles = arg_61_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_64_1 = arg_61_1.actors_["1041ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1041ui_story == nil then
				arg_61_1.var_.characterEffect1041ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1041ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1041ui_story then
				arg_61_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(114182015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 4 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 4)

				if (4 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 4)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182015", "story_v_out_114182.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182015", "story_v_out_114182.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_114182", "114182015", "story_v_out_114182.awb")

						arg_61_1:RecordAudio("114182015", var_64_11)
						arg_61_1:RecordAudio("114182015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114182", "114182015", "story_v_out_114182.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114182", "114182015", "story_v_out_114182.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play114182016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114182016
		arg_65_1.duration_ = 11.6

		local var_65_0 = {
			ja = 8.6,
			ko = 9.066,
			zh = 9.066,
			en = 11.6
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
				arg_65_0:Play114182017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1041ui_story"]) and arg_65_1.var_.characterEffect1041ui_story == nil then
				arg_65_1.var_.characterEffect1041ui_story = arg_65_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1041ui_story"]) then
				if arg_65_1.var_.characterEffect1041ui_story and not isNil(arg_65_1.actors_["1041ui_story"]) then
					arg_65_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1041ui_story"]) and arg_65_1.var_.characterEffect1041ui_story then
				arg_65_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_68_1 = "10006ui_story"

			if arg_65_1.actors_["10006ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10006ui_story"))) then
				local var_68_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_65_1.stage_.transform)

				var_68_2.name = var_68_1
				var_68_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_[var_68_1] = var_68_2

				local var_68_3 = var_68_2:GetComponentInChildren(typeof(CharacterEffect))

				var_68_3.enabled = true

				local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_2, typeof(DynamicBoneHelper))

				if var_68_4 then
					var_68_4:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_3.transform, false)

				arg_65_1.var_[var_68_1 .. "Animator"] = var_68_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_[var_68_1 .. "Animator"].applyRootMotion = true
				arg_65_1.var_[var_68_1 .. "LipSync"] = var_68_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_5 = arg_65_1.actors_["10006ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10006ui_story = var_68_5.localPosition
			end

			local var_68_6 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_65_1.time_ - 0) / var_68_6)
				var_68_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_5.position).x, (manager.ui.mainCamera.transform.position - var_68_5.position).y, (manager.ui.mainCamera.transform.position - var_68_5.position).z)
				var_68_5.localEulerAngles.z = 0
				var_68_5.localEulerAngles.x = 0
				var_68_5.localEulerAngles = var_68_5.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0.7, -0.98, -5.65)
				var_68_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_5.position).x, (manager.ui.mainCamera.transform.position - var_68_5.position).y, (manager.ui.mainCamera.transform.position - var_68_5.position).z)
				var_68_5.localEulerAngles.z = 0
				var_68_5.localEulerAngles.x = 0
				var_68_5.localEulerAngles = var_68_5.localEulerAngles
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_68_7 = arg_65_1.actors_["10006ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect10006ui_story == nil then
				arg_65_1.var_.characterEffect10006ui_story = var_68_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_8 and not isNil(var_68_7) then
				if arg_65_1.var_.characterEffect10006ui_story and not isNil(var_68_7) then
					arg_65_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_8 and arg_65_1.time_ < 0 + var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect10006ui_story then
				arg_65_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_68_10 = 0
			local var_68_11 = 0.75

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_12 = arg_65_1:GetWordFromCfg(114182016)
				local var_68_13 = arg_65_1:FormatText(var_68_12.content)

				arg_65_1.text_.text = var_68_13

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_15 = 30 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 30)

				if (30 <= 0 and var_68_11 or var_68_11 * (utf8.len(var_68_13) / 30)) > 0 and var_68_11 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_10
					end
				end

				arg_65_1.text_.text = var_68_13
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182016", "story_v_out_114182.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_114182", "114182016", "story_v_out_114182.awb") / 1000

					if var_68_16 + var_68_10 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_10
					end

					if var_68_12.prefab_name ~= "" and arg_65_1.actors_[var_68_12.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_12.prefab_name].transform, "story_v_out_114182", "114182016", "story_v_out_114182.awb")

						arg_65_1:RecordAudio("114182016", var_68_17)
						arg_65_1:RecordAudio("114182016", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114182", "114182016", "story_v_out_114182.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114182", "114182016", "story_v_out_114182.awb")
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
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play114182017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114182017
		arg_69_1.duration_ = 6.7

		local var_69_0 = {
			ja = 4.933,
			ko = 4.3,
			zh = 6.7,
			en = 4.533
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
				arg_69_0:Play114182018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1041ui_story"]) and arg_69_1.var_.characterEffect1041ui_story == nil then
				arg_69_1.var_.characterEffect1041ui_story = arg_69_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1041ui_story"]) then
				if arg_69_1.var_.characterEffect1041ui_story and not isNil(arg_69_1.actors_["1041ui_story"]) then
					arg_69_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1041ui_story"]) and arg_69_1.var_.characterEffect1041ui_story then
				arg_69_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_72_2 = arg_69_1.actors_["10006ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect10006ui_story == nil then
				arg_69_1.var_.characterEffect10006ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.characterEffect10006ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect10006ui_story then
				arg_69_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.55

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(114182017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 22 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 22)

				if (22 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 22)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182017", "story_v_out_114182.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182017", "story_v_out_114182.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_114182", "114182017", "story_v_out_114182.awb")

						arg_69_1:RecordAudio("114182017", var_72_11)
						arg_69_1:RecordAudio("114182017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114182", "114182017", "story_v_out_114182.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114182", "114182017", "story_v_out_114182.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114182018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114182018
		arg_73_1.duration_ = 5.43

		local var_73_0 = {
			ja = 5.433,
			ko = 2.533,
			zh = 2.3,
			en = 3.4
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
				arg_73_0:Play114182019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1041ui_story"]) and arg_73_1.var_.characterEffect1041ui_story == nil then
				arg_73_1.var_.characterEffect1041ui_story = arg_73_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1041ui_story"]) then
				if arg_73_1.var_.characterEffect1041ui_story and not isNil(arg_73_1.actors_["1041ui_story"]) then
					arg_73_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1041ui_story"]) and arg_73_1.var_.characterEffect1041ui_story then
				arg_73_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:GetWordFromCfg(114182018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 10 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 10)

				if (10 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 10)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182018", "story_v_out_114182.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_114182", "114182018", "story_v_out_114182.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_114182", "114182018", "story_v_out_114182.awb")

						arg_73_1:RecordAudio("114182018", var_76_8)
						arg_73_1:RecordAudio("114182018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114182", "114182018", "story_v_out_114182.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114182", "114182018", "story_v_out_114182.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_9 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_9 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_9

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_9 and arg_73_1.time_ < var_76_1 + var_76_9 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114182019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114182019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114182020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1041ui_story = arg_77_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).z)
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles = arg_77_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).z)
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles = arg_77_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10006ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10006ui_story = var_80_1.localPosition
			end

			local var_80_2 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_2)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			local var_80_3 = 0
			local var_80_4 = 0.725

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(114182019).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 29 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 29)

				if (29 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 29)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play114182020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114182020
		arg_81_1.duration_ = 6.73

		local var_81_0 = {
			ja = 6.733,
			ko = 6.3,
			zh = 5.7,
			en = 6.166
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
				arg_81_0:Play114182021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1184ui_story = arg_81_1.actors_["1184ui_story"].transform.localPosition

				arg_81_1:ShowWeapon(arg_81_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1184ui_story"].transform.position).z)
				arg_81_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1184ui_story"].transform.localEulerAngles = arg_81_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_81_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1184ui_story"].transform.position).z)
				arg_81_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1184ui_story"].transform.localEulerAngles = arg_81_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_84_1 = arg_81_1.actors_["1184ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1184ui_story == nil then
				arg_81_1.var_.characterEffect1184ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1184ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1184ui_story then
				arg_81_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(114182020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 24 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 24)

				if (24 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 24)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182020", "story_v_out_114182.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182020", "story_v_out_114182.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_114182", "114182020", "story_v_out_114182.awb")

						arg_81_1:RecordAudio("114182020", var_84_11)
						arg_81_1:RecordAudio("114182020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114182", "114182020", "story_v_out_114182.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114182", "114182020", "story_v_out_114182.awb")
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

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play114182021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114182021
		arg_85_1.duration_ = 0.2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"

			SetActive(arg_85_1.choicesGo_, true)

			for iter_86_0, iter_86_1 in ipairs(arg_85_1.choices_) do
				SetActive(iter_86_1.go, iter_86_0 <= 1)
			end

			arg_85_1.choices_[1].txt.text = arg_85_1:FormatText(StoryChoiceCfg[146].name)
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114182022(arg_85_1)
			end

			arg_85_1:RecordChoiceLog(114182021, 146)
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1184ui_story"]) and arg_85_1.var_.characterEffect1184ui_story == nil then
				arg_85_1.var_.characterEffect1184ui_story = arg_85_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1184ui_story"]) then
				if arg_85_1.var_.characterEffect1184ui_story and not isNil(arg_85_1.actors_["1184ui_story"]) then
					arg_85_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1184ui_story"]) and arg_85_1.var_.characterEffect1184ui_story then
				arg_85_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114182022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114182022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114182023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1184ui_story = arg_89_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1184ui_story"].transform.position).z)
				arg_89_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1184ui_story"].transform.localEulerAngles = arg_89_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1184ui_story"].transform.position).z)
				arg_89_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1184ui_story"].transform.localEulerAngles = arg_89_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_92_1 = 0
			local var_92_2 = 1.025

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(114182022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 41 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 41)

				if (41 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 41)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play114182023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114182023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play114182024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.3

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(114182023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 12 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 12)

				if (12 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 12)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114182024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114182024
		arg_97_1.duration_ = 9

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114182025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if arg_97_1.bgs_.F04 == nil then
				local var_100_0 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F04")
				var_100_0.name = "F04"
				var_100_0.transform.parent = arg_97_1.stage_.transform
				var_100_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_.F04 = var_100_0
			end

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= 2 + arg_100_0 then
				local var_100_1 = arg_97_1.bgs_.F04

				arg_97_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_100_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_2 = var_100_1:GetComponent("SpriteRenderer")

				if var_100_2 and var_100_2.sprite then
					local var_100_3 = 2 * (var_100_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_100_1.transform.localScale = Vector3.New(var_100_3 / var_100_2.sprite.bounds.size.y < var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x and var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x or var_100_3 / var_100_2.sprite.bounds.size.y, var_100_3 / var_100_2.sprite.bounds.size.y < var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x and var_100_3 * manager.ui.mainCameraCom_.aspect / var_100_2.sprite.bounds.size.x or var_100_3 / var_100_2.sprite.bounds.size.y, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "F04" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_4 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_5 = 2

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_5 then
				local var_100_6 = Color.New(0, 0, 0)

				var_100_6.a = Mathf.Lerp(0, 1, (arg_97_1.time_ - var_100_4) / var_100_5)
				arg_97_1.mask_.color = var_100_6
			end

			if arg_97_1.time_ >= var_100_4 + var_100_5 and arg_97_1.time_ < var_100_4 + var_100_5 + arg_100_0 then
				local var_100_7 = Color.New(0, 0, 0)

				var_100_7.a = 1
				arg_97_1.mask_.color = var_100_7
			end

			local var_100_8 = 2

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_9 = 2

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 then
				local var_100_10 = Color.New(0, 0, 0)

				var_100_10.a = Mathf.Lerp(1, 0, (arg_97_1.time_ - var_100_8) / var_100_9)
				arg_97_1.mask_.color = var_100_10
			end

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 then
				local var_100_11 = Color.New(0, 0, 0)

				arg_97_1.mask_.enabled = false
				var_100_11.a = 0
				arg_97_1.mask_.color = var_100_11
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_12 = 4
			local var_100_13 = 0.25

			if 4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_14 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_14:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_15 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(114182024).content)

				arg_97_1.text_.text = var_100_15

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_17 = 10 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 10)

				if (10 <= 0 and var_100_13 or var_100_13 * (utf8.len(var_100_15) / 10)) > 0 and var_100_13 < var_100_17 then
					arg_97_1.talkMaxDuration = var_100_17
					var_100_12 = var_100_12 + 0.3

					if var_100_17 + var_100_12 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_12
					end
				end

				arg_97_1.text_.text = var_100_15
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_18 = var_100_12 + 0.3
			local var_100_19 = math.max(var_100_13, arg_97_1.talkMaxDuration)

			if var_100_12 + 0.3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_18 + var_100_19 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_18) / var_100_19

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_18 + var_100_19 and arg_97_1.time_ < var_100_18 + var_100_19 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114182025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114182025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play114182026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.625

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(114182025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 25 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 25)

				if (25 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 25)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114182026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114182026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play114182027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.95

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(114182026).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 38 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 38)

				if (38 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 38)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114182027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114182027
		arg_111_1.duration_ = 3.23

		local var_111_0 = {
			ja = 2.3,
			ko = 3.1,
			zh = 3.2,
			en = 3.233
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
				arg_111_0:Play114182028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.375

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:GetWordFromCfg(114182027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 15 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 15)

				if (15 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 15)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182027", "story_v_out_114182.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_114182", "114182027", "story_v_out_114182.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_114182", "114182027", "story_v_out_114182.awb")

						arg_111_1:RecordAudio("114182027", var_114_6)
						arg_111_1:RecordAudio("114182027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114182", "114182027", "story_v_out_114182.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114182", "114182027", "story_v_out_114182.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play114182028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114182028
		arg_115_1.duration_ = 2.37

		local var_115_0 = {
			ja = 2.366,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.266
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
				arg_115_0:Play114182029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_118_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_115_1.stage_.transform)

				var_118_0.name = "1067ui_story"
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["1067ui_story"] = var_118_0

				local var_118_1 = var_118_0:GetComponentInChildren(typeof(CharacterEffect))

				var_118_1.enabled = true

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_1.transform, false)

				arg_115_1.var_["1067ui_story" .. "Animator"] = var_118_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_115_1.var_["1067ui_story" .. "LipSync"] = var_118_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_3 = arg_115_1.actors_["1067ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1067ui_story == nil then
				arg_115_1.var_.characterEffect1067ui_story = var_118_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_4 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 and not isNil(var_118_3) then
				if arg_115_1.var_.characterEffect1067ui_story and not isNil(var_118_3) then
					arg_115_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_4)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1067ui_story then
				arg_115_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_118_5 = "1042ui_story"

			if arg_115_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_118_6 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_115_1.stage_.transform)

				var_118_6.name = var_118_5
				var_118_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_[var_118_5] = var_118_6

				local var_118_7 = var_118_6:GetComponentInChildren(typeof(CharacterEffect))

				var_118_7.enabled = true

				local var_118_8 = GameObjectTools.GetOrAddComponent(var_118_6, typeof(DynamicBoneHelper))

				if var_118_8 then
					var_118_8:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_7.transform, false)

				arg_115_1.var_[var_118_5 .. "Animator"] = var_118_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_[var_118_5 .. "Animator"].applyRootMotion = true
				arg_115_1.var_[var_118_5 .. "LipSync"] = var_118_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_9 = arg_115_1.actors_["1042ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1042ui_story = var_118_9.localPosition
			end

			local var_118_10 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_10 then
				var_118_9.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_115_1.time_ - 0) / var_118_10)
				var_118_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_9.position).x, (manager.ui.mainCamera.transform.position - var_118_9.position).y, (manager.ui.mainCamera.transform.position - var_118_9.position).z)
				var_118_9.localEulerAngles.z = 0
				var_118_9.localEulerAngles.x = 0
				var_118_9.localEulerAngles = var_118_9.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_10 and arg_115_1.time_ < 0 + var_118_10 + arg_118_0 then
				var_118_9.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_118_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_9.position).x, (manager.ui.mainCamera.transform.position - var_118_9.position).y, (manager.ui.mainCamera.transform.position - var_118_9.position).z)
				var_118_9.localEulerAngles.z = 0
				var_118_9.localEulerAngles.x = 0
				var_118_9.localEulerAngles = var_118_9.localEulerAngles
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_118_11 = arg_115_1.actors_["1042ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.characterEffect1042ui_story == nil then
				arg_115_1.var_.characterEffect1042ui_story = var_118_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_12 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_12 and not isNil(var_118_11) then
				if arg_115_1.var_.characterEffect1042ui_story and not isNil(var_118_11) then
					arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_12 and arg_115_1.time_ < 0 + var_118_12 + arg_118_0 and not isNil(var_118_11) and arg_115_1.var_.characterEffect1042ui_story then
				arg_115_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_118_14 = 0
			local var_118_15 = 0.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_16 = arg_115_1:GetWordFromCfg(114182028)
				local var_118_17 = arg_115_1:FormatText(var_118_16.content)

				arg_115_1.text_.text = var_118_17

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 3 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 3)

				if (3 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 3)) > 0 and var_118_15 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19

					if var_118_19 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_17
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182028", "story_v_out_114182.awb") ~= 0 then
					local var_118_20 = manager.audio:GetVoiceLength("story_v_out_114182", "114182028", "story_v_out_114182.awb") / 1000

					if var_118_20 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_20 + var_118_14
					end

					if var_118_16.prefab_name ~= "" and arg_115_1.actors_[var_118_16.prefab_name] ~= nil then
						local var_118_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_16.prefab_name].transform, "story_v_out_114182", "114182028", "story_v_out_114182.awb")

						arg_115_1:RecordAudio("114182028", var_118_21)
						arg_115_1:RecordAudio("114182028", var_118_21)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114182", "114182028", "story_v_out_114182.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114182", "114182028", "story_v_out_114182.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_22 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_22 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_14) / var_118_22

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_14 + var_118_22 and arg_115_1.time_ < var_118_14 + var_118_22 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play114182029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114182029
		arg_119_1.duration_ = 6.1

		local var_119_0 = {
			ja = 6.1,
			ko = 2.8,
			zh = 4.666,
			en = 4
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
				arg_119_0:Play114182030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1067ui_story"]) and arg_119_1.var_.characterEffect1067ui_story == nil then
				arg_119_1.var_.characterEffect1067ui_story = arg_119_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1067ui_story"]) then
				if arg_119_1.var_.characterEffect1067ui_story and not isNil(arg_119_1.actors_["1067ui_story"]) then
					arg_119_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1067ui_story"]) and arg_119_1.var_.characterEffect1067ui_story then
				arg_119_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_122_2 = arg_119_1.actors_["1042ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1042ui_story == nil then
				arg_119_1.var_.characterEffect1042ui_story = var_122_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_3 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.characterEffect1042ui_story and not isNil(var_122_2) then
					arg_119_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_3)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.characterEffect1042ui_story then
				arg_119_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_122_4 = arg_119_1.actors_["1067ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1067ui_story = var_122_4.localPosition
			end

			local var_122_5 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1067ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_119_1.time_ - 0) / var_122_5)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			local var_122_6 = 0
			local var_122_7 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_8 = arg_119_1:GetWordFromCfg(114182029)
				local var_122_9 = arg_119_1:FormatText(var_122_8.content)

				arg_119_1.text_.text = var_122_9

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 14 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 14)

				if (14 <= 0 and var_122_7 or var_122_7 * (utf8.len(var_122_9) / 14)) > 0 and var_122_7 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_9
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182029", "story_v_out_114182.awb") ~= 0 then
					local var_122_12 = manager.audio:GetVoiceLength("story_v_out_114182", "114182029", "story_v_out_114182.awb") / 1000

					if var_122_12 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_6
					end

					if var_122_8.prefab_name ~= "" and arg_119_1.actors_[var_122_8.prefab_name] ~= nil then
						local var_122_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_8.prefab_name].transform, "story_v_out_114182", "114182029", "story_v_out_114182.awb")

						arg_119_1:RecordAudio("114182029", var_122_13)
						arg_119_1:RecordAudio("114182029", var_122_13)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114182", "114182029", "story_v_out_114182.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114182", "114182029", "story_v_out_114182.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_14 and arg_119_1.time_ < var_122_6 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play114182030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114182030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114182031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1067ui_story"]) and arg_123_1.var_.characterEffect1067ui_story == nil then
				arg_123_1.var_.characterEffect1067ui_story = arg_123_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1067ui_story"]) then
				if arg_123_1.var_.characterEffect1067ui_story and not isNil(arg_123_1.actors_["1067ui_story"]) then
					arg_123_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1067ui_story"]) and arg_123_1.var_.characterEffect1067ui_story then
				arg_123_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_2")
			end

			local var_126_1 = 0
			local var_126_2 = 0.925

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

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(114182030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 37 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 37)

				if (37 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 37)) > 0 and var_126_2 < var_126_5 then
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
	Play114182031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114182031
		arg_127_1.duration_ = 2.47

		local var_127_0 = {
			ja = 2.466,
			ko = 2.133,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_127_0:Play114182032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_130_0 = arg_127_1.actors_["1067ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1067ui_story == nil then
				arg_127_1.var_.characterEffect1067ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_1 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 and not isNil(var_130_0) then
				if arg_127_1.var_.characterEffect1067ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1067ui_story then
				arg_127_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_130_3 = 0
			local var_130_4 = 0.2

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_5 = arg_127_1:GetWordFromCfg(114182031)
				local var_130_6 = arg_127_1:FormatText(var_130_5.content)

				arg_127_1.text_.text = var_130_6

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_8 = 8 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_6) / 8)

				if (8 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_6) / 8)) > 0 and var_130_4 < var_130_8 then
					arg_127_1.talkMaxDuration = var_130_8

					if var_130_8 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_3
					end
				end

				arg_127_1.text_.text = var_130_6
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182031", "story_v_out_114182.awb") ~= 0 then
					local var_130_9 = manager.audio:GetVoiceLength("story_v_out_114182", "114182031", "story_v_out_114182.awb") / 1000

					if var_130_9 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_3
					end

					if var_130_5.prefab_name ~= "" and arg_127_1.actors_[var_130_5.prefab_name] ~= nil then
						local var_130_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_5.prefab_name].transform, "story_v_out_114182", "114182031", "story_v_out_114182.awb")

						arg_127_1:RecordAudio("114182031", var_130_10)
						arg_127_1:RecordAudio("114182031", var_130_10)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_114182", "114182031", "story_v_out_114182.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_114182", "114182031", "story_v_out_114182.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_11 = math.max(var_130_4, arg_127_1.talkMaxDuration)

			if var_130_3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_3 + var_130_11 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_3) / var_130_11

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_3 + var_130_11 and arg_127_1.time_ < var_130_3 + var_130_11 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play114182032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114182032
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114182033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1067ui_story"]) and arg_131_1.var_.characterEffect1067ui_story == nil then
				arg_131_1.var_.characterEffect1067ui_story = arg_131_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1067ui_story"]) then
				if arg_131_1.var_.characterEffect1067ui_story and not isNil(arg_131_1.actors_["1067ui_story"]) then
					arg_131_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1067ui_story"]) and arg_131_1.var_.characterEffect1067ui_story then
				arg_131_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_134_1 = arg_131_1.actors_["1042ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1042ui_story == nil then
				arg_131_1.var_.characterEffect1042ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1042ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1042ui_story then
				arg_131_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_134_4 = 0
			local var_134_5 = 0.075

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(114182032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 3 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 3)

				if (3 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 3)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182032", "story_v_out_114182.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182032", "story_v_out_114182.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_114182", "114182032", "story_v_out_114182.awb")

						arg_131_1:RecordAudio("114182032", var_134_11)
						arg_131_1:RecordAudio("114182032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_114182", "114182032", "story_v_out_114182.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_114182", "114182032", "story_v_out_114182.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114182033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114182033
		arg_135_1.duration_ = 9.97

		local var_135_0 = {
			ja = 5.1,
			ko = 9.966,
			zh = 7.7,
			en = 8.366
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
				arg_135_0:Play114182034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1067ui_story"]) and arg_135_1.var_.characterEffect1067ui_story == nil then
				arg_135_1.var_.characterEffect1067ui_story = arg_135_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1067ui_story"]) then
				if arg_135_1.var_.characterEffect1067ui_story and not isNil(arg_135_1.actors_["1067ui_story"]) then
					arg_135_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1067ui_story"]) and arg_135_1.var_.characterEffect1067ui_story then
				arg_135_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_138_2 = arg_135_1.actors_["1042ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect1042ui_story == nil then
				arg_135_1.var_.characterEffect1042ui_story = var_138_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.characterEffect1042ui_story and not isNil(var_138_2) then
					arg_135_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_3)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.characterEffect1042ui_story then
				arg_135_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_138_4 = 0
			local var_138_5 = 1

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(114182033)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 40 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 40)

				if (40 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 40)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182033", "story_v_out_114182.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182033", "story_v_out_114182.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_114182", "114182033", "story_v_out_114182.awb")

						arg_135_1:RecordAudio("114182033", var_138_11)
						arg_135_1:RecordAudio("114182033", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114182", "114182033", "story_v_out_114182.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114182", "114182033", "story_v_out_114182.awb")
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

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play114182034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114182034
		arg_139_1.duration_ = 4.5

		local var_139_0 = {
			ja = 3.5,
			ko = 4.5,
			zh = 3.466,
			en = 3.333
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
				arg_139_0:Play114182035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1067ui_story"]) and arg_139_1.var_.characterEffect1067ui_story == nil then
				arg_139_1.var_.characterEffect1067ui_story = arg_139_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1067ui_story"]) then
				if arg_139_1.var_.characterEffect1067ui_story and not isNil(arg_139_1.actors_["1067ui_story"]) then
					arg_139_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1067ui_story"]) and arg_139_1.var_.characterEffect1067ui_story then
				arg_139_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_142_1 = arg_139_1.actors_["1042ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1042ui_story == nil then
				arg_139_1.var_.characterEffect1042ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1042ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1042ui_story then
				arg_139_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.375

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(114182034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 15 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 15)

				if (15 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 15)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182034", "story_v_out_114182.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182034", "story_v_out_114182.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_114182", "114182034", "story_v_out_114182.awb")

						arg_139_1:RecordAudio("114182034", var_142_11)
						arg_139_1:RecordAudio("114182034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_114182", "114182034", "story_v_out_114182.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_114182", "114182034", "story_v_out_114182.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114182035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114182035
		arg_143_1.duration_ = 6

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114182036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1067ui_story = arg_143_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1067ui_story"].transform.position).z)
				arg_143_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1067ui_story"].transform.localEulerAngles = arg_143_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1067ui_story"].transform.position).z)
				arg_143_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1067ui_story"].transform.localEulerAngles = arg_143_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1042ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1042ui_story = var_146_1.localPosition
			end

			local var_146_2 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 then
				var_146_1.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_2)
				var_146_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_1.position).x, (manager.ui.mainCamera.transform.position - var_146_1.position).y, (manager.ui.mainCamera.transform.position - var_146_1.position).z)
				var_146_1.localEulerAngles.z = 0
				var_146_1.localEulerAngles.x = 0
				var_146_1.localEulerAngles = var_146_1.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 then
				var_146_1.localPosition = Vector3.New(0, 100, 0)
				var_146_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_1.position).x, (manager.ui.mainCamera.transform.position - var_146_1.position).y, (manager.ui.mainCamera.transform.position - var_146_1.position).z)
				var_146_1.localEulerAngles.z = 0
				var_146_1.localEulerAngles.x = 0
				var_146_1.localEulerAngles = var_146_1.localEulerAngles
			end

			local var_146_3 = manager.ui.mainCamera.transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.shakeOldPos = var_146_3.localPosition
			end

			local var_146_4 = 1

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				local var_146_5, var_146_6 = math.modf((arg_143_1.time_ - 0) / 0.066)

				var_146_3.localPosition = Vector3.New(var_146_6 * 0.13, var_146_6 * 0.13, var_146_6 * 0.13) + arg_143_1.var_.shakeOldPos
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_3.localPosition = arg_143_1.var_.shakeOldPos
			end

			local var_146_7 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_7 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			if arg_143_1.time_ >= var_146_7 + 1 and arg_143_1.time_ < var_146_7 + 1 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			if 1 < arg_143_1.time_ and arg_143_1.time_ <= 1 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_11", "se_story_11_blast02", "")
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_9 = 1
			local var_146_10 = 0.075

			if 1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_11 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_11:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_12 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(114182035).content)

				arg_143_1.text_.text = var_146_12

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_14 = 3 <= 0 and var_146_10 or var_146_10 * (utf8.len(var_146_12) / 3)

				if (3 <= 0 and var_146_10 or var_146_10 * (utf8.len(var_146_12) / 3)) > 0 and var_146_10 < var_146_14 then
					arg_143_1.talkMaxDuration = var_146_14
					var_146_9 = var_146_9 + 0.3

					if var_146_14 + var_146_9 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_9
					end
				end

				arg_143_1.text_.text = var_146_12
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_15 = var_146_9 + 0.3
			local var_146_16 = math.max(var_146_10, arg_143_1.talkMaxDuration)

			if var_146_9 + 0.3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_15 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_15) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_15 + var_146_16 and arg_143_1.time_ < var_146_15 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
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

		arg_143_1:InitPlayNodeList()
	end,
	Play114182036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114182036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play114182037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.55

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(114182036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 62 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 62)

				if (62 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 62)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play114182037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114182037
		arg_153_1.duration_ = 3.8

		local var_153_0 = {
			ja = 2.8,
			ko = 2.733,
			zh = 3.8,
			en = 2.7
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play114182038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_156_0 = arg_153_1.actors_["1067ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1067ui_story = var_156_0.localPosition
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1067ui_story, Vector3.New(0, -1.06, -6.2), (arg_153_1.time_ - 0) / var_156_1)
				var_156_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_0.position).x, (manager.ui.mainCamera.transform.position - var_156_0.position).y, (manager.ui.mainCamera.transform.position - var_156_0.position).z)
				var_156_0.localEulerAngles.z = 0
				var_156_0.localEulerAngles.x = 0
				var_156_0.localEulerAngles = var_156_0.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0, -1.06, -6.2)
				var_156_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_0.position).x, (manager.ui.mainCamera.transform.position - var_156_0.position).y, (manager.ui.mainCamera.transform.position - var_156_0.position).z)
				var_156_0.localEulerAngles.z = 0
				var_156_0.localEulerAngles.x = 0
				var_156_0.localEulerAngles = var_156_0.localEulerAngles
			end

			local var_156_2 = arg_153_1.actors_["1067ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1067ui_story == nil then
				arg_153_1.var_.characterEffect1067ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect1067ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect1067ui_story then
				arg_153_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_156_5 = 0
			local var_156_6 = 0.25

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(114182037)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 10 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 10)

				if (10 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 10)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182037", "story_v_out_114182.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182037", "story_v_out_114182.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_114182", "114182037", "story_v_out_114182.awb")

						arg_153_1:RecordAudio("114182037", var_156_12)
						arg_153_1:RecordAudio("114182037", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114182", "114182037", "story_v_out_114182.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114182", "114182037", "story_v_out_114182.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_13 and arg_153_1.time_ < var_156_5 + var_156_13 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play114182038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114182038
		arg_157_1.duration_ = 3.27

		local var_157_0 = {
			ja = 3.2,
			ko = 2.566,
			zh = 2.8,
			en = 3.266
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play114182039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1067ui_story = arg_157_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1067ui_story"].transform.position).z)
				arg_157_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1067ui_story"].transform.localEulerAngles = arg_157_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1067ui_story"].transform.position).z)
				arg_157_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1067ui_story"].transform.localEulerAngles = arg_157_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_160_1 = 0
			local var_160_2 = 0.3

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[210].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2049")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(114182038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 12 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 12)

				if (12 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 12)) > 0 and var_160_2 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182038", "story_v_out_114182.awb") ~= 0 then
					local var_160_7 = manager.audio:GetVoiceLength("story_v_out_114182", "114182038", "story_v_out_114182.awb") / 1000

					if var_160_7 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_1
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_114182", "114182038", "story_v_out_114182.awb")

						arg_157_1:RecordAudio("114182038", var_160_8)
						arg_157_1:RecordAudio("114182038", var_160_8)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114182", "114182038", "story_v_out_114182.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114182", "114182038", "story_v_out_114182.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_9 and arg_157_1.time_ < var_160_1 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play114182039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114182039
		arg_161_1.duration_ = 2.33

		local var_161_0 = {
			ja = 1.733,
			ko = 2.333,
			zh = 1.933,
			en = 2
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play114182040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.25

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[213].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(114182039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 8 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 8)

				if (8 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 8)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182039", "story_v_out_114182.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_114182", "114182039", "story_v_out_114182.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_114182", "114182039", "story_v_out_114182.awb")

						arg_161_1:RecordAudio("114182039", var_164_6)
						arg_161_1:RecordAudio("114182039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114182", "114182039", "story_v_out_114182.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114182", "114182039", "story_v_out_114182.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114182040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114182040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play114182041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.9

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(114182040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 36 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 36)

				if (36 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 36)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114182041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114182041
		arg_169_1.duration_ = 3

		local var_169_0 = {
			ja = 3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play114182042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_0 = arg_169_1.actors_["1067ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1067ui_story = var_172_0.localPosition
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_169_1.time_ - 0) / var_172_1)
				var_172_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_0.position).x, (manager.ui.mainCamera.transform.position - var_172_0.position).y, (manager.ui.mainCamera.transform.position - var_172_0.position).z)
				var_172_0.localEulerAngles.z = 0
				var_172_0.localEulerAngles.x = 0
				var_172_0.localEulerAngles = var_172_0.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_172_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_0.position).x, (manager.ui.mainCamera.transform.position - var_172_0.position).y, (manager.ui.mainCamera.transform.position - var_172_0.position).z)
				var_172_0.localEulerAngles.z = 0
				var_172_0.localEulerAngles.x = 0
				var_172_0.localEulerAngles = var_172_0.localEulerAngles
			end

			local var_172_2 = arg_169_1.actors_["1067ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1067ui_story == nil then
				arg_169_1.var_.characterEffect1067ui_story = var_172_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_3 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.characterEffect1067ui_story and not isNil(var_172_2) then
					arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.characterEffect1067ui_story then
				arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_172_5 = 0
			local var_172_6 = 0.2

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:GetWordFromCfg(114182041)
				local var_172_8 = arg_169_1:FormatText(var_172_7.content)

				arg_169_1.text_.text = var_172_8

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 8 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 8)

				if (8 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 8)) > 0 and var_172_6 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_8
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182041", "story_v_out_114182.awb") ~= 0 then
					local var_172_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182041", "story_v_out_114182.awb") / 1000

					if var_172_11 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_5
					end

					if var_172_7.prefab_name ~= "" and arg_169_1.actors_[var_172_7.prefab_name] ~= nil then
						local var_172_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_7.prefab_name].transform, "story_v_out_114182", "114182041", "story_v_out_114182.awb")

						arg_169_1:RecordAudio("114182041", var_172_12)
						arg_169_1:RecordAudio("114182041", var_172_12)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114182", "114182041", "story_v_out_114182.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114182", "114182041", "story_v_out_114182.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_13 and arg_169_1.time_ < var_172_5 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play114182042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114182042
		arg_173_1.duration_ = 6.33

		local var_173_0 = {
			ja = 6.333,
			ko = 4.6,
			zh = 3.3,
			en = 3.166
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114182043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1067ui_story"]) and arg_173_1.var_.characterEffect1067ui_story == nil then
				arg_173_1.var_.characterEffect1067ui_story = arg_173_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1067ui_story"]) then
				if arg_173_1.var_.characterEffect1067ui_story and not isNil(arg_173_1.actors_["1067ui_story"]) then
					arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1067ui_story"]) and arg_173_1.var_.characterEffect1067ui_story then
				arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_176_1 = arg_173_1.actors_["1042ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1042ui_story = var_176_1.localPosition
			end

			local var_176_2 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 then
				var_176_1.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_173_1.time_ - 0) / var_176_2)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 then
				var_176_1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_176_3 = arg_173_1.actors_["1042ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect1042ui_story == nil then
				arg_173_1.var_.characterEffect1042ui_story = var_176_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_4 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 and not isNil(var_176_3) then
				if arg_173_1.var_.characterEffect1042ui_story and not isNil(var_176_3) then
					arg_173_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 and not isNil(var_176_3) and arg_173_1.var_.characterEffect1042ui_story then
				arg_173_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_176_6 = 0
			local var_176_7 = 0.35

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(114182042)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 14 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 14)

				if (14 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 14)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182042", "story_v_out_114182.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_114182", "114182042", "story_v_out_114182.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_114182", "114182042", "story_v_out_114182.awb")

						arg_173_1:RecordAudio("114182042", var_176_13)
						arg_173_1:RecordAudio("114182042", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114182", "114182042", "story_v_out_114182.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114182", "114182042", "story_v_out_114182.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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

		arg_173_1:InitPlayNodeList()
	end,
	Play114182043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114182043
		arg_177_1.duration_ = 9

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play114182044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_0 = 2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				local var_180_1 = Color.New(0, 0, 0)

				var_180_1.a = Mathf.Lerp(0, 1, (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.mask_.color = var_180_1
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				local var_180_2 = Color.New(0, 0, 0)

				var_180_2.a = 1
				arg_177_1.mask_.color = var_180_2
			end

			local var_180_3 = 2

			if 2 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_4 = 2

			if var_180_3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_3 + var_180_4 then
				local var_180_5 = Color.New(0, 0, 0)

				var_180_5.a = Mathf.Lerp(1, 0, (arg_177_1.time_ - var_180_3) / var_180_4)
				arg_177_1.mask_.color = var_180_5
			end

			if arg_177_1.time_ >= var_180_3 + var_180_4 and arg_177_1.time_ < var_180_3 + var_180_4 + arg_180_0 then
				local var_180_6 = Color.New(0, 0, 0)

				arg_177_1.mask_.enabled = false
				var_180_6.a = 0
				arg_177_1.mask_.color = var_180_6
			end

			local var_180_7 = arg_177_1.actors_["1042ui_story"].transform

			if 1.966 < arg_177_1.time_ and arg_177_1.time_ <= 1.966 + arg_180_0 then
				arg_177_1.var_.moveOldPos1042ui_story = var_180_7.localPosition
			end

			local var_180_8 = 0.001

			if 1.966 <= arg_177_1.time_ and arg_177_1.time_ < 1.966 + var_180_8 then
				var_180_7.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 1.966) / var_180_8)
				var_180_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_7.position).x, (manager.ui.mainCamera.transform.position - var_180_7.position).y, (manager.ui.mainCamera.transform.position - var_180_7.position).z)
				var_180_7.localEulerAngles.z = 0
				var_180_7.localEulerAngles.x = 0
				var_180_7.localEulerAngles = var_180_7.localEulerAngles
			end

			if arg_177_1.time_ >= 1.966 + var_180_8 and arg_177_1.time_ < 1.966 + var_180_8 + arg_180_0 then
				var_180_7.localPosition = Vector3.New(0, 100, 0)
				var_180_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_7.position).x, (manager.ui.mainCamera.transform.position - var_180_7.position).y, (manager.ui.mainCamera.transform.position - var_180_7.position).z)
				var_180_7.localEulerAngles.z = 0
				var_180_7.localEulerAngles.x = 0
				var_180_7.localEulerAngles = var_180_7.localEulerAngles
			end

			local var_180_9 = arg_177_1.actors_["1067ui_story"].transform

			if 1.966 < arg_177_1.time_ and arg_177_1.time_ <= 1.966 + arg_180_0 then
				arg_177_1.var_.moveOldPos1067ui_story = var_180_9.localPosition
			end

			local var_180_10 = 0.001

			if 1.966 <= arg_177_1.time_ and arg_177_1.time_ < 1.966 + var_180_10 then
				var_180_9.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 1.966) / var_180_10)
				var_180_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_9.position).x, (manager.ui.mainCamera.transform.position - var_180_9.position).y, (manager.ui.mainCamera.transform.position - var_180_9.position).z)
				var_180_9.localEulerAngles.z = 0
				var_180_9.localEulerAngles.x = 0
				var_180_9.localEulerAngles = var_180_9.localEulerAngles
			end

			if arg_177_1.time_ >= 1.966 + var_180_10 and arg_177_1.time_ < 1.966 + var_180_10 + arg_180_0 then
				var_180_9.localPosition = Vector3.New(0, 100, 0)
				var_180_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_180_9.position).x, (manager.ui.mainCamera.transform.position - var_180_9.position).y, (manager.ui.mainCamera.transform.position - var_180_9.position).z)
				var_180_9.localEulerAngles.z = 0
				var_180_9.localEulerAngles.x = 0
				var_180_9.localEulerAngles = var_180_9.localEulerAngles
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_11 = 4
			local var_180_12 = 0.725

			if 4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_11 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_13 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_13:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_14 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(114182043).content)

				arg_177_1.text_.text = var_180_14

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_16 = 29 <= 0 and var_180_12 or var_180_12 * (utf8.len(var_180_14) / 29)

				if (29 <= 0 and var_180_12 or var_180_12 * (utf8.len(var_180_14) / 29)) > 0 and var_180_12 < var_180_16 then
					arg_177_1.talkMaxDuration = var_180_16
					var_180_11 = var_180_11 + 0.3

					if var_180_16 + var_180_11 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_16 + var_180_11
					end
				end

				arg_177_1.text_.text = var_180_14
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_17 = var_180_11 + 0.3
			local var_180_18 = math.max(var_180_12, arg_177_1.talkMaxDuration)

			if var_180_11 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_17 + var_180_18 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_17) / var_180_18

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_17 + var_180_18 and arg_177_1.time_ < var_180_17 + var_180_18 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play114182044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 114182044
		arg_183_1.duration_ = 2.83

		local var_183_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.833,
			en = 2.366
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
				arg_183_0:Play114182045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_186_0 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_183_1.stage_.transform)

				var_186_0.name = "6046_story"
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["6046_story"] = var_186_0

				local var_186_1 = var_186_0:GetComponentInChildren(typeof(CharacterEffect))

				var_186_1.enabled = true

				local var_186_2 = GameObjectTools.GetOrAddComponent(var_186_0, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(false)
				end

				arg_183_1:ShowWeapon(var_186_1.transform, false)

				arg_183_1.var_["6046_story" .. "Animator"] = var_186_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_183_1.var_["6046_story" .. "Animator"].applyRootMotion = true
				arg_183_1.var_["6046_story" .. "LipSync"] = var_186_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_186_3 = arg_183_1.actors_["6046_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos6046_story = var_186_3.localPosition

				local var_186_4 = GameObjectTools.GetOrAddComponent(var_186_3.gameObject, typeof(DynamicBoneHelper))

				if var_186_4 then
					var_186_4:EnableDynamicBone(false)
				end
			end

			local var_186_5 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_5 then
				var_186_3.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_183_1.time_ - 0) / var_186_5)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_5 and arg_183_1.time_ < 0 + var_186_5 + arg_186_0 then
				var_186_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles

				local var_186_6 = GameObjectTools.GetOrAddComponent(var_186_3.gameObject, typeof(DynamicBoneHelper))

				if var_186_6 then
					var_186_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_186_7 = arg_183_1.actors_["6046_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.characterEffect6046_story == nil then
				arg_183_1.var_.characterEffect6046_story = var_186_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_8 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_8 and not isNil(var_186_7) then
				if arg_183_1.var_.characterEffect6046_story and not isNil(var_186_7) then
					arg_183_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_8 and arg_183_1.time_ < 0 + var_186_8 + arg_186_0 and not isNil(var_186_7) and arg_183_1.var_.characterEffect6046_story then
				arg_183_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_186_10 = "6045_story"

			if arg_183_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_186_11 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_183_1.stage_.transform)

				var_186_11.name = var_186_10
				var_186_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_[var_186_10] = var_186_11

				local var_186_12 = var_186_11:GetComponentInChildren(typeof(CharacterEffect))

				var_186_12.enabled = true

				local var_186_13 = GameObjectTools.GetOrAddComponent(var_186_11, typeof(DynamicBoneHelper))

				if var_186_13 then
					var_186_13:EnableDynamicBone(false)
				end

				arg_183_1:ShowWeapon(var_186_12.transform, false)

				arg_183_1.var_[var_186_10 .. "Animator"] = var_186_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_183_1.var_[var_186_10 .. "Animator"].applyRootMotion = true
				arg_183_1.var_[var_186_10 .. "LipSync"] = var_186_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_186_14 = arg_183_1.actors_["6045_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos6045_story = var_186_14.localPosition

				local var_186_15 = GameObjectTools.GetOrAddComponent(var_186_14.gameObject, typeof(DynamicBoneHelper))

				if var_186_15 then
					var_186_15:EnableDynamicBone(false)
				end
			end

			local var_186_16 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_16 then
				var_186_14.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos6045_story, Vector3.New(0.7, -0.5, -6.3), (arg_183_1.time_ - 0) / var_186_16)
				var_186_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_14.position).x, (manager.ui.mainCamera.transform.position - var_186_14.position).y, (manager.ui.mainCamera.transform.position - var_186_14.position).z)
				var_186_14.localEulerAngles.z = 0
				var_186_14.localEulerAngles.x = 0
				var_186_14.localEulerAngles = var_186_14.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_16 and arg_183_1.time_ < 0 + var_186_16 + arg_186_0 then
				var_186_14.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_186_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_14.position).x, (manager.ui.mainCamera.transform.position - var_186_14.position).y, (manager.ui.mainCamera.transform.position - var_186_14.position).z)
				var_186_14.localEulerAngles.z = 0
				var_186_14.localEulerAngles.x = 0
				var_186_14.localEulerAngles = var_186_14.localEulerAngles

				local var_186_17 = GameObjectTools.GetOrAddComponent(var_186_14.gameObject, typeof(DynamicBoneHelper))

				if var_186_17 then
					var_186_17:EnableDynamicBone(true)
				end
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_186_18 = 0
			local var_186_19 = 0.175

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_18 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_20 = arg_183_1:GetWordFromCfg(114182044)
				local var_186_21 = arg_183_1:FormatText(var_186_20.content)

				arg_183_1.text_.text = var_186_21

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_23 = 7 <= 0 and var_186_19 or var_186_19 * (utf8.len(var_186_21) / 7)

				if (7 <= 0 and var_186_19 or var_186_19 * (utf8.len(var_186_21) / 7)) > 0 and var_186_19 < var_186_23 then
					arg_183_1.talkMaxDuration = var_186_23

					if var_186_23 + var_186_18 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_18
					end
				end

				arg_183_1.text_.text = var_186_21
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182044", "story_v_out_114182.awb") ~= 0 then
					local var_186_24 = manager.audio:GetVoiceLength("story_v_out_114182", "114182044", "story_v_out_114182.awb") / 1000

					if var_186_24 + var_186_18 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_24 + var_186_18
					end

					if var_186_20.prefab_name ~= "" and arg_183_1.actors_[var_186_20.prefab_name] ~= nil then
						local var_186_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_20.prefab_name].transform, "story_v_out_114182", "114182044", "story_v_out_114182.awb")

						arg_183_1:RecordAudio("114182044", var_186_25)
						arg_183_1:RecordAudio("114182044", var_186_25)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_114182", "114182044", "story_v_out_114182.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_114182", "114182044", "story_v_out_114182.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_26 = math.max(var_186_19, arg_183_1.talkMaxDuration)

			if var_186_18 <= arg_183_1.time_ and arg_183_1.time_ < var_186_18 + var_186_26 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_18) / var_186_26

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_18 + var_186_26 and arg_183_1.time_ < var_186_18 + var_186_26 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play114182045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 114182045
		arg_187_1.duration_ = 3.1

		local var_187_0 = {
			ja = 3.1,
			ko = 2.6,
			zh = 2.566,
			en = 2.733
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
				arg_187_0:Play114182046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["6046_story"]) and arg_187_1.var_.characterEffect6046_story == nil then
				arg_187_1.var_.characterEffect6046_story = arg_187_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["6046_story"]) then
				if arg_187_1.var_.characterEffect6046_story and not isNil(arg_187_1.actors_["6046_story"]) then
					arg_187_1.var_.characterEffect6046_story.fillFlat = true
					arg_187_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["6046_story"]) and arg_187_1.var_.characterEffect6046_story then
				arg_187_1.var_.characterEffect6046_story.fillFlat = true
				arg_187_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_190_1 = arg_187_1.actors_["6045_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect6045_story == nil then
				arg_187_1.var_.characterEffect6045_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect6045_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect6045_story.fillFlat = true
					arg_187_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_2)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect6045_story then
				arg_187_1.var_.characterEffect6045_story.fillFlat = true
				arg_187_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_190_3 = 0
			local var_190_4 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_3 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_5 = arg_187_1:GetWordFromCfg(114182045)
				local var_190_6 = arg_187_1:FormatText(var_190_5.content)

				arg_187_1.text_.text = var_190_6

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_8 = 11 <= 0 and var_190_4 or var_190_4 * (utf8.len(var_190_6) / 11)

				if (11 <= 0 and var_190_4 or var_190_4 * (utf8.len(var_190_6) / 11)) > 0 and var_190_4 < var_190_8 then
					arg_187_1.talkMaxDuration = var_190_8

					if var_190_8 + var_190_3 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_3
					end
				end

				arg_187_1.text_.text = var_190_6
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182045", "story_v_out_114182.awb") ~= 0 then
					local var_190_9 = manager.audio:GetVoiceLength("story_v_out_114182", "114182045", "story_v_out_114182.awb") / 1000

					if var_190_9 + var_190_3 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_3
					end

					if var_190_5.prefab_name ~= "" and arg_187_1.actors_[var_190_5.prefab_name] ~= nil then
						local var_190_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_5.prefab_name].transform, "story_v_out_114182", "114182045", "story_v_out_114182.awb")

						arg_187_1:RecordAudio("114182045", var_190_10)
						arg_187_1:RecordAudio("114182045", var_190_10)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_114182", "114182045", "story_v_out_114182.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_114182", "114182045", "story_v_out_114182.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_11 = math.max(var_190_4, arg_187_1.talkMaxDuration)

			if var_190_3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_3 + var_190_11 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_3) / var_190_11

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_3 + var_190_11 and arg_187_1.time_ < var_190_3 + var_190_11 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play114182046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 114182046
		arg_191_1.duration_ = 6.3

		local var_191_0 = {
			ja = 6.3,
			ko = 4.633,
			zh = 6.133,
			en = 5.9
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
				arg_191_0:Play114182047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["6045_story"]) and arg_191_1.var_.characterEffect6045_story == nil then
				arg_191_1.var_.characterEffect6045_story = arg_191_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["6045_story"]) then
				if arg_191_1.var_.characterEffect6045_story and not isNil(arg_191_1.actors_["6045_story"]) then
					arg_191_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["6045_story"]) and arg_191_1.var_.characterEffect6045_story then
				arg_191_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_194_2 = 0
			local var_194_3 = 0.4

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(114182046)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 16 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 16)

				if (16 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 16)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182046", "story_v_out_114182.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_114182", "114182046", "story_v_out_114182.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_114182", "114182046", "story_v_out_114182.awb")

						arg_191_1:RecordAudio("114182046", var_194_9)
						arg_191_1:RecordAudio("114182046", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_114182", "114182046", "story_v_out_114182.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_114182", "114182046", "story_v_out_114182.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play114182047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114182047
		arg_195_1.duration_ = 5.73

		local var_195_0 = {
			ja = 3.933,
			ko = 5.733,
			zh = 3.933,
			en = 4.3
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
				arg_195_0:Play114182048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["6045_story"]) and arg_195_1.var_.characterEffect6045_story == nil then
				arg_195_1.var_.characterEffect6045_story = arg_195_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["6045_story"]) then
				if arg_195_1.var_.characterEffect6045_story and not isNil(arg_195_1.actors_["6045_story"]) then
					arg_195_1.var_.characterEffect6045_story.fillFlat = true
					arg_195_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["6045_story"]) and arg_195_1.var_.characterEffect6045_story then
				arg_195_1.var_.characterEffect6045_story.fillFlat = true
				arg_195_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.525

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_7")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:GetWordFromCfg(114182047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_6 = 21 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_4) / 21)

				if (21 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_4) / 21)) > 0 and var_198_2 < var_198_6 then
					arg_195_1.talkMaxDuration = var_198_6

					if var_198_6 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_6 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182047", "story_v_out_114182.awb") ~= 0 then
					local var_198_7 = manager.audio:GetVoiceLength("story_v_out_114182", "114182047", "story_v_out_114182.awb") / 1000

					if var_198_7 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_1
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_114182", "114182047", "story_v_out_114182.awb")

						arg_195_1:RecordAudio("114182047", var_198_8)
						arg_195_1:RecordAudio("114182047", var_198_8)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_114182", "114182047", "story_v_out_114182.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_114182", "114182047", "story_v_out_114182.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_9 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_9 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_9

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_9 and arg_195_1.time_ < var_198_1 + var_198_9 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play114182048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114182048
		arg_199_1.duration_ = 8.67

		local var_199_0 = {
			ja = 8.666,
			ko = 4.4,
			zh = 6.166,
			en = 5.033
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play114182049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos6045_story = arg_199_1.actors_["6045_story"].transform.localPosition

				local var_202_0 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_0 then
					var_202_0:EnableDynamicBone(false)
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_1)
				arg_199_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6045_story"].transform.position).z)
				arg_199_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["6045_story"].transform.localEulerAngles = arg_199_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6045_story"].transform.position).z)
				arg_199_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["6045_story"].transform.localEulerAngles = arg_199_1.actors_["6045_story"].transform.localEulerAngles

				local var_202_2 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(true)
				end
			end

			local var_202_3 = arg_199_1.actors_["6046_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos6046_story = var_202_3.localPosition

				local var_202_4 = GameObjectTools.GetOrAddComponent(var_202_3.gameObject, typeof(DynamicBoneHelper))

				if var_202_4 then
					var_202_4:EnableDynamicBone(false)
				end
			end

			local var_202_5 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 then
				var_202_3.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_5)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 then
				var_202_3.localPosition = Vector3.New(0, 100, 0)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles

				local var_202_6 = GameObjectTools.GetOrAddComponent(var_202_3.gameObject, typeof(DynamicBoneHelper))

				if var_202_6 then
					var_202_6:EnableDynamicBone(true)
				end
			end

			local var_202_7 = 0
			local var_202_8 = 0.55

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_9 = arg_199_1:GetWordFromCfg(114182048)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_12 = 22 <= 0 and var_202_8 or var_202_8 * (utf8.len(var_202_10) / 22)

				if (22 <= 0 and var_202_8 or var_202_8 * (utf8.len(var_202_10) / 22)) > 0 and var_202_8 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_7 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_7
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182048", "story_v_out_114182.awb") ~= 0 then
					local var_202_13 = manager.audio:GetVoiceLength("story_v_out_114182", "114182048", "story_v_out_114182.awb") / 1000

					if var_202_13 + var_202_7 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_7
					end

					if var_202_9.prefab_name ~= "" and arg_199_1.actors_[var_202_9.prefab_name] ~= nil then
						local var_202_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_9.prefab_name].transform, "story_v_out_114182", "114182048", "story_v_out_114182.awb")

						arg_199_1:RecordAudio("114182048", var_202_14)
						arg_199_1:RecordAudio("114182048", var_202_14)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_114182", "114182048", "story_v_out_114182.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_114182", "114182048", "story_v_out_114182.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_15 = math.max(var_202_8, arg_199_1.talkMaxDuration)

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_15 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_7) / var_202_15

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_7 + var_202_15 and arg_199_1.time_ < var_202_7 + var_202_15 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play114182049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114182049
		arg_203_1.duration_ = 8.07

		local var_203_0 = {
			ja = 8.066,
			ko = 5.1,
			zh = 3.9,
			en = 4.666
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
				arg_203_0:Play114182050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.45

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(114182049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 18 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 18)

				if (18 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 18)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182049", "story_v_out_114182.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_114182", "114182049", "story_v_out_114182.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_114182", "114182049", "story_v_out_114182.awb")

						arg_203_1:RecordAudio("114182049", var_206_6)
						arg_203_1:RecordAudio("114182049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_114182", "114182049", "story_v_out_114182.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_114182", "114182049", "story_v_out_114182.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114182050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114182050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play114182051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.95

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(114182050).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 38 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 38)

				if (38 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 38)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play114182051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114182051
		arg_211_1.duration_ = 8.37

		local var_211_0 = {
			ja = 5.766,
			ko = 8.366,
			zh = 6.8,
			en = 8.266
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
				arg_211_0:Play114182052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1042ui_story = arg_211_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1042ui_story"].transform.position).z)
				arg_211_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1042ui_story"].transform.localEulerAngles = arg_211_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_211_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1042ui_story"].transform.position).z)
				arg_211_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1042ui_story"].transform.localEulerAngles = arg_211_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_214_1 = arg_211_1.actors_["1042ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1042ui_story == nil then
				arg_211_1.var_.characterEffect1042ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1042ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1042ui_story then
				arg_211_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_214_4 = 0
			local var_214_5 = 0.75

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(114182051)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 30 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 30)

				if (30 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 30)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182051", "story_v_out_114182.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182051", "story_v_out_114182.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_114182", "114182051", "story_v_out_114182.awb")

						arg_211_1:RecordAudio("114182051", var_214_11)
						arg_211_1:RecordAudio("114182051", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_114182", "114182051", "story_v_out_114182.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_114182", "114182051", "story_v_out_114182.awb")
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

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play114182052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114182052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114182053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_0 = 2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				local var_218_1 = Color.New(0, 0, 0)

				var_218_1.a = Mathf.Lerp(0, 1, (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.mask_.color = var_218_1
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				local var_218_2 = Color.New(0, 0, 0)

				var_218_2.a = 1
				arg_215_1.mask_.color = var_218_2
			end

			local var_218_3 = 2

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_4 = 1.966

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_4 then
				local var_218_5 = Color.New(0, 0, 0)

				var_218_5.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_3) / var_218_4)
				arg_215_1.mask_.color = var_218_5
			end

			if arg_215_1.time_ >= var_218_3 + var_218_4 and arg_215_1.time_ < var_218_3 + var_218_4 + arg_218_0 then
				local var_218_6 = Color.New(0, 0, 0)

				arg_215_1.mask_.enabled = false
				var_218_6.a = 0
				arg_215_1.mask_.color = var_218_6
			end

			local var_218_7 = arg_215_1.actors_["1042ui_story"].transform

			if 1.966 < arg_215_1.time_ and arg_215_1.time_ <= 1.966 + arg_218_0 then
				arg_215_1.var_.moveOldPos1042ui_story = var_218_7.localPosition
			end

			local var_218_8 = 0.001

			if 1.966 <= arg_215_1.time_ and arg_215_1.time_ < 1.966 + var_218_8 then
				var_218_7.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 1.966) / var_218_8)
				var_218_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_7.position).x, (manager.ui.mainCamera.transform.position - var_218_7.position).y, (manager.ui.mainCamera.transform.position - var_218_7.position).z)
				var_218_7.localEulerAngles.z = 0
				var_218_7.localEulerAngles.x = 0
				var_218_7.localEulerAngles = var_218_7.localEulerAngles
			end

			if arg_215_1.time_ >= 1.966 + var_218_8 and arg_215_1.time_ < 1.966 + var_218_8 + arg_218_0 then
				var_218_7.localPosition = Vector3.New(0, 100, 0)
				var_218_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_7.position).x, (manager.ui.mainCamera.transform.position - var_218_7.position).y, (manager.ui.mainCamera.transform.position - var_218_7.position).z)
				var_218_7.localEulerAngles.z = 0
				var_218_7.localEulerAngles.x = 0
				var_218_7.localEulerAngles = var_218_7.localEulerAngles
			end

			local var_218_9 = "STblack"

			if arg_215_1.bgs_.STblack == nil then
				local var_218_10 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_218_9)
				var_218_10.name = var_218_9
				var_218_10.transform.parent = arg_215_1.stage_.transform
				var_218_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_[var_218_9] = var_218_10
			end

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				local var_218_11 = arg_215_1.bgs_.STblack

				arg_215_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_12 = var_218_11:GetComponent("SpriteRenderer")

				if var_218_12 and var_218_12.sprite then
					local var_218_13 = 2 * (var_218_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_11.transform.localScale = Vector3.New(var_218_13 / var_218_12.sprite.bounds.size.y < var_218_13 * manager.ui.mainCameraCom_.aspect / var_218_12.sprite.bounds.size.x and var_218_13 * manager.ui.mainCameraCom_.aspect / var_218_12.sprite.bounds.size.x or var_218_13 / var_218_12.sprite.bounds.size.y, var_218_13 / var_218_12.sprite.bounds.size.y < var_218_13 * manager.ui.mainCameraCom_.aspect / var_218_12.sprite.bounds.size.x and var_218_13 * manager.ui.mainCameraCom_.aspect / var_218_12.sprite.bounds.size.x or var_218_13 / var_218_12.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "STblack" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0
				arg_215_1.fswt_.text = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(114182052).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_14 = 2.01666666666667

			if 2.01666666666667 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_15 = 21
			local var_218_16 = 1.4
			local var_218_17, var_218_18 = arg_215_1:GetPercentByPara(arg_215_1:FormatText(arg_215_1:GetWordFromCfg(114182052).content), 1)

			if var_218_14 < arg_215_1.time_ and arg_215_1.time_ <= var_218_14 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_19 = var_218_15 <= 0 and var_218_16 or var_218_16 * ((var_218_18 - arg_215_1.typewritterCharCountI18N) / var_218_15)

				if (var_218_15 <= 0 and var_218_16 or var_218_16 * ((var_218_18 - arg_215_1.typewritterCharCountI18N) / var_218_15)) > 0 and var_218_16 < var_218_19 then
					arg_215_1.talkMaxDuration = var_218_19

					if var_218_19 + var_218_14 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_19 + var_218_14
					end
				end
			end

			local var_218_20 = math.max(1.4, arg_215_1.talkMaxDuration)

			if var_218_14 <= arg_215_1.time_ and arg_215_1.time_ < var_218_14 + var_218_20 then
				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_17, (arg_215_1.time_ - var_218_14) / var_218_20)
				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_14 + var_218_20 and arg_215_1.time_ < var_218_14 + var_218_20 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_17

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_18
			end

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				local var_218_21 = arg_215_1.fswbg_.transform:Find("textbox/adapt/content") or arg_215_1.fswbg_.transform:Find("textbox/content")
				local var_218_22 = arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_218_23 = var_218_21:GetComponent("RectTransform")

				var_218_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_218_23.offsetMin = Vector2.New(0, 0)
				var_218_23.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play114182053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114182053
		arg_219_1.duration_ = 16.67

		local var_219_0 = {
			ja = 16.6,
			ko = 16.666,
			zh = 15.3,
			en = 16.666
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play114182054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 3.8 < arg_219_1.time_ and arg_219_1.time_ <= 3.8 + arg_222_0 then
				arg_219_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_222_0 = arg_219_1.actors_["1067ui_story"].transform

			if 3.8 < arg_219_1.time_ and arg_219_1.time_ <= 3.8 + arg_222_0 then
				arg_219_1.var_.moveOldPos1067ui_story = var_222_0.localPosition
			end

			local var_222_1 = 0.001

			if 3.8 <= arg_219_1.time_ and arg_219_1.time_ < 3.8 + var_222_1 then
				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_219_1.time_ - 3.8) / var_222_1)
				var_222_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_0.position).x, (manager.ui.mainCamera.transform.position - var_222_0.position).y, (manager.ui.mainCamera.transform.position - var_222_0.position).z)
				var_222_0.localEulerAngles.z = 0
				var_222_0.localEulerAngles.x = 0
				var_222_0.localEulerAngles = var_222_0.localEulerAngles
			end

			if arg_219_1.time_ >= 3.8 + var_222_1 and arg_219_1.time_ < 3.8 + var_222_1 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_222_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_0.position).x, (manager.ui.mainCamera.transform.position - var_222_0.position).y, (manager.ui.mainCamera.transform.position - var_222_0.position).z)
				var_222_0.localEulerAngles.z = 0
				var_222_0.localEulerAngles.x = 0
				var_222_0.localEulerAngles = var_222_0.localEulerAngles
			end

			local var_222_2 = arg_219_1.actors_["1067ui_story"]

			if 3.8 < arg_219_1.time_ and arg_219_1.time_ <= 3.8 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.characterEffect1067ui_story == nil then
				arg_219_1.var_.characterEffect1067ui_story = var_222_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_3 = 0.2

			if 3.8 <= arg_219_1.time_ and arg_219_1.time_ < 3.8 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.characterEffect1067ui_story and not isNil(var_222_2) then
					arg_219_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 3.8 + var_222_3 and arg_219_1.time_ < 3.8 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.characterEffect1067ui_story then
				arg_219_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 3.8 < arg_219_1.time_ and arg_219_1.time_ <= 3.8 + arg_222_0 then
				arg_219_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			local var_222_5 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_6 = 2

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 then
				local var_222_7 = Color.New(0, 0, 0)

				var_222_7.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_5) / var_222_6)
				arg_219_1.mask_.color = var_222_7
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 then
				local var_222_8 = Color.New(0, 0, 0)

				var_222_8.a = 1
				arg_219_1.mask_.color = var_222_8
			end

			local var_222_9 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_10 = 1.966

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_10 then
				local var_222_11 = Color.New(0, 0, 0)

				var_222_11.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_9) / var_222_10)
				arg_219_1.mask_.color = var_222_11
			end

			if arg_219_1.time_ >= var_222_9 + var_222_10 and arg_219_1.time_ < var_222_9 + var_222_10 + arg_222_0 then
				local var_222_12 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_12.a = 0
				arg_219_1.mask_.color = var_222_12
			end

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				local var_222_13 = arg_219_1.bgs_.F04

				arg_219_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_14 = var_222_13:GetComponent("SpriteRenderer")

				if var_222_14 and var_222_14.sprite then
					local var_222_15 = 2 * (var_222_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_13.transform.localScale = Vector3.New(var_222_15 / var_222_14.sprite.bounds.size.y < var_222_15 * manager.ui.mainCameraCom_.aspect / var_222_14.sprite.bounds.size.x and var_222_15 * manager.ui.mainCameraCom_.aspect / var_222_14.sprite.bounds.size.x or var_222_15 / var_222_14.sprite.bounds.size.y, var_222_15 / var_222_14.sprite.bounds.size.y < var_222_15 * manager.ui.mainCameraCom_.aspect / var_222_14.sprite.bounds.size.x and var_222_15 * manager.ui.mainCameraCom_.aspect / var_222_14.sprite.bounds.size.x or var_222_15 / var_222_14.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "F04" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(false)
				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_219_1:ShowNextGo(false)
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_16 = 4
			local var_222_17 = 1.275

			if 4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_16 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_18 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_18:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_19 = arg_219_1:GetWordFromCfg(114182053)
				local var_222_20 = arg_219_1:FormatText(var_222_19.content)

				arg_219_1.text_.text = var_222_20

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_22 = 51 <= 0 and var_222_17 or var_222_17 * (utf8.len(var_222_20) / 51)

				if (51 <= 0 and var_222_17 or var_222_17 * (utf8.len(var_222_20) / 51)) > 0 and var_222_17 < var_222_22 then
					arg_219_1.talkMaxDuration = var_222_22
					var_222_16 = var_222_16 + 0.3

					if var_222_22 + var_222_16 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_22 + var_222_16
					end
				end

				arg_219_1.text_.text = var_222_20
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182053", "story_v_out_114182.awb") ~= 0 then
					local var_222_23 = manager.audio:GetVoiceLength("story_v_out_114182", "114182053", "story_v_out_114182.awb") / 1000

					if var_222_23 + var_222_16 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_16
					end

					if var_222_19.prefab_name ~= "" and arg_219_1.actors_[var_222_19.prefab_name] ~= nil then
						local var_222_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_19.prefab_name].transform, "story_v_out_114182", "114182053", "story_v_out_114182.awb")

						arg_219_1:RecordAudio("114182053", var_222_24)
						arg_219_1:RecordAudio("114182053", var_222_24)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_114182", "114182053", "story_v_out_114182.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_114182", "114182053", "story_v_out_114182.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_25 = var_222_16 + 0.3
			local var_222_26 = math.max(var_222_17, arg_219_1.talkMaxDuration)

			if var_222_16 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_25 + var_222_26 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_25) / var_222_26

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_25 + var_222_26 and arg_219_1.time_ < var_222_25 + var_222_26 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play114182054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 114182054
		arg_225_1.duration_ = 9.93

		local var_225_0 = {
			ja = 8.7,
			ko = 9.933,
			zh = 7.866,
			en = 9.5
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
				arg_225_0:Play114182055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1184ui_story = arg_225_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1184ui_story"].transform.position).z)
				arg_225_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1184ui_story"].transform.localEulerAngles = arg_225_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_225_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1184ui_story"].transform.position).z)
				arg_225_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1184ui_story"].transform.localEulerAngles = arg_225_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_228_1 = arg_225_1.actors_["1184ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1184ui_story == nil then
				arg_225_1.var_.characterEffect1184ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1184ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1184ui_story then
				arg_225_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_228_4 = arg_225_1.actors_["1067ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1067ui_story == nil then
				arg_225_1.var_.characterEffect1067ui_story = var_228_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_5 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_5 and not isNil(var_228_4) then
				if arg_225_1.var_.characterEffect1067ui_story and not isNil(var_228_4) then
					arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_5)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_5 and arg_225_1.time_ < 0 + var_228_5 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect1067ui_story then
				arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_228_6 = 0
			local var_228_7 = 0.9

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(114182054)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 36 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 36)

				if (36 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 36)) > 0 and var_228_7 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182054", "story_v_out_114182.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_out_114182", "114182054", "story_v_out_114182.awb") / 1000

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_out_114182", "114182054", "story_v_out_114182.awb")

						arg_225_1:RecordAudio("114182054", var_228_13)
						arg_225_1:RecordAudio("114182054", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_114182", "114182054", "story_v_out_114182.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_114182", "114182054", "story_v_out_114182.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play114182055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 114182055
		arg_229_1.duration_ = 7.33

		local var_229_0 = {
			ja = 7.333,
			ko = 6.3,
			zh = 6.3,
			en = 5.966
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
				arg_229_0:Play114182056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_232_0 = arg_229_1.actors_["1067ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1067ui_story == nil then
				arg_229_1.var_.characterEffect1067ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_1 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 and not isNil(var_232_0) then
				if arg_229_1.var_.characterEffect1067ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1067ui_story then
				arg_229_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			local var_232_3 = arg_229_1.actors_["1184ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect1184ui_story == nil then
				arg_229_1.var_.characterEffect1184ui_story = var_232_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_4 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 and not isNil(var_232_3) then
				if arg_229_1.var_.characterEffect1184ui_story and not isNil(var_232_3) then
					arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_4)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 and not isNil(var_232_3) and arg_229_1.var_.characterEffect1184ui_story then
				arg_229_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_232_5 = 0
			local var_232_6 = 0.65

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(114182055)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 26 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 26)

				if (26 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 26)) > 0 and var_232_6 < var_232_10 then
					arg_229_1.talkMaxDuration = var_232_10

					if var_232_10 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182055", "story_v_out_114182.awb") ~= 0 then
					local var_232_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182055", "story_v_out_114182.awb") / 1000

					if var_232_11 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_5
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_out_114182", "114182055", "story_v_out_114182.awb")

						arg_229_1:RecordAudio("114182055", var_232_12)
						arg_229_1:RecordAudio("114182055", var_232_12)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_114182", "114182055", "story_v_out_114182.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_114182", "114182055", "story_v_out_114182.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_13 = math.max(var_232_6, arg_229_1.talkMaxDuration)

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_5) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_5 + var_232_13 and arg_229_1.time_ < var_232_5 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play114182056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 114182056
		arg_233_1.duration_ = 9.8

		local var_233_0 = {
			ja = 9.8,
			ko = 9.533,
			zh = 7.866,
			en = 6.666
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play114182057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1067ui_story = arg_233_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1067ui_story"].transform.position).z)
				arg_233_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1067ui_story"].transform.localEulerAngles = arg_233_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1067ui_story"].transform.position).z)
				arg_233_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1067ui_story"].transform.localEulerAngles = arg_233_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1184ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1184ui_story = var_236_1.localPosition
			end

			local var_236_2 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 then
				var_236_1.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_2)
				var_236_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_1.position).x, (manager.ui.mainCamera.transform.position - var_236_1.position).y, (manager.ui.mainCamera.transform.position - var_236_1.position).z)
				var_236_1.localEulerAngles.z = 0
				var_236_1.localEulerAngles.x = 0
				var_236_1.localEulerAngles = var_236_1.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 then
				var_236_1.localPosition = Vector3.New(0, 100, 0)
				var_236_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_1.position).x, (manager.ui.mainCamera.transform.position - var_236_1.position).y, (manager.ui.mainCamera.transform.position - var_236_1.position).z)
				var_236_1.localEulerAngles.z = 0
				var_236_1.localEulerAngles.x = 0
				var_236_1.localEulerAngles = var_236_1.localEulerAngles
			end

			local var_236_3 = arg_233_1.actors_["1042ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1042ui_story = var_236_3.localPosition
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_3.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_233_1.time_ - 0) / var_236_4)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_3.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_236_5 = arg_233_1.actors_["1042ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1042ui_story == nil then
				arg_233_1.var_.characterEffect1042ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.characterEffect1042ui_story and not isNil(var_236_5) then
					arg_233_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1042ui_story then
				arg_233_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_236_8 = 0
			local var_236_9 = 0.925

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(114182056)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 37 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 37)

				if (37 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 37)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182056", "story_v_out_114182.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182056", "story_v_out_114182.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_114182", "114182056", "story_v_out_114182.awb")

						arg_233_1:RecordAudio("114182056", var_236_15)
						arg_233_1:RecordAudio("114182056", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_114182", "114182056", "story_v_out_114182.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_114182", "114182056", "story_v_out_114182.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play114182057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 114182057
		arg_237_1.duration_ = 10.3

		local var_237_0 = {
			ja = 10.3,
			ko = 6.2,
			zh = 6.3,
			en = 5.9
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
				arg_237_0:Play114182058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1041ui_story = arg_237_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1041ui_story"].transform.position).z)
				arg_237_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1041ui_story"].transform.localEulerAngles = arg_237_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.9)
				arg_237_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1041ui_story"].transform.position).z)
				arg_237_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1041ui_story"].transform.localEulerAngles = arg_237_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_240_1 = arg_237_1.actors_["1041ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1041ui_story == nil then
				arg_237_1.var_.characterEffect1041ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1041ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1041ui_story then
				arg_237_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_240_4 = arg_237_1.actors_["1042ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1042ui_story == nil then
				arg_237_1.var_.characterEffect1042ui_story = var_240_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_5 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_5 and not isNil(var_240_4) then
				if arg_237_1.var_.characterEffect1042ui_story and not isNil(var_240_4) then
					arg_237_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_5)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_5 and arg_237_1.time_ < 0 + var_240_5 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1042ui_story then
				arg_237_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_240_6 = 0
			local var_240_7 = 0.8

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(114182057)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 32 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 32)

				if (32 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 32)) > 0 and var_240_7 < var_240_11 then
					arg_237_1.talkMaxDuration = var_240_11

					if var_240_11 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182057", "story_v_out_114182.awb") ~= 0 then
					local var_240_12 = manager.audio:GetVoiceLength("story_v_out_114182", "114182057", "story_v_out_114182.awb") / 1000

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end

					if var_240_8.prefab_name ~= "" and arg_237_1.actors_[var_240_8.prefab_name] ~= nil then
						local var_240_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_8.prefab_name].transform, "story_v_out_114182", "114182057", "story_v_out_114182.awb")

						arg_237_1:RecordAudio("114182057", var_240_13)
						arg_237_1:RecordAudio("114182057", var_240_13)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_114182", "114182057", "story_v_out_114182.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_114182", "114182057", "story_v_out_114182.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play114182058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 114182058
		arg_241_1.duration_ = 4.1

		local var_241_0 = {
			ja = 4.1,
			ko = 2.733,
			zh = 3.6,
			en = 3.8
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play114182059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_244_0 = arg_241_1.actors_["1042ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1042ui_story == nil then
				arg_241_1.var_.characterEffect1042ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_1 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_1 and not isNil(var_244_0) then
				if arg_241_1.var_.characterEffect1042ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_1 and arg_241_1.time_ < 0 + var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1042ui_story then
				arg_241_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_244_3 = arg_241_1.actors_["1041ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1041ui_story == nil then
				arg_241_1.var_.characterEffect1041ui_story = var_244_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_4 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 and not isNil(var_244_3) then
				if arg_241_1.var_.characterEffect1041ui_story and not isNil(var_244_3) then
					arg_241_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_4)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 and not isNil(var_244_3) and arg_241_1.var_.characterEffect1041ui_story then
				arg_241_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_244_5 = 0
			local var_244_6 = 0.325

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:GetWordFromCfg(114182058)
				local var_244_8 = arg_241_1:FormatText(var_244_7.content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 13 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 13)

				if (13 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 13)) > 0 and var_244_6 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182058", "story_v_out_114182.awb") ~= 0 then
					local var_244_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182058", "story_v_out_114182.awb") / 1000

					if var_244_11 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_5
					end

					if var_244_7.prefab_name ~= "" and arg_241_1.actors_[var_244_7.prefab_name] ~= nil then
						local var_244_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_7.prefab_name].transform, "story_v_out_114182", "114182058", "story_v_out_114182.awb")

						arg_241_1:RecordAudio("114182058", var_244_12)
						arg_241_1:RecordAudio("114182058", var_244_12)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_114182", "114182058", "story_v_out_114182.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_114182", "114182058", "story_v_out_114182.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_13 = math.max(var_244_6, arg_241_1.talkMaxDuration)

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_13 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_5) / var_244_13

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_5 + var_244_13 and arg_241_1.time_ < var_244_5 + var_244_13 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play114182059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 114182059
		arg_245_1.duration_ = 22.83

		local var_245_0 = {
			ja = 18.6,
			ko = 15,
			zh = 15.366,
			en = 22.833
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
				arg_245_0:Play114182060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_248_0 = 0
			local var_248_1 = 1.625

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(114182059)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 65 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 65)

				if (65 <= 0 and var_248_1 or var_248_1 * (utf8.len(var_248_3) / 65)) > 0 and var_248_1 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182059", "story_v_out_114182.awb") ~= 0 then
					local var_248_6 = manager.audio:GetVoiceLength("story_v_out_114182", "114182059", "story_v_out_114182.awb") / 1000

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end

					if var_248_2.prefab_name ~= "" and arg_245_1.actors_[var_248_2.prefab_name] ~= nil then
						local var_248_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_2.prefab_name].transform, "story_v_out_114182", "114182059", "story_v_out_114182.awb")

						arg_245_1:RecordAudio("114182059", var_248_7)
						arg_245_1:RecordAudio("114182059", var_248_7)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_114182", "114182059", "story_v_out_114182.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_114182", "114182059", "story_v_out_114182.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_8 and arg_245_1.time_ < var_248_0 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play114182060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 114182060
		arg_249_1.duration_ = 2.53

		local var_249_0 = {
			ja = 2.533,
			ko = 1.733,
			zh = 1.566,
			en = 1.833
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
				arg_249_0:Play114182061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1042ui_story"]) and arg_249_1.var_.characterEffect1042ui_story == nil then
				arg_249_1.var_.characterEffect1042ui_story = arg_249_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1042ui_story"]) then
				if arg_249_1.var_.characterEffect1042ui_story and not isNil(arg_249_1.actors_["1042ui_story"]) then
					arg_249_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1042ui_story"]) and arg_249_1.var_.characterEffect1042ui_story then
				arg_249_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.125

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:GetWordFromCfg(114182060)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 5 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 5)

				if (5 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_4) / 5)) > 0 and var_252_2 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182060", "story_v_out_114182.awb") ~= 0 then
					local var_252_7 = manager.audio:GetVoiceLength("story_v_out_114182", "114182060", "story_v_out_114182.awb") / 1000

					if var_252_7 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_1
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_114182", "114182060", "story_v_out_114182.awb")

						arg_249_1:RecordAudio("114182060", var_252_8)
						arg_249_1:RecordAudio("114182060", var_252_8)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_114182", "114182060", "story_v_out_114182.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_114182", "114182060", "story_v_out_114182.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_9 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_9 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_9

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_9 and arg_249_1.time_ < var_252_1 + var_252_9 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play114182061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 114182061
		arg_253_1.duration_ = 2

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play114182062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_256_0 = arg_253_1.actors_["1042ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1042ui_story == nil then
				arg_253_1.var_.characterEffect1042ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_1 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_1 and not isNil(var_256_0) then
				if arg_253_1.var_.characterEffect1042ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_1 and arg_253_1.time_ < 0 + var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect1042ui_story then
				arg_253_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_256_3 = 0
			local var_256_4 = 0.075

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:GetWordFromCfg(114182061)
				local var_256_6 = arg_253_1:FormatText(var_256_5.content)

				arg_253_1.text_.text = var_256_6

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_8 = 3 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_6) / 3)

				if (3 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_6) / 3)) > 0 and var_256_4 < var_256_8 then
					arg_253_1.talkMaxDuration = var_256_8

					if var_256_8 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_3
					end
				end

				arg_253_1.text_.text = var_256_6
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182061", "story_v_out_114182.awb") ~= 0 then
					local var_256_9 = manager.audio:GetVoiceLength("story_v_out_114182", "114182061", "story_v_out_114182.awb") / 1000

					if var_256_9 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_3
					end

					if var_256_5.prefab_name ~= "" and arg_253_1.actors_[var_256_5.prefab_name] ~= nil then
						local var_256_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_5.prefab_name].transform, "story_v_out_114182", "114182061", "story_v_out_114182.awb")

						arg_253_1:RecordAudio("114182061", var_256_10)
						arg_253_1:RecordAudio("114182061", var_256_10)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_114182", "114182061", "story_v_out_114182.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_114182", "114182061", "story_v_out_114182.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_11 = math.max(var_256_4, arg_253_1.talkMaxDuration)

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_11 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_3) / var_256_11

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_3 + var_256_11 and arg_253_1.time_ < var_256_3 + var_256_11 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play114182062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 114182062
		arg_257_1.duration_ = 11.07

		local var_257_0 = {
			ja = 8.9,
			ko = 11.066,
			zh = 10.733,
			en = 9.8
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play114182063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1042ui_story = arg_257_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1042ui_story"].transform.position).z)
				arg_257_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1042ui_story"].transform.localEulerAngles = arg_257_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1042ui_story"].transform.position).z)
				arg_257_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1042ui_story"].transform.localEulerAngles = arg_257_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["1041ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1041ui_story = var_260_1.localPosition
			end

			local var_260_2 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 then
				var_260_1.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_2)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 then
				var_260_1.localPosition = Vector3.New(0, 100, 0)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			local var_260_3 = arg_257_1.actors_["1067ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect1067ui_story == nil then
				arg_257_1.var_.characterEffect1067ui_story = var_260_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_4 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 and not isNil(var_260_3) then
				if arg_257_1.var_.characterEffect1067ui_story and not isNil(var_260_3) then
					arg_257_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect1067ui_story then
				arg_257_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_260_6 = arg_257_1.actors_["1067ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1067ui_story = var_260_6.localPosition
			end

			local var_260_7 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				var_260_6.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_257_1.time_ - 0) / var_260_7)
				var_260_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_6.position).x, (manager.ui.mainCamera.transform.position - var_260_6.position).y, (manager.ui.mainCamera.transform.position - var_260_6.position).z)
				var_260_6.localEulerAngles.z = 0
				var_260_6.localEulerAngles.x = 0
				var_260_6.localEulerAngles = var_260_6.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				var_260_6.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_260_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_6.position).x, (manager.ui.mainCamera.transform.position - var_260_6.position).y, (manager.ui.mainCamera.transform.position - var_260_6.position).z)
				var_260_6.localEulerAngles.z = 0
				var_260_6.localEulerAngles.x = 0
				var_260_6.localEulerAngles = var_260_6.localEulerAngles
			end

			local var_260_8 = 0
			local var_260_9 = 1.2

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_10 = arg_257_1:GetWordFromCfg(114182062)
				local var_260_11 = arg_257_1:FormatText(var_260_10.content)

				arg_257_1.text_.text = var_260_11

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 48 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 48)

				if (48 <= 0 and var_260_9 or var_260_9 * (utf8.len(var_260_11) / 48)) > 0 and var_260_9 < var_260_13 then
					arg_257_1.talkMaxDuration = var_260_13

					if var_260_13 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_13 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_11
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182062", "story_v_out_114182.awb") ~= 0 then
					local var_260_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182062", "story_v_out_114182.awb") / 1000

					if var_260_14 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_14 + var_260_8
					end

					if var_260_10.prefab_name ~= "" and arg_257_1.actors_[var_260_10.prefab_name] ~= nil then
						local var_260_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_10.prefab_name].transform, "story_v_out_114182", "114182062", "story_v_out_114182.awb")

						arg_257_1:RecordAudio("114182062", var_260_15)
						arg_257_1:RecordAudio("114182062", var_260_15)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_114182", "114182062", "story_v_out_114182.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_114182", "114182062", "story_v_out_114182.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_16 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_16 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_16

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_16 and arg_257_1.time_ < var_260_8 + var_260_16 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play114182063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 114182063
		arg_261_1.duration_ = 11.13

		local var_261_0 = {
			ja = 11.133,
			ko = 6.033,
			zh = 5.966,
			en = 7.266
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
				arg_261_0:Play114182064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if arg_261_1.actors_["1068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1068ui_story"))) then
				local var_264_0 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_261_1.stage_.transform)

				var_264_0.name = "1068ui_story"
				var_264_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["1068ui_story"] = var_264_0

				local var_264_1 = var_264_0:GetComponentInChildren(typeof(CharacterEffect))

				var_264_1.enabled = true

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_0, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end

				arg_261_1:ShowWeapon(var_264_1.transform, false)

				arg_261_1.var_["1068ui_story" .. "Animator"] = var_264_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_261_1.var_["1068ui_story" .. "Animator"].applyRootMotion = true
				arg_261_1.var_["1068ui_story" .. "LipSync"] = var_264_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_264_3 = arg_261_1.actors_["1068ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect1068ui_story == nil then
				arg_261_1.var_.characterEffect1068ui_story = var_264_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_4 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 and not isNil(var_264_3) then
				if arg_261_1.var_.characterEffect1068ui_story and not isNil(var_264_3) then
					arg_261_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect1068ui_story then
				arg_261_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_264_6 = arg_261_1.actors_["1068ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1068ui_story = var_264_6.localPosition
			end

			local var_264_7 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				var_264_6.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1068ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_261_1.time_ - 0) / var_264_7)
				var_264_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_6.position).x, (manager.ui.mainCamera.transform.position - var_264_6.position).y, (manager.ui.mainCamera.transform.position - var_264_6.position).z)
				var_264_6.localEulerAngles.z = 0
				var_264_6.localEulerAngles.x = 0
				var_264_6.localEulerAngles = var_264_6.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				var_264_6.localPosition = Vector3.New(0.7, -0.95, -5.88)
				var_264_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_6.position).x, (manager.ui.mainCamera.transform.position - var_264_6.position).y, (manager.ui.mainCamera.transform.position - var_264_6.position).z)
				var_264_6.localEulerAngles.z = 0
				var_264_6.localEulerAngles.x = 0
				var_264_6.localEulerAngles = var_264_6.localEulerAngles
			end

			local var_264_8 = arg_261_1.actors_["1067ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.characterEffect1067ui_story == nil then
				arg_261_1.var_.characterEffect1067ui_story = var_264_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_9 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_9 and not isNil(var_264_8) then
				if arg_261_1.var_.characterEffect1067ui_story and not isNil(var_264_8) then
					arg_261_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_9)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_9 and arg_261_1.time_ < 0 + var_264_9 + arg_264_0 and not isNil(var_264_8) and arg_261_1.var_.characterEffect1067ui_story then
				arg_261_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_264_10 = 0
			local var_264_11 = 0.7

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_12 = arg_261_1:GetWordFromCfg(114182063)
				local var_264_13 = arg_261_1:FormatText(var_264_12.content)

				arg_261_1.text_.text = var_264_13

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_15 = 28 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 28)

				if (28 <= 0 and var_264_11 or var_264_11 * (utf8.len(var_264_13) / 28)) > 0 and var_264_11 < var_264_15 then
					arg_261_1.talkMaxDuration = var_264_15

					if var_264_15 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_15 + var_264_10
					end
				end

				arg_261_1.text_.text = var_264_13
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182063", "story_v_out_114182.awb") ~= 0 then
					local var_264_16 = manager.audio:GetVoiceLength("story_v_out_114182", "114182063", "story_v_out_114182.awb") / 1000

					if var_264_16 + var_264_10 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_16 + var_264_10
					end

					if var_264_12.prefab_name ~= "" and arg_261_1.actors_[var_264_12.prefab_name] ~= nil then
						local var_264_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_12.prefab_name].transform, "story_v_out_114182", "114182063", "story_v_out_114182.awb")

						arg_261_1:RecordAudio("114182063", var_264_17)
						arg_261_1:RecordAudio("114182063", var_264_17)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_114182", "114182063", "story_v_out_114182.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_114182", "114182063", "story_v_out_114182.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_18 = math.max(var_264_11, arg_261_1.talkMaxDuration)

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_18 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_10) / var_264_18

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_10 + var_264_18 and arg_261_1.time_ < var_264_10 + var_264_18 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play114182064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 114182064
		arg_265_1.duration_ = 6.8

		local var_265_0 = {
			ja = 4.833,
			ko = 6.8,
			zh = 5.166,
			en = 5.5
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
				arg_265_0:Play114182065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_268_0 = arg_265_1.actors_["1067ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1067ui_story == nil then
				arg_265_1.var_.characterEffect1067ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_1 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 and not isNil(var_268_0) then
				if arg_265_1.var_.characterEffect1067ui_story and not isNil(var_268_0) then
					arg_265_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1067ui_story then
				arg_265_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_268_3 = arg_265_1.actors_["1068ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_3) and arg_265_1.var_.characterEffect1068ui_story == nil then
				arg_265_1.var_.characterEffect1068ui_story = var_268_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_4 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 and not isNil(var_268_3) then
				if arg_265_1.var_.characterEffect1068ui_story and not isNil(var_268_3) then
					arg_265_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_4)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 and not isNil(var_268_3) and arg_265_1.var_.characterEffect1068ui_story then
				arg_265_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_268_5 = 0
			local var_268_6 = 0.425

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:GetWordFromCfg(114182064)
				local var_268_8 = arg_265_1:FormatText(var_268_7.content)

				arg_265_1.text_.text = var_268_8

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 17 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 17)

				if (17 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 17)) > 0 and var_268_6 < var_268_10 then
					arg_265_1.talkMaxDuration = var_268_10

					if var_268_10 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_8
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182064", "story_v_out_114182.awb") ~= 0 then
					local var_268_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182064", "story_v_out_114182.awb") / 1000

					if var_268_11 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_5
					end

					if var_268_7.prefab_name ~= "" and arg_265_1.actors_[var_268_7.prefab_name] ~= nil then
						local var_268_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_7.prefab_name].transform, "story_v_out_114182", "114182064", "story_v_out_114182.awb")

						arg_265_1:RecordAudio("114182064", var_268_12)
						arg_265_1:RecordAudio("114182064", var_268_12)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_114182", "114182064", "story_v_out_114182.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_114182", "114182064", "story_v_out_114182.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_13 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_13 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_13

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_13 and arg_265_1.time_ < var_268_5 + var_268_13 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play114182065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 114182065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play114182066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1067ui_story = arg_269_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1067ui_story"].transform.position).z)
				arg_269_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1067ui_story"].transform.localEulerAngles = arg_269_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1067ui_story"].transform.position).z)
				arg_269_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1067ui_story"].transform.localEulerAngles = arg_269_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1068ui_story"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1068ui_story = var_272_1.localPosition
			end

			local var_272_2 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 then
				var_272_1.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_2)
				var_272_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_1.position).x, (manager.ui.mainCamera.transform.position - var_272_1.position).y, (manager.ui.mainCamera.transform.position - var_272_1.position).z)
				var_272_1.localEulerAngles.z = 0
				var_272_1.localEulerAngles.x = 0
				var_272_1.localEulerAngles = var_272_1.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 then
				var_272_1.localPosition = Vector3.New(0, 100, 0)
				var_272_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_1.position).x, (manager.ui.mainCamera.transform.position - var_272_1.position).y, (manager.ui.mainCamera.transform.position - var_272_1.position).z)
				var_272_1.localEulerAngles.z = 0
				var_272_1.localEulerAngles.x = 0
				var_272_1.localEulerAngles = var_272_1.localEulerAngles
			end

			local var_272_3 = 0
			local var_272_4 = 0.9

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_5 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(114182065).content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 36 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_5) / 36)

				if (36 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_5) / 36)) > 0 and var_272_4 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_3 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_3
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_4, arg_269_1.talkMaxDuration)

			if var_272_3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_3 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_3) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_3 + var_272_8 and arg_269_1.time_ < var_272_3 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play114182066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 114182066
		arg_273_1.duration_ = 13.3

		local var_273_0 = {
			ja = 13.3,
			ko = 8.9,
			zh = 8.9,
			en = 9.866
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
				arg_273_0:Play114182067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1042ui_story = arg_273_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1042ui_story"].transform.position).z)
				arg_273_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1042ui_story"].transform.localEulerAngles = arg_273_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_273_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1042ui_story"].transform.position).z)
				arg_273_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1042ui_story"].transform.localEulerAngles = arg_273_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_276_1 = arg_273_1.actors_["1042ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1042ui_story == nil then
				arg_273_1.var_.characterEffect1042ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1042ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1042ui_story then
				arg_273_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_276_4 = 0
			local var_276_5 = 0.925

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(114182066)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 37 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 37)

				if (37 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 37)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182066", "story_v_out_114182.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182066", "story_v_out_114182.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_114182", "114182066", "story_v_out_114182.awb")

						arg_273_1:RecordAudio("114182066", var_276_11)
						arg_273_1:RecordAudio("114182066", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_114182", "114182066", "story_v_out_114182.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_114182", "114182066", "story_v_out_114182.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play114182067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114182067
		arg_277_1.duration_ = 6.77

		local var_277_0 = {
			ja = 6.766,
			ko = 4.233,
			zh = 4.933,
			en = 5.466
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
				arg_277_0:Play114182068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1041ui_story = arg_277_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1041ui_story"].transform.position).z)
				arg_277_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1041ui_story"].transform.localEulerAngles = arg_277_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.9)
				arg_277_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["1041ui_story"].transform.position).z)
				arg_277_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["1041ui_story"].transform.localEulerAngles = arg_277_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_280_1 = arg_277_1.actors_["1041ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1041ui_story == nil then
				arg_277_1.var_.characterEffect1041ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1041ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1041ui_story then
				arg_277_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_280_4 = arg_277_1.actors_["1042ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1042ui_story == nil then
				arg_277_1.var_.characterEffect1042ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_5 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 and not isNil(var_280_4) then
				if arg_277_1.var_.characterEffect1042ui_story and not isNil(var_280_4) then
					arg_277_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_5)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1042ui_story then
				arg_277_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_280_6 = 0
			local var_280_7 = 0.55

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(114182067)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 22 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 22)

				if (22 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 22)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182067", "story_v_out_114182.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_114182", "114182067", "story_v_out_114182.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_114182", "114182067", "story_v_out_114182.awb")

						arg_277_1:RecordAudio("114182067", var_280_13)
						arg_277_1:RecordAudio("114182067", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_114182", "114182067", "story_v_out_114182.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_114182", "114182067", "story_v_out_114182.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play114182068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114182068
		arg_281_1.duration_ = 9.87

		local var_281_0 = {
			ja = 9.866,
			ko = 5.1,
			zh = 4.133,
			en = 7.5
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
				arg_281_0:Play114182069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_284_0 = arg_281_1.actors_["1042ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1042ui_story == nil then
				arg_281_1.var_.characterEffect1042ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_1 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 and not isNil(var_284_0) then
				if arg_281_1.var_.characterEffect1042ui_story and not isNil(var_284_0) then
					arg_281_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1042ui_story then
				arg_281_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_284_3 = arg_281_1.actors_["1041ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1041ui_story == nil then
				arg_281_1.var_.characterEffect1041ui_story = var_284_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_4 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 and not isNil(var_284_3) then
				if arg_281_1.var_.characterEffect1041ui_story and not isNil(var_284_3) then
					arg_281_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_4)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1041ui_story then
				arg_281_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_284_5 = 0
			local var_284_6 = 0.55

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(114182068)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 22 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 22)

				if (22 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 22)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182068", "story_v_out_114182.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182068", "story_v_out_114182.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_114182", "114182068", "story_v_out_114182.awb")

						arg_281_1:RecordAudio("114182068", var_284_12)
						arg_281_1:RecordAudio("114182068", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_114182", "114182068", "story_v_out_114182.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_114182", "114182068", "story_v_out_114182.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_13 and arg_281_1.time_ < var_284_5 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play114182069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 114182069
		arg_285_1.duration_ = 4.67

		local var_285_0 = {
			ja = 4.666,
			ko = 2.633,
			zh = 3.8,
			en = 3.233
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
				arg_285_0:Play114182070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10006ui_story = arg_285_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10006ui_story"].transform.position).z)
				arg_285_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10006ui_story"].transform.localEulerAngles = arg_285_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -5.65)
				arg_285_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["10006ui_story"].transform.position).z)
				arg_285_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["10006ui_story"].transform.localEulerAngles = arg_285_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_288_1 = arg_285_1.actors_["10006ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10006ui_story == nil then
				arg_285_1.var_.characterEffect10006ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect10006ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10006ui_story then
				arg_285_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["1041ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1041ui_story = var_288_4.localPosition
			end

			local var_288_5 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_5 then
				var_288_4.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_5)
				var_288_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_4.position).x, (manager.ui.mainCamera.transform.position - var_288_4.position).y, (manager.ui.mainCamera.transform.position - var_288_4.position).z)
				var_288_4.localEulerAngles.z = 0
				var_288_4.localEulerAngles.x = 0
				var_288_4.localEulerAngles = var_288_4.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_5 and arg_285_1.time_ < 0 + var_288_5 + arg_288_0 then
				var_288_4.localPosition = Vector3.New(0, 100, 0)
				var_288_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_4.position).x, (manager.ui.mainCamera.transform.position - var_288_4.position).y, (manager.ui.mainCamera.transform.position - var_288_4.position).z)
				var_288_4.localEulerAngles.z = 0
				var_288_4.localEulerAngles.x = 0
				var_288_4.localEulerAngles = var_288_4.localEulerAngles
			end

			local var_288_6 = arg_285_1.actors_["1042ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect1042ui_story == nil then
				arg_285_1.var_.characterEffect1042ui_story = var_288_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_7 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 and not isNil(var_288_6) then
				if arg_285_1.var_.characterEffect1042ui_story and not isNil(var_288_6) then
					arg_285_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_7)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 and not isNil(var_288_6) and arg_285_1.var_.characterEffect1042ui_story then
				arg_285_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_288_8 = 0
			local var_288_9 = 0.225

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(114182069)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 9 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 9)

				if (9 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 9)) > 0 and var_288_9 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182069", "story_v_out_114182.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_out_114182", "114182069", "story_v_out_114182.awb") / 1000

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_out_114182", "114182069", "story_v_out_114182.awb")

						arg_285_1:RecordAudio("114182069", var_288_15)
						arg_285_1:RecordAudio("114182069", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_114182", "114182069", "story_v_out_114182.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_114182", "114182069", "story_v_out_114182.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_16 and arg_285_1.time_ < var_288_8 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
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

		arg_285_1:InitPlayNodeList()
	end,
	Play114182070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 114182070
		arg_289_1.duration_ = 7.4

		local var_289_0 = {
			ja = 7.4,
			ko = 4.566,
			zh = 4.766,
			en = 3.733
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
				arg_289_0:Play114182071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1042ui_story"]) and arg_289_1.var_.characterEffect1042ui_story == nil then
				arg_289_1.var_.characterEffect1042ui_story = arg_289_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1042ui_story"]) then
				if arg_289_1.var_.characterEffect1042ui_story and not isNil(arg_289_1.actors_["1042ui_story"]) then
					arg_289_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1042ui_story"]) and arg_289_1.var_.characterEffect1042ui_story then
				arg_289_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_292_2 = arg_289_1.actors_["10006ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect10006ui_story == nil then
				arg_289_1.var_.characterEffect10006ui_story = var_292_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.characterEffect10006ui_story and not isNil(var_292_2) then
					arg_289_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_3)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect10006ui_story then
				arg_289_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_292_4 = 0
			local var_292_5 = 0.55

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(114182070)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 22 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 22)

				if (22 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 22)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182070", "story_v_out_114182.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182070", "story_v_out_114182.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_114182", "114182070", "story_v_out_114182.awb")

						arg_289_1:RecordAudio("114182070", var_292_11)
						arg_289_1:RecordAudio("114182070", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_114182", "114182070", "story_v_out_114182.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_114182", "114182070", "story_v_out_114182.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play114182071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 114182071
		arg_293_1.duration_ = 4.47

		local var_293_0 = {
			ja = 1.999999999999,
			ko = 4.466,
			zh = 4.033,
			en = 3.666
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
				arg_293_0:Play114182072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_296_0 = arg_293_1.actors_["10006ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect10006ui_story == nil then
				arg_293_1.var_.characterEffect10006ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_1 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_1 and not isNil(var_296_0) then
				if arg_293_1.var_.characterEffect10006ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_1 and arg_293_1.time_ < 0 + var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect10006ui_story then
				arg_293_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_296_3 = arg_293_1.actors_["1042ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_3) and arg_293_1.var_.characterEffect1042ui_story == nil then
				arg_293_1.var_.characterEffect1042ui_story = var_296_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_4 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 and not isNil(var_296_3) then
				if arg_293_1.var_.characterEffect1042ui_story and not isNil(var_296_3) then
					arg_293_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_4)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 and not isNil(var_296_3) and arg_293_1.var_.characterEffect1042ui_story then
				arg_293_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_296_5 = 0
			local var_296_6 = 0.35

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(114182071)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 14 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 14)

				if (14 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 14)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182071", "story_v_out_114182.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182071", "story_v_out_114182.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_114182", "114182071", "story_v_out_114182.awb")

						arg_293_1:RecordAudio("114182071", var_296_12)
						arg_293_1:RecordAudio("114182071", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_114182", "114182071", "story_v_out_114182.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_114182", "114182071", "story_v_out_114182.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_13 and arg_293_1.time_ < var_296_5 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play114182072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 114182072
		arg_297_1.duration_ = 18.57

		local var_297_0 = {
			ja = 18.566,
			ko = 13.5,
			zh = 14.033,
			en = 15.833
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play114182073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1042ui_story"]) and arg_297_1.var_.characterEffect1042ui_story == nil then
				arg_297_1.var_.characterEffect1042ui_story = arg_297_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1042ui_story"]) then
				if arg_297_1.var_.characterEffect1042ui_story and not isNil(arg_297_1.actors_["1042ui_story"]) then
					arg_297_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1042ui_story"]) and arg_297_1.var_.characterEffect1042ui_story then
				arg_297_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_300_2 = arg_297_1.actors_["10006ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect10006ui_story == nil then
				arg_297_1.var_.characterEffect10006ui_story = var_300_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.characterEffect10006ui_story and not isNil(var_300_2) then
					arg_297_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_3)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect10006ui_story then
				arg_297_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_300_4 = 0
			local var_300_5 = 1.5

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(114182072)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 60 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 60)

				if (60 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 60)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182072", "story_v_out_114182.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182072", "story_v_out_114182.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_114182", "114182072", "story_v_out_114182.awb")

						arg_297_1:RecordAudio("114182072", var_300_11)
						arg_297_1:RecordAudio("114182072", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_114182", "114182072", "story_v_out_114182.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_114182", "114182072", "story_v_out_114182.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play114182073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 114182073
		arg_301_1.duration_ = 7.4

		local var_301_0 = {
			ja = 6.666,
			ko = 4.833,
			zh = 5.333,
			en = 7.4
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
				arg_301_0:Play114182074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_304_0 = 0
			local var_304_1 = 0.6

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(114182073)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 24 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 24)

				if (24 <= 0 and var_304_1 or var_304_1 * (utf8.len(var_304_3) / 24)) > 0 and var_304_1 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182073", "story_v_out_114182.awb") ~= 0 then
					local var_304_6 = manager.audio:GetVoiceLength("story_v_out_114182", "114182073", "story_v_out_114182.awb") / 1000

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end

					if var_304_2.prefab_name ~= "" and arg_301_1.actors_[var_304_2.prefab_name] ~= nil then
						local var_304_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_2.prefab_name].transform, "story_v_out_114182", "114182073", "story_v_out_114182.awb")

						arg_301_1:RecordAudio("114182073", var_304_7)
						arg_301_1:RecordAudio("114182073", var_304_7)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_114182", "114182073", "story_v_out_114182.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_114182", "114182073", "story_v_out_114182.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play114182074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 114182074
		arg_305_1.duration_ = 2

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play114182075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_2")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_308_0 = arg_305_1.actors_["10006ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect10006ui_story == nil then
				arg_305_1.var_.characterEffect10006ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_1 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_1 and not isNil(var_308_0) then
				if arg_305_1.var_.characterEffect10006ui_story and not isNil(var_308_0) then
					arg_305_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_1 and arg_305_1.time_ < 0 + var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect10006ui_story then
				arg_305_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_308_3 = arg_305_1.actors_["1042ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_3) and arg_305_1.var_.characterEffect1042ui_story == nil then
				arg_305_1.var_.characterEffect1042ui_story = var_308_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_4 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 and not isNil(var_308_3) then
				if arg_305_1.var_.characterEffect1042ui_story and not isNil(var_308_3) then
					arg_305_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_4)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 and not isNil(var_308_3) and arg_305_1.var_.characterEffect1042ui_story then
				arg_305_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_308_5 = 0
			local var_308_6 = 0.075

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_7 = arg_305_1:GetWordFromCfg(114182074)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 3 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 3)

				if (3 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 3)) > 0 and var_308_6 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182074", "story_v_out_114182.awb") ~= 0 then
					local var_308_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182074", "story_v_out_114182.awb") / 1000

					if var_308_11 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_5
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_114182", "114182074", "story_v_out_114182.awb")

						arg_305_1:RecordAudio("114182074", var_308_12)
						arg_305_1:RecordAudio("114182074", var_308_12)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_114182", "114182074", "story_v_out_114182.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_114182", "114182074", "story_v_out_114182.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_13 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_13 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_13

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_13 and arg_305_1.time_ < var_308_5 + var_308_13 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play114182075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 114182075
		arg_309_1.duration_ = 8.37

		local var_309_0 = {
			ja = 7.4,
			ko = 6.8,
			zh = 7.066,
			en = 8.366
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
				arg_309_0:Play114182076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1042ui_story"]) and arg_309_1.var_.characterEffect1042ui_story == nil then
				arg_309_1.var_.characterEffect1042ui_story = arg_309_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1042ui_story"]) then
				if arg_309_1.var_.characterEffect1042ui_story and not isNil(arg_309_1.actors_["1042ui_story"]) then
					arg_309_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1042ui_story"]) and arg_309_1.var_.characterEffect1042ui_story then
				arg_309_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_312_2 = arg_309_1.actors_["10006ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect10006ui_story == nil then
				arg_309_1.var_.characterEffect10006ui_story = var_312_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_3 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.characterEffect10006ui_story and not isNil(var_312_2) then
					arg_309_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_3)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect10006ui_story then
				arg_309_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_312_4 = 0
			local var_312_5 = 0.625

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(114182075)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 25 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 25)

				if (25 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 25)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182075", "story_v_out_114182.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182075", "story_v_out_114182.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_114182", "114182075", "story_v_out_114182.awb")

						arg_309_1:RecordAudio("114182075", var_312_11)
						arg_309_1:RecordAudio("114182075", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_114182", "114182075", "story_v_out_114182.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_114182", "114182075", "story_v_out_114182.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play114182076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 114182076
		arg_313_1.duration_ = 2.37

		local var_313_0 = {
			ja = 2.366,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play114182077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_316_0 = arg_313_1.actors_["10006ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10006ui_story == nil then
				arg_313_1.var_.characterEffect10006ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_1 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 and not isNil(var_316_0) then
				if arg_313_1.var_.characterEffect10006ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10006ui_story then
				arg_313_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_316_3 = arg_313_1.actors_["1042ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect1042ui_story == nil then
				arg_313_1.var_.characterEffect1042ui_story = var_316_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_4 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 and not isNil(var_316_3) then
				if arg_313_1.var_.characterEffect1042ui_story and not isNil(var_316_3) then
					arg_313_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_4)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 and not isNil(var_316_3) and arg_313_1.var_.characterEffect1042ui_story then
				arg_313_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_316_5 = 0
			local var_316_6 = 0.1

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_7 = arg_313_1:GetWordFromCfg(114182076)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 4 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 4)

				if (4 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 4)) > 0 and var_316_6 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182076", "story_v_out_114182.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_114182", "114182076", "story_v_out_114182.awb") / 1000

					if var_316_11 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_5
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_114182", "114182076", "story_v_out_114182.awb")

						arg_313_1:RecordAudio("114182076", var_316_12)
						arg_313_1:RecordAudio("114182076", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_114182", "114182076", "story_v_out_114182.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_114182", "114182076", "story_v_out_114182.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_6, arg_313_1.talkMaxDuration)

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_5) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_5 + var_316_13 and arg_313_1.time_ < var_316_5 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play114182077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 114182077
		arg_317_1.duration_ = 10.5

		local var_317_0 = {
			ja = 4.466,
			ko = 7.166,
			zh = 7.566,
			en = 10.5
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
				arg_317_0:Play114182078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10006ui_story"]) and arg_317_1.var_.characterEffect10006ui_story == nil then
				arg_317_1.var_.characterEffect10006ui_story = arg_317_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10006ui_story"]) then
				if arg_317_1.var_.characterEffect10006ui_story and not isNil(arg_317_1.actors_["10006ui_story"]) then
					arg_317_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10006ui_story"]) and arg_317_1.var_.characterEffect10006ui_story then
				arg_317_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.8

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:GetWordFromCfg(114182077)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_6 = 32 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_4) / 32)

				if (32 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_4) / 32)) > 0 and var_320_2 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182077", "story_v_out_114182.awb") ~= 0 then
					local var_320_7 = manager.audio:GetVoiceLength("story_v_out_114182", "114182077", "story_v_out_114182.awb") / 1000

					if var_320_7 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_1
					end

					if var_320_3.prefab_name ~= "" and arg_317_1.actors_[var_320_3.prefab_name] ~= nil then
						local var_320_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_3.prefab_name].transform, "story_v_out_114182", "114182077", "story_v_out_114182.awb")

						arg_317_1:RecordAudio("114182077", var_320_8)
						arg_317_1:RecordAudio("114182077", var_320_8)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_114182", "114182077", "story_v_out_114182.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_114182", "114182077", "story_v_out_114182.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_9 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_9 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_9

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_9 and arg_317_1.time_ < var_320_1 + var_320_9 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play114182078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 114182078
		arg_321_1.duration_ = 10.47

		local var_321_0 = {
			ja = 9.566,
			ko = 9.8,
			zh = 10.466,
			en = 10.1
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
				arg_321_0:Play114182079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_324_0 = arg_321_1.actors_["10006ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10006ui_story == nil then
				arg_321_1.var_.characterEffect10006ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_1 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_1 and not isNil(var_324_0) then
				if arg_321_1.var_.characterEffect10006ui_story and not isNil(var_324_0) then
					arg_321_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_1 and arg_321_1.time_ < 0 + var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect10006ui_story then
				arg_321_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_324_3 = 0
			local var_324_4 = 0.9

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_5 = arg_321_1:GetWordFromCfg(114182078)
				local var_324_6 = arg_321_1:FormatText(var_324_5.content)

				arg_321_1.text_.text = var_324_6

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_8 = 36 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_6) / 36)

				if (36 <= 0 and var_324_4 or var_324_4 * (utf8.len(var_324_6) / 36)) > 0 and var_324_4 < var_324_8 then
					arg_321_1.talkMaxDuration = var_324_8

					if var_324_8 + var_324_3 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_3
					end
				end

				arg_321_1.text_.text = var_324_6
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182078", "story_v_out_114182.awb") ~= 0 then
					local var_324_9 = manager.audio:GetVoiceLength("story_v_out_114182", "114182078", "story_v_out_114182.awb") / 1000

					if var_324_9 + var_324_3 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_3
					end

					if var_324_5.prefab_name ~= "" and arg_321_1.actors_[var_324_5.prefab_name] ~= nil then
						local var_324_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_5.prefab_name].transform, "story_v_out_114182", "114182078", "story_v_out_114182.awb")

						arg_321_1:RecordAudio("114182078", var_324_10)
						arg_321_1:RecordAudio("114182078", var_324_10)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_114182", "114182078", "story_v_out_114182.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_114182", "114182078", "story_v_out_114182.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_11 = math.max(var_324_4, arg_321_1.talkMaxDuration)

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_11 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_3) / var_324_11

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_3 + var_324_11 and arg_321_1.time_ < var_324_3 + var_324_11 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play114182079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 114182079
		arg_325_1.duration_ = 10.07

		local var_325_0 = {
			ja = 10.066,
			ko = 5.833,
			zh = 5.366,
			en = 7.933
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play114182080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10006ui_story"]) and arg_325_1.var_.characterEffect10006ui_story == nil then
				arg_325_1.var_.characterEffect10006ui_story = arg_325_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10006ui_story"]) then
				if arg_325_1.var_.characterEffect10006ui_story and not isNil(arg_325_1.actors_["10006ui_story"]) then
					arg_325_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10006ui_story"]) and arg_325_1.var_.characterEffect10006ui_story then
				arg_325_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_328_1 = arg_325_1.actors_["1042ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1042ui_story == nil then
				arg_325_1.var_.characterEffect1042ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1042ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1042ui_story then
				arg_325_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_328_4 = 0
			local var_328_5 = 0.525

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(114182079)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 21 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 21)

				if (21 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 21)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182079", "story_v_out_114182.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182079", "story_v_out_114182.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_out_114182", "114182079", "story_v_out_114182.awb")

						arg_325_1:RecordAudio("114182079", var_328_11)
						arg_325_1:RecordAudio("114182079", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_114182", "114182079", "story_v_out_114182.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_114182", "114182079", "story_v_out_114182.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play114182080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 114182080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play114182081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1042ui_story = arg_329_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1042ui_story"].transform.position).z)
				arg_329_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1042ui_story"].transform.localEulerAngles = arg_329_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1042ui_story"].transform.position).z)
				arg_329_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1042ui_story"].transform.localEulerAngles = arg_329_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["10006ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos10006ui_story = var_332_1.localPosition
			end

			local var_332_2 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 then
				var_332_1.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_2)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 then
				var_332_1.localPosition = Vector3.New(0, 100, 0)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			local var_332_3 = 0
			local var_332_4 = 0.65

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_3 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_5 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(114182080).content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 26 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_5) / 26)

				if (26 <= 0 and var_332_4 or var_332_4 * (utf8.len(var_332_5) / 26)) > 0 and var_332_4 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_3 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_3
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_4, arg_329_1.talkMaxDuration)

			if var_332_3 <= arg_329_1.time_ and arg_329_1.time_ < var_332_3 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_3) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_3 + var_332_8 and arg_329_1.time_ < var_332_3 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play114182081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 114182081
		arg_333_1.duration_ = 11.4

		local var_333_0 = {
			ja = 11.4,
			ko = 7.666,
			zh = 5.7,
			en = 8.3
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
				arg_333_0:Play114182082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1042ui_story = arg_333_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1042ui_story"].transform.position).z)
				arg_333_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1042ui_story"].transform.localEulerAngles = arg_333_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_333_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1042ui_story"].transform.position).z)
				arg_333_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1042ui_story"].transform.localEulerAngles = arg_333_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_336_1 = arg_333_1.actors_["1042ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1042ui_story == nil then
				arg_333_1.var_.characterEffect1042ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1042ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1042ui_story then
				arg_333_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_336_4 = 0
			local var_336_5 = 0.7

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(114182081)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 28 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 28)

				if (28 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 28)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182081", "story_v_out_114182.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182081", "story_v_out_114182.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_114182", "114182081", "story_v_out_114182.awb")

						arg_333_1:RecordAudio("114182081", var_336_11)
						arg_333_1:RecordAudio("114182081", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_114182", "114182081", "story_v_out_114182.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_114182", "114182081", "story_v_out_114182.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play114182082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 114182082
		arg_337_1.duration_ = 3.13

		local var_337_0 = {
			ja = 2.9,
			ko = 2.3,
			zh = 2.766,
			en = 3.133
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
				arg_337_0:Play114182083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10006ui_story = arg_337_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10006ui_story"].transform.position).z)
				arg_337_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10006ui_story"].transform.localEulerAngles = arg_337_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -5.65)
				arg_337_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["10006ui_story"].transform.position).z)
				arg_337_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["10006ui_story"].transform.localEulerAngles = arg_337_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_340_1 = arg_337_1.actors_["10006ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect10006ui_story == nil then
				arg_337_1.var_.characterEffect10006ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect10006ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect10006ui_story then
				arg_337_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_340_4 = arg_337_1.actors_["1042ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1042ui_story == nil then
				arg_337_1.var_.characterEffect1042ui_story = var_340_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_5 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_5 and not isNil(var_340_4) then
				if arg_337_1.var_.characterEffect1042ui_story and not isNil(var_340_4) then
					arg_337_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_5)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_5 and arg_337_1.time_ < 0 + var_340_5 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1042ui_story then
				arg_337_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_340_6 = 0
			local var_340_7 = 0.125

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_8 = arg_337_1:GetWordFromCfg(114182082)
				local var_340_9 = arg_337_1:FormatText(var_340_8.content)

				arg_337_1.text_.text = var_340_9

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 5 <= 0 and var_340_7 or var_340_7 * (utf8.len(var_340_9) / 5)

				if (5 <= 0 and var_340_7 or var_340_7 * (utf8.len(var_340_9) / 5)) > 0 and var_340_7 < var_340_11 then
					arg_337_1.talkMaxDuration = var_340_11

					if var_340_11 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_11 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_9
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182082", "story_v_out_114182.awb") ~= 0 then
					local var_340_12 = manager.audio:GetVoiceLength("story_v_out_114182", "114182082", "story_v_out_114182.awb") / 1000

					if var_340_12 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_12 + var_340_6
					end

					if var_340_8.prefab_name ~= "" and arg_337_1.actors_[var_340_8.prefab_name] ~= nil then
						local var_340_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_8.prefab_name].transform, "story_v_out_114182", "114182082", "story_v_out_114182.awb")

						arg_337_1:RecordAudio("114182082", var_340_13)
						arg_337_1:RecordAudio("114182082", var_340_13)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_114182", "114182082", "story_v_out_114182.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_114182", "114182082", "story_v_out_114182.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play114182083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 114182083
		arg_341_1.duration_ = 7.27

		local var_341_0 = {
			ja = 7.266,
			ko = 4.6,
			zh = 3.9,
			en = 4.766
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
			arg_341_1.auto_ = false
		end

		function arg_341_1.playNext_(arg_343_0)
			arg_341_1.onStoryFinished_()
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["10006ui_story"]) and arg_341_1.var_.characterEffect10006ui_story == nil then
				arg_341_1.var_.characterEffect10006ui_story = arg_341_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["10006ui_story"]) then
				if arg_341_1.var_.characterEffect10006ui_story and not isNil(arg_341_1.actors_["10006ui_story"]) then
					arg_341_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_0)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["10006ui_story"]) and arg_341_1.var_.characterEffect10006ui_story then
				arg_341_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_344_1 = arg_341_1.actors_["1042ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1042ui_story == nil then
				arg_341_1.var_.characterEffect1042ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1042ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1042ui_story then
				arg_341_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_344_4 = 0
			local var_344_5 = 0.45

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(114182083)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 18 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 18)

				if (18 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 18)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114182", "114182083", "story_v_out_114182.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_114182", "114182083", "story_v_out_114182.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_114182", "114182083", "story_v_out_114182.awb")

						arg_341_1:RecordAudio("114182083", var_344_11)
						arg_341_1:RecordAudio("114182083", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_114182", "114182083", "story_v_out_114182.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_114182", "114182083", "story_v_out_114182.awb")
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
	assets = {
		"TextureConfig/Background/F06",
		"TextureConfig/Background/F04",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_114182.awb"
	}
}
