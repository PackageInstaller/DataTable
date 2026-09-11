return {
	Play105082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105082001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play105082002(arg_1_1)
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

			local var_4_4 = "B14"

			if arg_1_1.bgs_.B14 == nil then
				local var_4_5 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_4)
				var_4_5.name = var_4_4
				var_4_5.transform.parent = arg_1_1.stage_.transform
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_4] = var_4_5
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.B14:GetComponent("SpriteRenderer")

				if var_4_6 then
					arg_1_1.var_.alphaOldValueB14 = var_4_6.color.a
					arg_1_1.var_.alphaMatValueB14 = var_4_6
				end

				arg_1_1.var_.alphaOldValueB14 = 0
			end

			local var_4_7 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				if arg_1_1.var_.alphaMatValueB14 then
					arg_1_1.var_.alphaMatValueB14.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB14, 1, (arg_1_1.time_ - 0) / var_4_7)
					arg_1_1.var_.alphaMatValueB14.color = arg_1_1.var_.alphaMatValueB14.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 and arg_1_1.var_.alphaMatValueB14 then
				arg_1_1.var_.alphaMatValueB14.color.a = 1
				arg_1_1.var_.alphaMatValueB14.color = arg_1_1.var_.alphaMatValueB14.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_8 = arg_1_1.bgs_.B14

				arg_1_1.bgs_.B14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_9 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_9 and var_4_9.sprite then
					local var_4_10 = 2 * (var_4_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_8.transform.localScale = Vector3.New(var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B14" then
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

				local var_4_15 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(105082001).content)

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
	Play105082002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105082002
		arg_8_1.duration_ = 5.4

		local var_8_0 = {
			ja = 3.4,
			ko = 3.333,
			zh = 5.4,
			en = 4.733
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
				arg_8_0:Play105082003(arg_8_1)
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

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
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

			local var_11_8 = 0
			local var_11_9 = 0.4

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

				local var_11_10 = arg_8_1:GetWordFromCfg(105082002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 16 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 16)

				if (16 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 16)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082002", "story_v_out_105082.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082002", "story_v_out_105082.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_105082", "105082002", "story_v_out_105082.awb")

						arg_8_1:RecordAudio("105082002", var_11_15)
						arg_8_1:RecordAudio("105082002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_105082", "105082002", "story_v_out_105082.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_105082", "105082002", "story_v_out_105082.awb")
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
	Play105082003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 105082003
		arg_12_1.duration_ = 7

		local var_12_0 = {
			ja = 6.633,
			ko = 7,
			zh = 6.133,
			en = 4.766
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
				arg_12_0:Play105082004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "3008ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["3008ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["3008ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["3008ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["3008ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect3008ui_story == nil then
				arg_12_1.var_.characterEffect3008ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect3008ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect3008ui_story then
				arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["3008ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos3008ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, -1.51, -4.3)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
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
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_15_10 = 0
			local var_15_11 = 0.75

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(105082003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 29 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 29)

				if (29 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 29)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082003", "story_v_out_105082.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_105082", "105082003", "story_v_out_105082.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_105082", "105082003", "story_v_out_105082.awb")

						arg_12_1:RecordAudio("105082003", var_15_17)
						arg_12_1:RecordAudio("105082003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_105082", "105082003", "story_v_out_105082.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_105082", "105082003", "story_v_out_105082.awb")
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
				actorName = "3008ui_story",
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
	Play105082004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 105082004
		arg_16_1.duration_ = 2.53

		local var_16_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 2.2,
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
				arg_16_0:Play105082005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "4010ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["4010ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["4010ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["4010ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["4010ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect4010ui_story == nil then
				arg_16_1.var_.characterEffect4010ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect4010ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect4010ui_story then
				arg_16_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["3008ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect3008ui_story == nil then
				arg_16_1.var_.characterEffect3008ui_story = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect3008ui_story and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_16_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect3008ui_story then
				arg_16_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_16_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_19_8 = arg_16_1.actors_["3008ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos3008ui_story = var_19_8.localPosition
			end

			local var_19_9 = 0.5

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_9 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3008ui_story, Vector3.New(0.7, -1.51, -4.3), (arg_16_1.time_ - 0) / var_19_9)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_9 and arg_16_1.time_ < 0 + var_19_9 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0.7, -1.51, -4.3)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			local var_19_10 = arg_16_1.actors_["4010ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos4010ui_story = var_19_10.localPosition
			end

			local var_19_11 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_11 then
				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_16_1.time_ - 0) / var_19_11)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_11 and arg_16_1.time_ < 0 + var_19_11 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_14 = arg_16_1:GetWordFromCfg(105082004)
				local var_19_15 = arg_16_1:FormatText(var_19_14.content)

				arg_16_1.text_.text = var_19_15

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 4 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 4)

				if (4 <= 0 and var_19_13 or var_19_13 * (utf8.len(var_19_15) / 4)) > 0 and var_19_13 < var_19_17 then
					arg_16_1.talkMaxDuration = var_19_17

					if var_19_17 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_17 + var_19_12
					end
				end

				arg_16_1.text_.text = var_19_15
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082004", "story_v_out_105082.awb") ~= 0 then
					local var_19_18 = manager.audio:GetVoiceLength("story_v_out_105082", "105082004", "story_v_out_105082.awb") / 1000

					if var_19_18 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_18 + var_19_12
					end

					if var_19_14.prefab_name ~= "" and arg_16_1.actors_[var_19_14.prefab_name] ~= nil then
						local var_19_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_14.prefab_name].transform, "story_v_out_105082", "105082004", "story_v_out_105082.awb")

						arg_16_1:RecordAudio("105082004", var_19_19)
						arg_16_1:RecordAudio("105082004", var_19_19)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_105082", "105082004", "story_v_out_105082.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_105082", "105082004", "story_v_out_105082.awb")
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play105082005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 105082005
		arg_20_1.duration_ = 7.6

		local var_20_0 = {
			ja = 7.6,
			ko = 5,
			zh = 4.366,
			en = 5.866
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
				arg_20_0:Play105082006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "3009ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["3009ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["3009ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["3009ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["3009ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect3009ui_story == nil then
				arg_20_1.var_.characterEffect3009ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect3009ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect3009ui_story then
				arg_20_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_23_6 = arg_20_1.actors_["4010ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_6) and arg_20_1.var_.characterEffect4010ui_story == nil then
				arg_20_1.var_.characterEffect4010ui_story = var_23_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 and not isNil(var_23_6) then
				if arg_20_1.var_.characterEffect4010ui_story and not isNil(var_23_6) then
					arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_20_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_7)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 and not isNil(var_23_6) and arg_20_1.var_.characterEffect4010ui_story then
				arg_20_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_20_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_23_8 = arg_20_1.actors_["3008ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos3008ui_story = var_23_8.localPosition
			end

			local var_23_9 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 then
				var_23_8.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_9)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 then
				var_23_8.localPosition = Vector3.New(0, 100, 0)
				var_23_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_8.position).x, (manager.ui.mainCamera.transform.position - var_23_8.position).y, (manager.ui.mainCamera.transform.position - var_23_8.position).z)
				var_23_8.localEulerAngles.z = 0
				var_23_8.localEulerAngles.x = 0
				var_23_8.localEulerAngles = var_23_8.localEulerAngles
			end

			local var_23_10 = arg_20_1.actors_["3009ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos3009ui_story = var_23_10.localPosition
			end

			local var_23_11 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 then
				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_20_1.time_ - 0) / var_23_11)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_23_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_10.position).x, (manager.ui.mainCamera.transform.position - var_23_10.position).y, (manager.ui.mainCamera.transform.position - var_23_10.position).z)
				var_23_10.localEulerAngles.z = 0
				var_23_10.localEulerAngles.x = 0
				var_23_10.localEulerAngles = var_23_10.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_23_12 = 0
			local var_23_13 = 0.65

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(105082005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 26 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 26)

				if (26 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 26)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082005", "story_v_out_105082.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_105082", "105082005", "story_v_out_105082.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_105082", "105082005", "story_v_out_105082.awb")

						arg_20_1:RecordAudio("105082005", var_23_19)
						arg_20_1:RecordAudio("105082005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_105082", "105082005", "story_v_out_105082.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_105082", "105082005", "story_v_out_105082.awb")
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play105082006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 105082006
		arg_24_1.duration_ = 2.1

		local var_24_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
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
				arg_24_0:Play105082007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = arg_24_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) then
				if arg_24_1.var_.characterEffect4010ui_story and not isNil(arg_24_1.actors_["4010ui_story"]) then
					arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) and arg_24_1.var_.characterEffect4010ui_story then
				arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["3009ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect3009ui_story == nil then
				arg_24_1.var_.characterEffect3009ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect3009ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_24_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect3009ui_story then
				arg_24_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_24_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_27_4 = 0
			local var_27_5 = 0.075

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(105082006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 3 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 3)

				if (3 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 3)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082006", "story_v_out_105082.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_105082", "105082006", "story_v_out_105082.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_105082", "105082006", "story_v_out_105082.awb")

						arg_24_1:RecordAudio("105082006", var_27_11)
						arg_24_1:RecordAudio("105082006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_105082", "105082006", "story_v_out_105082.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_105082", "105082006", "story_v_out_105082.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play105082007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 105082007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play105082008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = arg_28_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) then
				if arg_28_1.var_.characterEffect4010ui_story and not isNil(arg_28_1.actors_["4010ui_story"]) then
					arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_28_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) and arg_28_1.var_.characterEffect4010ui_story then
				arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_28_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_31_1 = arg_28_1.actors_["3009ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos3009ui_story = var_31_1.localPosition
			end

			local var_31_2 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 then
				var_31_1.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_2)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 then
				var_31_1.localPosition = Vector3.New(0, 100, 0)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			local var_31_3 = arg_28_1.actors_["4010ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos4010ui_story = var_31_3.localPosition
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_4)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, 100, 0)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			local var_31_5 = 0
			local var_31_6 = 1.3

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_7 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(105082007).content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 52 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 52)

				if (52 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 52)) > 0 and var_31_6 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_10 and arg_28_1.time_ < var_31_5 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play105082008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 105082008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play105082009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_5", "se_story_5_signal", "")
			end

			local var_35_1 = 0
			local var_35_2 = 0.1

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(105082008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 4 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 4)

				if (4 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 4)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play105082009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 105082009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play105082010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.725

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(105082009).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 29 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 29)

				if (29 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 29)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play105082010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 105082010
		arg_40_1.duration_ = 9.87

		local var_40_0 = {
			ja = 9.8,
			ko = 8.5,
			zh = 9.866,
			en = 7.2
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
				arg_40_0:Play105082011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) and arg_40_1.var_.characterEffect4010ui_story == nil then
				arg_40_1.var_.characterEffect4010ui_story = arg_40_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) then
				if arg_40_1.var_.characterEffect4010ui_story and not isNil(arg_40_1.actors_["4010ui_story"]) then
					arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) and arg_40_1.var_.characterEffect4010ui_story then
				arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_43_2 = arg_40_1.actors_["4010ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos4010ui_story = var_43_2.localPosition
			end

			local var_43_3 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 then
				var_43_2.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_40_1.time_ - 0) / var_43_3)
				var_43_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_2.position).x, (manager.ui.mainCamera.transform.position - var_43_2.position).y, (manager.ui.mainCamera.transform.position - var_43_2.position).z)
				var_43_2.localEulerAngles.z = 0
				var_43_2.localEulerAngles.x = 0
				var_43_2.localEulerAngles = var_43_2.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 then
				var_43_2.localPosition = Vector3.New(0, -1.59, -5.2)
				var_43_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_2.position).x, (manager.ui.mainCamera.transform.position - var_43_2.position).y, (manager.ui.mainCamera.transform.position - var_43_2.position).z)
				var_43_2.localEulerAngles.z = 0
				var_43_2.localEulerAngles.x = 0
				var_43_2.localEulerAngles = var_43_2.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_43_4 = 0
			local var_43_5 = 1.2

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(105082010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 48 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 48)

				if (48 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 48)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082010", "story_v_out_105082.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_105082", "105082010", "story_v_out_105082.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_105082", "105082010", "story_v_out_105082.awb")

						arg_40_1:RecordAudio("105082010", var_43_11)
						arg_40_1:RecordAudio("105082010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_105082", "105082010", "story_v_out_105082.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_105082", "105082010", "story_v_out_105082.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play105082011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 105082011
		arg_44_1.duration_ = 4.4

		local var_44_0 = {
			ja = 4.4,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.133
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
				arg_44_0:Play105082012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_47_0 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_44_1.stage_.transform)

				var_47_0.name = "2020_tpose"
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["2020_tpose"] = var_47_0

				local var_47_1 = var_47_0:GetComponentInChildren(typeof(CharacterEffect))

				var_47_1.enabled = true

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_1.transform, false)

				arg_44_1.var_["2020_tpose" .. "Animator"] = var_47_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_["2020_tpose" .. "Animator"].applyRootMotion = true
				arg_44_1.var_["2020_tpose" .. "LipSync"] = var_47_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_3 = arg_44_1.actors_["2020_tpose"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect2020_tpose == nil then
				arg_44_1.var_.characterEffect2020_tpose = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect2020_tpose and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect2020_tpose then
				arg_44_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_47_6 = arg_44_1.actors_["4010ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect4010ui_story == nil then
				arg_44_1.var_.characterEffect4010ui_story = var_47_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_7 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 and not isNil(var_47_6) then
				if arg_44_1.var_.characterEffect4010ui_story and not isNil(var_47_6) then
					arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_44_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_7)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 and not isNil(var_47_6) and arg_44_1.var_.characterEffect4010ui_story then
				arg_44_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_44_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_47_8 = arg_44_1.actors_["4010ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos4010ui_story = var_47_8.localPosition
			end

			local var_47_9 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_9 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_9)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_9 and arg_44_1.time_ < 0 + var_47_9 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(0, 100, 0)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			local var_47_10 = arg_44_1.actors_["2020_tpose"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos2020_tpose = var_47_10.localPosition

				local var_47_11 = GameObjectTools.GetOrAddComponent(var_47_10.gameObject, typeof(DynamicBoneHelper))

				if var_47_11 then
					var_47_11:EnableDynamicBone(false)
				end
			end

			local var_47_12 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_12 then
				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos2020_tpose, Vector3.New(-0.7, -1.2, -4.1), (arg_44_1.time_ - 0) / var_47_12)
				var_47_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_10.position).x, (manager.ui.mainCamera.transform.position - var_47_10.position).y, (manager.ui.mainCamera.transform.position - var_47_10.position).z)
				var_47_10.localEulerAngles.z = 0
				var_47_10.localEulerAngles.x = 0
				var_47_10.localEulerAngles = var_47_10.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_12 and arg_44_1.time_ < 0 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(-0.7, -1.2, -4.1)
				var_47_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_10.position).x, (manager.ui.mainCamera.transform.position - var_47_10.position).y, (manager.ui.mainCamera.transform.position - var_47_10.position).z)
				var_47_10.localEulerAngles.z = 0
				var_47_10.localEulerAngles.x = 0
				var_47_10.localEulerAngles = var_47_10.localEulerAngles

				local var_47_13 = GameObjectTools.GetOrAddComponent(var_47_10.gameObject, typeof(DynamicBoneHelper))

				if var_47_13 then
					var_47_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_47_14 = 0
			local var_47_15 = 0.175

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_16 = arg_44_1:GetWordFromCfg(105082011)
				local var_47_17 = arg_44_1:FormatText(var_47_16.content)

				arg_44_1.text_.text = var_47_17

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_19 = 7 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_17) / 7)

				if (7 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_17) / 7)) > 0 and var_47_15 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_14 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_14
					end
				end

				arg_44_1.text_.text = var_47_17
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082011", "story_v_out_105082.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_105082", "105082011", "story_v_out_105082.awb") / 1000

					if var_47_20 + var_47_14 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_14
					end

					if var_47_16.prefab_name ~= "" and arg_44_1.actors_[var_47_16.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_16.prefab_name].transform, "story_v_out_105082", "105082011", "story_v_out_105082.awb")

						arg_44_1:RecordAudio("105082011", var_47_21)
						arg_44_1:RecordAudio("105082011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_105082", "105082011", "story_v_out_105082.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_105082", "105082011", "story_v_out_105082.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_15, arg_44_1.talkMaxDuration)

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_14) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_14 + var_47_22 and arg_44_1.time_ < var_47_14 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play105082012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 105082012
		arg_48_1.duration_ = 4.8

		local var_48_0 = {
			ja = 4.8,
			ko = 4.233,
			zh = 3.033,
			en = 3.833
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
				arg_48_0:Play105082013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story_5", "se_story_5_cheer", "")
			end

			local var_51_1 = "2030_tpose"

			if arg_48_1.actors_["2030_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2030_tpose"))) then
				local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_48_1.stage_.transform)

				var_51_2.name = var_51_1
				var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_[var_51_1] = var_51_2

				local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

				var_51_3.enabled = true

				local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

				if var_51_4 then
					var_51_4:EnableDynamicBone(false)
				end

				arg_48_1:ShowWeapon(var_51_3.transform, false)

				arg_48_1.var_[var_51_1 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_48_1.var_[var_51_1 .. "Animator"].applyRootMotion = true
				arg_48_1.var_[var_51_1 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_51_5 = arg_48_1.actors_["2030_tpose"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect2030_tpose == nil then
				arg_48_1.var_.characterEffect2030_tpose = var_51_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_6 and not isNil(var_51_5) then
				if arg_48_1.var_.characterEffect2030_tpose and not isNil(var_51_5) then
					arg_48_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_6 and arg_48_1.time_ < 0 + var_51_6 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect2030_tpose then
				arg_48_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_51_8 = arg_48_1.actors_["2020_tpose"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.characterEffect2020_tpose == nil then
				arg_48_1.var_.characterEffect2020_tpose = var_51_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_9 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_9 and not isNil(var_51_8) then
				if arg_48_1.var_.characterEffect2020_tpose and not isNil(var_51_8) then
					arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_48_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_9)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_9 and arg_48_1.time_ < 0 + var_51_9 + arg_51_0 and not isNil(var_51_8) and arg_48_1.var_.characterEffect2020_tpose then
				arg_48_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_48_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_51_10 = arg_48_1.actors_["2030_tpose"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos2030_tpose = var_51_10.localPosition

				local var_51_11 = GameObjectTools.GetOrAddComponent(var_51_10.gameObject, typeof(DynamicBoneHelper))

				if var_51_11 then
					var_51_11:EnableDynamicBone(false)
				end
			end

			local var_51_12 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_12 then
				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos2030_tpose, Vector3.New(0.7, -1.2, -4.2), (arg_48_1.time_ - 0) / var_51_12)
				var_51_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_10.position).x, (manager.ui.mainCamera.transform.position - var_51_10.position).y, (manager.ui.mainCamera.transform.position - var_51_10.position).z)
				var_51_10.localEulerAngles.z = 0
				var_51_10.localEulerAngles.x = 0
				var_51_10.localEulerAngles = var_51_10.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_12 and arg_48_1.time_ < 0 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0.7, -1.2, -4.2)
				var_51_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_10.position).x, (manager.ui.mainCamera.transform.position - var_51_10.position).y, (manager.ui.mainCamera.transform.position - var_51_10.position).z)
				var_51_10.localEulerAngles.z = 0
				var_51_10.localEulerAngles.x = 0
				var_51_10.localEulerAngles = var_51_10.localEulerAngles

				local var_51_13 = GameObjectTools.GetOrAddComponent(var_51_10.gameObject, typeof(DynamicBoneHelper))

				if var_51_13 then
					var_51_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_51_14 = 0
			local var_51_15 = 0.4

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_16 = arg_48_1:GetWordFromCfg(105082012)
				local var_51_17 = arg_48_1:FormatText(var_51_16.content)

				arg_48_1.text_.text = var_51_17

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_19 = 16 <= 0 and var_51_15 or var_51_15 * (utf8.len(var_51_17) / 16)

				if (16 <= 0 and var_51_15 or var_51_15 * (utf8.len(var_51_17) / 16)) > 0 and var_51_15 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_14 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_14
					end
				end

				arg_48_1.text_.text = var_51_17
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082012", "story_v_out_105082.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_105082", "105082012", "story_v_out_105082.awb") / 1000

					if var_51_20 + var_51_14 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_14
					end

					if var_51_16.prefab_name ~= "" and arg_48_1.actors_[var_51_16.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_16.prefab_name].transform, "story_v_out_105082", "105082012", "story_v_out_105082.awb")

						arg_48_1:RecordAudio("105082012", var_51_21)
						arg_48_1:RecordAudio("105082012", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_105082", "105082012", "story_v_out_105082.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_105082", "105082012", "story_v_out_105082.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_15, arg_48_1.talkMaxDuration)

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_14) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_14 + var_51_22 and arg_48_1.time_ < var_51_14 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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
	Play105082013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 105082013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play105082014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["2030_tpose"]) and arg_52_1.var_.characterEffect2030_tpose == nil then
				arg_52_1.var_.characterEffect2030_tpose = arg_52_1.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["2030_tpose"]) then
				if arg_52_1.var_.characterEffect2030_tpose and not isNil(arg_52_1.actors_["2030_tpose"]) then
					arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_52_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["2030_tpose"]) and arg_52_1.var_.characterEffect2030_tpose then
				arg_52_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_52_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_55_1 = arg_52_1.actors_["2030_tpose"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos2030_tpose = var_55_1.localPosition

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_1.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end
			end

			local var_55_3 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 then
				var_55_1.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_3)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 then
				var_55_1.localPosition = Vector3.New(0, 100, 0)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles

				local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_1.gameObject, typeof(DynamicBoneHelper))

				if var_55_4 then
					var_55_4:EnableDynamicBone(true)
				end
			end

			local var_55_5 = arg_52_1.actors_["2020_tpose"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos2020_tpose = var_55_5.localPosition

				local var_55_6 = GameObjectTools.GetOrAddComponent(var_55_5.gameObject, typeof(DynamicBoneHelper))

				if var_55_6 then
					var_55_6:EnableDynamicBone(false)
				end
			end

			local var_55_7 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_7)
				var_55_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_5.position).x, (manager.ui.mainCamera.transform.position - var_55_5.position).y, (manager.ui.mainCamera.transform.position - var_55_5.position).z)
				var_55_5.localEulerAngles.z = 0
				var_55_5.localEulerAngles.x = 0
				var_55_5.localEulerAngles = var_55_5.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(0, 100, 0)
				var_55_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_5.position).x, (manager.ui.mainCamera.transform.position - var_55_5.position).y, (manager.ui.mainCamera.transform.position - var_55_5.position).z)
				var_55_5.localEulerAngles.z = 0
				var_55_5.localEulerAngles.x = 0
				var_55_5.localEulerAngles = var_55_5.localEulerAngles

				local var_55_8 = GameObjectTools.GetOrAddComponent(var_55_5.gameObject, typeof(DynamicBoneHelper))

				if var_55_8 then
					var_55_8:EnableDynamicBone(true)
				end
			end

			local var_55_9 = 0
			local var_55_10 = 1.175

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_11 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(105082013).content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 47 <= 0 and var_55_10 or var_55_10 * (utf8.len(var_55_11) / 47)

				if (47 <= 0 and var_55_10 or var_55_10 * (utf8.len(var_55_11) / 47)) > 0 and var_55_10 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_9 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_9
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_10, arg_52_1.talkMaxDuration)

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_9) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_9 + var_55_14 and arg_52_1.time_ < var_55_9 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play105082014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 105082014
		arg_56_1.duration_ = 9

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play105082015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_0 = 2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				local var_59_1 = Color.New(0, 0, 0)

				var_59_1.a = Mathf.Lerp(0, 1, (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.mask_.color = var_59_1
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				local var_59_2 = Color.New(0, 0, 0)

				var_59_2.a = 1
				arg_56_1.mask_.color = var_59_2
			end

			local var_59_3 = 2

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_4 = 2

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_4 then
				local var_59_5 = Color.New(0, 0, 0)

				var_59_5.a = Mathf.Lerp(1, 0, (arg_56_1.time_ - var_59_3) / var_59_4)
				arg_56_1.mask_.color = var_59_5
			end

			if arg_56_1.time_ >= var_59_3 + var_59_4 and arg_56_1.time_ < var_59_3 + var_59_4 + arg_59_0 then
				local var_59_6 = Color.New(0, 0, 0)

				arg_56_1.mask_.enabled = false
				var_59_6.a = 0
				arg_56_1.mask_.color = var_59_6
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_7 = 4
			local var_59_8 = 0.175

			if 4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_9 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_9:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_10 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(105082014).content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_12 = 7 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_10) / 7)

				if (7 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_10) / 7)) > 0 and var_59_8 < var_59_12 then
					arg_56_1.talkMaxDuration = var_59_12
					var_59_7 = var_59_7 + 0.3

					if var_59_12 + var_59_7 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_7
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = var_59_7 + 0.3
			local var_59_14 = math.max(var_59_8, arg_56_1.talkMaxDuration)

			if var_59_7 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_13 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_13) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_13 + var_59_14 and arg_56_1.time_ < var_59_13 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play105082015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 105082015
		arg_62_1.duration_ = 2

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play105082016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if arg_62_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_65_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_62_1.stage_.transform)

				var_65_0.name = "1059ui_story"
				var_65_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["1059ui_story"] = var_65_0

				local var_65_1 = var_65_0:GetComponentInChildren(typeof(CharacterEffect))

				var_65_1.enabled = true

				local var_65_2 = GameObjectTools.GetOrAddComponent(var_65_0, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(false)
				end

				arg_62_1:ShowWeapon(var_65_1.transform, false)

				arg_62_1.var_["1059ui_story" .. "Animator"] = var_65_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_62_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_62_1.var_["1059ui_story" .. "LipSync"] = var_65_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_65_3 = arg_62_1.actors_["1059ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect1059ui_story == nil then
				arg_62_1.var_.characterEffect1059ui_story = var_65_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_4 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 and not isNil(var_65_3) then
				if arg_62_1.var_.characterEffect1059ui_story and not isNil(var_65_3) then
					arg_62_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect1059ui_story then
				arg_62_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_65_6 = arg_62_1.actors_["1059ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1059ui_story = var_65_6.localPosition
			end

			local var_65_7 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				var_65_6.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_62_1.time_ - 0) / var_65_7)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				var_65_6.localPosition = Vector3.New(0, -1.05, -6)
				var_65_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_6.position).x, (manager.ui.mainCamera.transform.position - var_65_6.position).y, (manager.ui.mainCamera.transform.position - var_65_6.position).z)
				var_65_6.localEulerAngles.z = 0
				var_65_6.localEulerAngles.x = 0
				var_65_6.localEulerAngles = var_65_6.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_65_8 = 0
			local var_65_9 = 0.075

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_8 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_10 = arg_62_1:GetWordFromCfg(105082015)
				local var_65_11 = arg_62_1:FormatText(var_65_10.content)

				arg_62_1.text_.text = var_65_11

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_13 = 3 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 3)

				if (3 <= 0 and var_65_9 or var_65_9 * (utf8.len(var_65_11) / 3)) > 0 and var_65_9 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_8
					end
				end

				arg_62_1.text_.text = var_65_11
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082015", "story_v_out_105082.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082015", "story_v_out_105082.awb") / 1000

					if var_65_14 + var_65_8 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_8
					end

					if var_65_10.prefab_name ~= "" and arg_62_1.actors_[var_65_10.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_10.prefab_name].transform, "story_v_out_105082", "105082015", "story_v_out_105082.awb")

						arg_62_1:RecordAudio("105082015", var_65_15)
						arg_62_1:RecordAudio("105082015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_105082", "105082015", "story_v_out_105082.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_105082", "105082015", "story_v_out_105082.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_9, arg_62_1.talkMaxDuration)

			if var_65_8 <= arg_62_1.time_ and arg_62_1.time_ < var_65_8 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_8) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_8 + var_65_16 and arg_62_1.time_ < var_65_8 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play105082016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 105082016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play105082017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1059ui_story"]) and arg_66_1.var_.characterEffect1059ui_story == nil then
				arg_66_1.var_.characterEffect1059ui_story = arg_66_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1059ui_story"]) then
				if arg_66_1.var_.characterEffect1059ui_story and not isNil(arg_66_1.actors_["1059ui_story"]) then
					arg_66_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1059ui_story"]) and arg_66_1.var_.characterEffect1059ui_story then
				arg_66_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_69_1 = arg_66_1.actors_["1059ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1059ui_story = var_69_1.localPosition
			end

			local var_69_2 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 then
				var_69_1.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_2)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 then
				var_69_1.localPosition = Vector3.New(0, 100, 0)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			local var_69_3 = 0
			local var_69_4 = 1.25

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_5 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(105082016).content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 49 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 49)

				if (49 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 49)) > 0 and var_69_4 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_3
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_4, arg_66_1.talkMaxDuration)

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_3) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_3 + var_69_8 and arg_66_1.time_ < var_69_3 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play105082017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 105082017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play105082018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:AudioAction("play", "effect", "se_story_5", "se_story_5_arrow", "")
			end

			local var_73_1 = 0
			local var_73_2 = 0.9

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

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(105082017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 36 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 36)

				if (36 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 36)) > 0 and var_73_2 < var_73_5 then
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

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play105082018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 105082018
		arg_74_1.duration_ = 2.83

		local var_74_0 = {
			ja = 2.833,
			ko = 2.766,
			zh = 2.5,
			en = 2.2
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
				arg_74_0:Play105082019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if arg_74_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_77_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_74_1.stage_.transform)

				var_77_0.name = "1148ui_story"
				var_77_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_74_1.actors_["1148ui_story"] = var_77_0

				local var_77_1 = var_77_0:GetComponentInChildren(typeof(CharacterEffect))

				var_77_1.enabled = true

				local var_77_2 = GameObjectTools.GetOrAddComponent(var_77_0, typeof(DynamicBoneHelper))

				if var_77_2 then
					var_77_2:EnableDynamicBone(false)
				end

				arg_74_1:ShowWeapon(var_77_1.transform, false)

				arg_74_1.var_["1148ui_story" .. "Animator"] = var_77_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_74_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_74_1.var_["1148ui_story" .. "LipSync"] = var_77_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_77_3 = arg_74_1.actors_["1148ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_3) and arg_74_1.var_.characterEffect1148ui_story == nil then
				arg_74_1.var_.characterEffect1148ui_story = var_77_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_4 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 and not isNil(var_77_3) then
				if arg_74_1.var_.characterEffect1148ui_story and not isNil(var_77_3) then
					arg_74_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 and not isNil(var_77_3) and arg_74_1.var_.characterEffect1148ui_story then
				arg_74_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_77_6 = arg_74_1.actors_["1148ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1148ui_story = var_77_6.localPosition
			end

			local var_77_7 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_74_1.time_ - 0) / var_77_7)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			local var_77_8 = 0
			local var_77_9 = 0.225

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_10 = arg_74_1:GetWordFromCfg(105082018)
				local var_77_11 = arg_74_1:FormatText(var_77_10.content)

				arg_74_1.text_.text = var_77_11

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 9 <= 0 and var_77_9 or var_77_9 * (utf8.len(var_77_11) / 9)

				if (9 <= 0 and var_77_9 or var_77_9 * (utf8.len(var_77_11) / 9)) > 0 and var_77_9 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_8
					end
				end

				arg_74_1.text_.text = var_77_11
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082018", "story_v_out_105082.awb") ~= 0 then
					local var_77_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082018", "story_v_out_105082.awb") / 1000

					if var_77_14 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_14 + var_77_8
					end

					if var_77_10.prefab_name ~= "" and arg_74_1.actors_[var_77_10.prefab_name] ~= nil then
						local var_77_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_10.prefab_name].transform, "story_v_out_105082", "105082018", "story_v_out_105082.awb")

						arg_74_1:RecordAudio("105082018", var_77_15)
						arg_74_1:RecordAudio("105082018", var_77_15)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_105082", "105082018", "story_v_out_105082.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_105082", "105082018", "story_v_out_105082.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_9, arg_74_1.talkMaxDuration)

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_8) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_8 + var_77_16 and arg_74_1.time_ < var_77_8 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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

		arg_74_1:InitPlayNodeList()
	end,
	Play105082019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 105082019
		arg_78_1.duration_ = 2.53

		local var_78_0 = {
			ja = 2.533,
			ko = 2.033,
			zh = 1.999999999999,
			en = 2.466
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
				arg_78_0:Play105082020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if arg_78_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_81_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_78_1.stage_.transform)

				var_81_0.name = "1027ui_story"
				var_81_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["1027ui_story"] = var_81_0

				local var_81_1 = var_81_0:GetComponentInChildren(typeof(CharacterEffect))

				var_81_1.enabled = true

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_0, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end

				arg_78_1:ShowWeapon(var_81_1.transform, false)

				arg_78_1.var_["1027ui_story" .. "Animator"] = var_81_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_78_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_78_1.var_["1027ui_story" .. "LipSync"] = var_81_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_81_3 = arg_78_1.actors_["1027ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1027ui_story == nil then
				arg_78_1.var_.characterEffect1027ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_4 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 and not isNil(var_81_3) then
				if arg_78_1.var_.characterEffect1027ui_story and not isNil(var_81_3) then
					arg_78_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1027ui_story then
				arg_78_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_81_6 = arg_78_1.actors_["1148ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect1148ui_story == nil then
				arg_78_1.var_.characterEffect1148ui_story = var_81_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_7 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 and not isNil(var_81_6) then
				if arg_78_1.var_.characterEffect1148ui_story and not isNil(var_81_6) then
					arg_78_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_7)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect1148ui_story then
				arg_78_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_81_8 = arg_78_1.actors_["1027ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1027ui_story = var_81_8.localPosition
			end

			local var_81_9 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_9 then
				var_81_8.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_78_1.time_ - 0) / var_81_9)
				var_81_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_8.position).x, (manager.ui.mainCamera.transform.position - var_81_8.position).y, (manager.ui.mainCamera.transform.position - var_81_8.position).z)
				var_81_8.localEulerAngles.z = 0
				var_81_8.localEulerAngles.x = 0
				var_81_8.localEulerAngles = var_81_8.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_9 and arg_78_1.time_ < 0 + var_81_9 + arg_81_0 then
				var_81_8.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_81_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_8.position).x, (manager.ui.mainCamera.transform.position - var_81_8.position).y, (manager.ui.mainCamera.transform.position - var_81_8.position).z)
				var_81_8.localEulerAngles.z = 0
				var_81_8.localEulerAngles.x = 0
				var_81_8.localEulerAngles = var_81_8.localEulerAngles
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_81_10 = 0
			local var_81_11 = 0.25

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_12 = arg_78_1:GetWordFromCfg(105082019)
				local var_81_13 = arg_78_1:FormatText(var_81_12.content)

				arg_78_1.text_.text = var_81_13

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 10 <= 0 and var_81_11 or var_81_11 * (utf8.len(var_81_13) / 10)

				if (10 <= 0 and var_81_11 or var_81_11 * (utf8.len(var_81_13) / 10)) > 0 and var_81_11 < var_81_15 then
					arg_78_1.talkMaxDuration = var_81_15

					if var_81_15 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_15 + var_81_10
					end
				end

				arg_78_1.text_.text = var_81_13
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082019", "story_v_out_105082.awb") ~= 0 then
					local var_81_16 = manager.audio:GetVoiceLength("story_v_out_105082", "105082019", "story_v_out_105082.awb") / 1000

					if var_81_16 + var_81_10 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_16 + var_81_10
					end

					if var_81_12.prefab_name ~= "" and arg_78_1.actors_[var_81_12.prefab_name] ~= nil then
						local var_81_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_12.prefab_name].transform, "story_v_out_105082", "105082019", "story_v_out_105082.awb")

						arg_78_1:RecordAudio("105082019", var_81_17)
						arg_78_1:RecordAudio("105082019", var_81_17)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_105082", "105082019", "story_v_out_105082.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_105082", "105082019", "story_v_out_105082.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_18 = math.max(var_81_11, arg_78_1.talkMaxDuration)

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_18 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_10) / var_81_18

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_10 + var_81_18 and arg_78_1.time_ < var_81_10 + var_81_18 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play105082020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 105082020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play105082021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1027ui_story"]) and arg_82_1.var_.characterEffect1027ui_story == nil then
				arg_82_1.var_.characterEffect1027ui_story = arg_82_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1027ui_story"]) then
				if arg_82_1.var_.characterEffect1027ui_story and not isNil(arg_82_1.actors_["1027ui_story"]) then
					arg_82_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1027ui_story"]) and arg_82_1.var_.characterEffect1027ui_story then
				arg_82_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_85_1 = 0
			local var_85_2 = 0.775

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(105082020).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 31 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 31)

				if (31 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 31)) > 0 and var_85_2 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_6 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_6

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_6 and arg_82_1.time_ < var_85_1 + var_85_6 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play105082021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 105082021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play105082022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1027ui_story = arg_86_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1027ui_story"].transform.position).z)
				arg_86_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1027ui_story"].transform.localEulerAngles = arg_86_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1027ui_story"].transform.position).z)
				arg_86_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1027ui_story"].transform.localEulerAngles = arg_86_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1148ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1148ui_story = var_89_1.localPosition
			end

			local var_89_2 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_2)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(0, 100, 0)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			local var_89_3 = 0
			local var_89_4 = 1.125

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_3 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_5 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(105082021).content)

				arg_86_1.text_.text = var_89_5

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_7 = 45 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 45)

				if (45 <= 0 and var_89_4 or var_89_4 * (utf8.len(var_89_5) / 45)) > 0 and var_89_4 < var_89_7 then
					arg_86_1.talkMaxDuration = var_89_7

					if var_89_7 + var_89_3 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_7 + var_89_3
					end
				end

				arg_86_1.text_.text = var_89_5
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_8 = math.max(var_89_4, arg_86_1.talkMaxDuration)

			if var_89_3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_3 + var_89_8 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_3) / var_89_8

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_3 + var_89_8 and arg_86_1.time_ < var_89_3 + var_89_8 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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

		arg_86_1:InitPlayNodeList()
	end,
	Play105082022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 105082022
		arg_90_1.duration_ = 10.6

		local var_90_0 = {
			ja = 10.166,
			ko = 7.333,
			zh = 9.066,
			en = 10.6
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
				arg_90_0:Play105082023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 1.175

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(105082022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 46 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 46)

				if (46 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 46)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082022", "story_v_out_105082.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_105082", "105082022", "story_v_out_105082.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_105082", "105082022", "story_v_out_105082.awb")

						arg_90_1:RecordAudio("105082022", var_93_6)
						arg_90_1:RecordAudio("105082022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_105082", "105082022", "story_v_out_105082.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_105082", "105082022", "story_v_out_105082.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play105082023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105082023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play105082024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.125

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(105082023).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 5 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 5)

				if (5 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 5)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play105082024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105082024
		arg_98_1.duration_ = 13.07

		local var_98_0 = {
			ja = 13.066,
			ko = 5.7,
			zh = 7.566,
			en = 8.266
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
				arg_98_0:Play105082025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_101_1 = "3005_tpose"

			if arg_98_1.actors_["3005_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3005_tpose"))) then
				local var_101_2 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_98_1.stage_.transform)

				var_101_2.name = var_101_1
				var_101_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_[var_101_1] = var_101_2

				local var_101_3 = var_101_2:GetComponentInChildren(typeof(CharacterEffect))

				var_101_3.enabled = true

				local var_101_4 = GameObjectTools.GetOrAddComponent(var_101_2, typeof(DynamicBoneHelper))

				if var_101_4 then
					var_101_4:EnableDynamicBone(false)
				end

				arg_98_1:ShowWeapon(var_101_3.transform, false)

				arg_98_1.var_[var_101_1 .. "Animator"] = var_101_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_98_1.var_[var_101_1 .. "Animator"].applyRootMotion = true
				arg_98_1.var_[var_101_1 .. "LipSync"] = var_101_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_101_5 = arg_98_1.actors_["3005_tpose"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect3005_tpose == nil then
				arg_98_1.var_.characterEffect3005_tpose = var_101_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_6 and not isNil(var_101_5) then
				if arg_98_1.var_.characterEffect3005_tpose and not isNil(var_101_5) then
					arg_98_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_6 and arg_98_1.time_ < 0 + var_101_6 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect3005_tpose then
				arg_98_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_101_8 = arg_98_1.actors_["3005_tpose"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos3005_tpose = var_101_8.localPosition

				local var_101_9 = GameObjectTools.GetOrAddComponent(var_101_8.gameObject, typeof(DynamicBoneHelper))

				if var_101_9 then
					var_101_9:EnableDynamicBone(false)
				end
			end

			local var_101_10 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_10 then
				var_101_8.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos3005_tpose, Vector3.New(0, -1.95, -2.63), (arg_98_1.time_ - 0) / var_101_10)
				var_101_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_8.position).x, (manager.ui.mainCamera.transform.position - var_101_8.position).y, (manager.ui.mainCamera.transform.position - var_101_8.position).z)
				var_101_8.localEulerAngles.z = 0
				var_101_8.localEulerAngles.x = 0
				var_101_8.localEulerAngles = var_101_8.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_10 and arg_98_1.time_ < 0 + var_101_10 + arg_101_0 then
				var_101_8.localPosition = Vector3.New(0, -1.95, -2.63)
				var_101_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_8.position).x, (manager.ui.mainCamera.transform.position - var_101_8.position).y, (manager.ui.mainCamera.transform.position - var_101_8.position).z)
				var_101_8.localEulerAngles.z = 0
				var_101_8.localEulerAngles.x = 0
				var_101_8.localEulerAngles = var_101_8.localEulerAngles

				local var_101_11 = GameObjectTools.GetOrAddComponent(var_101_8.gameObject, typeof(DynamicBoneHelper))

				if var_101_11 then
					var_101_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_101_12 = 0
			local var_101_13 = 0.6

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[58].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(105082024)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_17 = 24 <= 0 and var_101_13 or var_101_13 * (utf8.len(var_101_15) / 24)

				if (24 <= 0 and var_101_13 or var_101_13 * (utf8.len(var_101_15) / 24)) > 0 and var_101_13 < var_101_17 then
					arg_98_1.talkMaxDuration = var_101_17

					if var_101_17 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_17 + var_101_12
					end
				end

				arg_98_1.text_.text = var_101_15
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082024", "story_v_out_105082.awb") ~= 0 then
					local var_101_18 = manager.audio:GetVoiceLength("story_v_out_105082", "105082024", "story_v_out_105082.awb") / 1000

					if var_101_18 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_12
					end

					if var_101_14.prefab_name ~= "" and arg_98_1.actors_[var_101_14.prefab_name] ~= nil then
						local var_101_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_14.prefab_name].transform, "story_v_out_105082", "105082024", "story_v_out_105082.awb")

						arg_98_1:RecordAudio("105082024", var_101_19)
						arg_98_1:RecordAudio("105082024", var_101_19)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105082", "105082024", "story_v_out_105082.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105082", "105082024", "story_v_out_105082.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_20 = math.max(var_101_13, arg_98_1.talkMaxDuration)

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_20 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_12) / var_101_20

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_12 + var_101_20 and arg_98_1.time_ < var_101_12 + var_101_20 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play105082025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105082025
		arg_102_1.duration_ = 2.73

		local var_102_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 2.366,
			en = 2.566
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
				arg_102_0:Play105082026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1027ui_story"]) and arg_102_1.var_.characterEffect1027ui_story == nil then
				arg_102_1.var_.characterEffect1027ui_story = arg_102_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1027ui_story"]) then
				if arg_102_1.var_.characterEffect1027ui_story and not isNil(arg_102_1.actors_["1027ui_story"]) then
					arg_102_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1027ui_story"]) and arg_102_1.var_.characterEffect1027ui_story then
				arg_102_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["3005_tpose"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect3005_tpose == nil then
				arg_102_1.var_.characterEffect3005_tpose = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect3005_tpose and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_102_1.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect3005_tpose then
				arg_102_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_102_1.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			local var_105_4 = arg_102_1.actors_["3005_tpose"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos3005_tpose = var_105_4.localPosition

				local var_105_5 = GameObjectTools.GetOrAddComponent(var_105_4.gameObject, typeof(DynamicBoneHelper))

				if var_105_5 then
					var_105_5:EnableDynamicBone(false)
				end
			end

			local var_105_6 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_6 then
				var_105_4.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos3005_tpose, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_6)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_6 and arg_102_1.time_ < 0 + var_105_6 + arg_105_0 then
				var_105_4.localPosition = Vector3.New(0, 100, 0)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles

				local var_105_7 = GameObjectTools.GetOrAddComponent(var_105_4.gameObject, typeof(DynamicBoneHelper))

				if var_105_7 then
					var_105_7:EnableDynamicBone(true)
				end
			end

			local var_105_8 = arg_102_1.actors_["1027ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1027ui_story = var_105_8.localPosition
			end

			local var_105_9 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_9 then
				var_105_8.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_102_1.time_ - 0) / var_105_9)
				var_105_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_8.position).x, (manager.ui.mainCamera.transform.position - var_105_8.position).y, (manager.ui.mainCamera.transform.position - var_105_8.position).z)
				var_105_8.localEulerAngles.z = 0
				var_105_8.localEulerAngles.x = 0
				var_105_8.localEulerAngles = var_105_8.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_9 and arg_102_1.time_ < 0 + var_105_9 + arg_105_0 then
				var_105_8.localPosition = Vector3.New(0, -0.81, -5.8)
				var_105_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_8.position).x, (manager.ui.mainCamera.transform.position - var_105_8.position).y, (manager.ui.mainCamera.transform.position - var_105_8.position).z)
				var_105_8.localEulerAngles.z = 0
				var_105_8.localEulerAngles.x = 0
				var_105_8.localEulerAngles = var_105_8.localEulerAngles
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_105_10 = 0
			local var_105_11 = 0.25

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_12 = arg_102_1:GetWordFromCfg(105082025)
				local var_105_13 = arg_102_1:FormatText(var_105_12.content)

				arg_102_1.text_.text = var_105_13

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_15 = 10 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 10)

				if (10 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 10)) > 0 and var_105_11 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_10
					end
				end

				arg_102_1.text_.text = var_105_13
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082025", "story_v_out_105082.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_105082", "105082025", "story_v_out_105082.awb") / 1000

					if var_105_16 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_10
					end

					if var_105_12.prefab_name ~= "" and arg_102_1.actors_[var_105_12.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_12.prefab_name].transform, "story_v_out_105082", "105082025", "story_v_out_105082.awb")

						arg_102_1:RecordAudio("105082025", var_105_17)
						arg_102_1:RecordAudio("105082025", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105082", "105082025", "story_v_out_105082.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105082", "105082025", "story_v_out_105082.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_18 = math.max(var_105_11, arg_102_1.talkMaxDuration)

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_18 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_10) / var_105_18

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_10 + var_105_18 and arg_102_1.time_ < var_105_10 + var_105_18 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play105082026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105082026
		arg_106_1.duration_ = 2

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play105082027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if arg_106_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_109_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_106_1.stage_.transform)

				var_109_0.name = "1080ui_story"
				var_109_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["1080ui_story"] = var_109_0

				local var_109_1 = var_109_0:GetComponentInChildren(typeof(CharacterEffect))

				var_109_1.enabled = true

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_0, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end

				arg_106_1:ShowWeapon(var_109_1.transform, false)

				arg_106_1.var_["1080ui_story" .. "Animator"] = var_109_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_106_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_106_1.var_["1080ui_story" .. "LipSync"] = var_109_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_109_3 = arg_106_1.actors_["1080ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1080ui_story == nil then
				arg_106_1.var_.characterEffect1080ui_story = var_109_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_4 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 and not isNil(var_109_3) then
				if arg_106_1.var_.characterEffect1080ui_story and not isNil(var_109_3) then
					arg_106_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1080ui_story then
				arg_106_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_109_6 = arg_106_1.actors_["1027ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect1027ui_story == nil then
				arg_106_1.var_.characterEffect1027ui_story = var_109_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_7 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 and not isNil(var_109_6) then
				if arg_106_1.var_.characterEffect1027ui_story and not isNil(var_109_6) then
					arg_106_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_7)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect1027ui_story then
				arg_106_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_109_8 = arg_106_1.actors_["1027ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1027ui_story = var_109_8.localPosition
			end

			local var_109_9 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_9 then
				var_109_8.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_106_1.time_ - 0) / var_109_9)
				var_109_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_8.position).x, (manager.ui.mainCamera.transform.position - var_109_8.position).y, (manager.ui.mainCamera.transform.position - var_109_8.position).z)
				var_109_8.localEulerAngles.z = 0
				var_109_8.localEulerAngles.x = 0
				var_109_8.localEulerAngles = var_109_8.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_9 and arg_106_1.time_ < 0 + var_109_9 + arg_109_0 then
				var_109_8.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_109_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_8.position).x, (manager.ui.mainCamera.transform.position - var_109_8.position).y, (manager.ui.mainCamera.transform.position - var_109_8.position).z)
				var_109_8.localEulerAngles.z = 0
				var_109_8.localEulerAngles.x = 0
				var_109_8.localEulerAngles = var_109_8.localEulerAngles
			end

			local var_109_10 = arg_106_1.actors_["1027ui_story"].transform

			if 0.033 < arg_106_1.time_ and arg_106_1.time_ <= 0.033 + arg_109_0 then
				arg_106_1.var_.moveOldPos1027ui_story = var_109_10.localPosition
			end

			local var_109_11 = 0.5

			if 0.033 <= arg_106_1.time_ and arg_106_1.time_ < 0.033 + var_109_11 then
				var_109_10.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_106_1.time_ - 0.033) / var_109_11)
				var_109_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_10.position).x, (manager.ui.mainCamera.transform.position - var_109_10.position).y, (manager.ui.mainCamera.transform.position - var_109_10.position).z)
				var_109_10.localEulerAngles.z = 0
				var_109_10.localEulerAngles.x = 0
				var_109_10.localEulerAngles = var_109_10.localEulerAngles
			end

			if arg_106_1.time_ >= 0.033 + var_109_11 and arg_106_1.time_ < 0.033 + var_109_11 + arg_109_0 then
				var_109_10.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_109_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_10.position).x, (manager.ui.mainCamera.transform.position - var_109_10.position).y, (manager.ui.mainCamera.transform.position - var_109_10.position).z)
				var_109_10.localEulerAngles.z = 0
				var_109_10.localEulerAngles.x = 0
				var_109_10.localEulerAngles = var_109_10.localEulerAngles
			end

			local var_109_12 = arg_106_1.actors_["1080ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1080ui_story = var_109_12.localPosition
			end

			local var_109_13 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_13 then
				var_109_12.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_106_1.time_ - 0) / var_109_13)
				var_109_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_12.position).x, (manager.ui.mainCamera.transform.position - var_109_12.position).y, (manager.ui.mainCamera.transform.position - var_109_12.position).z)
				var_109_12.localEulerAngles.z = 0
				var_109_12.localEulerAngles.x = 0
				var_109_12.localEulerAngles = var_109_12.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_13 and arg_106_1.time_ < 0 + var_109_13 + arg_109_0 then
				var_109_12.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_109_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_12.position).x, (manager.ui.mainCamera.transform.position - var_109_12.position).y, (manager.ui.mainCamera.transform.position - var_109_12.position).z)
				var_109_12.localEulerAngles.z = 0
				var_109_12.localEulerAngles.x = 0
				var_109_12.localEulerAngles = var_109_12.localEulerAngles
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_109_14 = 0
			local var_109_15 = 0.075

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_14 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_16 = arg_106_1:GetWordFromCfg(105082026)
				local var_109_17 = arg_106_1:FormatText(var_109_16.content)

				arg_106_1.text_.text = var_109_17

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_19 = 3 <= 0 and var_109_15 or var_109_15 * (utf8.len(var_109_17) / 3)

				if (3 <= 0 and var_109_15 or var_109_15 * (utf8.len(var_109_17) / 3)) > 0 and var_109_15 < var_109_19 then
					arg_106_1.talkMaxDuration = var_109_19

					if var_109_19 + var_109_14 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_14
					end
				end

				arg_106_1.text_.text = var_109_17
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082026", "story_v_out_105082.awb") ~= 0 then
					local var_109_20 = manager.audio:GetVoiceLength("story_v_out_105082", "105082026", "story_v_out_105082.awb") / 1000

					if var_109_20 + var_109_14 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_20 + var_109_14
					end

					if var_109_16.prefab_name ~= "" and arg_106_1.actors_[var_109_16.prefab_name] ~= nil then
						local var_109_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_16.prefab_name].transform, "story_v_out_105082", "105082026", "story_v_out_105082.awb")

						arg_106_1:RecordAudio("105082026", var_109_21)
						arg_106_1:RecordAudio("105082026", var_109_21)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_105082", "105082026", "story_v_out_105082.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_105082", "105082026", "story_v_out_105082.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_15, arg_106_1.talkMaxDuration)

			if var_109_14 <= arg_106_1.time_ and arg_106_1.time_ < var_109_14 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_14) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_14 + var_109_22 and arg_106_1.time_ < var_109_14 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play105082027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105082027
		arg_110_1.duration_ = 3.67

		local var_110_0 = {
			ja = 3.666,
			ko = 2.033,
			zh = 1.8,
			en = 2.5
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
				arg_110_0:Play105082028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1080ui_story"]) and arg_110_1.var_.characterEffect1080ui_story == nil then
				arg_110_1.var_.characterEffect1080ui_story = arg_110_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1080ui_story"]) then
				if arg_110_1.var_.characterEffect1080ui_story and not isNil(arg_110_1.actors_["1080ui_story"]) then
					arg_110_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1080ui_story"]) and arg_110_1.var_.characterEffect1080ui_story then
				arg_110_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_113_1 = arg_110_1.actors_["1027ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1027ui_story = var_113_1.localPosition
			end

			local var_113_2 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 then
				var_113_1.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_2)
				var_113_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_1.position).x, (manager.ui.mainCamera.transform.position - var_113_1.position).y, (manager.ui.mainCamera.transform.position - var_113_1.position).z)
				var_113_1.localEulerAngles.z = 0
				var_113_1.localEulerAngles.x = 0
				var_113_1.localEulerAngles = var_113_1.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 then
				var_113_1.localPosition = Vector3.New(0, 100, 0)
				var_113_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_1.position).x, (manager.ui.mainCamera.transform.position - var_113_1.position).y, (manager.ui.mainCamera.transform.position - var_113_1.position).z)
				var_113_1.localEulerAngles.z = 0
				var_113_1.localEulerAngles.x = 0
				var_113_1.localEulerAngles = var_113_1.localEulerAngles
			end

			local var_113_3 = arg_110_1.actors_["1080ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1080ui_story = var_113_3.localPosition
			end

			local var_113_4 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				var_113_3.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_4)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				var_113_3.localPosition = Vector3.New(0, 100, 0)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles
			end

			local var_113_5 = 0
			local var_113_6 = 0.2

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_7 = arg_110_1:GetWordFromCfg(105082027)
				local var_113_8 = arg_110_1:FormatText(var_113_7.content)

				arg_110_1.text_.text = var_113_8

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_10 = 8 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_8) / 8)

				if (8 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_8) / 8)) > 0 and var_113_6 < var_113_10 then
					arg_110_1.talkMaxDuration = var_113_10

					if var_113_10 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_5
					end
				end

				arg_110_1.text_.text = var_113_8
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082027", "story_v_out_105082.awb") ~= 0 then
					local var_113_11 = manager.audio:GetVoiceLength("story_v_out_105082", "105082027", "story_v_out_105082.awb") / 1000

					if var_113_11 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_5
					end

					if var_113_7.prefab_name ~= "" and arg_110_1.actors_[var_113_7.prefab_name] ~= nil then
						local var_113_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_7.prefab_name].transform, "story_v_out_105082", "105082027", "story_v_out_105082.awb")

						arg_110_1:RecordAudio("105082027", var_113_12)
						arg_110_1:RecordAudio("105082027", var_113_12)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105082", "105082027", "story_v_out_105082.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105082", "105082027", "story_v_out_105082.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_13 = math.max(var_113_6, arg_110_1.talkMaxDuration)

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_13 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_5) / var_113_13

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_5 + var_113_13 and arg_110_1.time_ < var_113_5 + var_113_13 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play105082028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105082028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play105082029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.675

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(105082028).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 26 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 26)

				if (26 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 26)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play105082029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105082029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play105082030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.6

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(105082029).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 24 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 24)

				if (24 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 24)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play105082030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 105082030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play105082031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_5", "se_story_5_robotstop", "")
			end

			local var_125_1 = 0
			local var_125_2 = 1.2

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(105082030).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 48 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 48)

				if (48 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 48)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play105082031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 105082031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play105082032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:AudioAction("play", "effect", "se_story_5", "se_story_5_robotcollapse", "")
			end

			local var_129_1 = 0
			local var_129_2 = 1.4

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(105082031).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 56 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 56)

				if (56 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 56)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play105082032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 105082032
		arg_130_1.duration_ = 5.67

		local var_130_0 = {
			ja = 5.666,
			ko = 4.033,
			zh = 4.7,
			en = 3.3
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play105082033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.375

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_1 = arg_130_1:GetWordFromCfg(105082032)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 14 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 14)

				if (14 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 14)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082032", "story_v_out_105082.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_105082", "105082032", "story_v_out_105082.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_105082", "105082032", "story_v_out_105082.awb")

						arg_130_1:RecordAudio("105082032", var_133_6)
						arg_130_1:RecordAudio("105082032", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_105082", "105082032", "story_v_out_105082.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_105082", "105082032", "story_v_out_105082.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play105082033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 105082033
		arg_134_1.duration_ = 2.83

		local var_134_0 = {
			ja = 2.833,
			ko = 1.999999999999,
			zh = 2.533,
			en = 2.533
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
				arg_134_0:Play105082034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1027ui_story"]) and arg_134_1.var_.characterEffect1027ui_story == nil then
				arg_134_1.var_.characterEffect1027ui_story = arg_134_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.1

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1027ui_story"]) then
				if arg_134_1.var_.characterEffect1027ui_story and not isNil(arg_134_1.actors_["1027ui_story"]) then
					arg_134_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1027ui_story"]) and arg_134_1.var_.characterEffect1027ui_story then
				arg_134_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_137_2 = arg_134_1.actors_["1027ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1027ui_story = var_137_2.localPosition
			end

			local var_137_3 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 then
				var_137_2.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_134_1.time_ - 0) / var_137_3)
				var_137_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_2.position).x, (manager.ui.mainCamera.transform.position - var_137_2.position).y, (manager.ui.mainCamera.transform.position - var_137_2.position).z)
				var_137_2.localEulerAngles.z = 0
				var_137_2.localEulerAngles.x = 0
				var_137_2.localEulerAngles = var_137_2.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 then
				var_137_2.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_137_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_2.position).x, (manager.ui.mainCamera.transform.position - var_137_2.position).y, (manager.ui.mainCamera.transform.position - var_137_2.position).z)
				var_137_2.localEulerAngles.z = 0
				var_137_2.localEulerAngles.x = 0
				var_137_2.localEulerAngles = var_137_2.localEulerAngles
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_137_4 = 0
			local var_137_5 = 0.25

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(105082033)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 10 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 10)

				if (10 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 10)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082033", "story_v_out_105082.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_105082", "105082033", "story_v_out_105082.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_105082", "105082033", "story_v_out_105082.awb")

						arg_134_1:RecordAudio("105082033", var_137_11)
						arg_134_1:RecordAudio("105082033", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_105082", "105082033", "story_v_out_105082.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_105082", "105082033", "story_v_out_105082.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play105082034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 105082034
		arg_138_1.duration_ = 3.8

		local var_138_0 = {
			ja = 3.8,
			ko = 2.4,
			zh = 2.066,
			en = 2.8
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
				arg_138_0:Play105082035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1059ui_story"]) and arg_138_1.var_.characterEffect1059ui_story == nil then
				arg_138_1.var_.characterEffect1059ui_story = arg_138_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1059ui_story"]) then
				if arg_138_1.var_.characterEffect1059ui_story and not isNil(arg_138_1.actors_["1059ui_story"]) then
					arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1059ui_story"]) and arg_138_1.var_.characterEffect1059ui_story then
				arg_138_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_141_2 = arg_138_1.actors_["1027ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1027ui_story == nil then
				arg_138_1.var_.characterEffect1027ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_3 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.characterEffect1027ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_3)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1027ui_story then
				arg_138_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_141_4 = arg_138_1.actors_["1059ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1059ui_story = var_141_4.localPosition
			end

			local var_141_5 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 then
				var_141_4.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_138_1.time_ - 0) / var_141_5)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 then
				var_141_4.localPosition = Vector3.New(0.7, -1.05, -6)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_141_6 = 0
			local var_141_7 = 0.2

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(105082034)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 8 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 8)

				if (8 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 8)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082034", "story_v_out_105082.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_105082", "105082034", "story_v_out_105082.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_105082", "105082034", "story_v_out_105082.awb")

						arg_138_1:RecordAudio("105082034", var_141_13)
						arg_138_1:RecordAudio("105082034", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_105082", "105082034", "story_v_out_105082.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_105082", "105082034", "story_v_out_105082.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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

		arg_138_1:InitPlayNodeList()
	end,
	Play105082035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 105082035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play105082036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1059ui_story"]) and arg_142_1.var_.characterEffect1059ui_story == nil then
				arg_142_1.var_.characterEffect1059ui_story = arg_142_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.1

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1059ui_story"]) then
				if arg_142_1.var_.characterEffect1059ui_story and not isNil(arg_142_1.actors_["1059ui_story"]) then
					arg_142_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1059ui_story"]) and arg_142_1.var_.characterEffect1059ui_story then
				arg_142_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_145_1 = arg_142_1.actors_["1059ui_story"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1059ui_story = var_145_1.localPosition
			end

			local var_145_2 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_2 then
				var_145_1.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_2)
				var_145_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_1.position).x, (manager.ui.mainCamera.transform.position - var_145_1.position).y, (manager.ui.mainCamera.transform.position - var_145_1.position).z)
				var_145_1.localEulerAngles.z = 0
				var_145_1.localEulerAngles.x = 0
				var_145_1.localEulerAngles = var_145_1.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_2 and arg_142_1.time_ < 0 + var_145_2 + arg_145_0 then
				var_145_1.localPosition = Vector3.New(0, 100, 0)
				var_145_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_1.position).x, (manager.ui.mainCamera.transform.position - var_145_1.position).y, (manager.ui.mainCamera.transform.position - var_145_1.position).z)
				var_145_1.localEulerAngles.z = 0
				var_145_1.localEulerAngles.x = 0
				var_145_1.localEulerAngles = var_145_1.localEulerAngles
			end

			local var_145_3 = arg_142_1.actors_["1027ui_story"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1027ui_story = var_145_3.localPosition
			end

			local var_145_4 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				var_145_3.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_4)
				var_145_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_3.position).x, (manager.ui.mainCamera.transform.position - var_145_3.position).y, (manager.ui.mainCamera.transform.position - var_145_3.position).z)
				var_145_3.localEulerAngles.z = 0
				var_145_3.localEulerAngles.x = 0
				var_145_3.localEulerAngles = var_145_3.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				var_145_3.localPosition = Vector3.New(0, 100, 0)
				var_145_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_3.position).x, (manager.ui.mainCamera.transform.position - var_145_3.position).y, (manager.ui.mainCamera.transform.position - var_145_3.position).z)
				var_145_3.localEulerAngles.z = 0
				var_145_3.localEulerAngles.x = 0
				var_145_3.localEulerAngles = var_145_3.localEulerAngles
			end

			local var_145_5 = 0
			local var_145_6 = 0.575

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_7 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(105082035).content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 23 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_7) / 23)

				if (23 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_7) / 23)) > 0 and var_145_6 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_10 and arg_142_1.time_ < var_145_5 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play105082036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 105082036
		arg_146_1.duration_ = 10.43

		local var_146_0 = {
			ja = 10.433,
			ko = 6.8,
			zh = 5.666,
			en = 7.3
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
				arg_146_0:Play105082037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1059ui_story"]) and arg_146_1.var_.characterEffect1059ui_story == nil then
				arg_146_1.var_.characterEffect1059ui_story = arg_146_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1059ui_story"]) then
				if arg_146_1.var_.characterEffect1059ui_story and not isNil(arg_146_1.actors_["1059ui_story"]) then
					arg_146_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1059ui_story"]) and arg_146_1.var_.characterEffect1059ui_story then
				arg_146_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_149_2 = arg_146_1.actors_["1059ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1059ui_story = var_149_2.localPosition
			end

			local var_149_3 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 then
				var_149_2.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_146_1.time_ - 0) / var_149_3)
				var_149_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_2.position).x, (manager.ui.mainCamera.transform.position - var_149_2.position).y, (manager.ui.mainCamera.transform.position - var_149_2.position).z)
				var_149_2.localEulerAngles.z = 0
				var_149_2.localEulerAngles.x = 0
				var_149_2.localEulerAngles = var_149_2.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 then
				var_149_2.localPosition = Vector3.New(0, -1.05, -6)
				var_149_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_2.position).x, (manager.ui.mainCamera.transform.position - var_149_2.position).y, (manager.ui.mainCamera.transform.position - var_149_2.position).z)
				var_149_2.localEulerAngles.z = 0
				var_149_2.localEulerAngles.x = 0
				var_149_2.localEulerAngles = var_149_2.localEulerAngles
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_149_4 = 0
			local var_149_5 = 0.675

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(105082036)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 27 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 27)

				if (27 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 27)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082036", "story_v_out_105082.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_out_105082", "105082036", "story_v_out_105082.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_out_105082", "105082036", "story_v_out_105082.awb")

						arg_146_1:RecordAudio("105082036", var_149_11)
						arg_146_1:RecordAudio("105082036", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_105082", "105082036", "story_v_out_105082.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_105082", "105082036", "story_v_out_105082.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play105082037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 105082037
		arg_150_1.duration_ = 2.5

		local var_150_0 = {
			ja = 2.5,
			ko = 1.999999999999,
			zh = 2.233,
			en = 1.999999999999
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play105082038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1027ui_story"]) and arg_150_1.var_.characterEffect1027ui_story == nil then
				arg_150_1.var_.characterEffect1027ui_story = arg_150_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1027ui_story"]) then
				if arg_150_1.var_.characterEffect1027ui_story and not isNil(arg_150_1.actors_["1027ui_story"]) then
					arg_150_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1027ui_story"]) and arg_150_1.var_.characterEffect1027ui_story then
				arg_150_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_153_2 = arg_150_1.actors_["1059ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1059ui_story == nil then
				arg_150_1.var_.characterEffect1059ui_story = var_153_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_3 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.characterEffect1059ui_story and not isNil(var_153_2) then
					arg_150_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_3)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect1059ui_story then
				arg_150_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_153_4 = arg_150_1.actors_["1059ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1059ui_story = var_153_4.localPosition
			end

			local var_153_5 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_5 then
				var_153_4.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_5)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_5 and arg_150_1.time_ < 0 + var_153_5 + arg_153_0 then
				var_153_4.localPosition = Vector3.New(0, 100, 0)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles
			end

			local var_153_6 = arg_150_1.actors_["1027ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1027ui_story = var_153_6.localPosition
			end

			local var_153_7 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				var_153_6.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_150_1.time_ - 0) / var_153_7)
				var_153_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_6.position).x, (manager.ui.mainCamera.transform.position - var_153_6.position).y, (manager.ui.mainCamera.transform.position - var_153_6.position).z)
				var_153_6.localEulerAngles.z = 0
				var_153_6.localEulerAngles.x = 0
				var_153_6.localEulerAngles = var_153_6.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				var_153_6.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_153_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_6.position).x, (manager.ui.mainCamera.transform.position - var_153_6.position).y, (manager.ui.mainCamera.transform.position - var_153_6.position).z)
				var_153_6.localEulerAngles.z = 0
				var_153_6.localEulerAngles.x = 0
				var_153_6.localEulerAngles = var_153_6.localEulerAngles
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_153_8 = 0
			local var_153_9 = 0.175

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:GetWordFromCfg(105082037)
				local var_153_11 = arg_150_1:FormatText(var_153_10.content)

				arg_150_1.text_.text = var_153_11

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 7 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 7)

				if (7 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 7)) > 0 and var_153_9 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_11
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082037", "story_v_out_105082.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082037", "story_v_out_105082.awb") / 1000

					if var_153_14 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_8
					end

					if var_153_10.prefab_name ~= "" and arg_150_1.actors_[var_153_10.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_10.prefab_name].transform, "story_v_out_105082", "105082037", "story_v_out_105082.awb")

						arg_150_1:RecordAudio("105082037", var_153_15)
						arg_150_1:RecordAudio("105082037", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_105082", "105082037", "story_v_out_105082.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_105082", "105082037", "story_v_out_105082.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_9, arg_150_1.talkMaxDuration)

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_8) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_8 + var_153_16 and arg_150_1.time_ < var_153_8 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play105082038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 105082038
		arg_154_1.duration_ = 4.57

		local var_154_0 = {
			ja = 4.366,
			ko = 4.366,
			zh = 4.133,
			en = 4.566
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
				arg_154_0:Play105082039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1148ui_story"]) and arg_154_1.var_.characterEffect1148ui_story == nil then
				arg_154_1.var_.characterEffect1148ui_story = arg_154_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1148ui_story"]) then
				if arg_154_1.var_.characterEffect1148ui_story and not isNil(arg_154_1.actors_["1148ui_story"]) then
					arg_154_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1148ui_story"]) and arg_154_1.var_.characterEffect1148ui_story then
				arg_154_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_157_2 = arg_154_1.actors_["1027ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1027ui_story == nil then
				arg_154_1.var_.characterEffect1027ui_story = var_157_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_3 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.characterEffect1027ui_story and not isNil(var_157_2) then
					arg_154_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_3)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1027ui_story then
				arg_154_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_157_4 = arg_154_1.actors_["1148ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1148ui_story = var_157_4.localPosition
			end

			local var_157_5 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_5 then
				var_157_4.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_154_1.time_ - 0) / var_157_5)
				var_157_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_4.position).x, (manager.ui.mainCamera.transform.position - var_157_4.position).y, (manager.ui.mainCamera.transform.position - var_157_4.position).z)
				var_157_4.localEulerAngles.z = 0
				var_157_4.localEulerAngles.x = 0
				var_157_4.localEulerAngles = var_157_4.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_5 and arg_154_1.time_ < 0 + var_157_5 + arg_157_0 then
				var_157_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_157_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_4.position).x, (manager.ui.mainCamera.transform.position - var_157_4.position).y, (manager.ui.mainCamera.transform.position - var_157_4.position).z)
				var_157_4.localEulerAngles.z = 0
				var_157_4.localEulerAngles.x = 0
				var_157_4.localEulerAngles = var_157_4.localEulerAngles
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_157_6 = 0
			local var_157_7 = 0.475

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_8 = arg_154_1:GetWordFromCfg(105082038)
				local var_157_9 = arg_154_1:FormatText(var_157_8.content)

				arg_154_1.text_.text = var_157_9

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 19 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_9) / 19)

				if (19 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_9) / 19)) > 0 and var_157_7 < var_157_11 then
					arg_154_1.talkMaxDuration = var_157_11

					if var_157_11 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_9
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082038", "story_v_out_105082.awb") ~= 0 then
					local var_157_12 = manager.audio:GetVoiceLength("story_v_out_105082", "105082038", "story_v_out_105082.awb") / 1000

					if var_157_12 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_12 + var_157_6
					end

					if var_157_8.prefab_name ~= "" and arg_154_1.actors_[var_157_8.prefab_name] ~= nil then
						local var_157_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_8.prefab_name].transform, "story_v_out_105082", "105082038", "story_v_out_105082.awb")

						arg_154_1:RecordAudio("105082038", var_157_13)
						arg_154_1:RecordAudio("105082038", var_157_13)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_105082", "105082038", "story_v_out_105082.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_105082", "105082038", "story_v_out_105082.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_14 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_14 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_14

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_14 and arg_154_1.time_ < var_157_6 + var_157_14 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play105082039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 105082039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play105082040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1148ui_story"]) and arg_158_1.var_.characterEffect1148ui_story == nil then
				arg_158_1.var_.characterEffect1148ui_story = arg_158_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.1

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1148ui_story"]) then
				if arg_158_1.var_.characterEffect1148ui_story and not isNil(arg_158_1.actors_["1148ui_story"]) then
					arg_158_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1148ui_story"]) and arg_158_1.var_.characterEffect1148ui_story then
				arg_158_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 0.625

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(105082039).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 25 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 25)

				if (25 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 25)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play105082040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 105082040
		arg_162_1.duration_ = 2.07

		local var_162_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.066,
			en = 1.999999999999
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play105082041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1080ui_story"]) and arg_162_1.var_.characterEffect1080ui_story == nil then
				arg_162_1.var_.characterEffect1080ui_story = arg_162_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.1

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1080ui_story"]) then
				if arg_162_1.var_.characterEffect1080ui_story and not isNil(arg_162_1.actors_["1080ui_story"]) then
					arg_162_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1080ui_story"]) and arg_162_1.var_.characterEffect1080ui_story then
				arg_162_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_165_2 = arg_162_1.actors_["1148ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1148ui_story = var_165_2.localPosition
			end

			local var_165_3 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_3 then
				var_165_2.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_3)
				var_165_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_2.position).x, (manager.ui.mainCamera.transform.position - var_165_2.position).y, (manager.ui.mainCamera.transform.position - var_165_2.position).z)
				var_165_2.localEulerAngles.z = 0
				var_165_2.localEulerAngles.x = 0
				var_165_2.localEulerAngles = var_165_2.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_3 and arg_162_1.time_ < 0 + var_165_3 + arg_165_0 then
				var_165_2.localPosition = Vector3.New(0, 100, 0)
				var_165_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_2.position).x, (manager.ui.mainCamera.transform.position - var_165_2.position).y, (manager.ui.mainCamera.transform.position - var_165_2.position).z)
				var_165_2.localEulerAngles.z = 0
				var_165_2.localEulerAngles.x = 0
				var_165_2.localEulerAngles = var_165_2.localEulerAngles
			end

			local var_165_4 = arg_162_1.actors_["1027ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1027ui_story = var_165_4.localPosition
			end

			local var_165_5 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_5 then
				var_165_4.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_5)
				var_165_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_4.position).x, (manager.ui.mainCamera.transform.position - var_165_4.position).y, (manager.ui.mainCamera.transform.position - var_165_4.position).z)
				var_165_4.localEulerAngles.z = 0
				var_165_4.localEulerAngles.x = 0
				var_165_4.localEulerAngles = var_165_4.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_5 and arg_162_1.time_ < 0 + var_165_5 + arg_165_0 then
				var_165_4.localPosition = Vector3.New(0, 100, 0)
				var_165_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_4.position).x, (manager.ui.mainCamera.transform.position - var_165_4.position).y, (manager.ui.mainCamera.transform.position - var_165_4.position).z)
				var_165_4.localEulerAngles.z = 0
				var_165_4.localEulerAngles.x = 0
				var_165_4.localEulerAngles = var_165_4.localEulerAngles
			end

			local var_165_6 = arg_162_1.actors_["1080ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1080ui_story = var_165_6.localPosition
			end

			local var_165_7 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				var_165_6.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_162_1.time_ - 0) / var_165_7)
				var_165_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_6.position).x, (manager.ui.mainCamera.transform.position - var_165_6.position).y, (manager.ui.mainCamera.transform.position - var_165_6.position).z)
				var_165_6.localEulerAngles.z = 0
				var_165_6.localEulerAngles.x = 0
				var_165_6.localEulerAngles = var_165_6.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				var_165_6.localPosition = Vector3.New(0, -1.01, -6.05)
				var_165_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_6.position).x, (manager.ui.mainCamera.transform.position - var_165_6.position).y, (manager.ui.mainCamera.transform.position - var_165_6.position).z)
				var_165_6.localEulerAngles.z = 0
				var_165_6.localEulerAngles.x = 0
				var_165_6.localEulerAngles = var_165_6.localEulerAngles
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_165_8 = 0
			local var_165_9 = 0.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_8 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_10 = arg_162_1:GetWordFromCfg(105082040)
				local var_165_11 = arg_162_1:FormatText(var_165_10.content)

				arg_162_1.text_.text = var_165_11

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_13 = 7 <= 0 and var_165_9 or var_165_9 * (utf8.len(var_165_11) / 7)

				if (7 <= 0 and var_165_9 or var_165_9 * (utf8.len(var_165_11) / 7)) > 0 and var_165_9 < var_165_13 then
					arg_162_1.talkMaxDuration = var_165_13

					if var_165_13 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_13 + var_165_8
					end
				end

				arg_162_1.text_.text = var_165_11
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082040", "story_v_out_105082.awb") ~= 0 then
					local var_165_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082040", "story_v_out_105082.awb") / 1000

					if var_165_14 + var_165_8 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_14 + var_165_8
					end

					if var_165_10.prefab_name ~= "" and arg_162_1.actors_[var_165_10.prefab_name] ~= nil then
						local var_165_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_10.prefab_name].transform, "story_v_out_105082", "105082040", "story_v_out_105082.awb")

						arg_162_1:RecordAudio("105082040", var_165_15)
						arg_162_1:RecordAudio("105082040", var_165_15)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_105082", "105082040", "story_v_out_105082.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_105082", "105082040", "story_v_out_105082.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_16 = math.max(var_165_9, arg_162_1.talkMaxDuration)

			if var_165_8 <= arg_162_1.time_ and arg_162_1.time_ < var_165_8 + var_165_16 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_8) / var_165_16

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_8 + var_165_16 and arg_162_1.time_ < var_165_8 + var_165_16 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play105082041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 105082041
		arg_166_1.duration_ = 7

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play105082042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_169_2 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_2 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_2

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_2
						arg_166_1.bgmTxt2_.text = var_169_2
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_169_3 = arg_166_1.actors_["1080ui_story"]

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= 2 + arg_169_0 and not isNil(var_169_3) and arg_166_1.var_.characterEffect1080ui_story == nil then
				arg_166_1.var_.characterEffect1080ui_story = var_169_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_4 = 0.1

			if 2 <= arg_166_1.time_ and arg_166_1.time_ < 2 + var_169_4 and not isNil(var_169_3) then
				if arg_166_1.var_.characterEffect1080ui_story and not isNil(var_169_3) then
					arg_166_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 2) / var_169_4)
				end
			end

			if arg_166_1.time_ >= 2 + var_169_4 and arg_166_1.time_ < 2 + var_169_4 + arg_169_0 and not isNil(var_169_3) and arg_166_1.var_.characterEffect1080ui_story then
				arg_166_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				local var_169_5 = arg_166_1.bgs_.B14:GetComponent("SpriteRenderer")

				if var_169_5 then
					arg_166_1.var_.alphaOldValueB14 = var_169_5.color.a
					arg_166_1.var_.alphaMatValueB14 = var_169_5
				end

				arg_166_1.var_.alphaOldValueB14 = 1
			end

			local var_169_6 = 1.5

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_6 then
				if arg_166_1.var_.alphaMatValueB14 then
					arg_166_1.var_.alphaMatValueB14.color.a = Mathf.Lerp(arg_166_1.var_.alphaOldValueB14, 0, (arg_166_1.time_ - 0) / var_169_6)
					arg_166_1.var_.alphaMatValueB14.color = arg_166_1.var_.alphaMatValueB14.color
				end
			end

			if arg_166_1.time_ >= 0 + var_169_6 and arg_166_1.time_ < 0 + var_169_6 + arg_169_0 and arg_166_1.var_.alphaMatValueB14 then
				arg_166_1.var_.alphaMatValueB14.color.a = 0
				arg_166_1.var_.alphaMatValueB14.color = arg_166_1.var_.alphaMatValueB14.color
			end

			local var_169_7 = arg_166_1.bgs_.B14.transform

			if 1.5 < arg_166_1.time_ and arg_166_1.time_ <= 1.5 + arg_169_0 then
				arg_166_1.var_.moveOldPosB14 = var_169_7.localPosition
			end

			local var_169_8 = 0.001

			if 1.5 <= arg_166_1.time_ and arg_166_1.time_ < 1.5 + var_169_8 then
				var_169_7.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPosB14, Vector3.New(0, -100, 10), (arg_166_1.time_ - 1.5) / var_169_8)
			end

			if arg_166_1.time_ >= 1.5 + var_169_8 and arg_166_1.time_ < 1.5 + var_169_8 + arg_169_0 then
				var_169_7.localPosition = Vector3.New(0, -100, 10)
			end

			local var_169_9 = "A00"

			if arg_166_1.bgs_.A00 == nil then
				local var_169_10 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_169_9)
				var_169_10.name = var_169_9
				var_169_10.transform.parent = arg_166_1.stage_.transform
				var_169_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_[var_169_9] = var_169_10
			end

			if 1.5 < arg_166_1.time_ and arg_166_1.time_ <= 1.5 + arg_169_0 then
				local var_169_11 = arg_166_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_169_11 then
					arg_166_1.var_.alphaOldValueA00 = var_169_11.color.a
					arg_166_1.var_.alphaMatValueA00 = var_169_11
				end

				arg_166_1.var_.alphaOldValueA00 = 0
			end

			local var_169_12 = 1.5

			if 1.5 <= arg_166_1.time_ and arg_166_1.time_ < 1.5 + var_169_12 then
				if arg_166_1.var_.alphaMatValueA00 then
					arg_166_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_166_1.var_.alphaOldValueA00, 1, (arg_166_1.time_ - 1.5) / var_169_12)
					arg_166_1.var_.alphaMatValueA00.color = arg_166_1.var_.alphaMatValueA00.color
				end
			end

			if arg_166_1.time_ >= 1.5 + var_169_12 and arg_166_1.time_ < 1.5 + var_169_12 + arg_169_0 and arg_166_1.var_.alphaMatValueA00 then
				arg_166_1.var_.alphaMatValueA00.color.a = 1
				arg_166_1.var_.alphaMatValueA00.color = arg_166_1.var_.alphaMatValueA00.color
			end

			if 1.5 < arg_166_1.time_ and arg_166_1.time_ <= 1.5 + arg_169_0 then
				local var_169_13 = arg_166_1.bgs_.A00

				arg_166_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_14 = var_169_13:GetComponent("SpriteRenderer")

				if var_169_14 and var_169_14.sprite then
					local var_169_15 = 2 * (var_169_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_13.transform.localScale = Vector3.New(var_169_15 / var_169_14.sprite.bounds.size.y < var_169_15 * manager.ui.mainCameraCom_.aspect / var_169_14.sprite.bounds.size.x and var_169_15 * manager.ui.mainCameraCom_.aspect / var_169_14.sprite.bounds.size.x or var_169_15 / var_169_14.sprite.bounds.size.y, var_169_15 / var_169_14.sprite.bounds.size.y < var_169_15 * manager.ui.mainCameraCom_.aspect / var_169_14.sprite.bounds.size.x and var_169_15 * manager.ui.mainCameraCom_.aspect / var_169_14.sprite.bounds.size.x or var_169_15 / var_169_14.sprite.bounds.size.y, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "A00" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_16 = arg_166_1.actors_["1080ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1080ui_story = var_169_16.localPosition
			end

			local var_169_17 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_17 then
				var_169_16.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_17)
				var_169_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_16.position).x, (manager.ui.mainCamera.transform.position - var_169_16.position).y, (manager.ui.mainCamera.transform.position - var_169_16.position).z)
				var_169_16.localEulerAngles.z = 0
				var_169_16.localEulerAngles.x = 0
				var_169_16.localEulerAngles = var_169_16.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_17 and arg_166_1.time_ < 0 + var_169_17 + arg_169_0 then
				var_169_16.localPosition = Vector3.New(0, 100, 0)
				var_169_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_16.position).x, (manager.ui.mainCamera.transform.position - var_169_16.position).y, (manager.ui.mainCamera.transform.position - var_169_16.position).z)
				var_169_16.localEulerAngles.z = 0
				var_169_16.localEulerAngles.x = 0
				var_169_16.localEulerAngles = var_169_16.localEulerAngles
			end

			local var_169_18 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_18 + 2 and arg_166_1.time_ < var_169_18 + 2 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_19 = 2
			local var_169_20 = 0.225

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_19 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_21 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(105082041).content)

				arg_166_1.text_.text = var_169_21

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_23 = 9 <= 0 and var_169_20 or var_169_20 * (utf8.len(var_169_21) / 9)

				if (9 <= 0 and var_169_20 or var_169_20 * (utf8.len(var_169_21) / 9)) > 0 and var_169_20 < var_169_23 then
					arg_166_1.talkMaxDuration = var_169_23

					if var_169_23 + var_169_19 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_19
					end
				end

				arg_166_1.text_.text = var_169_21
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_24 = math.max(var_169_20, arg_166_1.talkMaxDuration)

			if var_169_19 <= arg_166_1.time_ and arg_166_1.time_ < var_169_19 + var_169_24 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_19) / var_169_24

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_19 + var_169_24 and arg_166_1.time_ < var_169_19 + var_169_24 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B14",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play105082042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 105082042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play105082043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.675

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(105082042).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 27 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 27)

				if (27 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 27)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play105082043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 105082043
		arg_175_1.duration_ = 4.2

		local var_175_0 = {
			ja = 3.333,
			ko = 2.8,
			zh = 3.1,
			en = 4.2
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play105082044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.3

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(105082043)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 12 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 12)

				if (12 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 12)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082043", "story_v_out_105082.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_105082", "105082043", "story_v_out_105082.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_105082", "105082043", "story_v_out_105082.awb")

						arg_175_1:RecordAudio("105082043", var_178_6)
						arg_175_1:RecordAudio("105082043", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_105082", "105082043", "story_v_out_105082.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_105082", "105082043", "story_v_out_105082.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play105082044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 105082044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play105082045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.875

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(105082044).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 35 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 35)

				if (35 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 35)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play105082045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 105082045
		arg_183_1.duration_ = 8.47

		local var_183_0 = {
			ja = 8.466,
			ko = 6.2,
			zh = 5.266,
			en = 5.033
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
				arg_183_0:Play105082046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.65

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:GetWordFromCfg(105082045)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 26 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 26)

				if (26 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 26)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082045", "story_v_out_105082.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_105082", "105082045", "story_v_out_105082.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_105082", "105082045", "story_v_out_105082.awb")

						arg_183_1:RecordAudio("105082045", var_186_6)
						arg_183_1:RecordAudio("105082045", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_105082", "105082045", "story_v_out_105082.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_105082", "105082045", "story_v_out_105082.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play105082046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 105082046
		arg_187_1.duration_ = 2.4

		local var_187_0 = {
			ja = 2.4,
			ko = 2.2,
			zh = 2.166,
			en = 2.266
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
				arg_187_0:Play105082047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if arg_187_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_190_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_187_1.stage_.transform)

				var_190_0.name = "1037ui_story"
				var_190_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.actors_["1037ui_story"] = var_190_0

				local var_190_1 = var_190_0:GetComponentInChildren(typeof(CharacterEffect))

				var_190_1.enabled = true

				local var_190_2 = GameObjectTools.GetOrAddComponent(var_190_0, typeof(DynamicBoneHelper))

				if var_190_2 then
					var_190_2:EnableDynamicBone(false)
				end

				arg_187_1:ShowWeapon(var_190_1.transform, false)

				arg_187_1.var_["1037ui_story" .. "Animator"] = var_190_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_187_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_187_1.var_["1037ui_story" .. "LipSync"] = var_190_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_190_3 = arg_187_1.actors_["1037ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_3) and arg_187_1.var_.characterEffect1037ui_story == nil then
				arg_187_1.var_.characterEffect1037ui_story = var_190_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_4 = 0.1

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 and not isNil(var_190_3) then
				if arg_187_1.var_.characterEffect1037ui_story and not isNil(var_190_3) then
					arg_187_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 and not isNil(var_190_3) and arg_187_1.var_.characterEffect1037ui_story then
				arg_187_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_190_6 = arg_187_1.actors_["1037ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1037ui_story = var_190_6.localPosition
			end

			local var_190_7 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				var_190_6.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_187_1.time_ - 0) / var_190_7)
				var_190_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_6.position).x, (manager.ui.mainCamera.transform.position - var_190_6.position).y, (manager.ui.mainCamera.transform.position - var_190_6.position).z)
				var_190_6.localEulerAngles.z = 0
				var_190_6.localEulerAngles.x = 0
				var_190_6.localEulerAngles = var_190_6.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				var_190_6.localPosition = Vector3.New(0, -1.09, -5.81)
				var_190_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_6.position).x, (manager.ui.mainCamera.transform.position - var_190_6.position).y, (manager.ui.mainCamera.transform.position - var_190_6.position).z)
				var_190_6.localEulerAngles.z = 0
				var_190_6.localEulerAngles.x = 0
				var_190_6.localEulerAngles = var_190_6.localEulerAngles
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_190_8 = 0
			local var_190_9 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(105082046)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 11 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 11)

				if (11 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 11)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082046", "story_v_out_105082.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_105082", "105082046", "story_v_out_105082.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_105082", "105082046", "story_v_out_105082.awb")

						arg_187_1:RecordAudio("105082046", var_190_15)
						arg_187_1:RecordAudio("105082046", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_105082", "105082046", "story_v_out_105082.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_105082", "105082046", "story_v_out_105082.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play105082047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 105082047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play105082048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1037ui_story"]) and arg_191_1.var_.characterEffect1037ui_story == nil then
				arg_191_1.var_.characterEffect1037ui_story = arg_191_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.1

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1037ui_story"]) then
				if arg_191_1.var_.characterEffect1037ui_story and not isNil(arg_191_1.actors_["1037ui_story"]) then
					arg_191_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1037ui_story"]) and arg_191_1.var_.characterEffect1037ui_story then
				arg_191_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.225

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(105082047).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 9 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 9)

				if (9 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 9)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play105082048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 105082048
		arg_195_1.duration_ = 5.63

		local var_195_0 = {
			ja = 5.633,
			ko = 3.166,
			zh = 3.833,
			en = 3.6
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
				arg_195_0:Play105082049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1037ui_story"]) and arg_195_1.var_.characterEffect1037ui_story == nil then
				arg_195_1.var_.characterEffect1037ui_story = arg_195_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.1

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1037ui_story"]) then
				if arg_195_1.var_.characterEffect1037ui_story and not isNil(arg_195_1.actors_["1037ui_story"]) then
					arg_195_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1037ui_story"]) and arg_195_1.var_.characterEffect1037ui_story then
				arg_195_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_198_2 = 0
			local var_198_3 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(105082048)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 18 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 18)

				if (18 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 18)) > 0 and var_198_3 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082048", "story_v_out_105082.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_105082", "105082048", "story_v_out_105082.awb") / 1000

					if var_198_8 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_2
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_out_105082", "105082048", "story_v_out_105082.awb")

						arg_195_1:RecordAudio("105082048", var_198_9)
						arg_195_1:RecordAudio("105082048", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_105082", "105082048", "story_v_out_105082.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_105082", "105082048", "story_v_out_105082.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_10 and arg_195_1.time_ < var_198_2 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play105082049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 105082049
		arg_199_1.duration_ = 5.73

		local var_199_0 = {
			ja = 5.733,
			ko = 4.3,
			zh = 4.966,
			en = 5.4
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
			arg_199_1.auto_ = false
		end

		function arg_199_1.playNext_(arg_201_0)
			arg_199_1.onStoryFinished_()
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1037ui_story"]) and arg_199_1.var_.characterEffect1037ui_story == nil then
				arg_199_1.var_.characterEffect1037ui_story = arg_199_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.1

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1037ui_story"]) then
				if arg_199_1.var_.characterEffect1037ui_story and not isNil(arg_199_1.actors_["1037ui_story"]) then
					arg_199_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1037ui_story"]) and arg_199_1.var_.characterEffect1037ui_story then
				arg_199_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.45

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(105082049)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 18 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 18)

				if (18 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 18)) > 0 and var_202_2 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105082", "105082049", "story_v_out_105082.awb") ~= 0 then
					local var_202_7 = manager.audio:GetVoiceLength("story_v_out_105082", "105082049", "story_v_out_105082.awb") / 1000

					if var_202_7 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_1
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_105082", "105082049", "story_v_out_105082.awb")

						arg_199_1:RecordAudio("105082049", var_202_8)
						arg_199_1:RecordAudio("105082049", var_202_8)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_105082", "105082049", "story_v_out_105082.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_105082", "105082049", "story_v_out_105082.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_9 and arg_199_1.time_ < var_202_1 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B14",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_105082.awb"
	}
}
