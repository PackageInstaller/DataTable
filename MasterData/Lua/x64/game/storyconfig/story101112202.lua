return {
	Play111222001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111222001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111222002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A07a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A07a")
				var_4_0.name = "A07a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A07a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A07a

				arg_1_1.bgs_.A07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.A07a:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueA07a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueA07a = var_4_4
				end

				arg_1_1.var_.alphaOldValueA07a = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueA07a then
					arg_1_1.var_.alphaMatValueA07a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueA07a, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueA07a.color = arg_1_1.var_.alphaMatValueA07a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueA07a then
				arg_1_1.var_.alphaMatValueA07a.color.a = 1
				arg_1_1.var_.alphaMatValueA07a.color = arg_1_1.var_.alphaMatValueA07a.color
			end

			local var_4_6 = manager.ui.mainCamera.transform

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_6.localPosition
			end

			local var_4_7 = 0.6

			if 1.2 <= arg_1_1.time_ and arg_1_1.time_ < 1.2 + var_4_7 then
				local var_4_8, var_4_9 = math.modf((arg_1_1.time_ - 1.2) / 0.066)

				var_4_6.localPosition = Vector3.New(var_4_9 * 0.13, var_4_9 * 0.13, var_4_9 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1.2 + var_4_7 and arg_1_1.time_ < 1.2 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_10 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_10 + 2 and arg_1_1.time_ < var_4_10 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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
			local var_4_15 = 0.9

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(111222001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 36 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 36)

				if (36 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 36)) > 0 and var_4_15 < var_4_19 then
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
	Play111222002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111222002
		arg_8_1.duration_ = 4.1

		local var_8_0 = {
			ja = 3.9,
			ko = 4.1,
			zh = 3.366,
			en = 3.666
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
				arg_8_0:Play111222003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1096ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1096ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1096ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1096ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1096ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1096ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1096ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1096ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1096ui_story == nil then
				arg_8_1.var_.characterEffect1096ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1096ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1096ui_story then
				arg_8_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_6 = arg_8_1.actors_["1096ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1096ui_story = var_11_6.localPosition
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(0, -1.13, -5.6)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			local var_11_8 = 0
			local var_11_9 = 0.425

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(111222002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 17 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 17)

				if (17 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 17)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222002", "story_v_out_111222.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_111222", "111222002", "story_v_out_111222.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_111222", "111222002", "story_v_out_111222.awb")

						arg_8_1:RecordAudio("111222002", var_11_15)
						arg_8_1:RecordAudio("111222002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_111222", "111222002", "story_v_out_111222.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_111222", "111222002", "story_v_out_111222.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play111222003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111222003
		arg_12_1.duration_ = 9.4

		local var_12_0 = {
			ja = 4.6,
			ko = 9.4,
			zh = 6.966,
			en = 6.4
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
				arg_12_0:Play111222004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1096ui_story"]) and arg_12_1.var_.characterEffect1096ui_story == nil then
				arg_12_1.var_.characterEffect1096ui_story = arg_12_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1096ui_story"]) then
				if arg_12_1.var_.characterEffect1096ui_story and not isNil(arg_12_1.actors_["1096ui_story"]) then
					arg_12_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1096ui_story"]) and arg_12_1.var_.characterEffect1096ui_story then
				arg_12_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 1.05

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(111222003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_6 = 38 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_4) / 38)

				if (38 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_4) / 38)) > 0 and var_15_2 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222003", "story_v_out_111222.awb") ~= 0 then
					local var_15_7 = manager.audio:GetVoiceLength("story_v_out_111222", "111222003", "story_v_out_111222.awb") / 1000

					if var_15_7 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_1
					end

					if var_15_3.prefab_name ~= "" and arg_12_1.actors_[var_15_3.prefab_name] ~= nil then
						local var_15_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_3.prefab_name].transform, "story_v_out_111222", "111222003", "story_v_out_111222.awb")

						arg_12_1:RecordAudio("111222003", var_15_8)
						arg_12_1:RecordAudio("111222003", var_15_8)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_111222", "111222003", "story_v_out_111222.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_111222", "111222003", "story_v_out_111222.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_9 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_9 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_9

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_9 and arg_12_1.time_ < var_15_1 + var_15_9 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play111222004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111222004
		arg_16_1.duration_ = 11

		local var_16_0 = {
			ja = 8.133,
			ko = 11,
			zh = 8.3,
			en = 8.066
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
				arg_16_0:Play111222005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.125

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(111222004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 45 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 45)

				if (45 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 45)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222004", "story_v_out_111222.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_111222", "111222004", "story_v_out_111222.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_111222", "111222004", "story_v_out_111222.awb")

						arg_16_1:RecordAudio("111222004", var_19_6)
						arg_16_1:RecordAudio("111222004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111222", "111222004", "story_v_out_111222.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111222", "111222004", "story_v_out_111222.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play111222005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 111222005
		arg_20_1.duration_ = 5.17

		local var_20_0 = {
			ja = 4.833,
			ko = 5.166,
			zh = 4.333,
			en = 3.566
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
				arg_20_0:Play111222006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1096ui_story"]) and arg_20_1.var_.characterEffect1096ui_story == nil then
				arg_20_1.var_.characterEffect1096ui_story = arg_20_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1096ui_story"]) then
				if arg_20_1.var_.characterEffect1096ui_story and not isNil(arg_20_1.actors_["1096ui_story"]) then
					arg_20_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1096ui_story"]) and arg_20_1.var_.characterEffect1096ui_story then
				arg_20_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action4_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_23_2 = 0
			local var_23_3 = 0.65

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(111222005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 22 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 22)

				if (22 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 22)) > 0 and var_23_3 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222005", "story_v_out_111222.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_111222", "111222005", "story_v_out_111222.awb") / 1000

					if var_23_8 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_2
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_111222", "111222005", "story_v_out_111222.awb")

						arg_20_1:RecordAudio("111222005", var_23_9)
						arg_20_1:RecordAudio("111222005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_111222", "111222005", "story_v_out_111222.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_111222", "111222005", "story_v_out_111222.awb")
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
	Play111222006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 111222006
		arg_24_1.duration_ = 2.7

		local var_24_0 = {
			ja = 2.2,
			ko = 2.333,
			zh = 1.999999999999,
			en = 2.7
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
				arg_24_0:Play111222007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_0 = 0
			local var_27_1 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(111222006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 11 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 11)

				if (11 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 11)) > 0 and var_27_1 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222006", "story_v_out_111222.awb") ~= 0 then
					local var_27_6 = manager.audio:GetVoiceLength("story_v_out_111222", "111222006", "story_v_out_111222.awb") / 1000

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end

					if var_27_2.prefab_name ~= "" and arg_24_1.actors_[var_27_2.prefab_name] ~= nil then
						local var_27_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_2.prefab_name].transform, "story_v_out_111222", "111222006", "story_v_out_111222.awb")

						arg_24_1:RecordAudio("111222006", var_27_7)
						arg_24_1:RecordAudio("111222006", var_27_7)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_111222", "111222006", "story_v_out_111222.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_111222", "111222006", "story_v_out_111222.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play111222007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 111222007
		arg_28_1.duration_ = 5.73

		local var_28_0 = {
			ja = 3.4,
			ko = 5.733,
			zh = 4.4,
			en = 4.533
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
				arg_28_0:Play111222008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1096ui_story"]) and arg_28_1.var_.characterEffect1096ui_story == nil then
				arg_28_1.var_.characterEffect1096ui_story = arg_28_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1096ui_story"]) then
				if arg_28_1.var_.characterEffect1096ui_story and not isNil(arg_28_1.actors_["1096ui_story"]) then
					arg_28_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1096ui_story"]) and arg_28_1.var_.characterEffect1096ui_story then
				arg_28_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.6

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(111222007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 24 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 24)

				if (24 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 24)) > 0 and var_31_2 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222007", "story_v_out_111222.awb") ~= 0 then
					local var_31_7 = manager.audio:GetVoiceLength("story_v_out_111222", "111222007", "story_v_out_111222.awb") / 1000

					if var_31_7 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_1
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_111222", "111222007", "story_v_out_111222.awb")

						arg_28_1:RecordAudio("111222007", var_31_8)
						arg_28_1:RecordAudio("111222007", var_31_8)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_111222", "111222007", "story_v_out_111222.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_111222", "111222007", "story_v_out_111222.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_9 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_9

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_9 and arg_28_1.time_ < var_31_1 + var_31_9 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play111222008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 111222008
		arg_32_1.duration_ = 10.33

		local var_32_0 = {
			ja = 10.333,
			ko = 9.866,
			zh = 8.7,
			en = 8.533
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
				arg_32_0:Play111222009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.25

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:GetWordFromCfg(111222008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 50 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 50)

				if (50 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 50)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222008", "story_v_out_111222.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_111222", "111222008", "story_v_out_111222.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_111222", "111222008", "story_v_out_111222.awb")

						arg_32_1:RecordAudio("111222008", var_35_6)
						arg_32_1:RecordAudio("111222008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_111222", "111222008", "story_v_out_111222.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_111222", "111222008", "story_v_out_111222.awb")
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
	Play111222009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 111222009
		arg_36_1.duration_ = 12.4

		local var_36_0 = {
			ja = 12.4,
			ko = 11.266,
			zh = 9,
			en = 9.333
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
				arg_36_0:Play111222010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.2

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(111222009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 48 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 48)

				if (48 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 48)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222009", "story_v_out_111222.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_111222", "111222009", "story_v_out_111222.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_111222", "111222009", "story_v_out_111222.awb")

						arg_36_1:RecordAudio("111222009", var_39_6)
						arg_36_1:RecordAudio("111222009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_111222", "111222009", "story_v_out_111222.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_111222", "111222009", "story_v_out_111222.awb")
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
	Play111222010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 111222010
		arg_40_1.duration_ = 4.13

		local var_40_0 = {
			ja = 3.633,
			ko = 2.1,
			zh = 2.933,
			en = 4.133
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
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play111222011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1096ui_story"]) and arg_40_1.var_.characterEffect1096ui_story == nil then
				arg_40_1.var_.characterEffect1096ui_story = arg_40_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1096ui_story"]) then
				if arg_40_1.var_.characterEffect1096ui_story and not isNil(arg_40_1.actors_["1096ui_story"]) then
					arg_40_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1096ui_story"]) and arg_40_1.var_.characterEffect1096ui_story then
				arg_40_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action446")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_43_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_4 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_4

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_4
						arg_40_1.bgmTxt2_.text = var_43_4
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_43_5 = 0
			local var_43_6 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(111222010)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 14 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 14)

				if (14 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 14)) > 0 and var_43_6 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10

					if var_43_10 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222010", "story_v_out_111222.awb") ~= 0 then
					local var_43_11 = manager.audio:GetVoiceLength("story_v_out_111222", "111222010", "story_v_out_111222.awb") / 1000

					if var_43_11 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_5
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_out_111222", "111222010", "story_v_out_111222.awb")

						arg_40_1:RecordAudio("111222010", var_43_12)
						arg_40_1:RecordAudio("111222010", var_43_12)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_111222", "111222010", "story_v_out_111222.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_111222", "111222010", "story_v_out_111222.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_13 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_13 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_13

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_13 and arg_40_1.time_ < var_43_5 + var_43_13 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play111222011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 111222011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play111222012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1096ui_story = arg_45_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1096ui_story"].transform.position).z)
				arg_45_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1096ui_story"].transform.localEulerAngles = arg_45_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1096ui_story"].transform.position).z)
				arg_45_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1096ui_story"].transform.localEulerAngles = arg_45_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			local var_48_1 = 0
			local var_48_2 = 1.1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(111222011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 44 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 44)

				if (44 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 44)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play111222012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 111222012
		arg_49_1.duration_ = 3.93

		local var_49_0 = {
			ja = 3.9,
			ko = 3.766,
			zh = 3.8,
			en = 3.933
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
				arg_49_0:Play111222013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1096ui_story"]) and arg_49_1.var_.characterEffect1096ui_story == nil then
				arg_49_1.var_.characterEffect1096ui_story = arg_49_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1096ui_story"]) then
				if arg_49_1.var_.characterEffect1096ui_story and not isNil(arg_49_1.actors_["1096ui_story"]) then
					arg_49_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1096ui_story"]) and arg_49_1.var_.characterEffect1096ui_story then
				arg_49_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_52_2 = arg_49_1.actors_["1096ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1096ui_story = var_52_2.localPosition
			end

			local var_52_3 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 then
				var_52_2.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_49_1.time_ - 0) / var_52_3)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 then
				var_52_2.localPosition = Vector3.New(0, -1.13, -5.6)
				var_52_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_2.position).x, (manager.ui.mainCamera.transform.position - var_52_2.position).y, (manager.ui.mainCamera.transform.position - var_52_2.position).z)
				var_52_2.localEulerAngles.z = 0
				var_52_2.localEulerAngles.x = 0
				var_52_2.localEulerAngles = var_52_2.localEulerAngles
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "music", "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story.awb")

				local var_52_6 = manager.audio:GetAudioName("bgm_activity_1_1_1_hermes_story", "bgm_activity_1_1_1_hermes_story")

				if "" ~= "" then
					if arg_49_1.bgmTxt_.text ~= var_52_6 and arg_49_1.bgmTxt_.text ~= "" then
						if arg_49_1.bgmTxt2_.text ~= "" then
							arg_49_1.bgmTxt_.text = arg_49_1.bgmTxt2_.text
						end

						arg_49_1.bgmTxt2_.text = var_52_6

						arg_49_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_49_1.bgmTxt_.text = var_52_6
						arg_49_1.bgmTxt2_.text = var_52_6
					end

					if arg_49_1.bgmTimer then
						arg_49_1.bgmTimer:Stop()

						arg_49_1.bgmTimer = nil
					end

					if arg_49_1.settingData.show_music_name == 1 then
						arg_49_1.musicController:SetSelectedState("show")
						arg_49_1.musicAnimator_:Play("open", 0, 0)

						if arg_49_1.settingData.music_time ~= 0 then
							arg_49_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_49_1.settingData.music_time), function()
								if arg_49_1 == nil or isNil(arg_49_1.bgmTxt_) then
									return
								end

								arg_49_1.musicController:SetSelectedState("hide")
								arg_49_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_52_7 = 0
			local var_52_8 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(111222012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_12 = 20 <= 0 and var_52_8 or var_52_8 * (utf8.len(var_52_10) / 20)

				if (20 <= 0 and var_52_8 or var_52_8 * (utf8.len(var_52_10) / 20)) > 0 and var_52_8 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_7
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222012", "story_v_out_111222.awb") ~= 0 then
					local var_52_13 = manager.audio:GetVoiceLength("story_v_out_111222", "111222012", "story_v_out_111222.awb") / 1000

					if var_52_13 + var_52_7 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_7
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_111222", "111222012", "story_v_out_111222.awb")

						arg_49_1:RecordAudio("111222012", var_52_14)
						arg_49_1:RecordAudio("111222012", var_52_14)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_111222", "111222012", "story_v_out_111222.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_111222", "111222012", "story_v_out_111222.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_8, arg_49_1.talkMaxDuration)

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_7) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_7 + var_52_15 and arg_49_1.time_ < var_52_7 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play111222013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111222013
		arg_54_1.duration_ = 11.2

		local var_54_0 = {
			ja = 8.566,
			ko = 11.2,
			zh = 6.4,
			en = 6.433
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play111222014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1096ui_story"]) and arg_54_1.var_.characterEffect1096ui_story == nil then
				arg_54_1.var_.characterEffect1096ui_story = arg_54_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1096ui_story"]) then
				if arg_54_1.var_.characterEffect1096ui_story and not isNil(arg_54_1.actors_["1096ui_story"]) then
					arg_54_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_0)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1096ui_story"]) and arg_54_1.var_.characterEffect1096ui_story then
				arg_54_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_57_1 = 0
			local var_57_2 = 0.825

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_3 = arg_54_1:GetWordFromCfg(111222013)
				local var_57_4 = arg_54_1:FormatText(var_57_3.content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_6 = 34 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_4) / 34)

				if (34 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_4) / 34)) > 0 and var_57_2 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222013", "story_v_out_111222.awb") ~= 0 then
					local var_57_7 = manager.audio:GetVoiceLength("story_v_out_111222", "111222013", "story_v_out_111222.awb") / 1000

					if var_57_7 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_1
					end

					if var_57_3.prefab_name ~= "" and arg_54_1.actors_[var_57_3.prefab_name] ~= nil then
						local var_57_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_3.prefab_name].transform, "story_v_out_111222", "111222013", "story_v_out_111222.awb")

						arg_54_1:RecordAudio("111222013", var_57_8)
						arg_54_1:RecordAudio("111222013", var_57_8)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_111222", "111222013", "story_v_out_111222.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_111222", "111222013", "story_v_out_111222.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_9 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_9 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_9

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_9 and arg_54_1.time_ < var_57_1 + var_57_9 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play111222014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111222014
		arg_58_1.duration_ = 5.77

		local var_58_0 = {
			ja = 5.766,
			ko = 5.433,
			zh = 4.866,
			en = 4.633
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play111222015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action6_2")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_61_0 = arg_58_1.actors_["1096ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1096ui_story == nil then
				arg_58_1.var_.characterEffect1096ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_1 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_1 and not isNil(var_61_0) then
				if arg_58_1.var_.characterEffect1096ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_1 and arg_58_1.time_ < 0 + var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1096ui_story then
				arg_58_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_61_3 = 0
			local var_61_4 = 0.675

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_5 = arg_58_1:GetWordFromCfg(111222014)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_8 = 27 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 27)

				if (27 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_6) / 27)) > 0 and var_61_4 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8

					if var_61_8 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_3
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222014", "story_v_out_111222.awb") ~= 0 then
					local var_61_9 = manager.audio:GetVoiceLength("story_v_out_111222", "111222014", "story_v_out_111222.awb") / 1000

					if var_61_9 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_3
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_111222", "111222014", "story_v_out_111222.awb")

						arg_58_1:RecordAudio("111222014", var_61_10)
						arg_58_1:RecordAudio("111222014", var_61_10)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_111222", "111222014", "story_v_out_111222.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_111222", "111222014", "story_v_out_111222.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_11 = math.max(var_61_4, arg_58_1.talkMaxDuration)

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_11 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_3) / var_61_11

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_3 + var_61_11 and arg_58_1.time_ < var_61_3 + var_61_11 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play111222015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111222015
		arg_62_1.duration_ = 2.03

		local var_62_0 = {
			ja = 1.933,
			ko = 2.033,
			zh = 2.033,
			en = 1.2
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play111222016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1096ui_story"]) and arg_62_1.var_.characterEffect1096ui_story == nil then
				arg_62_1.var_.characterEffect1096ui_story = arg_62_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1096ui_story"]) then
				if arg_62_1.var_.characterEffect1096ui_story and not isNil(arg_62_1.actors_["1096ui_story"]) then
					arg_62_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1096ui_story"]) and arg_62_1.var_.characterEffect1096ui_story then
				arg_62_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.25

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(111222015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 6 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 6)

				if (6 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_4) / 6)) > 0 and var_65_2 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222015", "story_v_out_111222.awb") ~= 0 then
					local var_65_7 = manager.audio:GetVoiceLength("story_v_out_111222", "111222015", "story_v_out_111222.awb") / 1000

					if var_65_7 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_1
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_111222", "111222015", "story_v_out_111222.awb")

						arg_62_1:RecordAudio("111222015", var_65_8)
						arg_62_1:RecordAudio("111222015", var_65_8)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_111222", "111222015", "story_v_out_111222.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_111222", "111222015", "story_v_out_111222.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_9 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_9 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_9

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_9 and arg_62_1.time_ < var_65_1 + var_65_9 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play111222016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 111222016
		arg_66_1.duration_ = 6.7

		local var_66_0 = {
			ja = 6.7,
			ko = 2.333,
			zh = 2.366,
			en = 1.999999999999
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play111222017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_69_0 = arg_66_1.actors_["1096ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1096ui_story == nil then
				arg_66_1.var_.characterEffect1096ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_1 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_1 and not isNil(var_69_0) then
				if arg_66_1.var_.characterEffect1096ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_1 and arg_66_1.time_ < 0 + var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1096ui_story then
				arg_66_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_69_3 = 0
			local var_69_4 = 0.275

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_5 = arg_66_1:GetWordFromCfg(111222016)
				local var_69_6 = arg_66_1:FormatText(var_69_5.content)

				arg_66_1.text_.text = var_69_6

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_8 = 11 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_6) / 11)

				if (11 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_6) / 11)) > 0 and var_69_4 < var_69_8 then
					arg_66_1.talkMaxDuration = var_69_8

					if var_69_8 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_3
					end
				end

				arg_66_1.text_.text = var_69_6
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222016", "story_v_out_111222.awb") ~= 0 then
					local var_69_9 = manager.audio:GetVoiceLength("story_v_out_111222", "111222016", "story_v_out_111222.awb") / 1000

					if var_69_9 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_3
					end

					if var_69_5.prefab_name ~= "" and arg_66_1.actors_[var_69_5.prefab_name] ~= nil then
						local var_69_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_5.prefab_name].transform, "story_v_out_111222", "111222016", "story_v_out_111222.awb")

						arg_66_1:RecordAudio("111222016", var_69_10)
						arg_66_1:RecordAudio("111222016", var_69_10)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_111222", "111222016", "story_v_out_111222.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_111222", "111222016", "story_v_out_111222.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_4, arg_66_1.talkMaxDuration)

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_3) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_3 + var_69_11 and arg_66_1.time_ < var_69_3 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play111222017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 111222017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play111222018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1096ui_story = arg_70_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1096ui_story"].transform.position).z)
				arg_70_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1096ui_story"].transform.localEulerAngles = arg_70_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1096ui_story"].transform.position).z)
				arg_70_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1096ui_story"].transform.localEulerAngles = arg_70_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			local var_73_1 = 0
			local var_73_2 = 0.95

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(111222017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 38 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 38)

				if (38 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 38)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play111222018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 111222018
		arg_74_1.duration_ = 4.43

		local var_74_0 = {
			ja = 4.3,
			ko = 4.033,
			zh = 4.266,
			en = 4.433
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play111222019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1096ui_story"]) and arg_74_1.var_.characterEffect1096ui_story == nil then
				arg_74_1.var_.characterEffect1096ui_story = arg_74_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1096ui_story"]) then
				if arg_74_1.var_.characterEffect1096ui_story and not isNil(arg_74_1.actors_["1096ui_story"]) then
					arg_74_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1096ui_story"]) and arg_74_1.var_.characterEffect1096ui_story then
				arg_74_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action1_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_77_2 = arg_74_1.actors_["1096ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1096ui_story = var_77_2.localPosition
			end

			local var_77_3 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 then
				var_77_2.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1096ui_story, Vector3.New(0, -1.13, -5.6), (arg_74_1.time_ - 0) / var_77_3)
				var_77_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_2.position).x, (manager.ui.mainCamera.transform.position - var_77_2.position).y, (manager.ui.mainCamera.transform.position - var_77_2.position).z)
				var_77_2.localEulerAngles.z = 0
				var_77_2.localEulerAngles.x = 0
				var_77_2.localEulerAngles = var_77_2.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 then
				var_77_2.localPosition = Vector3.New(0, -1.13, -5.6)
				var_77_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_2.position).x, (manager.ui.mainCamera.transform.position - var_77_2.position).y, (manager.ui.mainCamera.transform.position - var_77_2.position).z)
				var_77_2.localEulerAngles.z = 0
				var_77_2.localEulerAngles.x = 0
				var_77_2.localEulerAngles = var_77_2.localEulerAngles
			end

			local var_77_4 = 0
			local var_77_5 = 0.45

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(111222018)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 18 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 18)

				if (18 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 18)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222018", "story_v_out_111222.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_111222", "111222018", "story_v_out_111222.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_111222", "111222018", "story_v_out_111222.awb")

						arg_74_1:RecordAudio("111222018", var_77_11)
						arg_74_1:RecordAudio("111222018", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_111222", "111222018", "story_v_out_111222.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_111222", "111222018", "story_v_out_111222.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play111222019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 111222019
		arg_78_1.duration_ = 7.83

		local var_78_0 = {
			ja = 6.533,
			ko = 7.833,
			zh = 7.5,
			en = 7.333
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play111222020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_81_0 = 0
			local var_81_1 = 1.025

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_2 = arg_78_1:GetWordFromCfg(111222019)
				local var_81_3 = arg_78_1:FormatText(var_81_2.content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 41 <= 0 and var_81_1 or var_81_1 * (utf8.len(var_81_3) / 41)

				if (41 <= 0 and var_81_1 or var_81_1 * (utf8.len(var_81_3) / 41)) > 0 and var_81_1 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222019", "story_v_out_111222.awb") ~= 0 then
					local var_81_6 = manager.audio:GetVoiceLength("story_v_out_111222", "111222019", "story_v_out_111222.awb") / 1000

					if var_81_6 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_6 + var_81_0
					end

					if var_81_2.prefab_name ~= "" and arg_78_1.actors_[var_81_2.prefab_name] ~= nil then
						local var_81_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_2.prefab_name].transform, "story_v_out_111222", "111222019", "story_v_out_111222.awb")

						arg_78_1:RecordAudio("111222019", var_81_7)
						arg_78_1:RecordAudio("111222019", var_81_7)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_111222", "111222019", "story_v_out_111222.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_111222", "111222019", "story_v_out_111222.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_8 and arg_78_1.time_ < var_81_0 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play111222020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 111222020
		arg_82_1.duration_ = 12.73

		local var_82_0 = {
			ja = 12.733,
			ko = 8.5,
			zh = 12.166,
			en = 10.866
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play111222021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_85_0 = 0
			local var_85_1 = 1.3

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_2 = arg_82_1:GetWordFromCfg(111222020)
				local var_85_3 = arg_82_1:FormatText(var_85_2.content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 52 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 52)

				if (52 <= 0 and var_85_1 or var_85_1 * (utf8.len(var_85_3) / 52)) > 0 and var_85_1 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222020", "story_v_out_111222.awb") ~= 0 then
					local var_85_6 = manager.audio:GetVoiceLength("story_v_out_111222", "111222020", "story_v_out_111222.awb") / 1000

					if var_85_6 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_0
					end

					if var_85_2.prefab_name ~= "" and arg_82_1.actors_[var_85_2.prefab_name] ~= nil then
						local var_85_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_2.prefab_name].transform, "story_v_out_111222", "111222020", "story_v_out_111222.awb")

						arg_82_1:RecordAudio("111222020", var_85_7)
						arg_82_1:RecordAudio("111222020", var_85_7)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_111222", "111222020", "story_v_out_111222.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_111222", "111222020", "story_v_out_111222.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_8 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_8 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_8

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_8 and arg_82_1.time_ < var_85_0 + var_85_8 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play111222021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 111222021
		arg_86_1.duration_ = 8.5

		local var_86_0 = {
			ja = 8.5,
			ko = 4.9,
			zh = 6.033,
			en = 5.6
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play111222022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_89_0 = 0
			local var_89_1 = 0.625

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_2 = arg_86_1:GetWordFromCfg(111222021)
				local var_89_3 = arg_86_1:FormatText(var_89_2.content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 25 <= 0 and var_89_1 or var_89_1 * (utf8.len(var_89_3) / 25)

				if (25 <= 0 and var_89_1 or var_89_1 * (utf8.len(var_89_3) / 25)) > 0 and var_89_1 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_0
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222021", "story_v_out_111222.awb") ~= 0 then
					local var_89_6 = manager.audio:GetVoiceLength("story_v_out_111222", "111222021", "story_v_out_111222.awb") / 1000

					if var_89_6 + var_89_0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_6 + var_89_0
					end

					if var_89_2.prefab_name ~= "" and arg_86_1.actors_[var_89_2.prefab_name] ~= nil then
						local var_89_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_2.prefab_name].transform, "story_v_out_111222", "111222021", "story_v_out_111222.awb")

						arg_86_1:RecordAudio("111222021", var_89_7)
						arg_86_1:RecordAudio("111222021", var_89_7)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_111222", "111222021", "story_v_out_111222.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_111222", "111222021", "story_v_out_111222.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_8 = math.max(var_89_1, arg_86_1.talkMaxDuration)

			if var_89_0 <= arg_86_1.time_ and arg_86_1.time_ < var_89_0 + var_89_8 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_0) / var_89_8

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_0 + var_89_8 and arg_86_1.time_ < var_89_0 + var_89_8 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play111222022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 111222022
		arg_90_1.duration_ = 6.33

		local var_90_0 = {
			ja = 6.333,
			ko = 3.9,
			zh = 5.1,
			en = 3.733
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play111222023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1096ui_story"]) and arg_90_1.var_.characterEffect1096ui_story == nil then
				arg_90_1.var_.characterEffect1096ui_story = arg_90_1.actors_["1096ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1096ui_story"]) then
				if arg_90_1.var_.characterEffect1096ui_story and not isNil(arg_90_1.actors_["1096ui_story"]) then
					arg_90_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1096ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1096ui_story"]) and arg_90_1.var_.characterEffect1096ui_story then
				arg_90_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1096ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.575

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:GetWordFromCfg(111222022)
				local var_93_4 = arg_90_1:FormatText(var_93_3.content)

				arg_90_1.text_.text = var_93_4

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_6 = 18 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_4) / 18)

				if (18 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_4) / 18)) > 0 and var_93_2 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_4
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222022", "story_v_out_111222.awb") ~= 0 then
					local var_93_7 = manager.audio:GetVoiceLength("story_v_out_111222", "111222022", "story_v_out_111222.awb") / 1000

					if var_93_7 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_1
					end

					if var_93_3.prefab_name ~= "" and arg_90_1.actors_[var_93_3.prefab_name] ~= nil then
						local var_93_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_3.prefab_name].transform, "story_v_out_111222", "111222022", "story_v_out_111222.awb")

						arg_90_1:RecordAudio("111222022", var_93_8)
						arg_90_1:RecordAudio("111222022", var_93_8)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_111222", "111222022", "story_v_out_111222.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_111222", "111222022", "story_v_out_111222.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_9 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_9 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_9

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_9 and arg_90_1.time_ < var_93_1 + var_93_9 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play111222023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 111222023
		arg_94_1.duration_ = 5.23

		local var_94_0 = {
			ja = 4.033,
			ko = 5.233,
			zh = 4.5,
			en = 2.9
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play111222024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_97_0 = arg_94_1.actors_["1096ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1096ui_story == nil then
				arg_94_1.var_.characterEffect1096ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_1 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 and not isNil(var_97_0) then
				if arg_94_1.var_.characterEffect1096ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1096ui_story then
				arg_94_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_97_3 = 0
			local var_97_4 = 0.55

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_5 = arg_94_1:GetWordFromCfg(111222023)
				local var_97_6 = arg_94_1:FormatText(var_97_5.content)

				arg_94_1.text_.text = var_97_6

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_8 = 22 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_6) / 22)

				if (22 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_6) / 22)) > 0 and var_97_4 < var_97_8 then
					arg_94_1.talkMaxDuration = var_97_8

					if var_97_8 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_3
					end
				end

				arg_94_1.text_.text = var_97_6
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222023", "story_v_out_111222.awb") ~= 0 then
					local var_97_9 = manager.audio:GetVoiceLength("story_v_out_111222", "111222023", "story_v_out_111222.awb") / 1000

					if var_97_9 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_3
					end

					if var_97_5.prefab_name ~= "" and arg_94_1.actors_[var_97_5.prefab_name] ~= nil then
						local var_97_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_5.prefab_name].transform, "story_v_out_111222", "111222023", "story_v_out_111222.awb")

						arg_94_1:RecordAudio("111222023", var_97_10)
						arg_94_1:RecordAudio("111222023", var_97_10)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_111222", "111222023", "story_v_out_111222.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_111222", "111222023", "story_v_out_111222.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_11 = math.max(var_97_4, arg_94_1.talkMaxDuration)

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_11 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_3) / var_97_11

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_3 + var_97_11 and arg_94_1.time_ < var_97_3 + var_97_11 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play111222024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 111222024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play111222025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1096ui_story = arg_98_1.actors_["1096ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["1096ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1096ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1096ui_story"].transform.position).z)
				arg_98_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1096ui_story"].transform.localEulerAngles = arg_98_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["1096ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["1096ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1096ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1096ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1096ui_story"].transform.position).z)
				arg_98_1.actors_["1096ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1096ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1096ui_story"].transform.localEulerAngles = arg_98_1.actors_["1096ui_story"].transform.localEulerAngles
			end

			local var_101_1 = 0
			local var_101_2 = 0.6

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(111222024).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 24 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 24)

				if (24 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 24)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play111222025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 111222025
		arg_102_1.duration_ = 3.63

		local var_102_0 = {
			ja = 3.633,
			ko = 1.5,
			zh = 3,
			en = 3.6
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play111222026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.2

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1096")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_1 = arg_102_1:GetWordFromCfg(111222025)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 8 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 8)

				if (8 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 8)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222025", "story_v_out_111222.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_111222", "111222025", "story_v_out_111222.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_111222", "111222025", "story_v_out_111222.awb")

						arg_102_1:RecordAudio("111222025", var_105_6)
						arg_102_1:RecordAudio("111222025", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_111222", "111222025", "story_v_out_111222.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_111222", "111222025", "story_v_out_111222.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play111222026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 111222026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play111222027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPosA07a = arg_106_1.bgs_.A07a.transform.localPosition
			end

			local var_109_0 = 2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.bgs_.A07a.transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPosA07a, Vector3.New(0, 1, 9), (arg_106_1.time_ - 0) / var_109_0)
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.bgs_.A07a.transform.localPosition = Vector3.New(0, 1, 9)
			end

			local var_109_1 = 0
			local var_109_2 = 1.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(111222026).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 52 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 52)

				if (52 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 52)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A07a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play111222027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 111222027
		arg_110_1.duration_ = 6.5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play111222028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPosA07a = arg_110_1.bgs_.A07a.transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.bgs_.A07a.transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosA07a, Vector3.New(0, 1, 9), (arg_110_1.time_ - 0) / var_113_0)
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.bgs_.A07a.transform.localPosition = Vector3.New(0, 1, 9)
			end

			local var_113_1 = arg_110_1.bgs_.A07a.transform

			if 0.0166666666666667 < arg_110_1.time_ and arg_110_1.time_ <= 0.0166666666666667 + arg_113_0 then
				arg_110_1.var_.moveOldPosA07a = var_113_1.localPosition
			end

			local var_113_2 = 0.1

			if 0.0166666666666667 <= arg_110_1.time_ and arg_110_1.time_ < 0.0166666666666667 + var_113_2 then
				var_113_1.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosA07a, Vector3.New(1.5, 2, 1), (arg_110_1.time_ - 0.0166666666666667) / var_113_2)
			end

			if arg_110_1.time_ >= 0.0166666666666667 + var_113_2 and arg_110_1.time_ < 0.0166666666666667 + var_113_2 + arg_113_0 then
				var_113_1.localPosition = Vector3.New(1.5, 2, 1)
			end

			if 0.116666666666667 < arg_110_1.time_ and arg_110_1.time_ <= 0.116666666666667 + arg_113_0 then
				local var_113_3 = arg_110_1.bgs_.A07a:GetComponent("SpriteRenderer")

				if var_113_3 then
					arg_110_1.var_.alphaOldValueA07a = var_113_3.color.a
					arg_110_1.var_.alphaMatValueA07a = var_113_3
				end

				arg_110_1.var_.alphaOldValueA07a = 1
			end

			local var_113_4 = 0.0166666666666667

			if 0.116666666666667 <= arg_110_1.time_ and arg_110_1.time_ < 0.116666666666667 + var_113_4 then
				if arg_110_1.var_.alphaMatValueA07a then
					arg_110_1.var_.alphaMatValueA07a.color.a = Mathf.Lerp(arg_110_1.var_.alphaOldValueA07a, 0, (arg_110_1.time_ - 0.116666666666667) / var_113_4)
					arg_110_1.var_.alphaMatValueA07a.color = arg_110_1.var_.alphaMatValueA07a.color
				end
			end

			if arg_110_1.time_ >= 0.116666666666667 + var_113_4 and arg_110_1.time_ < 0.116666666666667 + var_113_4 + arg_113_0 and arg_110_1.var_.alphaMatValueA07a then
				arg_110_1.var_.alphaMatValueA07a.color.a = 0
				arg_110_1.var_.alphaMatValueA07a.color = arg_110_1.var_.alphaMatValueA07a.color
			end

			local var_113_5 = "STwhite"

			if arg_110_1.bgs_.STwhite == nil then
				local var_113_6 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_113_5)
				var_113_6.name = var_113_5
				var_113_6.transform.parent = arg_110_1.stage_.transform
				var_113_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_[var_113_5] = var_113_6
			end

			local var_113_7 = arg_110_1.bgs_.STwhite.transform

			if 1.08266666666667 < arg_110_1.time_ and arg_110_1.time_ <= 1.08266666666667 + arg_113_0 then
				arg_110_1.var_.moveOldPosSTwhite = var_113_7.localPosition
				var_113_7.localScale = Vector3.New(10, 10, 10)
			end

			local var_113_8 = 0.001

			if 1.08266666666667 <= arg_110_1.time_ and arg_110_1.time_ < 1.08266666666667 + var_113_8 then
				var_113_7.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_110_1.time_ - 1.08266666666667) / var_113_8)
			end

			if arg_110_1.time_ >= 1.08266666666667 + var_113_8 and arg_110_1.time_ < 1.08266666666667 + var_113_8 + arg_113_0 then
				var_113_7.localPosition = Vector3.New(0, 0, 0)
			end

			local var_113_9 = 0.116666666666667

			if 0.116666666666667 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_10 = 1

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 then
				local var_113_11 = Color.New(1, 1, 1)

				var_113_11.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_9) / var_113_10)
				arg_110_1.mask_.color = var_113_11
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 then
				local var_113_12 = Color.New(1, 1, 1)

				var_113_12.a = 1
				arg_110_1.mask_.color = var_113_12
			end

			local var_113_13 = 1.11666666666667

			if 1.11666666666667 < arg_110_1.time_ and arg_110_1.time_ <= var_113_13 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = false

				arg_110_1:SetGaussion(false)
			end

			local var_113_14 = 0.0166666666666667

			if var_113_13 <= arg_110_1.time_ and arg_110_1.time_ < var_113_13 + var_113_14 then
				local var_113_15 = Color.New(1, 1, 1)

				var_113_15.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_13) / var_113_14)
				arg_110_1.mask_.color = var_113_15
			end

			if arg_110_1.time_ >= var_113_13 + var_113_14 and arg_110_1.time_ < var_113_13 + var_113_14 + arg_113_0 then
				local var_113_16 = Color.New(1, 1, 1)

				arg_110_1.mask_.enabled = false
				var_113_16.a = 0
				arg_110_1.mask_.color = var_113_16
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_17 = 1.5
			local var_113_18 = 0.975

			if 1.5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_17 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_19 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_19:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_20 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(111222027).content)

				arg_110_1.text_.text = var_113_20

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_22 = 39 <= 0 and var_113_18 or var_113_18 * (utf8.len(var_113_20) / 39)

				if (39 <= 0 and var_113_18 or var_113_18 * (utf8.len(var_113_20) / 39)) > 0 and var_113_18 < var_113_22 then
					arg_110_1.talkMaxDuration = var_113_22
					var_113_17 = var_113_17 + 0.3

					if var_113_22 + var_113_17 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_22 + var_113_17
					end
				end

				arg_110_1.text_.text = var_113_20
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_23 = var_113_17 + 0.3
			local var_113_24 = math.max(var_113_18, arg_110_1.talkMaxDuration)

			if var_113_17 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_23 + var_113_24 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_23) / var_113_24

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_23 + var_113_24 and arg_110_1.time_ < var_113_23 + var_113_24 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "A07a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "A07a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.08266666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play111222028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 111222028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play111222029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1.225

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(111222028).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 49 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 49)

				if (49 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 49)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play111222029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 111222029
		arg_120_1.duration_ = 7

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play111222030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if arg_120_1.bgs_.AS0109 == nil then
				local var_123_0 = Object.Instantiate(arg_120_1.paintGo_)

				var_123_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "AS0109")
				var_123_0.name = "AS0109"
				var_123_0.transform.parent = arg_120_1.stage_.transform
				var_123_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.bgs_.AS0109 = var_123_0
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				local var_123_1 = arg_120_1.bgs_.AS0109

				arg_120_1.bgs_.AS0109.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_123_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_2 = var_123_1:GetComponent("SpriteRenderer")

				if var_123_2 and var_123_2.sprite then
					local var_123_3 = 2 * (var_123_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_123_1.transform.localScale = Vector3.New(var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, var_123_3 / var_123_2.sprite.bounds.size.y < var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x and var_123_3 * manager.ui.mainCameraCom_.aspect / var_123_2.sprite.bounds.size.x or var_123_3 / var_123_2.sprite.bounds.size.y, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "AS0109" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_4 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = false

				arg_120_1:SetGaussion(false)
			end

			local var_123_5 = 1.5

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_5 then
				local var_123_6 = Color.New(1, 1, 1)

				var_123_6.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_4) / var_123_5)
				arg_120_1.mask_.color = var_123_6
			end

			if arg_120_1.time_ >= var_123_4 + var_123_5 and arg_120_1.time_ < var_123_4 + var_123_5 + arg_123_0 then
				local var_123_7 = Color.New(1, 1, 1)

				arg_120_1.mask_.enabled = false
				var_123_7.a = 0
				arg_120_1.mask_.color = var_123_7
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_8 = 2
			local var_123_9 = 0.45

			if 2 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_10 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_10:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_11 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(111222029).content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_13 = 18 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 18)

				if (18 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 18)) > 0 and var_123_9 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13
					var_123_8 = var_123_8 + 0.3

					if var_123_13 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_8
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = var_123_8 + 0.3
			local var_123_15 = math.max(var_123_9, arg_120_1.talkMaxDuration)

			if var_123_8 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_14 + var_123_15 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_14) / var_123_15

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_14 + var_123_15 and arg_120_1.time_ < var_123_14 + var_123_15 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play111222030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 111222030
		arg_126_1.duration_ = 5.13

		local var_126_0 = {
			ja = 3.3,
			ko = 3.4,
			zh = 4.366,
			en = 5.133
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
				arg_126_0:Play111222031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0.2 < arg_126_1.time_ and arg_126_1.time_ <= 0.2 + arg_129_0 then
				arg_126_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_129_0 = 0.6

			if 0.2 <= arg_126_1.time_ and arg_126_1.time_ < 0.2 + var_129_0 then
				local var_129_1, var_129_2 = math.modf((arg_126_1.time_ - 0.2) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_129_2 * 0.13, var_129_2 * 0.13, var_129_2 * 0.13) + arg_126_1.var_.shakeOldPos
			end

			if arg_126_1.time_ >= 0.2 + var_129_0 and arg_126_1.time_ < 0.2 + var_129_0 + arg_129_0 then
				manager.ui.mainCamera.transform.localPosition = arg_126_1.var_.shakeOldPos
			end

			local var_129_3 = 0
			local var_129_4 = 0.2

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_3 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[169].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_5 = arg_126_1:GetWordFromCfg(111222030)
				local var_129_6 = arg_126_1:FormatText(var_129_5.content)

				arg_126_1.text_.text = var_129_6

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_8 = 8 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_6) / 8)

				if (8 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_6) / 8)) > 0 and var_129_4 < var_129_8 then
					arg_126_1.talkMaxDuration = var_129_8

					if var_129_8 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_3
					end
				end

				arg_126_1.text_.text = var_129_6
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111222", "111222030", "story_v_out_111222.awb") ~= 0 then
					local var_129_9 = manager.audio:GetVoiceLength("story_v_out_111222", "111222030", "story_v_out_111222.awb") / 1000

					if var_129_9 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_3
					end

					if var_129_5.prefab_name ~= "" and arg_126_1.actors_[var_129_5.prefab_name] ~= nil then
						local var_129_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_5.prefab_name].transform, "story_v_out_111222", "111222030", "story_v_out_111222.awb")

						arg_126_1:RecordAudio("111222030", var_129_10)
						arg_126_1:RecordAudio("111222030", var_129_10)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_111222", "111222030", "story_v_out_111222.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_111222", "111222030", "story_v_out_111222.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_11 = math.max(var_129_4, arg_126_1.talkMaxDuration)

			if var_129_3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_3 + var_129_11 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_3) / var_129_11

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_3 + var_129_11 and arg_126_1.time_ < var_129_3 + var_129_11 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play111222031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 111222031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play111222032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.6

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(111222031).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 24 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 24)

				if (24 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 24)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play111222032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 111222032
		arg_134_1.duration_ = 7.19

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
			arg_134_1.auto_ = false
		end

		function arg_134_1.playNext_(arg_136_0)
			arg_134_1.onStoryFinished_()
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_0 = 1.5

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				local var_137_1 = Color.New(1, 1, 1)

				var_137_1.a = Mathf.Lerp(0, 1, (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.mask_.color = var_137_1
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				local var_137_2 = Color.New(1, 1, 1)

				var_137_2.a = 1
				arg_134_1.mask_.color = var_137_2
			end

			local var_137_3 = 1.5

			if 1.5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_3 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = false

				arg_134_1:SetGaussion(false)
			end

			local var_137_4 = 0.0166666666666667

			if var_137_3 <= arg_134_1.time_ and arg_134_1.time_ < var_137_3 + var_137_4 then
				local var_137_5 = Color.New(1, 1, 1)

				var_137_5.a = Mathf.Lerp(1, 0, (arg_134_1.time_ - var_137_3) / var_137_4)
				arg_134_1.mask_.color = var_137_5
			end

			if arg_134_1.time_ >= var_137_3 + var_137_4 and arg_134_1.time_ < var_137_3 + var_137_4 + arg_137_0 then
				local var_137_6 = Color.New(1, 1, 1)

				arg_134_1.mask_.enabled = false
				var_137_6.a = 0
				arg_134_1.mask_.color = var_137_6
			end

			if 1.51666666666667 < arg_134_1.time_ and arg_134_1.time_ <= 1.51666666666667 + arg_137_0 then
				local var_137_7 = arg_134_1.bgs_.STwhite:GetComponent("SpriteRenderer")

				if var_137_7 then
					arg_134_1.var_.alphaOldValueSTwhite = var_137_7.color.a
					arg_134_1.var_.alphaMatValueSTwhite = var_137_7
				end

				arg_134_1.var_.alphaOldValueSTwhite = 1
			end

			local var_137_8 = 1.5

			if 1.51666666666667 <= arg_134_1.time_ and arg_134_1.time_ < 1.51666666666667 + var_137_8 then
				if arg_134_1.var_.alphaMatValueSTwhite then
					arg_134_1.var_.alphaMatValueSTwhite.color.a = Mathf.Lerp(arg_134_1.var_.alphaOldValueSTwhite, 0, (arg_134_1.time_ - 1.51666666666667) / var_137_8)
					arg_134_1.var_.alphaMatValueSTwhite.color = arg_134_1.var_.alphaMatValueSTwhite.color
				end
			end

			if arg_134_1.time_ >= 1.51666666666667 + var_137_8 and arg_134_1.time_ < 1.51666666666667 + var_137_8 + arg_137_0 and arg_134_1.var_.alphaMatValueSTwhite then
				arg_134_1.var_.alphaMatValueSTwhite.color.a = 0
				arg_134_1.var_.alphaMatValueSTwhite.color = arg_134_1.var_.alphaMatValueSTwhite.color
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				local var_137_9 = arg_134_1.bgs_.AS0109:GetComponent("SpriteRenderer")

				if var_137_9 then
					arg_134_1.var_.alphaOldValueAS0109 = var_137_9.color.a
					arg_134_1.var_.alphaMatValueAS0109 = var_137_9
				end

				arg_134_1.var_.alphaOldValueAS0109 = 1
			end

			local var_137_10 = 0.0166666666666667

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_10 then
				if arg_134_1.var_.alphaMatValueAS0109 then
					arg_134_1.var_.alphaMatValueAS0109.color.a = Mathf.Lerp(arg_134_1.var_.alphaOldValueAS0109, 0, (arg_134_1.time_ - 0) / var_137_10)
					arg_134_1.var_.alphaMatValueAS0109.color = arg_134_1.var_.alphaMatValueAS0109.color
				end
			end

			if arg_134_1.time_ >= 0 + var_137_10 and arg_134_1.time_ < 0 + var_137_10 + arg_137_0 and arg_134_1.var_.alphaMatValueAS0109 then
				arg_134_1.var_.alphaMatValueAS0109.color.a = 0
				arg_134_1.var_.alphaMatValueAS0109.color = arg_134_1.var_.alphaMatValueAS0109.color
			end

			local var_137_11 = arg_134_1.bgs_.STwhite.transform

			if 1.466 < arg_134_1.time_ and arg_134_1.time_ <= 1.466 + arg_137_0 then
				arg_134_1.var_.moveOldPosSTwhite = var_137_11.localPosition
				var_137_11.localScale = Vector3.New(10, 10, 10)
			end

			local var_137_12 = 0.001

			if 1.466 <= arg_134_1.time_ and arg_134_1.time_ < 1.466 + var_137_12 then
				var_137_11.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_134_1.time_ - 1.466) / var_137_12)
			end

			if arg_134_1.time_ >= 1.466 + var_137_12 and arg_134_1.time_ < 1.466 + var_137_12 + arg_137_0 then
				var_137_11.localPosition = Vector3.New(0, 0, 0)
			end

			local var_137_13 = 2.19166666666667
			local var_137_14 = 0.825

			if 2.19166666666667 < arg_134_1.time_ and arg_134_1.time_ <= var_137_13 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_15 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(111222032).content)

				arg_134_1.text_.text = var_137_15

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_17 = 33 <= 0 and var_137_14 or var_137_14 * (utf8.len(var_137_15) / 33)

				if (33 <= 0 and var_137_14 or var_137_14 * (utf8.len(var_137_15) / 33)) > 0 and var_137_14 < var_137_17 then
					arg_134_1.talkMaxDuration = var_137_17

					if var_137_17 + var_137_13 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_17 + var_137_13
					end
				end

				arg_134_1.text_.text = var_137_15
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_18 = math.max(var_137_14, arg_134_1.talkMaxDuration)

			if var_137_13 <= arg_134_1.time_ and arg_134_1.time_ < var_137_13 + var_137_18 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_13) / var_137_18

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_13 + var_137_18 and arg_134_1.time_ < var_137_13 + var_137_18 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A07a",
		"TextureConfig/Background/AS0109"
	},
	voices = {
		"story_v_out_111222.awb"
	}
}
