return {
	Play104061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_4 = "B06a"

			if arg_1_1.bgs_.B06a == nil then
				local var_4_5 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_4)
				var_4_5.name = var_4_4
				var_4_5.transform.parent = arg_1_1.stage_.transform
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_4] = var_4_5
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.B06a:GetComponent("SpriteRenderer")

				if var_4_6 then
					arg_1_1.var_.alphaOldValueB06a = var_4_6.color.a
					arg_1_1.var_.alphaMatValueB06a = var_4_6
				end

				arg_1_1.var_.alphaOldValueB06a = 0
			end

			local var_4_7 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				if arg_1_1.var_.alphaMatValueB06a then
					arg_1_1.var_.alphaMatValueB06a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB06a, 1, (arg_1_1.time_ - 0) / var_4_7)
					arg_1_1.var_.alphaMatValueB06a.color = arg_1_1.var_.alphaMatValueB06a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 and arg_1_1.var_.alphaMatValueB06a then
				arg_1_1.var_.alphaMatValueB06a.color.a = 1
				arg_1_1.var_.alphaMatValueB06a.color = arg_1_1.var_.alphaMatValueB06a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_8 = arg_1_1.bgs_.B06a

				arg_1_1.bgs_.B06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_9 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_9 and var_4_9.sprite then
					local var_4_10 = 2 * (var_4_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_8.transform.localScale = Vector3.New(var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_11 + 2 and arg_1_1.time_ < var_4_11 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_12 = 2
			local var_4_13 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_14 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_14:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(104061001).content)

				arg_1_1.text_.text = var_4_15

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_17 = 10 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 10)

				if (10 <= 0 and var_4_13 or var_4_13 * (utf8.len(var_4_15) / 10)) > 0 and var_4_13 < var_4_17 then
					arg_1_1.talkMaxDuration = var_4_17
					var_4_12 = var_4_12 + 0.3

					if var_4_17 + var_4_12 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_12
					end
				end

				arg_1_1.text_.text = var_4_15
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_18 = var_4_12 + 0.3
			local var_4_19 = math.max(var_4_13, arg_1_1.talkMaxDuration)

			if var_4_12 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_18) / var_4_19

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104061002
		arg_8_1.duration_ = 9.57

		local var_8_0 = {
			ja = 7.3,
			ko = 5.466,
			zh = 5.633,
			en = 9.566
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
				arg_8_0:Play104061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1035ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1035ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1035ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1035ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1035ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1035ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1035ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0, -1.05, -5.6)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["1035ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1035ui_story == nil then
				arg_8_1.var_.characterEffect1035ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1035ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1035ui_story then
				arg_8_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_11_8 = 0
			local var_11_9 = 0.675

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(104061002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 27 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 27)

				if (27 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 27)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061002", "story_v_out_104061.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_104061", "104061002", "story_v_out_104061.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_104061", "104061002", "story_v_out_104061.awb")

						arg_8_1:RecordAudio("104061002", var_11_15)
						arg_8_1:RecordAudio("104061002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104061", "104061002", "story_v_out_104061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104061", "104061002", "story_v_out_104061.awb")
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
				actorName = "1035ui_story",
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
	Play104061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104061003
		arg_12_1.duration_ = 8.9

		local var_12_0 = {
			ja = 8.9,
			ko = 5.533,
			zh = 5.066,
			en = 7.2
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
				arg_12_0:Play104061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1148ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1148ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1148ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1148ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1148ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1148ui_story == nil then
				arg_12_1.var_.characterEffect1148ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1148ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1148ui_story then
				arg_12_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1148ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1148ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_15_8 = arg_12_1.actors_["1035ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1035ui_story = var_15_8.localPosition
			end

			local var_15_9 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_9)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0, 100, 0)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_10 = 0
			local var_15_11 = 0.6

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(104061003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 24 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 24)

				if (24 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 24)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061003", "story_v_out_104061.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_104061", "104061003", "story_v_out_104061.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_104061", "104061003", "story_v_out_104061.awb")

						arg_12_1:RecordAudio("104061003", var_15_17)
						arg_12_1:RecordAudio("104061003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104061", "104061003", "story_v_out_104061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104061", "104061003", "story_v_out_104061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play104061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104061004
		arg_16_1.duration_ = 4.1

		local var_16_0 = {
			ja = 3.766,
			ko = 2.466,
			zh = 4.1,
			en = 2.933
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
				arg_16_0:Play104061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = arg_16_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).z)
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles = arg_16_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).z)
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles = arg_16_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1035ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1035ui_story = var_19_1.localPosition
			end

			local var_19_2 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 then
				var_19_1.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_16_1.time_ - 0) / var_19_2)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 then
				var_19_1.localPosition = Vector3.New(0, -1.05, -5.6)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action7_1")
			end

			local var_19_3 = arg_16_1.actors_["1035ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1035ui_story == nil then
				arg_16_1.var_.characterEffect1035ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1035ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1035ui_story then
				arg_16_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_19_6 = 0
			local var_19_7 = 0.175

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(104061004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 7 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 7)

				if (7 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 7)) > 0 and var_19_7 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061004", "story_v_out_104061.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_104061", "104061004", "story_v_out_104061.awb") / 1000

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_104061", "104061004", "story_v_out_104061.awb")

						arg_16_1:RecordAudio("104061004", var_19_13)
						arg_16_1:RecordAudio("104061004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104061", "104061004", "story_v_out_104061.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104061", "104061004", "story_v_out_104061.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play104061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104061005
		arg_20_1.duration_ = 8.2

		local var_20_0 = {
			ja = 7.533,
			ko = 6.1,
			zh = 8.2,
			en = 5.7
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
				arg_20_0:Play104061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1059ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1059ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1059ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1059ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1059ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1059ui_story == nil then
				arg_20_1.var_.characterEffect1059ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect1059ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1059ui_story then
				arg_20_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_23_6 = arg_20_1.actors_["1148ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1148ui_story = var_23_6.localPosition
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_7)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, 100, 0)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			local var_23_8 = arg_20_1.actors_["1059ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1059ui_story = var_23_8.localPosition
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_20_1.time_ - 0) / var_23_9)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0, -1.05, -6)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_23_10 = arg_20_1.actors_["1035ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1035ui_story = var_23_10.localPosition
			end

			local var_23_11 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 then
				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_11)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(0, 100, 0)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_23_12 = 0
			local var_23_13 = 0.825

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(104061005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 33 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 33)

				if (33 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 33)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061005", "story_v_out_104061.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_104061", "104061005", "story_v_out_104061.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_104061", "104061005", "story_v_out_104061.awb")

						arg_20_1:RecordAudio("104061005", var_23_19)
						arg_20_1:RecordAudio("104061005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104061", "104061005", "story_v_out_104061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104061", "104061005", "story_v_out_104061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_20 and arg_20_1.time_ < var_23_12 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
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
	Play104061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104061006
		arg_24_1.duration_ = 3.63

		local var_24_0 = {
			ja = 3.633,
			ko = 3.6,
			zh = 2.666,
			en = 3.166
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
				arg_24_0:Play104061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_24_1.stage_.transform)

				var_27_0.name = "2020_tpose"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["2020_tpose"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["2020_tpose" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["2020_tpose" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["2020_tpose" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["2020_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect2020_tpose == nil then
				arg_24_1.var_.characterEffect2020_tpose = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect2020_tpose and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect2020_tpose then
				arg_24_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_27_6 = arg_24_1.actors_["1059ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1059ui_story == nil then
				arg_24_1.var_.characterEffect1059ui_story = var_27_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 and not isNil(var_27_6) then
				if arg_24_1.var_.characterEffect1059ui_story and not isNil(var_27_6) then
					arg_24_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_7)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1059ui_story then
				arg_24_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_27_8 = arg_24_1.actors_["1059ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, 100, 0)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			local var_27_10 = arg_24_1.actors_["2020_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos2020_tpose = var_27_10.localPosition

				local var_27_11 = GameObjectTools.GetOrAddComponent(var_27_10.gameObject, typeof(DynamicBoneHelper))

				if var_27_11 then
					var_27_11:EnableDynamicBone(false)
				end
			end

			local var_27_12 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_12 then
				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos2020_tpose, Vector3.New(-0.7, -1.2, -4.1), (arg_24_1.time_ - 0) / var_27_12)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_12 and arg_24_1.time_ < 0 + var_27_12 + arg_27_0 then
				var_27_10.localPosition = Vector3.New(-0.7, -1.2, -4.1)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles

				local var_27_13 = GameObjectTools.GetOrAddComponent(var_27_10.gameObject, typeof(DynamicBoneHelper))

				if var_27_13 then
					var_27_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_27_14 = 0
			local var_27_15 = 0.375

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(104061006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 15 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 15)

				if (15 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 15)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061006", "story_v_out_104061.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_104061", "104061006", "story_v_out_104061.awb") / 1000

					if var_27_20 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_14
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_104061", "104061006", "story_v_out_104061.awb")

						arg_24_1:RecordAudio("104061006", var_27_21)
						arg_24_1:RecordAudio("104061006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104061", "104061006", "story_v_out_104061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104061", "104061006", "story_v_out_104061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_22 and arg_24_1.time_ < var_27_14 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
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
	Play104061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104061007
		arg_28_1.duration_ = 9

		local var_28_0 = {
			ja = 4.8,
			ko = 6.666,
			zh = 9,
			en = 6.733
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
				arg_28_0:Play104061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1035ui_story = arg_28_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1035ui_story, Vector3.New(0.7, -1.05, -5.6), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1035ui_story"].transform.position).z)
				arg_28_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1035ui_story"].transform.localEulerAngles = arg_28_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -5.6)
				arg_28_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1035ui_story"].transform.position).z)
				arg_28_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1035ui_story"].transform.localEulerAngles = arg_28_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action1_1")
			end

			local var_31_1 = arg_28_1.actors_["2020_tpose"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect2020_tpose == nil then
				arg_28_1.var_.characterEffect2020_tpose = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect2020_tpose and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_28_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_2)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect2020_tpose then
				arg_28_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_28_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_31_3 = arg_28_1.actors_["1035ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1035ui_story == nil then
				arg_28_1.var_.characterEffect1035ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect1035ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1035ui_story then
				arg_28_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_31_6 = 0
			local var_31_7 = 0.775

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(104061007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 30 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 30)

				if (30 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 30)) > 0 and var_31_7 < var_31_11 then
					arg_28_1.talkMaxDuration = var_31_11

					if var_31_11 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_11 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061007", "story_v_out_104061.awb") ~= 0 then
					local var_31_12 = manager.audio:GetVoiceLength("story_v_out_104061", "104061007", "story_v_out_104061.awb") / 1000

					if var_31_12 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_6
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_out_104061", "104061007", "story_v_out_104061.awb")

						arg_28_1:RecordAudio("104061007", var_31_13)
						arg_28_1:RecordAudio("104061007", var_31_13)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104061", "104061007", "story_v_out_104061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104061", "104061007", "story_v_out_104061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play104061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104061008
		arg_32_1.duration_ = 6.73

		local var_32_0 = {
			ja = 6.733,
			ko = 4.8,
			zh = 4,
			en = 5.766
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
				arg_32_0:Play104061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["2020_tpose"]) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = arg_32_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["2020_tpose"]) then
				if arg_32_1.var_.characterEffect2020_tpose and not isNil(arg_32_1.actors_["2020_tpose"]) then
					arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["2020_tpose"]) and arg_32_1.var_.characterEffect2020_tpose then
				arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["2020_tpose"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect2020_tpose == nil then
				arg_32_1.var_.characterEffect2020_tpose = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect2020_tpose and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect2020_tpose then
				arg_32_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_35_5 = arg_32_1.actors_["1035ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1035ui_story == nil then
				arg_32_1.var_.characterEffect1035ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect1035ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_6)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1035ui_story then
				arg_32_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_35_7 = 0
			local var_35_8 = 0.55

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_9 = arg_32_1:GetWordFromCfg(104061008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_12 = 22 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_10) / 22)

				if (22 <= 0 and var_35_8 or var_35_8 * (utf8.len(var_35_10) / 22)) > 0 and var_35_8 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_7
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061008", "story_v_out_104061.awb") ~= 0 then
					local var_35_13 = manager.audio:GetVoiceLength("story_v_out_104061", "104061008", "story_v_out_104061.awb") / 1000

					if var_35_13 + var_35_7 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_7
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_104061", "104061008", "story_v_out_104061.awb")

						arg_32_1:RecordAudio("104061008", var_35_14)
						arg_32_1:RecordAudio("104061008", var_35_14)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104061", "104061008", "story_v_out_104061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104061", "104061008", "story_v_out_104061.awb")
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

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104061009
		arg_36_1.duration_ = 4.6

		local var_36_0 = {
			ja = 3.066,
			ko = 2.666,
			zh = 3.6,
			en = 4.6
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
				arg_36_0:Play104061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["2020_tpose"]) and arg_36_1.var_.characterEffect2020_tpose == nil then
				arg_36_1.var_.characterEffect2020_tpose = arg_36_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["2020_tpose"]) then
				if arg_36_1.var_.characterEffect2020_tpose and not isNil(arg_36_1.actors_["2020_tpose"]) then
					arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_36_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["2020_tpose"]) and arg_36_1.var_.characterEffect2020_tpose then
				arg_36_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_36_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_39_1 = arg_36_1.actors_["1035ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1035ui_story == nil then
				arg_36_1.var_.characterEffect1035ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect1035ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1035ui_story then
				arg_36_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_39_4 = 0
			local var_39_5 = 0.275

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(104061009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 11 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 11)

				if (11 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 11)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061009", "story_v_out_104061.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_104061", "104061009", "story_v_out_104061.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_104061", "104061009", "story_v_out_104061.awb")

						arg_36_1:RecordAudio("104061009", var_39_11)
						arg_36_1:RecordAudio("104061009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104061", "104061009", "story_v_out_104061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104061", "104061009", "story_v_out_104061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104061010
		arg_40_1.duration_ = 6.93

		local var_40_0 = {
			ja = 6.933,
			ko = 4.366,
			zh = 3.9,
			en = 4.433
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
				arg_40_0:Play104061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) and arg_40_1.var_.characterEffect1148ui_story == nil then
				arg_40_1.var_.characterEffect1148ui_story = arg_40_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) then
				if arg_40_1.var_.characterEffect1148ui_story and not isNil(arg_40_1.actors_["1148ui_story"]) then
					arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) and arg_40_1.var_.characterEffect1148ui_story then
				arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["2020_tpose"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos2020_tpose = var_43_2.localPosition

				local var_43_3 = GameObjectTools.GetOrAddComponent(var_43_2.gameObject, typeof(DynamicBoneHelper))

				if var_43_3 then
					var_43_3:EnableDynamicBone(false)
				end
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_2.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_4)
				var_43_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_2.position).x, (manager.ui.mainCamera.transform.position - var_43_2.position).y, (manager.ui.mainCamera.transform.position - var_43_2.position).z)
				var_43_2.localEulerAngles.z = 0
				var_43_2.localEulerAngles.x = 0
				var_43_2.localEulerAngles = var_43_2.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_2.localPosition = Vector3.New(0, 100, 0)
				var_43_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_2.position).x, (manager.ui.mainCamera.transform.position - var_43_2.position).y, (manager.ui.mainCamera.transform.position - var_43_2.position).z)
				var_43_2.localEulerAngles.z = 0
				var_43_2.localEulerAngles.x = 0
				var_43_2.localEulerAngles = var_43_2.localEulerAngles

				local var_43_5 = GameObjectTools.GetOrAddComponent(var_43_2.gameObject, typeof(DynamicBoneHelper))

				if var_43_5 then
					var_43_5:EnableDynamicBone(true)
				end
			end

			local var_43_6 = arg_40_1.actors_["1148ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1148ui_story = var_43_6.localPosition
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_40_1.time_ - 0) / var_43_7)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, -0.8, -6.2)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_43_8 = arg_40_1.actors_["1035ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1035ui_story = var_43_8.localPosition
			end

			local var_43_9 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_9 then
				var_43_8.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_9)
				var_43_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_8.position).x, (manager.ui.mainCamera.transform.position - var_43_8.position).y, (manager.ui.mainCamera.transform.position - var_43_8.position).z)
				var_43_8.localEulerAngles.z = 0
				var_43_8.localEulerAngles.x = 0
				var_43_8.localEulerAngles = var_43_8.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_9 and arg_40_1.time_ < 0 + var_43_9 + arg_43_0 then
				var_43_8.localPosition = Vector3.New(0, 100, 0)
				var_43_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_8.position).x, (manager.ui.mainCamera.transform.position - var_43_8.position).y, (manager.ui.mainCamera.transform.position - var_43_8.position).z)
				var_43_8.localEulerAngles.z = 0
				var_43_8.localEulerAngles.x = 0
				var_43_8.localEulerAngles = var_43_8.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_43_10 = 0
			local var_43_11 = 0.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_12 = arg_40_1:GetWordFromCfg(104061010)
				local var_43_13 = arg_40_1:FormatText(var_43_12.content)

				arg_40_1.text_.text = var_43_13

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_15 = 12 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 12)

				if (12 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 12)) > 0 and var_43_11 < var_43_15 then
					arg_40_1.talkMaxDuration = var_43_15

					if var_43_15 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_10
					end
				end

				arg_40_1.text_.text = var_43_13
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061010", "story_v_out_104061.awb") ~= 0 then
					local var_43_16 = manager.audio:GetVoiceLength("story_v_out_104061", "104061010", "story_v_out_104061.awb") / 1000

					if var_43_16 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_10
					end

					if var_43_12.prefab_name ~= "" and arg_40_1.actors_[var_43_12.prefab_name] ~= nil then
						local var_43_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_12.prefab_name].transform, "story_v_out_104061", "104061010", "story_v_out_104061.awb")

						arg_40_1:RecordAudio("104061010", var_43_17)
						arg_40_1:RecordAudio("104061010", var_43_17)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104061", "104061010", "story_v_out_104061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104061", "104061010", "story_v_out_104061.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_10) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_10 + var_43_18 and arg_40_1.time_ < var_43_10 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play104061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104061011
		arg_44_1.duration_ = 7.33

		local var_44_0 = {
			ja = 7.333,
			ko = 4.466,
			zh = 4.1,
			en = 5.7
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
				arg_44_0:Play104061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1148ui_story"]) and arg_44_1.var_.characterEffect1148ui_story == nil then
				arg_44_1.var_.characterEffect1148ui_story = arg_44_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1148ui_story"]) then
				if arg_44_1.var_.characterEffect1148ui_story and not isNil(arg_44_1.actors_["1148ui_story"]) then
					arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1148ui_story"]) and arg_44_1.var_.characterEffect1148ui_story then
				arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1035")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(104061011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 20 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_4) / 20)

				if (20 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_4) / 20)) > 0 and var_47_2 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061011", "story_v_out_104061.awb") ~= 0 then
					local var_47_7 = manager.audio:GetVoiceLength("story_v_out_104061", "104061011", "story_v_out_104061.awb") / 1000

					if var_47_7 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_1
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_104061", "104061011", "story_v_out_104061.awb")

						arg_44_1:RecordAudio("104061011", var_47_8)
						arg_44_1:RecordAudio("104061011", var_47_8)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104061", "104061011", "story_v_out_104061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104061", "104061011", "story_v_out_104061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_9 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_9 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_9

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_9 and arg_44_1.time_ < var_47_1 + var_47_9 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104061012
		arg_48_1.duration_ = 4.1

		local var_48_0 = {
			ja = 2.833,
			ko = 4.1,
			zh = 2.9,
			en = 3.033
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
				arg_48_0:Play104061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1059ui_story"]) and arg_48_1.var_.characterEffect1059ui_story == nil then
				arg_48_1.var_.characterEffect1059ui_story = arg_48_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1059ui_story"]) then
				if arg_48_1.var_.characterEffect1059ui_story and not isNil(arg_48_1.actors_["1059ui_story"]) then
					arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1059ui_story"]) and arg_48_1.var_.characterEffect1059ui_story then
				arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1148ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1148ui_story = var_51_2.localPosition
			end

			local var_51_3 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_3)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(0, 100, 0)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			local var_51_4 = arg_48_1.actors_["1059ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1059ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0, -1.05, -6)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_6 = 0
			local var_51_7 = 0.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_8 = arg_48_1:GetWordFromCfg(104061012)
				local var_51_9 = arg_48_1:FormatText(var_51_8.content)

				arg_48_1.text_.text = var_51_9

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 15 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 15)

				if (15 <= 0 and var_51_7 or var_51_7 * (utf8.len(var_51_9) / 15)) > 0 and var_51_7 < var_51_11 then
					arg_48_1.talkMaxDuration = var_51_11

					if var_51_11 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_9
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061012", "story_v_out_104061.awb") ~= 0 then
					local var_51_12 = manager.audio:GetVoiceLength("story_v_out_104061", "104061012", "story_v_out_104061.awb") / 1000

					if var_51_12 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_6
					end

					if var_51_8.prefab_name ~= "" and arg_48_1.actors_[var_51_8.prefab_name] ~= nil then
						local var_51_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_8.prefab_name].transform, "story_v_out_104061", "104061012", "story_v_out_104061.awb")

						arg_48_1:RecordAudio("104061012", var_51_13)
						arg_48_1:RecordAudio("104061012", var_51_13)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104061", "104061012", "story_v_out_104061.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104061", "104061012", "story_v_out_104061.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play104061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104061013
		arg_52_1.duration_ = 6.77

		local var_52_0 = {
			ja = 6.766,
			ko = 6.1,
			zh = 3.166,
			en = 3.7
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
				arg_52_0:Play104061015(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1148ui_story"]) and arg_52_1.var_.characterEffect1148ui_story == nil then
				arg_52_1.var_.characterEffect1148ui_story = arg_52_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1148ui_story"]) then
				if arg_52_1.var_.characterEffect1148ui_story and not isNil(arg_52_1.actors_["1148ui_story"]) then
					arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1148ui_story"]) and arg_52_1.var_.characterEffect1148ui_story then
				arg_52_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["1059ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1059ui_story == nil then
				arg_52_1.var_.characterEffect1059ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1059ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1059ui_story then
				arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_55_4 = arg_52_1.actors_["1059ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1059ui_story = var_55_4.localPosition
			end

			local var_55_5 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_5 then
				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_5)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_5 and arg_52_1.time_ < 0 + var_55_5 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(0, 100, 0)
				var_55_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_4.position).x, (manager.ui.mainCamera.transform.position - var_55_4.position).y, (manager.ui.mainCamera.transform.position - var_55_4.position).z)
				var_55_4.localEulerAngles.z = 0
				var_55_4.localEulerAngles.x = 0
				var_55_4.localEulerAngles = var_55_4.localEulerAngles
			end

			local var_55_6 = arg_52_1.actors_["1148ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1148ui_story = var_55_6.localPosition
			end

			local var_55_7 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				var_55_6.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_52_1.time_ - 0) / var_55_7)
				var_55_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_6.position).x, (manager.ui.mainCamera.transform.position - var_55_6.position).y, (manager.ui.mainCamera.transform.position - var_55_6.position).z)
				var_55_6.localEulerAngles.z = 0
				var_55_6.localEulerAngles.x = 0
				var_55_6.localEulerAngles = var_55_6.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				var_55_6.localPosition = Vector3.New(0, -0.8, -6.2)
				var_55_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_6.position).x, (manager.ui.mainCamera.transform.position - var_55_6.position).y, (manager.ui.mainCamera.transform.position - var_55_6.position).z)
				var_55_6.localEulerAngles.z = 0
				var_55_6.localEulerAngles.x = 0
				var_55_6.localEulerAngles = var_55_6.localEulerAngles
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_55_8 = 0
			local var_55_9 = 0.375

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_10 = arg_52_1:GetWordFromCfg(104061013)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 15 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 15)

				if (15 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 15)) > 0 and var_55_9 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061013", "story_v_out_104061.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_104061", "104061013", "story_v_out_104061.awb") / 1000

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end

					if var_55_10.prefab_name ~= "" and arg_52_1.actors_[var_55_10.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_10.prefab_name].transform, "story_v_out_104061", "104061013", "story_v_out_104061.awb")

						arg_52_1:RecordAudio("104061013", var_55_15)
						arg_52_1:RecordAudio("104061013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104061", "104061013", "story_v_out_104061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104061", "104061013", "story_v_out_104061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_9, arg_52_1.talkMaxDuration)

			if var_55_8 <= arg_52_1.time_ and arg_52_1.time_ < var_55_8 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_8) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_8 + var_55_16 and arg_52_1.time_ < var_55_8 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play104061015 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104061015
		arg_56_1.duration_ = 6.27

		local var_56_0 = {
			ja = 6.266,
			ko = 4.733,
			zh = 4.366,
			en = 5.5
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
				arg_56_0:Play104061016(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_59_1 = "3005_tpose"

			if arg_56_1.actors_["3005_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3005_tpose"))) then
				local var_59_2 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_56_1.stage_.transform)

				var_59_2.name = var_59_1
				var_59_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_[var_59_1] = var_59_2

				local var_59_3 = var_59_2:GetComponentInChildren(typeof(CharacterEffect))

				var_59_3.enabled = true

				local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_2, typeof(DynamicBoneHelper))

				if var_59_4 then
					var_59_4:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_3.transform, false)

				arg_56_1.var_[var_59_1 .. "Animator"] = var_59_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_[var_59_1 .. "Animator"].applyRootMotion = true
				arg_56_1.var_[var_59_1 .. "LipSync"] = var_59_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_5 = arg_56_1.actors_["3005_tpose"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect3005_tpose == nil then
				arg_56_1.var_.characterEffect3005_tpose = var_59_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_6 and not isNil(var_59_5) then
				if arg_56_1.var_.characterEffect3005_tpose and not isNil(var_59_5) then
					arg_56_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_6 and arg_56_1.time_ < 0 + var_59_6 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect3005_tpose then
				arg_56_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_59_8 = arg_56_1.actors_["1148ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.characterEffect1148ui_story == nil then
				arg_56_1.var_.characterEffect1148ui_story = var_59_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_9 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_9 and not isNil(var_59_8) then
				if arg_56_1.var_.characterEffect1148ui_story and not isNil(var_59_8) then
					arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_9)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_9 and arg_56_1.time_ < 0 + var_59_9 + arg_59_0 and not isNil(var_59_8) and arg_56_1.var_.characterEffect1148ui_story then
				arg_56_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_59_10 = arg_56_1.actors_["1148ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1148ui_story = var_59_10.localPosition
			end

			local var_59_11 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_11 then
				var_59_10.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_11)
				var_59_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_10.position).x, (manager.ui.mainCamera.transform.position - var_59_10.position).y, (manager.ui.mainCamera.transform.position - var_59_10.position).z)
				var_59_10.localEulerAngles.z = 0
				var_59_10.localEulerAngles.x = 0
				var_59_10.localEulerAngles = var_59_10.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_11 and arg_56_1.time_ < 0 + var_59_11 + arg_59_0 then
				var_59_10.localPosition = Vector3.New(0, 100, 0)
				var_59_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_10.position).x, (manager.ui.mainCamera.transform.position - var_59_10.position).y, (manager.ui.mainCamera.transform.position - var_59_10.position).z)
				var_59_10.localEulerAngles.z = 0
				var_59_10.localEulerAngles.x = 0
				var_59_10.localEulerAngles = var_59_10.localEulerAngles
			end

			local var_59_12 = arg_56_1.actors_["3005_tpose"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos3005_tpose = var_59_12.localPosition

				local var_59_13 = GameObjectTools.GetOrAddComponent(var_59_12.gameObject, typeof(DynamicBoneHelper))

				if var_59_13 then
					var_59_13:EnableDynamicBone(false)
				end
			end

			local var_59_14 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_14 then
				var_59_12.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3005_tpose, Vector3.New(0, -1.95, -2.63), (arg_56_1.time_ - 0) / var_59_14)
				var_59_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_12.position).x, (manager.ui.mainCamera.transform.position - var_59_12.position).y, (manager.ui.mainCamera.transform.position - var_59_12.position).z)
				var_59_12.localEulerAngles.z = 0
				var_59_12.localEulerAngles.x = 0
				var_59_12.localEulerAngles = var_59_12.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_14 and arg_56_1.time_ < 0 + var_59_14 + arg_59_0 then
				var_59_12.localPosition = Vector3.New(0, -1.95, -2.63)
				var_59_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_12.position).x, (manager.ui.mainCamera.transform.position - var_59_12.position).y, (manager.ui.mainCamera.transform.position - var_59_12.position).z)
				var_59_12.localEulerAngles.z = 0
				var_59_12.localEulerAngles.x = 0
				var_59_12.localEulerAngles = var_59_12.localEulerAngles

				local var_59_15 = GameObjectTools.GetOrAddComponent(var_59_12.gameObject, typeof(DynamicBoneHelper))

				if var_59_15 then
					var_59_15:EnableDynamicBone(true)
				end
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_59_16 = 0
			local var_59_17 = 0.6

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[58].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_18 = arg_56_1:GetWordFromCfg(104061015)
				local var_59_19 = arg_56_1:FormatText(var_59_18.content)

				arg_56_1.text_.text = var_59_19

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_21 = 23 <= 0 and var_59_17 or var_59_17 * (utf8.len(var_59_19) / 23)

				if (23 <= 0 and var_59_17 or var_59_17 * (utf8.len(var_59_19) / 23)) > 0 and var_59_17 < var_59_21 then
					arg_56_1.talkMaxDuration = var_59_21

					if var_59_21 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_21 + var_59_16
					end
				end

				arg_56_1.text_.text = var_59_19
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061015", "story_v_out_104061.awb") ~= 0 then
					local var_59_22 = manager.audio:GetVoiceLength("story_v_out_104061", "104061015", "story_v_out_104061.awb") / 1000

					if var_59_22 + var_59_16 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_16
					end

					if var_59_18.prefab_name ~= "" and arg_56_1.actors_[var_59_18.prefab_name] ~= nil then
						local var_59_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_18.prefab_name].transform, "story_v_out_104061", "104061015", "story_v_out_104061.awb")

						arg_56_1:RecordAudio("104061015", var_59_23)
						arg_56_1:RecordAudio("104061015", var_59_23)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104061", "104061015", "story_v_out_104061.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104061", "104061015", "story_v_out_104061.awb")
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
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play104061016 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104061016
		arg_60_1.duration_ = 2.53

		local var_60_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_60_0:Play104061017(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story == nil then
				arg_60_1.var_.characterEffect1148ui_story = arg_60_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) then
				if arg_60_1.var_.characterEffect1148ui_story and not isNil(arg_60_1.actors_["1148ui_story"]) then
					arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story then
				arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["3005_tpose"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect3005_tpose == nil then
				arg_60_1.var_.characterEffect3005_tpose = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect3005_tpose and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_60_1.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect3005_tpose then
				arg_60_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_60_1.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			local var_63_4 = arg_60_1.actors_["3005_tpose"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos3005_tpose = var_63_4.localPosition

				local var_63_5 = GameObjectTools.GetOrAddComponent(var_63_4.gameObject, typeof(DynamicBoneHelper))

				if var_63_5 then
					var_63_5:EnableDynamicBone(false)
				end
			end

			local var_63_6 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_6 then
				var_63_4.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos3005_tpose, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_6)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_6 and arg_60_1.time_ < 0 + var_63_6 + arg_63_0 then
				var_63_4.localPosition = Vector3.New(0, 100, 0)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles

				local var_63_7 = GameObjectTools.GetOrAddComponent(var_63_4.gameObject, typeof(DynamicBoneHelper))

				if var_63_7 then
					var_63_7:EnableDynamicBone(true)
				end
			end

			local var_63_8 = arg_60_1.actors_["1148ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1148ui_story = var_63_8.localPosition
			end

			local var_63_9 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_9 then
				var_63_8.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_60_1.time_ - 0) / var_63_9)
				var_63_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_8.position).x, (manager.ui.mainCamera.transform.position - var_63_8.position).y, (manager.ui.mainCamera.transform.position - var_63_8.position).z)
				var_63_8.localEulerAngles.z = 0
				var_63_8.localEulerAngles.x = 0
				var_63_8.localEulerAngles = var_63_8.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_9 and arg_60_1.time_ < 0 + var_63_9 + arg_63_0 then
				var_63_8.localPosition = Vector3.New(0, -0.8, -6.2)
				var_63_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_8.position).x, (manager.ui.mainCamera.transform.position - var_63_8.position).y, (manager.ui.mainCamera.transform.position - var_63_8.position).z)
				var_63_8.localEulerAngles.z = 0
				var_63_8.localEulerAngles.x = 0
				var_63_8.localEulerAngles = var_63_8.localEulerAngles
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_10 = 0
			local var_63_11 = 0.225

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_12 = arg_60_1:GetWordFromCfg(104061016)
				local var_63_13 = arg_60_1:FormatText(var_63_12.content)

				arg_60_1.text_.text = var_63_13

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 9 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 9)

				if (9 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 9)) > 0 and var_63_11 < var_63_15 then
					arg_60_1.talkMaxDuration = var_63_15

					if var_63_15 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_15 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_13
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061016", "story_v_out_104061.awb") ~= 0 then
					local var_63_16 = manager.audio:GetVoiceLength("story_v_out_104061", "104061016", "story_v_out_104061.awb") / 1000

					if var_63_16 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_16 + var_63_10
					end

					if var_63_12.prefab_name ~= "" and arg_60_1.actors_[var_63_12.prefab_name] ~= nil then
						local var_63_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_12.prefab_name].transform, "story_v_out_104061", "104061016", "story_v_out_104061.awb")

						arg_60_1:RecordAudio("104061016", var_63_17)
						arg_60_1:RecordAudio("104061016", var_63_17)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104061", "104061016", "story_v_out_104061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104061", "104061016", "story_v_out_104061.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_18 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_18 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_18

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_18 and arg_60_1.time_ < var_63_10 + var_63_18 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play104061017 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104061017
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104061018(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_4", "se_story_4_arm_1", "")
			end

			local var_67_1 = arg_64_1.actors_["1148ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1148ui_story == nil then
				arg_64_1.var_.characterEffect1148ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect1148ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_2)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1148ui_story then
				arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_67_3 = manager.ui.mainCamera.transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.shakeOldPosMainCamera = var_67_3.localPosition
			end

			local var_67_4 = 0.600000023841858

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				local var_67_5, var_67_6 = math.modf((arg_64_1.time_ - 0) / 0.066)

				var_67_3.localPosition = Vector3.New(var_67_6 * 0.13, var_67_6 * 0.13, var_67_6 * 0.13) + arg_64_1.var_.shakeOldPosMainCamera
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_3.localPosition = arg_64_1.var_.shakeOldPosMainCamera
			end

			local var_67_7 = arg_64_1.actors_["1148ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1148ui_story = var_67_7.localPosition
			end

			local var_67_8 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_8 then
				var_67_7.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_8)
				var_67_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_7.position).x, (manager.ui.mainCamera.transform.position - var_67_7.position).y, (manager.ui.mainCamera.transform.position - var_67_7.position).z)
				var_67_7.localEulerAngles.z = 0
				var_67_7.localEulerAngles.x = 0
				var_67_7.localEulerAngles = var_67_7.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_8 and arg_64_1.time_ < 0 + var_67_8 + arg_67_0 then
				var_67_7.localPosition = Vector3.New(0, 100, 0)
				var_67_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_7.position).x, (manager.ui.mainCamera.transform.position - var_67_7.position).y, (manager.ui.mainCamera.transform.position - var_67_7.position).z)
				var_67_7.localEulerAngles.z = 0
				var_67_7.localEulerAngles.x = 0
				var_67_7.localEulerAngles = var_67_7.localEulerAngles
			end

			local var_67_9 = 0
			local var_67_10 = 1.05

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_11 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(104061017).content)

				arg_64_1.text_.text = var_67_11

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_13 = 42 <= 0 and var_67_10 or var_67_10 * (utf8.len(var_67_11) / 42)

				if (42 <= 0 and var_67_10 or var_67_10 * (utf8.len(var_67_11) / 42)) > 0 and var_67_10 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_9 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_9
					end
				end

				arg_64_1.text_.text = var_67_11
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_10, arg_64_1.talkMaxDuration)

			if var_67_9 <= arg_64_1.time_ and arg_64_1.time_ < var_67_9 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_9) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_9 + var_67_14 and arg_64_1.time_ < var_67_9 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play104061018 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104061018
		arg_68_1.duration_ = 3.27

		local var_68_0 = {
			ja = 2.5,
			ko = 2.833,
			zh = 2.7,
			en = 3.266
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play104061019(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1059ui_story"]) and arg_68_1.var_.characterEffect1059ui_story == nil then
				arg_68_1.var_.characterEffect1059ui_story = arg_68_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1059ui_story"]) then
				if arg_68_1.var_.characterEffect1059ui_story and not isNil(arg_68_1.actors_["1059ui_story"]) then
					arg_68_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1059ui_story"]) and arg_68_1.var_.characterEffect1059ui_story then
				arg_68_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1059ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1059ui_story = var_71_2.localPosition
			end

			local var_71_3 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_68_1.time_ - 0) / var_71_3)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(0, -1.05, -6)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_71_4 = 0
			local var_71_5 = 0.225

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(104061018)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 9 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 9)

				if (9 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 9)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061018", "story_v_out_104061.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_104061", "104061018", "story_v_out_104061.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_104061", "104061018", "story_v_out_104061.awb")

						arg_68_1:RecordAudio("104061018", var_71_11)
						arg_68_1:RecordAudio("104061018", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104061", "104061018", "story_v_out_104061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104061", "104061018", "story_v_out_104061.awb")
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play104061019 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104061019
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104061020(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1059ui_story"]) and arg_72_1.var_.characterEffect1059ui_story == nil then
				arg_72_1.var_.characterEffect1059ui_story = arg_72_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1059ui_story"]) then
				if arg_72_1.var_.characterEffect1059ui_story and not isNil(arg_72_1.actors_["1059ui_story"]) then
					arg_72_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1059ui_story"]) and arg_72_1.var_.characterEffect1059ui_story then
				arg_72_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.325

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(104061019).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 13 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 13)

				if (13 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 13)) > 0 and var_75_2 < var_75_5 then
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
	Play104061020 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 104061020
		arg_76_1.duration_ = 1.83

		local var_76_0 = {
			ja = 1.833,
			ko = 1.499999999999,
			zh = 1.733,
			en = 1.633
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
				arg_76_0:Play104061021(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = arg_76_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) then
				if arg_76_1.var_.characterEffect1059ui_story and not isNil(arg_76_1.actors_["1059ui_story"]) then
					arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story then
				arg_76_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action426")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_2 = 0
			local var_79_3 = 0.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(104061020)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 8 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 8)

				if (8 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 8)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061020", "story_v_out_104061.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_104061", "104061020", "story_v_out_104061.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_104061", "104061020", "story_v_out_104061.awb")

						arg_76_1:RecordAudio("104061020", var_79_9)
						arg_76_1:RecordAudio("104061020", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_104061", "104061020", "story_v_out_104061.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_104061", "104061020", "story_v_out_104061.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play104061021 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 104061021
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play104061022(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1059ui_story"]) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = arg_80_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1059ui_story"]) then
				if arg_80_1.var_.characterEffect1059ui_story and not isNil(arg_80_1.actors_["1059ui_story"]) then
					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1059ui_story"]) and arg_80_1.var_.characterEffect1059ui_story then
				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.775

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(104061021).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 31 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 31)

				if (31 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 31)) > 0 and var_83_2 < var_83_5 then
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
	Play104061022 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104061022
		arg_84_1.duration_ = 2.7

		local var_84_0 = {
			ja = 2.533,
			ko = 1.466,
			zh = 1.7,
			en = 2.7
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
				arg_84_0:Play104061023(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1059ui_story"]) and arg_84_1.var_.characterEffect1059ui_story == nil then
				arg_84_1.var_.characterEffect1059ui_story = arg_84_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1059ui_story"]) then
				if arg_84_1.var_.characterEffect1059ui_story and not isNil(arg_84_1.actors_["1059ui_story"]) then
					arg_84_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1059ui_story"]) and arg_84_1.var_.characterEffect1059ui_story then
				arg_84_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_87_2 = 0
			local var_87_3 = 0.125

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(104061022)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 5 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 5)

				if (5 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 5)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061022", "story_v_out_104061.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_104061", "104061022", "story_v_out_104061.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_104061", "104061022", "story_v_out_104061.awb")

						arg_84_1:RecordAudio("104061022", var_87_9)
						arg_84_1:RecordAudio("104061022", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104061", "104061022", "story_v_out_104061.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104061", "104061022", "story_v_out_104061.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play104061023 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 104061023
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play104061024(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1059ui_story"]) and arg_88_1.var_.characterEffect1059ui_story == nil then
				arg_88_1.var_.characterEffect1059ui_story = arg_88_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1059ui_story"]) then
				if arg_88_1.var_.characterEffect1059ui_story and not isNil(arg_88_1.actors_["1059ui_story"]) then
					arg_88_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1059ui_story"]) and arg_88_1.var_.characterEffect1059ui_story then
				arg_88_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.275

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(104061023).content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 11 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 11)

				if (11 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 11)) > 0 and var_91_2 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_6 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_6 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_6

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_6 and arg_88_1.time_ < var_91_1 + var_91_6 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play104061024 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 104061024
		arg_92_1.duration_ = 7.57

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play104061025(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_95_1 = "2043_tpose"

			if arg_92_1.actors_["2043_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2043_tpose"))) then
				local var_95_2 = Object.Instantiate(Asset.Load("Char/" .. "2043_tpose"), arg_92_1.stage_.transform)

				var_95_2.name = var_95_1
				var_95_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_[var_95_1] = var_95_2

				local var_95_3 = var_95_2:GetComponentInChildren(typeof(CharacterEffect))

				var_95_3.enabled = true

				local var_95_4 = GameObjectTools.GetOrAddComponent(var_95_2, typeof(DynamicBoneHelper))

				if var_95_4 then
					var_95_4:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(var_95_3.transform, false)

				arg_92_1.var_[var_95_1 .. "Animator"] = var_95_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_92_1.var_[var_95_1 .. "Animator"].applyRootMotion = true
				arg_92_1.var_[var_95_1 .. "LipSync"] = var_95_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_95_5 = arg_92_1.actors_["2043_tpose"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect2043_tpose == nil then
				arg_92_1.var_.characterEffect2043_tpose = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 and not isNil(var_95_5) then
				if arg_92_1.var_.characterEffect2043_tpose and not isNil(var_95_5) then
					arg_92_1.var_.characterEffect2043_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect2043_tpose then
				arg_92_1.var_.characterEffect2043_tpose.fillFlat = false
			end

			local var_95_8 = arg_92_1.actors_["3005_tpose"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.characterEffect3005_tpose == nil then
				arg_92_1.var_.characterEffect3005_tpose = var_95_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_9 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_9 and not isNil(var_95_8) then
				if arg_92_1.var_.characterEffect3005_tpose and not isNil(var_95_8) then
					arg_92_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_9 and arg_92_1.time_ < 0 + var_95_9 + arg_95_0 and not isNil(var_95_8) and arg_92_1.var_.characterEffect3005_tpose then
				arg_92_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_95_11 = arg_92_1.actors_["1059ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1059ui_story = var_95_11.localPosition
			end

			local var_95_12 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_12 then
				var_95_11.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_12)
				var_95_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_11.position).x, (manager.ui.mainCamera.transform.position - var_95_11.position).y, (manager.ui.mainCamera.transform.position - var_95_11.position).z)
				var_95_11.localEulerAngles.z = 0
				var_95_11.localEulerAngles.x = 0
				var_95_11.localEulerAngles = var_95_11.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_12 and arg_92_1.time_ < 0 + var_95_12 + arg_95_0 then
				var_95_11.localPosition = Vector3.New(0, 100, 0)
				var_95_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_11.position).x, (manager.ui.mainCamera.transform.position - var_95_11.position).y, (manager.ui.mainCamera.transform.position - var_95_11.position).z)
				var_95_11.localEulerAngles.z = 0
				var_95_11.localEulerAngles.x = 0
				var_95_11.localEulerAngles = var_95_11.localEulerAngles
			end

			local var_95_13 = arg_92_1.actors_["2043_tpose"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos2043_tpose = var_95_13.localPosition

				local var_95_14 = GameObjectTools.GetOrAddComponent(var_95_13.gameObject, typeof(DynamicBoneHelper))

				if var_95_14 then
					var_95_14:EnableDynamicBone(false)
				end
			end

			local var_95_15 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_15 then
				var_95_13.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos2043_tpose, Vector3.New(-0.7, -0.95, -3.2), (arg_92_1.time_ - 0) / var_95_15)
				var_95_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_13.position).x, (manager.ui.mainCamera.transform.position - var_95_13.position).y, (manager.ui.mainCamera.transform.position - var_95_13.position).z)
				var_95_13.localEulerAngles.z = 0
				var_95_13.localEulerAngles.x = 0
				var_95_13.localEulerAngles = var_95_13.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_15 and arg_92_1.time_ < 0 + var_95_15 + arg_95_0 then
				var_95_13.localPosition = Vector3.New(-0.7, -0.95, -3.2)
				var_95_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_13.position).x, (manager.ui.mainCamera.transform.position - var_95_13.position).y, (manager.ui.mainCamera.transform.position - var_95_13.position).z)
				var_95_13.localEulerAngles.z = 0
				var_95_13.localEulerAngles.x = 0
				var_95_13.localEulerAngles = var_95_13.localEulerAngles

				local var_95_16 = GameObjectTools.GetOrAddComponent(var_95_13.gameObject, typeof(DynamicBoneHelper))

				if var_95_16 then
					var_95_16:EnableDynamicBone(true)
				end
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("2043_tpose", "StoryTimeline/CharAction/story2043/story2043action/2043action1_1")
			end

			local var_95_17 = arg_92_1.actors_["3005_tpose"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos3005_tpose = var_95_17.localPosition

				local var_95_18 = GameObjectTools.GetOrAddComponent(var_95_17.gameObject, typeof(DynamicBoneHelper))

				if var_95_18 then
					var_95_18:EnableDynamicBone(false)
				end
			end

			local var_95_19 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_19 then
				var_95_17.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3005_tpose, Vector3.New(0.7, -1.95, -2.35), (arg_92_1.time_ - 0) / var_95_19)
				var_95_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_17.position).x, (manager.ui.mainCamera.transform.position - var_95_17.position).y, (manager.ui.mainCamera.transform.position - var_95_17.position).z)
				var_95_17.localEulerAngles.z = 0
				var_95_17.localEulerAngles.x = 0
				var_95_17.localEulerAngles = var_95_17.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_19 and arg_92_1.time_ < 0 + var_95_19 + arg_95_0 then
				var_95_17.localPosition = Vector3.New(0.7, -1.95, -2.35)
				var_95_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_17.position).x, (manager.ui.mainCamera.transform.position - var_95_17.position).y, (manager.ui.mainCamera.transform.position - var_95_17.position).z)
				var_95_17.localEulerAngles.z = 0
				var_95_17.localEulerAngles.x = 0
				var_95_17.localEulerAngles = var_95_17.localEulerAngles

				local var_95_20 = GameObjectTools.GetOrAddComponent(var_95_17.gameObject, typeof(DynamicBoneHelper))

				if var_95_20 then
					var_95_20:EnableDynamicBone(true)
				end
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_95_21 = 0
			local var_95_22 = 0.225

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_21 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[58].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_23 = arg_92_1:GetWordFromCfg(104061024)
				local var_95_24 = arg_92_1:FormatText(var_95_23.content)

				arg_92_1.text_.text = var_95_24

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_26 = 9 <= 0 and var_95_22 or var_95_22 * (utf8.len(var_95_24) / 9)

				if (9 <= 0 and var_95_22 or var_95_22 * (utf8.len(var_95_24) / 9)) > 0 and var_95_22 < var_95_26 then
					arg_92_1.talkMaxDuration = var_95_26

					if var_95_26 + var_95_21 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_26 + var_95_21
					end
				end

				arg_92_1.text_.text = var_95_24
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061024", "story_v_out_104061.awb") ~= 0 then
					local var_95_27 = manager.audio:GetVoiceLength("story_v_out_104061", "104061024", "story_v_out_104061.awb") / 1000

					if var_95_27 + var_95_21 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_27 + var_95_21
					end

					if var_95_23.prefab_name ~= "" and arg_92_1.actors_[var_95_23.prefab_name] ~= nil then
						local var_95_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_23.prefab_name].transform, "story_v_out_104061", "104061024", "story_v_out_104061.awb")

						arg_92_1:RecordAudio("104061024", var_95_28)
						arg_92_1:RecordAudio("104061024", var_95_28)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_104061", "104061024", "story_v_out_104061.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_104061", "104061024", "story_v_out_104061.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_29 = math.max(var_95_22, arg_92_1.talkMaxDuration)

			if var_95_21 <= arg_92_1.time_ and arg_92_1.time_ < var_95_21 + var_95_29 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_21) / var_95_29

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_21 + var_95_29 and arg_92_1.time_ < var_95_21 + var_95_29 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play104061025 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 104061025
		arg_96_1.duration_ = 4.57

		local var_96_0 = {
			ja = 4.566,
			ko = 4.5,
			zh = 4.1,
			en = 4.5
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
				arg_96_0:Play104061026(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1148ui_story"]) and arg_96_1.var_.characterEffect1148ui_story == nil then
				arg_96_1.var_.characterEffect1148ui_story = arg_96_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1148ui_story"]) then
				if arg_96_1.var_.characterEffect1148ui_story and not isNil(arg_96_1.actors_["1148ui_story"]) then
					arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1148ui_story"]) and arg_96_1.var_.characterEffect1148ui_story then
				arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["2043_tpose"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect2043_tpose == nil then
				arg_96_1.var_.characterEffect2043_tpose = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect2043_tpose and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect2043_tpose.fillFlat = true
					arg_96_1.var_.characterEffect2043_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect2043_tpose then
				arg_96_1.var_.characterEffect2043_tpose.fillFlat = true
				arg_96_1.var_.characterEffect2043_tpose.fillRatio = 0.5
			end

			local var_99_4 = arg_96_1.actors_["3005_tpose"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect3005_tpose == nil then
				arg_96_1.var_.characterEffect3005_tpose = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_5 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_5 and not isNil(var_99_4) then
				if arg_96_1.var_.characterEffect3005_tpose and not isNil(var_99_4) then
					arg_96_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_96_1.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_5)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_5 and arg_96_1.time_ < 0 + var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect3005_tpose then
				arg_96_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_96_1.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			local var_99_6 = arg_96_1.actors_["2043_tpose"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos2043_tpose = var_99_6.localPosition

				local var_99_7 = GameObjectTools.GetOrAddComponent(var_99_6.gameObject, typeof(DynamicBoneHelper))

				if var_99_7 then
					var_99_7:EnableDynamicBone(false)
				end
			end

			local var_99_8 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_8 then
				var_99_6.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos2043_tpose, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_8)
				var_99_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_6.position).x, (manager.ui.mainCamera.transform.position - var_99_6.position).y, (manager.ui.mainCamera.transform.position - var_99_6.position).z)
				var_99_6.localEulerAngles.z = 0
				var_99_6.localEulerAngles.x = 0
				var_99_6.localEulerAngles = var_99_6.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_8 and arg_96_1.time_ < 0 + var_99_8 + arg_99_0 then
				var_99_6.localPosition = Vector3.New(0, 100, 0)
				var_99_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_6.position).x, (manager.ui.mainCamera.transform.position - var_99_6.position).y, (manager.ui.mainCamera.transform.position - var_99_6.position).z)
				var_99_6.localEulerAngles.z = 0
				var_99_6.localEulerAngles.x = 0
				var_99_6.localEulerAngles = var_99_6.localEulerAngles

				local var_99_9 = GameObjectTools.GetOrAddComponent(var_99_6.gameObject, typeof(DynamicBoneHelper))

				if var_99_9 then
					var_99_9:EnableDynamicBone(true)
				end
			end

			local var_99_10 = arg_96_1.actors_["3005_tpose"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos3005_tpose = var_99_10.localPosition

				local var_99_11 = GameObjectTools.GetOrAddComponent(var_99_10.gameObject, typeof(DynamicBoneHelper))

				if var_99_11 then
					var_99_11:EnableDynamicBone(false)
				end
			end

			local var_99_12 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_12 then
				var_99_10.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3005_tpose, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_12)
				var_99_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_10.position).x, (manager.ui.mainCamera.transform.position - var_99_10.position).y, (manager.ui.mainCamera.transform.position - var_99_10.position).z)
				var_99_10.localEulerAngles.z = 0
				var_99_10.localEulerAngles.x = 0
				var_99_10.localEulerAngles = var_99_10.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_12 and arg_96_1.time_ < 0 + var_99_12 + arg_99_0 then
				var_99_10.localPosition = Vector3.New(0, 100, 0)
				var_99_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_10.position).x, (manager.ui.mainCamera.transform.position - var_99_10.position).y, (manager.ui.mainCamera.transform.position - var_99_10.position).z)
				var_99_10.localEulerAngles.z = 0
				var_99_10.localEulerAngles.x = 0
				var_99_10.localEulerAngles = var_99_10.localEulerAngles

				local var_99_13 = GameObjectTools.GetOrAddComponent(var_99_10.gameObject, typeof(DynamicBoneHelper))

				if var_99_13 then
					var_99_13:EnableDynamicBone(true)
				end
			end

			local var_99_14 = arg_96_1.actors_["1148ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1148ui_story = var_99_14.localPosition
			end

			local var_99_15 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_15 then
				var_99_14.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_96_1.time_ - 0) / var_99_15)
				var_99_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_14.position).x, (manager.ui.mainCamera.transform.position - var_99_14.position).y, (manager.ui.mainCamera.transform.position - var_99_14.position).z)
				var_99_14.localEulerAngles.z = 0
				var_99_14.localEulerAngles.x = 0
				var_99_14.localEulerAngles = var_99_14.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_15 and arg_96_1.time_ < 0 + var_99_15 + arg_99_0 then
				var_99_14.localPosition = Vector3.New(0, -0.8, -6.2)
				var_99_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_14.position).x, (manager.ui.mainCamera.transform.position - var_99_14.position).y, (manager.ui.mainCamera.transform.position - var_99_14.position).z)
				var_99_14.localEulerAngles.z = 0
				var_99_14.localEulerAngles.x = 0
				var_99_14.localEulerAngles = var_99_14.localEulerAngles
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_99_16 = 0
			local var_99_17 = 0.4

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(104061025)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_21 = 16 <= 0 and var_99_17 or var_99_17 * (utf8.len(var_99_19) / 16)

				if (16 <= 0 and var_99_17 or var_99_17 * (utf8.len(var_99_19) / 16)) > 0 and var_99_17 < var_99_21 then
					arg_96_1.talkMaxDuration = var_99_21

					if var_99_21 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_21 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061025", "story_v_out_104061.awb") ~= 0 then
					local var_99_22 = manager.audio:GetVoiceLength("story_v_out_104061", "104061025", "story_v_out_104061.awb") / 1000

					if var_99_22 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_16
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_104061", "104061025", "story_v_out_104061.awb")

						arg_96_1:RecordAudio("104061025", var_99_23)
						arg_96_1:RecordAudio("104061025", var_99_23)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_104061", "104061025", "story_v_out_104061.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_104061", "104061025", "story_v_out_104061.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_24 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 <= arg_96_1.time_ and arg_96_1.time_ < var_99_16 + var_99_24 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_16) / var_99_24

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_16 + var_99_24 and arg_96_1.time_ < var_99_16 + var_99_24 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play104061026 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 104061026
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play104061027(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) and arg_100_1.var_.characterEffect1148ui_story == nil then
				arg_100_1.var_.characterEffect1148ui_story = arg_100_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) then
				if arg_100_1.var_.characterEffect1148ui_story and not isNil(arg_100_1.actors_["1148ui_story"]) then
					arg_100_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) and arg_100_1.var_.characterEffect1148ui_story then
				arg_100_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_103_1 = arg_100_1.actors_["1148ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1148ui_story = var_103_1.localPosition
			end

			local var_103_2 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 then
				var_103_1.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_2)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 then
				var_103_1.localPosition = Vector3.New(0, 100, 0)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_103_3 = 0
			local var_103_4 = 1.275

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(104061026).content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 51 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 51)

				if (51 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 51)) > 0 and var_103_4 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_8 and arg_100_1.time_ < var_103_3 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play104061027 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 104061027
		arg_104_1.duration_ = 4.3

		local var_104_0 = {
			ja = 4.3,
			ko = 3.033,
			zh = 3.766,
			en = 3.2
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
				arg_104_0:Play104061028(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1059ui_story"]) and arg_104_1.var_.characterEffect1059ui_story == nil then
				arg_104_1.var_.characterEffect1059ui_story = arg_104_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1059ui_story"]) then
				if arg_104_1.var_.characterEffect1059ui_story and not isNil(arg_104_1.actors_["1059ui_story"]) then
					arg_104_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1059ui_story"]) and arg_104_1.var_.characterEffect1059ui_story then
				arg_104_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["1059ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1059ui_story = var_107_2.localPosition
			end

			local var_107_3 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 then
				var_107_2.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_104_1.time_ - 0) / var_107_3)
				var_107_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_2.position).x, (manager.ui.mainCamera.transform.position - var_107_2.position).y, (manager.ui.mainCamera.transform.position - var_107_2.position).z)
				var_107_2.localEulerAngles.z = 0
				var_107_2.localEulerAngles.x = 0
				var_107_2.localEulerAngles = var_107_2.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 then
				var_107_2.localPosition = Vector3.New(0, -1.05, -6)
				var_107_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_2.position).x, (manager.ui.mainCamera.transform.position - var_107_2.position).y, (manager.ui.mainCamera.transform.position - var_107_2.position).z)
				var_107_2.localEulerAngles.z = 0
				var_107_2.localEulerAngles.x = 0
				var_107_2.localEulerAngles = var_107_2.localEulerAngles
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_107_4 = 0
			local var_107_5 = 0.4

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(104061027)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 16 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 16)

				if (16 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 16)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061027", "story_v_out_104061.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_104061", "104061027", "story_v_out_104061.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_104061", "104061027", "story_v_out_104061.awb")

						arg_104_1:RecordAudio("104061027", var_107_11)
						arg_104_1:RecordAudio("104061027", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_104061", "104061027", "story_v_out_104061.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_104061", "104061027", "story_v_out_104061.awb")
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

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play104061028 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 104061028
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play104061029(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_4", "se_story_4_arm_2", "")
			end

			local var_111_1 = arg_108_1.actors_["3005_tpose"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect3005_tpose == nil then
				arg_108_1.var_.characterEffect3005_tpose = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect3005_tpose and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect3005_tpose then
				arg_108_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["1059ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1059ui_story == nil then
				arg_108_1.var_.characterEffect1059ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_5 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 and not isNil(var_111_4) then
				if arg_108_1.var_.characterEffect1059ui_story and not isNil(var_111_4) then
					arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_5)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1059ui_story then
				arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_111_6 = arg_108_1.actors_["1059ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1059ui_story = var_111_6.localPosition
			end

			local var_111_7 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				var_111_6.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_7)
				var_111_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_6.position).x, (manager.ui.mainCamera.transform.position - var_111_6.position).y, (manager.ui.mainCamera.transform.position - var_111_6.position).z)
				var_111_6.localEulerAngles.z = 0
				var_111_6.localEulerAngles.x = 0
				var_111_6.localEulerAngles = var_111_6.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				var_111_6.localPosition = Vector3.New(0, 100, 0)
				var_111_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_6.position).x, (manager.ui.mainCamera.transform.position - var_111_6.position).y, (manager.ui.mainCamera.transform.position - var_111_6.position).z)
				var_111_6.localEulerAngles.z = 0
				var_111_6.localEulerAngles.x = 0
				var_111_6.localEulerAngles = var_111_6.localEulerAngles
			end

			local var_111_8 = arg_108_1.actors_["3005_tpose"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos3005_tpose = var_111_8.localPosition

				local var_111_9 = GameObjectTools.GetOrAddComponent(var_111_8.gameObject, typeof(DynamicBoneHelper))

				if var_111_9 then
					var_111_9:EnableDynamicBone(false)
				end
			end

			local var_111_10 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_10 then
				var_111_8.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos3005_tpose, Vector3.New(0, -1.95, -2.63), (arg_108_1.time_ - 0) / var_111_10)
				var_111_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_8.position).x, (manager.ui.mainCamera.transform.position - var_111_8.position).y, (manager.ui.mainCamera.transform.position - var_111_8.position).z)
				var_111_8.localEulerAngles.z = 0
				var_111_8.localEulerAngles.x = 0
				var_111_8.localEulerAngles = var_111_8.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_10 and arg_108_1.time_ < 0 + var_111_10 + arg_111_0 then
				var_111_8.localPosition = Vector3.New(0, -1.95, -2.63)
				var_111_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_8.position).x, (manager.ui.mainCamera.transform.position - var_111_8.position).y, (manager.ui.mainCamera.transform.position - var_111_8.position).z)
				var_111_8.localEulerAngles.z = 0
				var_111_8.localEulerAngles.x = 0
				var_111_8.localEulerAngles = var_111_8.localEulerAngles

				local var_111_11 = GameObjectTools.GetOrAddComponent(var_111_8.gameObject, typeof(DynamicBoneHelper))

				if var_111_11 then
					var_111_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_111_12 = 0
			local var_111_13 = 0.525

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_14 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(104061028).content)

				arg_108_1.text_.text = var_111_14

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_16 = 21 <= 0 and var_111_13 or var_111_13 * (utf8.len(var_111_14) / 21)

				if (21 <= 0 and var_111_13 or var_111_13 * (utf8.len(var_111_14) / 21)) > 0 and var_111_13 < var_111_16 then
					arg_108_1.talkMaxDuration = var_111_16

					if var_111_16 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_12
					end
				end

				arg_108_1.text_.text = var_111_14
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_17 = math.max(var_111_13, arg_108_1.talkMaxDuration)

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_17 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_12) / var_111_17

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_12 + var_111_17 and arg_108_1.time_ < var_111_12 + var_111_17 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play104061029 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 104061029
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play104061030(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["3005_tpose"]) and arg_112_1.var_.characterEffect3005_tpose == nil then
				arg_112_1.var_.characterEffect3005_tpose = arg_112_1.actors_["3005_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["3005_tpose"]) then
				if arg_112_1.var_.characterEffect3005_tpose and not isNil(arg_112_1.actors_["3005_tpose"]) then
					arg_112_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_112_1.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["3005_tpose"]) and arg_112_1.var_.characterEffect3005_tpose then
				arg_112_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_112_1.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			local var_115_1 = arg_112_1.actors_["3005_tpose"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos3005_tpose = var_115_1.localPosition

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_1.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end
			end

			local var_115_3 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 then
				var_115_1.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos3005_tpose, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_3)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 then
				var_115_1.localPosition = Vector3.New(0, 100, 0)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles

				local var_115_4 = GameObjectTools.GetOrAddComponent(var_115_1.gameObject, typeof(DynamicBoneHelper))

				if var_115_4 then
					var_115_4:EnableDynamicBone(true)
				end
			end

			local var_115_5 = 0
			local var_115_6 = 0.725

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_7 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(104061029).content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 29 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_7) / 29)

				if (29 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_7) / 29)) > 0 and var_115_6 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_5
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_6, arg_112_1.talkMaxDuration)

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_5) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_5 + var_115_10 and arg_112_1.time_ < var_115_5 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play104061030 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 104061030
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play104061031(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1.2

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(104061030).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 48 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 48)

				if (48 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 48)) > 0 and var_119_0 < var_119_3 then
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
	Play104061031 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 104061031
		arg_120_1.duration_ = 8.83

		local var_120_0 = {
			ja = 8.833,
			ko = 5.033,
			zh = 7.3,
			en = 6.333
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
				arg_120_0:Play104061032(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1059ui_story"]) and arg_120_1.var_.characterEffect1059ui_story == nil then
				arg_120_1.var_.characterEffect1059ui_story = arg_120_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1059ui_story"]) then
				if arg_120_1.var_.characterEffect1059ui_story and not isNil(arg_120_1.actors_["1059ui_story"]) then
					arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1059ui_story"]) and arg_120_1.var_.characterEffect1059ui_story then
				arg_120_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_123_2 = arg_120_1.actors_["1059ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1059ui_story = var_123_2.localPosition
			end

			local var_123_3 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 then
				var_123_2.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_120_1.time_ - 0) / var_123_3)
				var_123_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_2.position).x, (manager.ui.mainCamera.transform.position - var_123_2.position).y, (manager.ui.mainCamera.transform.position - var_123_2.position).z)
				var_123_2.localEulerAngles.z = 0
				var_123_2.localEulerAngles.x = 0
				var_123_2.localEulerAngles = var_123_2.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 then
				var_123_2.localPosition = Vector3.New(0, -1.05, -6)
				var_123_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_2.position).x, (manager.ui.mainCamera.transform.position - var_123_2.position).y, (manager.ui.mainCamera.transform.position - var_123_2.position).z)
				var_123_2.localEulerAngles.z = 0
				var_123_2.localEulerAngles.x = 0
				var_123_2.localEulerAngles = var_123_2.localEulerAngles
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_123_4 = 0
			local var_123_5 = 0.725

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(104061031)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 29 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 29)

				if (29 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 29)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061031", "story_v_out_104061.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_104061", "104061031", "story_v_out_104061.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_104061", "104061031", "story_v_out_104061.awb")

						arg_120_1:RecordAudio("104061031", var_123_11)
						arg_120_1:RecordAudio("104061031", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_104061", "104061031", "story_v_out_104061.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_104061", "104061031", "story_v_out_104061.awb")
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

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play104061032 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 104061032
		arg_124_1.duration_ = 0.1

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"

			SetActive(arg_124_1.choicesGo_, true)

			for iter_125_0, iter_125_1 in ipairs(arg_124_1.choices_) do
				SetActive(iter_125_1.go, iter_125_0 <= 2)
			end

			arg_124_1.choices_[1].txt.text = arg_124_1:FormatText(StoryChoiceCfg[25].name)
			arg_124_1.choices_[2].txt.text = arg_124_1:FormatText(StoryChoiceCfg[26].name)
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play104061033(arg_124_1)
			end

			if arg_126_0 == 2 then
				arg_124_0:Play104061033(arg_124_1)
			end

			arg_124_1:RecordChoiceLog(104061032, 25, 26)
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1059ui_story"]) and arg_124_1.var_.characterEffect1059ui_story == nil then
				arg_124_1.var_.characterEffect1059ui_story = arg_124_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1059ui_story"]) then
				if arg_124_1.var_.characterEffect1059ui_story and not isNil(arg_124_1.actors_["1059ui_story"]) then
					arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1059ui_story"]) and arg_124_1.var_.characterEffect1059ui_story then
				arg_124_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play104061033 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 104061033
		arg_128_1.duration_ = 3.17

		local var_128_0 = {
			ja = 2.466,
			ko = 2.9,
			zh = 3.166,
			en = 2.366
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
				arg_128_0:Play104061034(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1148ui_story"]) and arg_128_1.var_.characterEffect1148ui_story == nil then
				arg_128_1.var_.characterEffect1148ui_story = arg_128_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.1

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1148ui_story"]) then
				if arg_128_1.var_.characterEffect1148ui_story and not isNil(arg_128_1.actors_["1148ui_story"]) then
					arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1148ui_story"]) and arg_128_1.var_.characterEffect1148ui_story then
				arg_128_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1059ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1059ui_story = var_131_2.localPosition
			end

			local var_131_3 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_3)
				var_131_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_2.position).x, (manager.ui.mainCamera.transform.position - var_131_2.position).y, (manager.ui.mainCamera.transform.position - var_131_2.position).z)
				var_131_2.localEulerAngles.z = 0
				var_131_2.localEulerAngles.x = 0
				var_131_2.localEulerAngles = var_131_2.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(0, 100, 0)
				var_131_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_2.position).x, (manager.ui.mainCamera.transform.position - var_131_2.position).y, (manager.ui.mainCamera.transform.position - var_131_2.position).z)
				var_131_2.localEulerAngles.z = 0
				var_131_2.localEulerAngles.x = 0
				var_131_2.localEulerAngles = var_131_2.localEulerAngles
			end

			local var_131_4 = arg_128_1.actors_["1148ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1148ui_story = var_131_4.localPosition
			end

			local var_131_5 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_5 then
				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_128_1.time_ - 0) / var_131_5)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_5 and arg_128_1.time_ < 0 + var_131_5 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(0, -0.8, -6.2)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles
			end

			local var_131_6 = "1148ui_story"

			if arg_128_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_131_7 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_128_1.stage_.transform)

				var_131_7.name = var_131_6
				var_131_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_[var_131_6] = var_131_7

				local var_131_8 = var_131_7:GetComponentInChildren(typeof(CharacterEffect))

				var_131_8.enabled = true

				local var_131_9 = GameObjectTools.GetOrAddComponent(var_131_7, typeof(DynamicBoneHelper))

				if var_131_9 then
					var_131_9:EnableDynamicBone(false)
				end

				arg_128_1:ShowWeapon(var_131_8.transform, false)

				arg_128_1.var_[var_131_6 .. "Animator"] = var_131_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_128_1.var_[var_131_6 .. "Animator"].applyRootMotion = true
				arg_128_1.var_[var_131_6 .. "LipSync"] = var_131_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_131_10 = "1148ui_story"

			if arg_128_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_131_11 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_128_1.stage_.transform)

				var_131_11.name = var_131_10
				var_131_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_[var_131_10] = var_131_11

				local var_131_12 = var_131_11:GetComponentInChildren(typeof(CharacterEffect))

				var_131_12.enabled = true

				local var_131_13 = GameObjectTools.GetOrAddComponent(var_131_11, typeof(DynamicBoneHelper))

				if var_131_13 then
					var_131_13:EnableDynamicBone(false)
				end

				arg_128_1:ShowWeapon(var_131_12.transform, false)

				arg_128_1.var_[var_131_10 .. "Animator"] = var_131_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_128_1.var_[var_131_10 .. "Animator"].applyRootMotion = true
				arg_128_1.var_[var_131_10 .. "LipSync"] = var_131_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_131_14 = 0
			local var_131_15 = 0.25

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_16 = arg_128_1:GetWordFromCfg(104061033)
				local var_131_17 = arg_128_1:FormatText(var_131_16.content)

				arg_128_1.text_.text = var_131_17

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_19 = 10 <= 0 and var_131_15 or var_131_15 * (utf8.len(var_131_17) / 10)

				if (10 <= 0 and var_131_15 or var_131_15 * (utf8.len(var_131_17) / 10)) > 0 and var_131_15 < var_131_19 then
					arg_128_1.talkMaxDuration = var_131_19

					if var_131_19 + var_131_14 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_19 + var_131_14
					end
				end

				arg_128_1.text_.text = var_131_17
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061033", "story_v_out_104061.awb") ~= 0 then
					local var_131_20 = manager.audio:GetVoiceLength("story_v_out_104061", "104061033", "story_v_out_104061.awb") / 1000

					if var_131_20 + var_131_14 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_20 + var_131_14
					end

					if var_131_16.prefab_name ~= "" and arg_128_1.actors_[var_131_16.prefab_name] ~= nil then
						local var_131_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_16.prefab_name].transform, "story_v_out_104061", "104061033", "story_v_out_104061.awb")

						arg_128_1:RecordAudio("104061033", var_131_21)
						arg_128_1:RecordAudio("104061033", var_131_21)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_104061", "104061033", "story_v_out_104061.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_104061", "104061033", "story_v_out_104061.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_22 = math.max(var_131_15, arg_128_1.talkMaxDuration)

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_22 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_14) / var_131_22

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_14 + var_131_22 and arg_128_1.time_ < var_131_14 + var_131_22 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play104061034 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 104061034
		arg_132_1.duration_ = 6.37

		local var_132_0 = {
			ja = 6.366,
			ko = 4.266,
			zh = 4.2,
			en = 4.266
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
				arg_132_0:Play104061035(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:AudioAction("play", "effect", "se_story_4", "se_story_4_arm_3", "")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action432")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_135_1 = 0
			local var_135_2 = 0.45

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(104061034)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 18 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 18)

				if (18 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 18)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061034", "story_v_out_104061.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_out_104061", "104061034", "story_v_out_104061.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_104061", "104061034", "story_v_out_104061.awb")

						arg_132_1:RecordAudio("104061034", var_135_8)
						arg_132_1:RecordAudio("104061034", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_104061", "104061034", "story_v_out_104061.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_104061", "104061034", "story_v_out_104061.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play104061035 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 104061035
		arg_136_1.duration_ = 6.4

		local var_136_0 = {
			ja = 6.4,
			ko = 6.033,
			zh = 5.566,
			en = 4.266
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
			arg_136_1.auto_ = false
		end

		function arg_136_1.playNext_(arg_138_0)
			arg_136_1.onStoryFinished_()
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1059ui_story"]) and arg_136_1.var_.characterEffect1059ui_story == nil then
				arg_136_1.var_.characterEffect1059ui_story = arg_136_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1059ui_story"]) then
				if arg_136_1.var_.characterEffect1059ui_story and not isNil(arg_136_1.actors_["1059ui_story"]) then
					arg_136_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1059ui_story"]) and arg_136_1.var_.characterEffect1059ui_story then
				arg_136_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1148ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1148ui_story == nil then
				arg_136_1.var_.characterEffect1148ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1148ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1148ui_story then
				arg_136_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_139_4 = arg_136_1.actors_["1148ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1148ui_story = var_139_4.localPosition
			end

			local var_139_5 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 then
				var_139_4.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_136_1.time_ - 0) / var_139_5)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 then
				var_139_4.localPosition = Vector3.New(0, -0.8, -6.2)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			local var_139_6 = arg_136_1.actors_["1148ui_story"].transform

			if 0.033 < arg_136_1.time_ and arg_136_1.time_ <= 0.033 + arg_139_0 then
				arg_136_1.var_.moveOldPos1148ui_story = var_139_6.localPosition
			end

			local var_139_7 = 0.5

			if 0.033 <= arg_136_1.time_ and arg_136_1.time_ < 0.033 + var_139_7 then
				var_139_6.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_136_1.time_ - 0.033) / var_139_7)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			if arg_136_1.time_ >= 0.033 + var_139_7 and arg_136_1.time_ < 0.033 + var_139_7 + arg_139_0 then
				var_139_6.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			local var_139_8 = arg_136_1.actors_["1059ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_8.localPosition
			end

			local var_139_9 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_9 then
				var_139_8.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_136_1.time_ - 0) / var_139_9)
				var_139_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_8.position).x, (manager.ui.mainCamera.transform.position - var_139_8.position).y, (manager.ui.mainCamera.transform.position - var_139_8.position).z)
				var_139_8.localEulerAngles.z = 0
				var_139_8.localEulerAngles.x = 0
				var_139_8.localEulerAngles = var_139_8.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_9 and arg_136_1.time_ < 0 + var_139_9 + arg_139_0 then
				var_139_8.localPosition = Vector3.New(0.7, -1.05, -6)
				var_139_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_8.position).x, (manager.ui.mainCamera.transform.position - var_139_8.position).y, (manager.ui.mainCamera.transform.position - var_139_8.position).z)
				var_139_8.localEulerAngles.z = 0
				var_139_8.localEulerAngles.x = 0
				var_139_8.localEulerAngles = var_139_8.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_139_10 = 0
			local var_139_11 = 0.7

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_12 = arg_136_1:GetWordFromCfg(104061035)
				local var_139_13 = arg_136_1:FormatText(var_139_12.content)

				arg_136_1.text_.text = var_139_13

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 28 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 28)

				if (28 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 28)) > 0 and var_139_11 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_13
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104061", "104061035", "story_v_out_104061.awb") ~= 0 then
					local var_139_16 = manager.audio:GetVoiceLength("story_v_out_104061", "104061035", "story_v_out_104061.awb") / 1000

					if var_139_16 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_16 + var_139_10
					end

					if var_139_12.prefab_name ~= "" and arg_136_1.actors_[var_139_12.prefab_name] ~= nil then
						local var_139_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_12.prefab_name].transform, "story_v_out_104061", "104061035", "story_v_out_104061.awb")

						arg_136_1:RecordAudio("104061035", var_139_17)
						arg_136_1:RecordAudio("104061035", var_139_17)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_104061", "104061035", "story_v_out_104061.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_104061", "104061035", "story_v_out_104061.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_18 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_18 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_18

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_18 and arg_136_1.time_ < var_139_10 + var_139_18 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06a"
	},
	voices = {
		"story_v_out_104061.awb"
	}
}
