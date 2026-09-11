return {
	Play324551001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324551001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324551002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J27g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27g")
				var_4_0.name = "J27g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J27g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J27g

				arg_1_1.bgs_.J27g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J27g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_150", "se_story_150_huatian", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_5_0_story_huatian", "bgm_activity_5_0_story_huatian")

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
			local var_4_15 = 1.6

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(324551001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 64 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 64)

				if (64 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 64)) > 0 and var_4_15 < var_4_19 then
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
	Play324551002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324551002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324551003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.975

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(324551002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 39 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 39)

				if (39 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 39)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324551003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324551003
		arg_12_1.duration_ = 2

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324551004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1071ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1071ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1071ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1071ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1071ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1071ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1071ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1071ui_story == nil then
				arg_12_1.var_.characterEffect1071ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1071ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1071ui_story then
				arg_12_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_15_8 = 0
			local var_15_9 = 0.125

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(324551003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 5 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 5)

				if (5 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 5)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551003", "story_v_out_324551.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_324551", "324551003", "story_v_out_324551.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_324551", "324551003", "story_v_out_324551.awb")

						arg_12_1:RecordAudio("324551003", var_15_15)
						arg_12_1:RecordAudio("324551003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_324551", "324551003", "story_v_out_324551.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_324551", "324551003", "story_v_out_324551.awb")
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
				actorName = "1071ui_story",
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
	Play324551004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324551004
		arg_16_1.duration_ = 3

		local var_16_0 = {
			zh = 2.266,
			ja = 3
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
				arg_16_0:Play324551005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "6148ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["6148ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["6148ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["6148ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["6148ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos6148ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["1071ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1071ui_story = var_19_7.localPosition
			end

			local var_19_8 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 then
				var_19_7.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_8)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 then
				var_19_7.localPosition = Vector3.New(0, 100, 0)
				var_19_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_7.position).x, (manager.ui.mainCamera.transform.position - var_19_7.position).y, (manager.ui.mainCamera.transform.position - var_19_7.position).z)
				var_19_7.localEulerAngles.z = 0
				var_19_7.localEulerAngles.x = 0
				var_19_7.localEulerAngles = var_19_7.localEulerAngles
			end

			local var_19_9 = arg_16_1.actors_["6148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect6148ui_story == nil then
				arg_16_1.var_.characterEffect6148ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_10 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_10 and not isNil(var_19_9) then
				if arg_16_1.var_.characterEffect6148ui_story and not isNil(var_19_9) then
					arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_10 and arg_16_1.time_ < 0 + var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect6148ui_story then
				arg_16_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_19_12 = arg_16_1.actors_["1071ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_12) and arg_16_1.var_.characterEffect1071ui_story == nil then
				arg_16_1.var_.characterEffect1071ui_story = var_19_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_13 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_13 and not isNil(var_19_12) then
				if arg_16_1.var_.characterEffect1071ui_story and not isNil(var_19_12) then
					arg_16_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_13)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_13 and arg_16_1.time_ < 0 + var_19_13 + arg_19_0 and not isNil(var_19_12) and arg_16_1.var_.characterEffect1071ui_story then
				arg_16_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_19_14 = 0
			local var_19_15 = 0.25

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_16 = arg_16_1:GetWordFromCfg(324551004)
				local var_19_17 = arg_16_1:FormatText(var_19_16.content)

				arg_16_1.text_.text = var_19_17

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 10 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 10)

				if (10 <= 0 and var_19_15 or var_19_15 * (utf8.len(var_19_17) / 10)) > 0 and var_19_15 < var_19_19 then
					arg_16_1.talkMaxDuration = var_19_19

					if var_19_19 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_19 + var_19_14
					end
				end

				arg_16_1.text_.text = var_19_17
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551004", "story_v_out_324551.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_324551", "324551004", "story_v_out_324551.awb") / 1000

					if var_19_20 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_14
					end

					if var_19_16.prefab_name ~= "" and arg_16_1.actors_[var_19_16.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_16.prefab_name].transform, "story_v_out_324551", "324551004", "story_v_out_324551.awb")

						arg_16_1:RecordAudio("324551004", var_19_21)
						arg_16_1:RecordAudio("324551004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324551", "324551004", "story_v_out_324551.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324551", "324551004", "story_v_out_324551.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_22 = math.max(var_19_15, arg_16_1.talkMaxDuration)

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_22 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_14) / var_19_22

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_14 + var_19_22 and arg_16_1.time_ < var_19_14 + var_19_22 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play324551005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324551005
		arg_20_1.duration_ = 5.37

		local var_20_0 = {
			zh = 3.6,
			ja = 5.366
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
				arg_20_0:Play324551006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1054ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1054ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1054ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1054ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1054ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1054ui_story = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = arg_20_1.actors_["1054ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1054ui_story == nil then
				arg_20_1.var_.characterEffect1054ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect1054ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect1054ui_story then
				arg_20_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_23_10 = arg_20_1.actors_["6148ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect6148ui_story == nil then
				arg_20_1.var_.characterEffect6148ui_story = var_23_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_11 and not isNil(var_23_10) then
				if arg_20_1.var_.characterEffect6148ui_story and not isNil(var_23_10) then
					arg_20_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_11)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_11 and arg_20_1.time_ < 0 + var_23_11 + arg_23_0 and not isNil(var_23_10) and arg_20_1.var_.characterEffect6148ui_story then
				arg_20_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_23_12 = 0
			local var_23_13 = 0.325

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(324551005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 13 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 13)

				if (13 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 13)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551005", "story_v_out_324551.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_324551", "324551005", "story_v_out_324551.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_324551", "324551005", "story_v_out_324551.awb")

						arg_20_1:RecordAudio("324551005", var_23_19)
						arg_20_1:RecordAudio("324551005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324551", "324551005", "story_v_out_324551.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324551", "324551005", "story_v_out_324551.awb")
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
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play324551006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324551006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324551007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos6148ui_story = arg_24_1.actors_["6148ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).z)
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles = arg_24_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["6148ui_story"].transform.position).z)
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["6148ui_story"].transform.localEulerAngles = arg_24_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["1054ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1054ui_story = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_5)
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

			local var_27_7 = arg_24_1.actors_["1054ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_8)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1054ui_story then
				arg_24_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_27_9 = 0
			local var_27_10 = 0.75

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_11 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(324551006).content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 30 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 30)

				if (30 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_11) / 30)) > 0 and var_27_10 < var_27_13 then
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324551007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324551007
		arg_28_1.duration_ = 3.1

		local var_28_0 = {
			zh = 2.2,
			ja = 3.1
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
				arg_28_0:Play324551008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1075ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1075ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1075ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1075ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1075ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1075ui_story = var_31_3.localPosition
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_28_1.time_ - 0) / var_31_4)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			local var_31_5 = arg_28_1.actors_["1075ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1075ui_story == nil then
				arg_28_1.var_.characterEffect1075ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.characterEffect1075ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1075ui_story then
				arg_28_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_31_8 = 0
			local var_31_9 = 0.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(324551007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 8 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 8)

				if (8 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 8)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551007", "story_v_out_324551.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_324551", "324551007", "story_v_out_324551.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_out_324551", "324551007", "story_v_out_324551.awb")

						arg_28_1:RecordAudio("324551007", var_31_15)
						arg_28_1:RecordAudio("324551007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324551", "324551007", "story_v_out_324551.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324551", "324551007", "story_v_out_324551.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play324551008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324551008
		arg_32_1.duration_ = 2

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324551009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos6148ui_story = arg_32_1.actors_["6148ui_story"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).z)
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles = arg_32_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_32_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["6148ui_story"].transform.position).z)
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["6148ui_story"].transform.localEulerAngles = arg_32_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = arg_32_1.actors_["1075ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1075ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			local var_35_5 = arg_32_1.actors_["6148ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect6148ui_story == nil then
				arg_32_1.var_.characterEffect6148ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect6148ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect6148ui_story then
				arg_32_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_35_8 = arg_32_1.actors_["1075ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.characterEffect1075ui_story == nil then
				arg_32_1.var_.characterEffect1075ui_story = var_35_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_9 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 and not isNil(var_35_8) then
				if arg_32_1.var_.characterEffect1075ui_story and not isNil(var_35_8) then
					arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_9)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.characterEffect1075ui_story then
				arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_35_10 = 0
			local var_35_11 = 0.225

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_12 = arg_32_1:GetWordFromCfg(324551008)
				local var_35_13 = arg_32_1:FormatText(var_35_12.content)

				arg_32_1.text_.text = var_35_13

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 9 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 9)

				if (9 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 9)) > 0 and var_35_11 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_13
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551008", "story_v_out_324551.awb") ~= 0 then
					local var_35_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551008", "story_v_out_324551.awb") / 1000

					if var_35_16 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_10
					end

					if var_35_12.prefab_name ~= "" and arg_32_1.actors_[var_35_12.prefab_name] ~= nil then
						local var_35_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_12.prefab_name].transform, "story_v_out_324551", "324551008", "story_v_out_324551.awb")

						arg_32_1:RecordAudio("324551008", var_35_17)
						arg_32_1:RecordAudio("324551008", var_35_17)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324551", "324551008", "story_v_out_324551.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324551", "324551008", "story_v_out_324551.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_18 and arg_32_1.time_ < var_35_10 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
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
	Play324551009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324551009
		arg_36_1.duration_ = 3.7

		local var_36_0 = {
			zh = 3,
			ja = 3.7
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
				arg_36_0:Play324551010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1075ui_story"]) and arg_36_1.var_.characterEffect1075ui_story == nil then
				arg_36_1.var_.characterEffect1075ui_story = arg_36_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1075ui_story"]) then
				if arg_36_1.var_.characterEffect1075ui_story and not isNil(arg_36_1.actors_["1075ui_story"]) then
					arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1075ui_story"]) and arg_36_1.var_.characterEffect1075ui_story then
				arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["6148ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect6148ui_story == nil then
				arg_36_1.var_.characterEffect6148ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect6148ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_36_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect6148ui_story then
				arg_36_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_36_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_39_4 = 0
			local var_39_5 = 0.575

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(324551009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 23 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 23)

				if (23 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 23)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551009", "story_v_out_324551.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_324551", "324551009", "story_v_out_324551.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_324551", "324551009", "story_v_out_324551.awb")

						arg_36_1:RecordAudio("324551009", var_39_11)
						arg_36_1:RecordAudio("324551009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324551", "324551009", "story_v_out_324551.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324551", "324551009", "story_v_out_324551.awb")
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
	Play324551010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324551010
		arg_40_1.duration_ = 5.73

		local var_40_0 = {
			zh = 4.733,
			ja = 5.733
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
				arg_40_0:Play324551011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos6148ui_story = arg_40_1.actors_["6148ui_story"].transform.localPosition

				local var_43_0 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_0 then
					var_43_0:EnableDynamicBone(false)
				end
			end

			local var_43_1 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_1 then
				arg_40_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_40_1.time_ - 0) / var_43_1)
				arg_40_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["6148ui_story"].transform.position).z)
				arg_40_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["6148ui_story"].transform.localEulerAngles = arg_40_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_1 and arg_40_1.time_ < 0 + var_43_1 + arg_43_0 then
				arg_40_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_40_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["6148ui_story"].transform.position).z)
				arg_40_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["6148ui_story"].transform.localEulerAngles = arg_40_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_43_2 = GameObjectTools.GetOrAddComponent(arg_40_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(true)
				end
			end

			local var_43_3 = arg_40_1.actors_["1054ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1054ui_story = var_43_3.localPosition

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(false)
				end
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_40_1.time_ - 0) / var_43_5)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(true)
				end
			end

			local var_43_7 = arg_40_1.actors_["1054ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1054ui_story == nil then
				arg_40_1.var_.characterEffect1054ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1054ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1054ui_story then
				arg_40_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_43_10 = arg_40_1.actors_["1075ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_10) and arg_40_1.var_.characterEffect1075ui_story == nil then
				arg_40_1.var_.characterEffect1075ui_story = var_43_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_11 and not isNil(var_43_10) then
				if arg_40_1.var_.characterEffect1075ui_story and not isNil(var_43_10) then
					arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_11)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_11 and arg_40_1.time_ < 0 + var_43_11 + arg_43_0 and not isNil(var_43_10) and arg_40_1.var_.characterEffect1075ui_story then
				arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action432")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_43_12 = arg_40_1.actors_["1075ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1075ui_story = var_43_12.localPosition
			end

			local var_43_13 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_13 then
				var_43_12.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_13)
				var_43_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_12.position).x, (manager.ui.mainCamera.transform.position - var_43_12.position).y, (manager.ui.mainCamera.transform.position - var_43_12.position).z)
				var_43_12.localEulerAngles.z = 0
				var_43_12.localEulerAngles.x = 0
				var_43_12.localEulerAngles = var_43_12.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_13 and arg_40_1.time_ < 0 + var_43_13 + arg_43_0 then
				var_43_12.localPosition = Vector3.New(0, 100, 0)
				var_43_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_12.position).x, (manager.ui.mainCamera.transform.position - var_43_12.position).y, (manager.ui.mainCamera.transform.position - var_43_12.position).z)
				var_43_12.localEulerAngles.z = 0
				var_43_12.localEulerAngles.x = 0
				var_43_12.localEulerAngles = var_43_12.localEulerAngles
			end

			local var_43_14 = 0
			local var_43_15 = 0.55

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_14 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_16 = arg_40_1:GetWordFromCfg(324551010)
				local var_43_17 = arg_40_1:FormatText(var_43_16.content)

				arg_40_1.text_.text = var_43_17

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_19 = 22 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_17) / 22)

				if (22 <= 0 and var_43_15 or var_43_15 * (utf8.len(var_43_17) / 22)) > 0 and var_43_15 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_14 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_14
					end
				end

				arg_40_1.text_.text = var_43_17
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551010", "story_v_out_324551.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_324551", "324551010", "story_v_out_324551.awb") / 1000

					if var_43_20 + var_43_14 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_14
					end

					if var_43_16.prefab_name ~= "" and arg_40_1.actors_[var_43_16.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_16.prefab_name].transform, "story_v_out_324551", "324551010", "story_v_out_324551.awb")

						arg_40_1:RecordAudio("324551010", var_43_21)
						arg_40_1:RecordAudio("324551010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324551", "324551010", "story_v_out_324551.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324551", "324551010", "story_v_out_324551.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_15, arg_40_1.talkMaxDuration)

			if var_43_14 <= arg_40_1.time_ and arg_40_1.time_ < var_43_14 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_14) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_14 + var_43_22 and arg_40_1.time_ < var_43_14 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play324551011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324551011
		arg_44_1.duration_ = 4.7

		local var_44_0 = {
			zh = 3.2,
			ja = 4.7
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
				arg_44_0:Play324551012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["6148ui_story"]) and arg_44_1.var_.characterEffect6148ui_story == nil then
				arg_44_1.var_.characterEffect6148ui_story = arg_44_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["6148ui_story"]) then
				if arg_44_1.var_.characterEffect6148ui_story and not isNil(arg_44_1.actors_["6148ui_story"]) then
					arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["6148ui_story"]) and arg_44_1.var_.characterEffect6148ui_story then
				arg_44_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1054ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1054ui_story then
				arg_44_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.275

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(324551011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 11 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 11)

				if (11 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 11)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551011", "story_v_out_324551.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_324551", "324551011", "story_v_out_324551.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_324551", "324551011", "story_v_out_324551.awb")

						arg_44_1:RecordAudio("324551011", var_47_11)
						arg_44_1:RecordAudio("324551011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324551", "324551011", "story_v_out_324551.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324551", "324551011", "story_v_out_324551.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324551012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324551012
		arg_48_1.duration_ = 7.27

		local var_48_0 = {
			zh = 4.7,
			ja = 7.266
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
				arg_48_0:Play324551013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.65

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(324551012)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 26 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 26)

				if (26 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 26)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551012", "story_v_out_324551.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_324551", "324551012", "story_v_out_324551.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_324551", "324551012", "story_v_out_324551.awb")

						arg_48_1:RecordAudio("324551012", var_51_6)
						arg_48_1:RecordAudio("324551012", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_324551", "324551012", "story_v_out_324551.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_324551", "324551012", "story_v_out_324551.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324551013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 324551013
		arg_52_1.duration_ = 4.87

		local var_52_0 = {
			zh = 4.533,
			ja = 4.866
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
				arg_52_0:Play324551014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.actors_["1170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1170ui_story"))) then
				local var_55_0 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_52_1.stage_.transform)

				var_55_0.name = "1170ui_story"
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1170ui_story"] = var_55_0

				local var_55_1 = var_55_0:GetComponentInChildren(typeof(CharacterEffect))

				var_55_1.enabled = true

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_1.transform, false)

				arg_52_1.var_["1170ui_story" .. "Animator"] = var_55_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_["1170ui_story" .. "Animator"].applyRootMotion = true
				arg_52_1.var_["1170ui_story" .. "LipSync"] = var_55_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_3 = arg_52_1.actors_["1170ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1170ui_story == nil then
				arg_52_1.var_.characterEffect1170ui_story = var_55_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_4 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 and not isNil(var_55_3) then
				if arg_52_1.var_.characterEffect1170ui_story and not isNil(var_55_3) then
					arg_52_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1170ui_story then
				arg_52_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_55_6 = arg_52_1.actors_["6148ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect6148ui_story == nil then
				arg_52_1.var_.characterEffect6148ui_story = var_55_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 and not isNil(var_55_6) then
				if arg_52_1.var_.characterEffect6148ui_story and not isNil(var_55_6) then
					arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_52_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_7)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect6148ui_story then
				arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_52_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_55_8 = 0
			local var_55_9 = 0.45

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_8 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1170")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_10 = arg_52_1:GetWordFromCfg(324551013)
				local var_55_11 = arg_52_1:FormatText(var_55_10.content)

				arg_52_1.text_.text = var_55_11

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_13 = 18 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 18)

				if (18 <= 0 and var_55_9 or var_55_9 * (utf8.len(var_55_11) / 18)) > 0 and var_55_9 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_8
					end
				end

				arg_52_1.text_.text = var_55_11
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551013", "story_v_out_324551.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_324551", "324551013", "story_v_out_324551.awb") / 1000

					if var_55_14 + var_55_8 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_8
					end

					if var_55_10.prefab_name ~= "" and arg_52_1.actors_[var_55_10.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_10.prefab_name].transform, "story_v_out_324551", "324551013", "story_v_out_324551.awb")

						arg_52_1:RecordAudio("324551013", var_55_15)
						arg_52_1:RecordAudio("324551013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_324551", "324551013", "story_v_out_324551.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_324551", "324551013", "story_v_out_324551.awb")
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

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play324551014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 324551014
		arg_56_1.duration_ = 5.5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play324551015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_9000

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos6148ui_story = arg_56_1.actors_["6148ui_story"].transform.localPosition

				local var_59_0 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_0 then
					var_59_0:EnableDynamicBone(false)
				end
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				arg_56_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_1)
				arg_56_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6148ui_story"].transform.position).z)
				arg_56_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["6148ui_story"].transform.localEulerAngles = arg_56_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				arg_56_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["6148ui_story"].transform.position).z)
				arg_56_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["6148ui_story"].transform.localEulerAngles = arg_56_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_59_2 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(true)
				end
			end

			local var_59_3 = arg_56_1.actors_["1170ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1170ui_story == nil then
				arg_56_1.var_.characterEffect1170ui_story = var_59_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_4 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 and not isNil(var_59_3) then
				if arg_56_1.var_.characterEffect1170ui_story and not isNil(var_59_3) then
					arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_4)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1170ui_story then
				arg_56_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_59_5 = arg_56_1.actors_["1054ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1054ui_story = var_59_5.localPosition

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_5.gameObject, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(false)
				end
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_7)
				var_59_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_5.position).x, (manager.ui.mainCamera.transform.position - var_59_5.position).y, (manager.ui.mainCamera.transform.position - var_59_5.position).z)
				var_59_5.localEulerAngles.z = 0
				var_59_5.localEulerAngles.x = 0
				var_59_5.localEulerAngles = var_59_5.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(0, 100, 0)
				var_59_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_5.position).x, (manager.ui.mainCamera.transform.position - var_59_5.position).y, (manager.ui.mainCamera.transform.position - var_59_5.position).z)
				var_59_5.localEulerAngles.z = 0
				var_59_5.localEulerAngles.x = 0
				var_59_5.localEulerAngles = var_59_5.localEulerAngles

				local var_59_8 = GameObjectTools.GetOrAddComponent(var_59_5.gameObject, typeof(DynamicBoneHelper))

				if var_59_8 then
					var_59_8:EnableDynamicBone(true)
				end
			end

			local var_59_9 = manager.ui.mainCamera.transform

			if 0.7 < arg_56_1.time_ and arg_56_1.time_ <= 0.7 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_9.localPosition
			end

			local var_59_10 = 0.3

			if 0.7 <= arg_56_1.time_ and arg_56_1.time_ < 0.7 + var_59_10 then
				local var_59_11, var_59_12 = math.modf((arg_56_1.time_ - 0.7) / 0.066)

				var_59_9.localPosition = Vector3.New(var_59_12 * 0.13, var_59_12 * 0.13, var_59_12 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= 0.7 + var_59_10 and arg_56_1.time_ < 0.7 + var_59_10 + arg_59_0 then
				var_59_9.localPosition = arg_56_1.var_.shakeOldPos
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_13 = arg_56_1.var_.effectjinwuluodi1

				if not arg_56_1.var_.effectjinwuluodi1 then
					var_59_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_59_13.name = "jinwuluodi1"
					arg_56_1.var_.effectjinwuluodi1 = var_59_13
				else
					var_59_13.transform:SetParent(var_59_9000)
				end

				var_59_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_59_15 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_15 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_15 + 1 and arg_56_1.time_ < var_59_15 + 1 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if 0.1 < arg_56_1.time_ and arg_56_1.time_ <= 0.1 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_wind", "")
			end

			if 0.8 < arg_56_1.time_ and arg_56_1.time_ <= 0.8 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_jump", "")
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_18 = 0.5
			local var_59_19 = 0.775

			if 0.5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_18 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_20 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_20:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_21 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(324551014).content)

				arg_56_1.text_.text = var_59_21

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_23 = 31 <= 0 and var_59_19 or var_59_19 * (utf8.len(var_59_21) / 31)

				if (31 <= 0 and var_59_19 or var_59_19 * (utf8.len(var_59_21) / 31)) > 0 and var_59_19 < var_59_23 then
					arg_56_1.talkMaxDuration = var_59_23
					var_59_18 = var_59_18 + 0.3

					if var_59_23 + var_59_18 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_23 + var_59_18
					end
				end

				arg_56_1.text_.text = var_59_21
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_24 = var_59_18 + 0.3
			local var_59_25 = math.max(var_59_19, arg_56_1.talkMaxDuration)

			if var_59_18 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_24 + var_59_25 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_24) / var_59_25

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_24 + var_59_25 and arg_56_1.time_ < var_59_24 + var_59_25 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play324551015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324551015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324551016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.55

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(324551015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 62 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 62)

				if (62 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 62)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324551016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324551016
		arg_66_1.duration_ = 4.4

		local var_66_0 = {
			zh = 2.666,
			ja = 4.4
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
				arg_66_0:Play324551017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1071ui_story = arg_66_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_69_0 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 then
				arg_66_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_66_1.time_ - 0) / var_69_0)
				arg_66_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1071ui_story"].transform.position).z)
				arg_66_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1071ui_story"].transform.localEulerAngles = arg_66_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 then
				arg_66_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_66_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["1071ui_story"].transform.position).z)
				arg_66_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["1071ui_story"].transform.localEulerAngles = arg_66_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_69_1 = arg_66_1.actors_["1071ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1071ui_story == nil then
				arg_66_1.var_.characterEffect1071ui_story = var_69_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 and not isNil(var_69_1) then
				if arg_66_1.var_.characterEffect1071ui_story and not isNil(var_69_1) then
					arg_66_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1071ui_story then
				arg_66_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_69_4 = 0
			local var_69_5 = 0.325

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(324551016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 13 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 13)

				if (13 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 13)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551016", "story_v_out_324551.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_324551", "324551016", "story_v_out_324551.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_324551", "324551016", "story_v_out_324551.awb")

						arg_66_1:RecordAudio("324551016", var_69_11)
						arg_66_1:RecordAudio("324551016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_324551", "324551016", "story_v_out_324551.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_324551", "324551016", "story_v_out_324551.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play324551017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324551017
		arg_70_1.duration_ = 8.37

		local var_70_0 = {
			zh = 4.2,
			ja = 8.366
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play324551018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1170ui_story = arg_70_1.actors_["1170ui_story"].transform.localPosition

				local var_73_0 = GameObjectTools.GetOrAddComponent(arg_70_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_73_0 then
					var_73_0:EnableDynamicBone(false)
				end
			end

			local var_73_1 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_1 then
				arg_70_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_70_1.time_ - 0) / var_73_1)
				arg_70_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1170ui_story"].transform.position).z)
				arg_70_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1170ui_story"].transform.localEulerAngles = arg_70_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_1 and arg_70_1.time_ < 0 + var_73_1 + arg_73_0 then
				arg_70_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0.03, -0.95, -6.08)
				arg_70_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1170ui_story"].transform.position).z)
				arg_70_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1170ui_story"].transform.localEulerAngles = arg_70_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_73_2 = GameObjectTools.GetOrAddComponent(arg_70_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(true)
				end
			end

			local var_73_3 = arg_70_1.actors_["1071ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1071ui_story = var_73_3.localPosition
			end

			local var_73_4 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_3.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_4)
				var_73_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_3.position).x, (manager.ui.mainCamera.transform.position - var_73_3.position).y, (manager.ui.mainCamera.transform.position - var_73_3.position).z)
				var_73_3.localEulerAngles.z = 0
				var_73_3.localEulerAngles.x = 0
				var_73_3.localEulerAngles = var_73_3.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_3.localPosition = Vector3.New(0, 100, 0)
				var_73_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_3.position).x, (manager.ui.mainCamera.transform.position - var_73_3.position).y, (manager.ui.mainCamera.transform.position - var_73_3.position).z)
				var_73_3.localEulerAngles.z = 0
				var_73_3.localEulerAngles.x = 0
				var_73_3.localEulerAngles = var_73_3.localEulerAngles
			end

			local var_73_5 = arg_70_1.actors_["1170ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1170ui_story == nil then
				arg_70_1.var_.characterEffect1170ui_story = var_73_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_6 and not isNil(var_73_5) then
				if arg_70_1.var_.characterEffect1170ui_story and not isNil(var_73_5) then
					arg_70_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_6 and arg_70_1.time_ < 0 + var_73_6 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1170ui_story then
				arg_70_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_73_8 = arg_70_1.actors_["1071ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.characterEffect1071ui_story == nil then
				arg_70_1.var_.characterEffect1071ui_story = var_73_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_9 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_9 and not isNil(var_73_8) then
				if arg_70_1.var_.characterEffect1071ui_story and not isNil(var_73_8) then
					arg_70_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_9)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_9 and arg_70_1.time_ < 0 + var_73_9 + arg_73_0 and not isNil(var_73_8) and arg_70_1.var_.characterEffect1071ui_story then
				arg_70_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action5_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_73_10 = 0
			local var_73_11 = 0.5

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_12 = arg_70_1:GetWordFromCfg(324551017)
				local var_73_13 = arg_70_1:FormatText(var_73_12.content)

				arg_70_1.text_.text = var_73_13

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_15 = 20 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 20)

				if (20 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 20)) > 0 and var_73_11 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_10
					end
				end

				arg_70_1.text_.text = var_73_13
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551017", "story_v_out_324551.awb") ~= 0 then
					local var_73_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551017", "story_v_out_324551.awb") / 1000

					if var_73_16 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_16 + var_73_10
					end

					if var_73_12.prefab_name ~= "" and arg_70_1.actors_[var_73_12.prefab_name] ~= nil then
						local var_73_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_12.prefab_name].transform, "story_v_out_324551", "324551017", "story_v_out_324551.awb")

						arg_70_1:RecordAudio("324551017", var_73_17)
						arg_70_1:RecordAudio("324551017", var_73_17)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_324551", "324551017", "story_v_out_324551.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_324551", "324551017", "story_v_out_324551.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_18 = math.max(var_73_11, arg_70_1.talkMaxDuration)

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_18 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_10) / var_73_18

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_10 + var_73_18 and arg_70_1.time_ < var_73_10 + var_73_18 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play324551018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324551018
		arg_74_1.duration_ = 4.3

		local var_74_0 = {
			zh = 3.566,
			ja = 4.3
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
				arg_74_0:Play324551019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1075ui_story = arg_74_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_77_0 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 then
				arg_74_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_74_1.time_ - 0) / var_77_0)
				arg_74_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1075ui_story"].transform.position).z)
				arg_74_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1075ui_story"].transform.localEulerAngles = arg_74_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 then
				arg_74_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.16)
				arg_74_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_74_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_74_1.actors_["1075ui_story"].transform.position).z)
				arg_74_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_74_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_74_1.actors_["1075ui_story"].transform.localEulerAngles = arg_74_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_77_1 = arg_74_1.actors_["1075ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1075ui_story == nil then
				arg_74_1.var_.characterEffect1075ui_story = var_77_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 and not isNil(var_77_1) then
				if arg_74_1.var_.characterEffect1075ui_story and not isNil(var_77_1) then
					arg_74_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1075ui_story then
				arg_74_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["1170ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1170ui_story == nil then
				arg_74_1.var_.characterEffect1170ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_5 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_5 and not isNil(var_77_4) then
				if arg_74_1.var_.characterEffect1170ui_story and not isNil(var_77_4) then
					arg_74_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_5)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_5 and arg_74_1.time_ < 0 + var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1170ui_story then
				arg_74_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_77_6 = arg_74_1.actors_["1170ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1170ui_story = var_77_6.localPosition

				local var_77_7 = GameObjectTools.GetOrAddComponent(var_77_6.gameObject, typeof(DynamicBoneHelper))

				if var_77_7 then
					var_77_7:EnableDynamicBone(false)
				end
			end

			local var_77_8 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_8 then
				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_74_1.time_ - 0) / var_77_8)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_8 and arg_74_1.time_ < 0 + var_77_8 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				var_77_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_6.position).x, (manager.ui.mainCamera.transform.position - var_77_6.position).y, (manager.ui.mainCamera.transform.position - var_77_6.position).z)
				var_77_6.localEulerAngles.z = 0
				var_77_6.localEulerAngles.x = 0
				var_77_6.localEulerAngles = var_77_6.localEulerAngles

				local var_77_9 = GameObjectTools.GetOrAddComponent(var_77_6.gameObject, typeof(DynamicBoneHelper))

				if var_77_9 then
					var_77_9:EnableDynamicBone(true)
				end
			end

			local var_77_10 = 0
			local var_77_11 = 0.3

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_12 = arg_74_1:GetWordFromCfg(324551018)
				local var_77_13 = arg_74_1:FormatText(var_77_12.content)

				arg_74_1.text_.text = var_77_13

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_15 = 12 <= 0 and var_77_11 or var_77_11 * (utf8.len(var_77_13) / 12)

				if (12 <= 0 and var_77_11 or var_77_11 * (utf8.len(var_77_13) / 12)) > 0 and var_77_11 < var_77_15 then
					arg_74_1.talkMaxDuration = var_77_15

					if var_77_15 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_15 + var_77_10
					end
				end

				arg_74_1.text_.text = var_77_13
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551018", "story_v_out_324551.awb") ~= 0 then
					local var_77_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551018", "story_v_out_324551.awb") / 1000

					if var_77_16 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_16 + var_77_10
					end

					if var_77_12.prefab_name ~= "" and arg_74_1.actors_[var_77_12.prefab_name] ~= nil then
						local var_77_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_12.prefab_name].transform, "story_v_out_324551", "324551018", "story_v_out_324551.awb")

						arg_74_1:RecordAudio("324551018", var_77_17)
						arg_74_1:RecordAudio("324551018", var_77_17)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_324551", "324551018", "story_v_out_324551.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_324551", "324551018", "story_v_out_324551.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_18 = math.max(var_77_11, arg_74_1.talkMaxDuration)

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_18 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_10) / var_77_18

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_10 + var_77_18 and arg_74_1.time_ < var_77_10 + var_77_18 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play324551019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324551019
		arg_78_1.duration_ = 10.3

		local var_78_0 = {
			zh = 5.5,
			ja = 10.3
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
				arg_78_0:Play324551020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1170ui_story"]) and arg_78_1.var_.characterEffect1170ui_story == nil then
				arg_78_1.var_.characterEffect1170ui_story = arg_78_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1170ui_story"]) then
				if arg_78_1.var_.characterEffect1170ui_story and not isNil(arg_78_1.actors_["1170ui_story"]) then
					arg_78_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1170ui_story"]) and arg_78_1.var_.characterEffect1170ui_story then
				arg_78_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["1075ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1075ui_story == nil then
				arg_78_1.var_.characterEffect1075ui_story = var_81_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.characterEffect1075ui_story and not isNil(var_81_2) then
					arg_78_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect1075ui_story then
				arg_78_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action459")
			end

			local var_81_4 = 0
			local var_81_5 = 0.625

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(324551019)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 25 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 25)

				if (25 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 25)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551019", "story_v_out_324551.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_324551", "324551019", "story_v_out_324551.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_324551", "324551019", "story_v_out_324551.awb")

						arg_78_1:RecordAudio("324551019", var_81_11)
						arg_78_1:RecordAudio("324551019", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324551", "324551019", "story_v_out_324551.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324551", "324551019", "story_v_out_324551.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324551020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324551020
		arg_82_1.duration_ = 6.93

		local var_82_0 = {
			zh = 5.366,
			ja = 6.933
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
				arg_82_0:Play324551021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1071ui_story = arg_82_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_85_0 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				arg_82_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_82_1.time_ - 0) / var_85_0)
				arg_82_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1071ui_story"].transform.position).z)
				arg_82_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1071ui_story"].transform.localEulerAngles = arg_82_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				arg_82_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_82_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1071ui_story"].transform.position).z)
				arg_82_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1071ui_story"].transform.localEulerAngles = arg_82_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_85_1 = arg_82_1.actors_["1075ui_story"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1075ui_story = var_85_1.localPosition
			end

			local var_85_2 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_2 then
				var_85_1.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 0) / var_85_2)
				var_85_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_1.position).x, (manager.ui.mainCamera.transform.position - var_85_1.position).y, (manager.ui.mainCamera.transform.position - var_85_1.position).z)
				var_85_1.localEulerAngles.z = 0
				var_85_1.localEulerAngles.x = 0
				var_85_1.localEulerAngles = var_85_1.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_2 and arg_82_1.time_ < 0 + var_85_2 + arg_85_0 then
				var_85_1.localPosition = Vector3.New(0, 100, 0)
				var_85_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_1.position).x, (manager.ui.mainCamera.transform.position - var_85_1.position).y, (manager.ui.mainCamera.transform.position - var_85_1.position).z)
				var_85_1.localEulerAngles.z = 0
				var_85_1.localEulerAngles.x = 0
				var_85_1.localEulerAngles = var_85_1.localEulerAngles
			end

			local var_85_3 = arg_82_1.actors_["1071ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1071ui_story == nil then
				arg_82_1.var_.characterEffect1071ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect1071ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1071ui_story then
				arg_82_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_85_6 = arg_82_1.actors_["1170ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1170ui_story == nil then
				arg_82_1.var_.characterEffect1170ui_story = var_85_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_7 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 and not isNil(var_85_6) then
				if arg_82_1.var_.characterEffect1170ui_story and not isNil(var_85_6) then
					arg_82_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_7)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1170ui_story then
				arg_82_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_1")
			end

			local var_85_8 = 0
			local var_85_9 = 0.575

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_10 = arg_82_1:GetWordFromCfg(324551020)
				local var_85_11 = arg_82_1:FormatText(var_85_10.content)

				arg_82_1.text_.text = var_85_11

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_13 = 23 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 23)

				if (23 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 23)) > 0 and var_85_9 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_8
					end
				end

				arg_82_1.text_.text = var_85_11
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551020", "story_v_out_324551.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_324551", "324551020", "story_v_out_324551.awb") / 1000

					if var_85_14 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_8
					end

					if var_85_10.prefab_name ~= "" and arg_82_1.actors_[var_85_10.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_10.prefab_name].transform, "story_v_out_324551", "324551020", "story_v_out_324551.awb")

						arg_82_1:RecordAudio("324551020", var_85_15)
						arg_82_1:RecordAudio("324551020", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_324551", "324551020", "story_v_out_324551.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_324551", "324551020", "story_v_out_324551.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_9, arg_82_1.talkMaxDuration)

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_8) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_8 + var_85_16 and arg_82_1.time_ < var_85_8 + var_85_16 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play324551021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324551021
		arg_86_1.duration_ = 3.4

		local var_86_0 = {
			zh = 2.7,
			ja = 3.4
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
				arg_86_0:Play324551022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1071ui_story = arg_86_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1071ui_story"].transform.position).z)
				arg_86_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1071ui_story"].transform.localEulerAngles = arg_86_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1071ui_story"].transform.position).z)
				arg_86_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1071ui_story"].transform.localEulerAngles = arg_86_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1054ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1054ui_story = var_89_1.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_1.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_86_1.time_ - 0) / var_89_3)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(0.7, -0.985, -6)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles

				local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_1.gameObject, typeof(DynamicBoneHelper))

				if var_89_4 then
					var_89_4:EnableDynamicBone(true)
				end
			end

			local var_89_5 = arg_86_1.actors_["1054ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1054ui_story == nil then
				arg_86_1.var_.characterEffect1054ui_story = var_89_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_6 and not isNil(var_89_5) then
				if arg_86_1.var_.characterEffect1054ui_story and not isNil(var_89_5) then
					arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_6 and arg_86_1.time_ < 0 + var_89_6 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect1054ui_story then
				arg_86_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_89_8 = arg_86_1.actors_["1071ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.characterEffect1071ui_story == nil then
				arg_86_1.var_.characterEffect1071ui_story = var_89_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_9 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_9 and not isNil(var_89_8) then
				if arg_86_1.var_.characterEffect1071ui_story and not isNil(var_89_8) then
					arg_86_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_9)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_9 and arg_86_1.time_ < 0 + var_89_9 + arg_89_0 and not isNil(var_89_8) and arg_86_1.var_.characterEffect1071ui_story then
				arg_86_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action8_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_89_10 = 0
			local var_89_11 = 0.275

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_12 = arg_86_1:GetWordFromCfg(324551021)
				local var_89_13 = arg_86_1:FormatText(var_89_12.content)

				arg_86_1.text_.text = var_89_13

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 11 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 11)

				if (11 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 11)) > 0 and var_89_11 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_13
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551021", "story_v_out_324551.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551021", "story_v_out_324551.awb") / 1000

					if var_89_16 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_10
					end

					if var_89_12.prefab_name ~= "" and arg_86_1.actors_[var_89_12.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_12.prefab_name].transform, "story_v_out_324551", "324551021", "story_v_out_324551.awb")

						arg_86_1:RecordAudio("324551021", var_89_17)
						arg_86_1:RecordAudio("324551021", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_324551", "324551021", "story_v_out_324551.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_324551", "324551021", "story_v_out_324551.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_18 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_18 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_18

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_18 and arg_86_1.time_ < var_89_10 + var_89_18 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play324551022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324551022
		arg_90_1.duration_ = 2

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324551023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1170ui_story"]) and arg_90_1.var_.characterEffect1170ui_story == nil then
				arg_90_1.var_.characterEffect1170ui_story = arg_90_1.actors_["1170ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1170ui_story"]) then
				if arg_90_1.var_.characterEffect1170ui_story and not isNil(arg_90_1.actors_["1170ui_story"]) then
					arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1170ui_story"]) and arg_90_1.var_.characterEffect1170ui_story then
				arg_90_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["1054ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1054ui_story == nil then
				arg_90_1.var_.characterEffect1054ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect1054ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1054ui_story then
				arg_90_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170actionlink/1170action496")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_93_4 = 0
			local var_93_5 = 0.075

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(324551022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 3 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 3)

				if (3 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 3)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551022", "story_v_out_324551.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_324551", "324551022", "story_v_out_324551.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_324551", "324551022", "story_v_out_324551.awb")

						arg_90_1:RecordAudio("324551022", var_93_11)
						arg_90_1:RecordAudio("324551022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_324551", "324551022", "story_v_out_324551.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_324551", "324551022", "story_v_out_324551.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324551023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324551023
		arg_94_1.duration_ = 9.5

		local var_94_0 = {
			zh = 7.033,
			ja = 9.5
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
				arg_94_0:Play324551024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos6148ui_story = arg_94_1.actors_["6148ui_story"].transform.localPosition

				local var_97_0 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_0 then
					var_97_0:EnableDynamicBone(false)
				end
			end

			local var_97_1 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 then
				arg_94_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_94_1.time_ - 0) / var_97_1)
				arg_94_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["6148ui_story"].transform.position).z)
				arg_94_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["6148ui_story"].transform.localEulerAngles = arg_94_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 then
				arg_94_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_94_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["6148ui_story"].transform.position).z)
				arg_94_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["6148ui_story"].transform.localEulerAngles = arg_94_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_97_2 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(true)
				end
			end

			local var_97_3 = arg_94_1.actors_["6148ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect6148ui_story == nil then
				arg_94_1.var_.characterEffect6148ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect6148ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect6148ui_story then
				arg_94_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_97_6 = arg_94_1.actors_["1170ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1170ui_story == nil then
				arg_94_1.var_.characterEffect1170ui_story = var_97_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_7 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 and not isNil(var_97_6) then
				if arg_94_1.var_.characterEffect1170ui_story and not isNil(var_97_6) then
					arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_7)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1170ui_story then
				arg_94_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_97_8 = arg_94_1.actors_["1054ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1054ui_story = var_97_8.localPosition

				local var_97_9 = GameObjectTools.GetOrAddComponent(var_97_8.gameObject, typeof(DynamicBoneHelper))

				if var_97_9 then
					var_97_9:EnableDynamicBone(false)
				end
			end

			local var_97_10 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_10 then
				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_10)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_10 and arg_94_1.time_ < 0 + var_97_10 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(0, 100, 0)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles

				local var_97_11 = GameObjectTools.GetOrAddComponent(var_97_8.gameObject, typeof(DynamicBoneHelper))

				if var_97_11 then
					var_97_11:EnableDynamicBone(true)
				end
			end

			local var_97_12 = 0
			local var_97_13 = 0.825

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_14 = arg_94_1:GetWordFromCfg(324551023)
				local var_97_15 = arg_94_1:FormatText(var_97_14.content)

				arg_94_1.text_.text = var_97_15

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 33 <= 0 and var_97_13 or var_97_13 * (utf8.len(var_97_15) / 33)

				if (33 <= 0 and var_97_13 or var_97_13 * (utf8.len(var_97_15) / 33)) > 0 and var_97_13 < var_97_17 then
					arg_94_1.talkMaxDuration = var_97_17

					if var_97_17 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_17 + var_97_12
					end
				end

				arg_94_1.text_.text = var_97_15
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551023", "story_v_out_324551.awb") ~= 0 then
					local var_97_18 = manager.audio:GetVoiceLength("story_v_out_324551", "324551023", "story_v_out_324551.awb") / 1000

					if var_97_18 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_18 + var_97_12
					end

					if var_97_14.prefab_name ~= "" and arg_94_1.actors_[var_97_14.prefab_name] ~= nil then
						local var_97_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_14.prefab_name].transform, "story_v_out_324551", "324551023", "story_v_out_324551.awb")

						arg_94_1:RecordAudio("324551023", var_97_19)
						arg_94_1:RecordAudio("324551023", var_97_19)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324551", "324551023", "story_v_out_324551.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324551", "324551023", "story_v_out_324551.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_20 = math.max(var_97_13, arg_94_1.talkMaxDuration)

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_20 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_12) / var_97_20

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_12 + var_97_20 and arg_94_1.time_ < var_97_12 + var_97_20 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play324551024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324551024
		arg_98_1.duration_ = 4.33

		local var_98_0 = {
			zh = 3.866,
			ja = 4.333
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
				arg_98_0:Play324551025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos6148ui_story = arg_98_1.actors_["6148ui_story"].transform.localPosition

				local var_101_0 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_0 then
					var_101_0:EnableDynamicBone(false)
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_1)
				arg_98_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["6148ui_story"].transform.position).z)
				arg_98_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["6148ui_story"].transform.localEulerAngles = arg_98_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["6148ui_story"].transform.position).z)
				arg_98_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["6148ui_story"].transform.localEulerAngles = arg_98_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_101_2 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(true)
				end
			end

			local var_101_3 = arg_98_1.actors_["1071ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1071ui_story = var_101_3.localPosition
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_3.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1071ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_98_1.time_ - 0) / var_101_4)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_3.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_101_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_3.position).x, (manager.ui.mainCamera.transform.position - var_101_3.position).y, (manager.ui.mainCamera.transform.position - var_101_3.position).z)
				var_101_3.localEulerAngles.z = 0
				var_101_3.localEulerAngles.x = 0
				var_101_3.localEulerAngles = var_101_3.localEulerAngles
			end

			local var_101_5 = arg_98_1.actors_["1071ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect1071ui_story == nil then
				arg_98_1.var_.characterEffect1071ui_story = var_101_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_6 and not isNil(var_101_5) then
				if arg_98_1.var_.characterEffect1071ui_story and not isNil(var_101_5) then
					arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_6 and arg_98_1.time_ < 0 + var_101_6 + arg_101_0 and not isNil(var_101_5) and arg_98_1.var_.characterEffect1071ui_story then
				arg_98_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_101_8 = arg_98_1.actors_["6148ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.characterEffect6148ui_story == nil then
				arg_98_1.var_.characterEffect6148ui_story = var_101_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_9 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_9 and not isNil(var_101_8) then
				if arg_98_1.var_.characterEffect6148ui_story and not isNil(var_101_8) then
					arg_98_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_98_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_9)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_9 and arg_98_1.time_ < 0 + var_101_9 + arg_101_0 and not isNil(var_101_8) and arg_98_1.var_.characterEffect6148ui_story then
				arg_98_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_98_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action4_2")
			end

			local var_101_10 = 0
			local var_101_11 = 0.4

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_12 = arg_98_1:GetWordFromCfg(324551024)
				local var_101_13 = arg_98_1:FormatText(var_101_12.content)

				arg_98_1.text_.text = var_101_13

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_15 = 16 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 16)

				if (16 <= 0 and var_101_11 or var_101_11 * (utf8.len(var_101_13) / 16)) > 0 and var_101_11 < var_101_15 then
					arg_98_1.talkMaxDuration = var_101_15

					if var_101_15 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_15 + var_101_10
					end
				end

				arg_98_1.text_.text = var_101_13
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551024", "story_v_out_324551.awb") ~= 0 then
					local var_101_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551024", "story_v_out_324551.awb") / 1000

					if var_101_16 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_16 + var_101_10
					end

					if var_101_12.prefab_name ~= "" and arg_98_1.actors_[var_101_12.prefab_name] ~= nil then
						local var_101_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_12.prefab_name].transform, "story_v_out_324551", "324551024", "story_v_out_324551.awb")

						arg_98_1:RecordAudio("324551024", var_101_17)
						arg_98_1:RecordAudio("324551024", var_101_17)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324551", "324551024", "story_v_out_324551.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324551", "324551024", "story_v_out_324551.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_18 = math.max(var_101_11, arg_98_1.talkMaxDuration)

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_18 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_10) / var_101_18

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_10 + var_101_18 and arg_98_1.time_ < var_101_10 + var_101_18 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play324551025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324551025
		arg_102_1.duration_ = 7.47

		local var_102_0 = {
			zh = 4.533,
			ja = 7.466
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
				arg_102_0:Play324551026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1071ui_story = arg_102_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1071ui_story"].transform.position).z)
				arg_102_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1071ui_story"].transform.localEulerAngles = arg_102_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1071ui_story"].transform.position).z)
				arg_102_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1071ui_story"].transform.localEulerAngles = arg_102_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1170ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1170ui_story = var_105_1.localPosition

				local var_105_2 = GameObjectTools.GetOrAddComponent(var_105_1.gameObject, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(false)
				end
			end

			local var_105_3 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 then
				var_105_1.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_102_1.time_ - 0) / var_105_3)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 then
				var_105_1.localPosition = Vector3.New(0.03, -0.95, -6.08)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles

				local var_105_4 = GameObjectTools.GetOrAddComponent(var_105_1.gameObject, typeof(DynamicBoneHelper))

				if var_105_4 then
					var_105_4:EnableDynamicBone(true)
				end
			end

			local var_105_5 = arg_102_1.actors_["1170ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_5) and arg_102_1.var_.characterEffect1170ui_story == nil then
				arg_102_1.var_.characterEffect1170ui_story = var_105_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_6 and not isNil(var_105_5) then
				if arg_102_1.var_.characterEffect1170ui_story and not isNil(var_105_5) then
					arg_102_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_6 and arg_102_1.time_ < 0 + var_105_6 + arg_105_0 and not isNil(var_105_5) and arg_102_1.var_.characterEffect1170ui_story then
				arg_102_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_105_8 = arg_102_1.actors_["1071ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.characterEffect1071ui_story == nil then
				arg_102_1.var_.characterEffect1071ui_story = var_105_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_9 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_9 and not isNil(var_105_8) then
				if arg_102_1.var_.characterEffect1071ui_story and not isNil(var_105_8) then
					arg_102_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_9)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_9 and arg_102_1.time_ < 0 + var_105_9 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.characterEffect1071ui_story then
				arg_102_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action6_2")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_105_10 = 0
			local var_105_11 = 0.525

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_12 = arg_102_1:GetWordFromCfg(324551025)
				local var_105_13 = arg_102_1:FormatText(var_105_12.content)

				arg_102_1.text_.text = var_105_13

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_15 = 21 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 21)

				if (21 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 21)) > 0 and var_105_11 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_10
					end
				end

				arg_102_1.text_.text = var_105_13
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551025", "story_v_out_324551.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551025", "story_v_out_324551.awb") / 1000

					if var_105_16 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_10
					end

					if var_105_12.prefab_name ~= "" and arg_102_1.actors_[var_105_12.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_12.prefab_name].transform, "story_v_out_324551", "324551025", "story_v_out_324551.awb")

						arg_102_1:RecordAudio("324551025", var_105_17)
						arg_102_1:RecordAudio("324551025", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324551", "324551025", "story_v_out_324551.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324551", "324551025", "story_v_out_324551.awb")
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play324551026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324551026
		arg_106_1.duration_ = 11.07

		local var_106_0 = {
			zh = 10.166,
			ja = 11.066
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
				arg_106_0:Play324551027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1170ui_story = arg_106_1.actors_["1170ui_story"].transform.localPosition

				local var_109_0 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_0 then
					var_109_0:EnableDynamicBone(false)
				end
			end

			local var_109_1 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_1 then
				arg_106_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1170ui_story, Vector3.New(-0.68, -0.95, -6.08), (arg_106_1.time_ - 0) / var_109_1)
				arg_106_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1170ui_story"].transform.position).z)
				arg_106_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1170ui_story"].transform.localEulerAngles = arg_106_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_1 and arg_106_1.time_ < 0 + var_109_1 + arg_109_0 then
				arg_106_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(-0.68, -0.95, -6.08)
				arg_106_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1170ui_story"].transform.position).z)
				arg_106_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1170ui_story"].transform.localEulerAngles = arg_106_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_109_2 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(true)
				end
			end

			local var_109_3 = arg_106_1.actors_["1075ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1075ui_story == nil then
				arg_106_1.var_.characterEffect1075ui_story = var_109_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_4 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 and not isNil(var_109_3) then
				if arg_106_1.var_.characterEffect1075ui_story and not isNil(var_109_3) then
					arg_106_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1075ui_story then
				arg_106_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_109_6 = arg_106_1.actors_["1170ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect1170ui_story == nil then
				arg_106_1.var_.characterEffect1170ui_story = var_109_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_7 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 and not isNil(var_109_6) then
				if arg_106_1.var_.characterEffect1170ui_story and not isNil(var_109_6) then
					arg_106_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_7)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect1170ui_story then
				arg_106_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_8 = arg_106_1.actors_["1075ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1075ui_story = var_109_8.localPosition
			end

			local var_109_9 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_9 then
				var_109_8.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_106_1.time_ - 0) / var_109_9)
				var_109_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_8.position).x, (manager.ui.mainCamera.transform.position - var_109_8.position).y, (manager.ui.mainCamera.transform.position - var_109_8.position).z)
				var_109_8.localEulerAngles.z = 0
				var_109_8.localEulerAngles.x = 0
				var_109_8.localEulerAngles = var_109_8.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_9 and arg_106_1.time_ < 0 + var_109_9 + arg_109_0 then
				var_109_8.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_109_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_8.position).x, (manager.ui.mainCamera.transform.position - var_109_8.position).y, (manager.ui.mainCamera.transform.position - var_109_8.position).z)
				var_109_8.localEulerAngles.z = 0
				var_109_8.localEulerAngles.x = 0
				var_109_8.localEulerAngles = var_109_8.localEulerAngles
			end

			local var_109_10 = 0
			local var_109_11 = 1.025

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_12 = arg_106_1:GetWordFromCfg(324551026)
				local var_109_13 = arg_106_1:FormatText(var_109_12.content)

				arg_106_1.text_.text = var_109_13

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_15 = 41 <= 0 and var_109_11 or var_109_11 * (utf8.len(var_109_13) / 41)

				if (41 <= 0 and var_109_11 or var_109_11 * (utf8.len(var_109_13) / 41)) > 0 and var_109_11 < var_109_15 then
					arg_106_1.talkMaxDuration = var_109_15

					if var_109_15 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_15 + var_109_10
					end
				end

				arg_106_1.text_.text = var_109_13
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551026", "story_v_out_324551.awb") ~= 0 then
					local var_109_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551026", "story_v_out_324551.awb") / 1000

					if var_109_16 + var_109_10 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_16 + var_109_10
					end

					if var_109_12.prefab_name ~= "" and arg_106_1.actors_[var_109_12.prefab_name] ~= nil then
						local var_109_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_12.prefab_name].transform, "story_v_out_324551", "324551026", "story_v_out_324551.awb")

						arg_106_1:RecordAudio("324551026", var_109_17)
						arg_106_1:RecordAudio("324551026", var_109_17)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_324551", "324551026", "story_v_out_324551.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_324551", "324551026", "story_v_out_324551.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_18 = math.max(var_109_11, arg_106_1.talkMaxDuration)

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_18 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_10) / var_109_18

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_10 + var_109_18 and arg_106_1.time_ < var_109_10 + var_109_18 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play324551027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324551027
		arg_110_1.duration_ = 5.83

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324551028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.bgs_.ST2007 == nil then
				local var_113_0 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_113_0.name = "ST2007"
				var_113_0.transform.parent = arg_110_1.stage_.transform
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_.ST2007 = var_113_0
			end

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_1 = arg_110_1.bgs_.ST2007

				arg_110_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_2 = var_113_1:GetComponent("SpriteRenderer")

				if var_113_2 and var_113_2.sprite then
					local var_113_3 = 2 * (var_113_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_1.transform.localScale = Vector3.New(var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "ST2007" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_4 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.allBtn_.enabled = false
			end

			if arg_110_1.time_ >= var_113_4 + 0.3 and arg_110_1.time_ < var_113_4 + 0.3 + arg_113_0 then
				arg_110_1.allBtn_.enabled = true
			end

			local var_113_5 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_6 = 2

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_5) / var_113_6)
				arg_110_1.mask_.color = var_113_7
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 then
				local var_113_8 = Color.New(0, 0, 0)

				var_113_8.a = 1
				arg_110_1.mask_.color = var_113_8
			end

			local var_113_9 = 2

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_9 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_10 = 2

			if var_113_9 <= arg_110_1.time_ and arg_110_1.time_ < var_113_9 + var_113_10 then
				local var_113_11 = Color.New(0, 0, 0)

				var_113_11.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_9) / var_113_10)
				arg_110_1.mask_.color = var_113_11
			end

			if arg_110_1.time_ >= var_113_9 + var_113_10 and arg_110_1.time_ < var_113_9 + var_113_10 + arg_113_0 then
				local var_113_12 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_12.a = 0
				arg_110_1.mask_.color = var_113_12
			end

			local var_113_13 = arg_110_1.actors_["1054ui_story"].transform

			if 3.8 < arg_110_1.time_ and arg_110_1.time_ <= 3.8 + arg_113_0 then
				arg_110_1.var_.moveOldPos1054ui_story = var_113_13.localPosition

				local var_113_14 = GameObjectTools.GetOrAddComponent(var_113_13.gameObject, typeof(DynamicBoneHelper))

				if var_113_14 then
					var_113_14:EnableDynamicBone(false)
				end
			end

			local var_113_15 = 0.001

			if 3.8 <= arg_110_1.time_ and arg_110_1.time_ < 3.8 + var_113_15 then
				var_113_13.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_110_1.time_ - 3.8) / var_113_15)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles
			end

			if arg_110_1.time_ >= 3.8 + var_113_15 and arg_110_1.time_ < 3.8 + var_113_15 + arg_113_0 then
				var_113_13.localPosition = Vector3.New(0, -0.985, -6)
				var_113_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_13.position).x, (manager.ui.mainCamera.transform.position - var_113_13.position).y, (manager.ui.mainCamera.transform.position - var_113_13.position).z)
				var_113_13.localEulerAngles.z = 0
				var_113_13.localEulerAngles.x = 0
				var_113_13.localEulerAngles = var_113_13.localEulerAngles

				local var_113_16 = GameObjectTools.GetOrAddComponent(var_113_13.gameObject, typeof(DynamicBoneHelper))

				if var_113_16 then
					var_113_16:EnableDynamicBone(true)
				end
			end

			local var_113_17 = arg_110_1.actors_["1075ui_story"].transform

			if 1.96599999815226 < arg_110_1.time_ and arg_110_1.time_ <= 1.96599999815226 + arg_113_0 then
				arg_110_1.var_.moveOldPos1075ui_story = var_113_17.localPosition
			end

			local var_113_18 = 0.001

			if 1.96599999815226 <= arg_110_1.time_ and arg_110_1.time_ < 1.96599999815226 + var_113_18 then
				var_113_17.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 1.96599999815226) / var_113_18)
				var_113_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_17.position).x, (manager.ui.mainCamera.transform.position - var_113_17.position).y, (manager.ui.mainCamera.transform.position - var_113_17.position).z)
				var_113_17.localEulerAngles.z = 0
				var_113_17.localEulerAngles.x = 0
				var_113_17.localEulerAngles = var_113_17.localEulerAngles
			end

			if arg_110_1.time_ >= 1.96599999815226 + var_113_18 and arg_110_1.time_ < 1.96599999815226 + var_113_18 + arg_113_0 then
				var_113_17.localPosition = Vector3.New(0, 100, 0)
				var_113_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_17.position).x, (manager.ui.mainCamera.transform.position - var_113_17.position).y, (manager.ui.mainCamera.transform.position - var_113_17.position).z)
				var_113_17.localEulerAngles.z = 0
				var_113_17.localEulerAngles.x = 0
				var_113_17.localEulerAngles = var_113_17.localEulerAngles
			end

			local var_113_19 = arg_110_1.actors_["1054ui_story"]

			if 3.83400000184774 < arg_110_1.time_ and arg_110_1.time_ <= 3.83400000184774 + arg_113_0 and not isNil(var_113_19) and arg_110_1.var_.characterEffect1054ui_story == nil then
				arg_110_1.var_.characterEffect1054ui_story = var_113_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_20 = 0.200000002980232

			if 3.83400000184774 <= arg_110_1.time_ and arg_110_1.time_ < 3.83400000184774 + var_113_20 and not isNil(var_113_19) then
				if arg_110_1.var_.characterEffect1054ui_story and not isNil(var_113_19) then
					arg_110_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 3.83400000184774 + var_113_20 and arg_110_1.time_ < 3.83400000184774 + var_113_20 + arg_113_0 and not isNil(var_113_19) and arg_110_1.var_.characterEffect1054ui_story then
				arg_110_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_113_22 = arg_110_1.actors_["1075ui_story"]

			if 3.83400000184774 < arg_110_1.time_ and arg_110_1.time_ <= 3.83400000184774 + arg_113_0 and not isNil(var_113_22) and arg_110_1.var_.characterEffect1075ui_story == nil then
				arg_110_1.var_.characterEffect1075ui_story = var_113_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_23 = 0.200000002980232

			if 3.83400000184774 <= arg_110_1.time_ and arg_110_1.time_ < 3.83400000184774 + var_113_23 and not isNil(var_113_22) then
				if arg_110_1.var_.characterEffect1075ui_story and not isNil(var_113_22) then
					arg_110_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 3.83400000184774) / var_113_23)
				end
			end

			if arg_110_1.time_ >= 3.83400000184774 + var_113_23 and arg_110_1.time_ < 3.83400000184774 + var_113_23 + arg_113_0 and not isNil(var_113_22) and arg_110_1.var_.characterEffect1075ui_story then
				arg_110_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 3.83400000184774 < arg_110_1.time_ and arg_110_1.time_ <= 3.83400000184774 + arg_113_0 then
				arg_110_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 3.83400000184774 < arg_110_1.time_ and arg_110_1.time_ <= 3.83400000184774 + arg_113_0 then
				arg_110_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_113_24 = arg_110_1.actors_["1170ui_story"].transform

			if 1.96599999815226 < arg_110_1.time_ and arg_110_1.time_ <= 1.96599999815226 + arg_113_0 then
				arg_110_1.var_.moveOldPos1170ui_story = var_113_24.localPosition

				local var_113_25 = GameObjectTools.GetOrAddComponent(var_113_24.gameObject, typeof(DynamicBoneHelper))

				if var_113_25 then
					var_113_25:EnableDynamicBone(false)
				end
			end

			local var_113_26 = 0.001

			if 1.96599999815226 <= arg_110_1.time_ and arg_110_1.time_ < 1.96599999815226 + var_113_26 then
				var_113_24.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 1.96599999815226) / var_113_26)
				var_113_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_24.position).x, (manager.ui.mainCamera.transform.position - var_113_24.position).y, (manager.ui.mainCamera.transform.position - var_113_24.position).z)
				var_113_24.localEulerAngles.z = 0
				var_113_24.localEulerAngles.x = 0
				var_113_24.localEulerAngles = var_113_24.localEulerAngles
			end

			if arg_110_1.time_ >= 1.96599999815226 + var_113_26 and arg_110_1.time_ < 1.96599999815226 + var_113_26 + arg_113_0 then
				var_113_24.localPosition = Vector3.New(0, 100, 0)
				var_113_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_24.position).x, (manager.ui.mainCamera.transform.position - var_113_24.position).y, (manager.ui.mainCamera.transform.position - var_113_24.position).z)
				var_113_24.localEulerAngles.z = 0
				var_113_24.localEulerAngles.x = 0
				var_113_24.localEulerAngles = var_113_24.localEulerAngles

				local var_113_27 = GameObjectTools.GetOrAddComponent(var_113_24.gameObject, typeof(DynamicBoneHelper))

				if var_113_27 then
					var_113_27:EnableDynamicBone(true)
				end
			end

			if 1.2 < arg_110_1.time_ and arg_110_1.time_ <= 1.2 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0.1 < arg_110_1.time_ and arg_110_1.time_ <= 0.1 + arg_113_0 then
				arg_110_1:AudioAction("stop", "effect", "se_story_150", "se_story_150_huatian", "")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_110_1.time_ and arg_110_1.time_ <= 1 + arg_113_0 then
				arg_110_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_113_33 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

				if "" ~= "" then
					if arg_110_1.bgmTxt_.text ~= var_113_33 and arg_110_1.bgmTxt_.text ~= "" then
						if arg_110_1.bgmTxt2_.text ~= "" then
							arg_110_1.bgmTxt_.text = arg_110_1.bgmTxt2_.text
						end

						arg_110_1.bgmTxt2_.text = var_113_33

						arg_110_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_110_1.bgmTxt_.text = var_113_33
						arg_110_1.bgmTxt2_.text = var_113_33
					end

					if arg_110_1.bgmTimer then
						arg_110_1.bgmTimer:Stop()

						arg_110_1.bgmTimer = nil
					end

					if arg_110_1.settingData.show_music_name == 1 then
						arg_110_1.musicController:SetSelectedState("show")
						arg_110_1.musicAnimator_:Play("open", 0, 0)

						if arg_110_1.settingData.music_time ~= 0 then
							arg_110_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_110_1.settingData.music_time), function()
								if arg_110_1 == nil or isNil(arg_110_1.bgmTxt_) then
									return
								end

								arg_110_1.musicController:SetSelectedState("hide")
								arg_110_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_34 = 3.874999999999
			local var_113_35 = 0.125

			if 3.874999999999 < arg_110_1.time_ and arg_110_1.time_ <= var_113_34 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_36 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_36:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_110_1.dialogCg_.alpha = arg_115_0
				end))
				var_113_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_37 = arg_110_1:GetWordFromCfg(324551027)
				local var_113_38 = arg_110_1:FormatText(var_113_37.content)

				arg_110_1.text_.text = var_113_38

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_40 = 5 <= 0 and var_113_35 or var_113_35 * (utf8.len(var_113_38) / 5)

				if (5 <= 0 and var_113_35 or var_113_35 * (utf8.len(var_113_38) / 5)) > 0 and var_113_35 < var_113_40 then
					arg_110_1.talkMaxDuration = var_113_40
					var_113_34 = var_113_34 + 0.3

					if var_113_40 + var_113_34 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_40 + var_113_34
					end
				end

				arg_110_1.text_.text = var_113_38
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551027", "story_v_out_324551.awb") ~= 0 then
					local var_113_41 = manager.audio:GetVoiceLength("story_v_out_324551", "324551027", "story_v_out_324551.awb") / 1000

					if var_113_41 + var_113_34 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_41 + var_113_34
					end

					if var_113_37.prefab_name ~= "" and arg_110_1.actors_[var_113_37.prefab_name] ~= nil then
						local var_113_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_37.prefab_name].transform, "story_v_out_324551", "324551027", "story_v_out_324551.awb")

						arg_110_1:RecordAudio("324551027", var_113_42)
						arg_110_1:RecordAudio("324551027", var_113_42)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324551", "324551027", "story_v_out_324551.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324551", "324551027", "story_v_out_324551.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_43 = var_113_34 + 0.3
			local var_113_44 = math.max(var_113_35, arg_110_1.talkMaxDuration)

			if var_113_34 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_43 + var_113_44 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_43) / var_113_44

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_43 + var_113_44 and arg_110_1.time_ < var_113_43 + var_113_44 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play324551028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 324551028
		arg_117_1.duration_ = 2

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play324551029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1054ui_story = arg_117_1.actors_["1054ui_story"].transform.localPosition

				local var_120_0 = GameObjectTools.GetOrAddComponent(arg_117_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_120_0 then
					var_120_0:EnableDynamicBone(false)
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_117_1.time_ - 0) / var_120_1)
				arg_117_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).z)
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles = arg_117_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_117_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).z)
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles = arg_117_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_120_2 = GameObjectTools.GetOrAddComponent(arg_117_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(true)
				end
			end

			local var_120_3 = arg_117_1.actors_["6148ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos6148ui_story = var_120_3.localPosition

				local var_120_4 = GameObjectTools.GetOrAddComponent(var_120_3.gameObject, typeof(DynamicBoneHelper))

				if var_120_4 then
					var_120_4:EnableDynamicBone(false)
				end
			end

			local var_120_5 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_117_1.time_ - 0) / var_120_5)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles

				local var_120_6 = GameObjectTools.GetOrAddComponent(var_120_3.gameObject, typeof(DynamicBoneHelper))

				if var_120_6 then
					var_120_6:EnableDynamicBone(true)
				end
			end

			local var_120_7 = arg_117_1.actors_["6148ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.characterEffect6148ui_story == nil then
				arg_117_1.var_.characterEffect6148ui_story = var_120_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_8 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_8 and not isNil(var_120_7) then
				if arg_117_1.var_.characterEffect6148ui_story and not isNil(var_120_7) then
					arg_117_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_8 and arg_117_1.time_ < 0 + var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.characterEffect6148ui_story then
				arg_117_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_120_10 = arg_117_1.actors_["1054ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect1054ui_story == nil then
				arg_117_1.var_.characterEffect1054ui_story = var_120_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_11 and not isNil(var_120_10) then
				if arg_117_1.var_.characterEffect1054ui_story and not isNil(var_120_10) then
					arg_117_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_11)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_11 and arg_117_1.time_ < 0 + var_120_11 + arg_120_0 and not isNil(var_120_10) and arg_117_1.var_.characterEffect1054ui_story then
				arg_117_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_12 = 0
			local var_120_13 = 0.2

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:GetWordFromCfg(324551028)
				local var_120_15 = arg_117_1:FormatText(var_120_14.content)

				arg_117_1.text_.text = var_120_15

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_17 = 8 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_15) / 8)

				if (8 <= 0 and var_120_13 or var_120_13 * (utf8.len(var_120_15) / 8)) > 0 and var_120_13 < var_120_17 then
					arg_117_1.talkMaxDuration = var_120_17

					if var_120_17 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_15
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551028", "story_v_out_324551.awb") ~= 0 then
					local var_120_18 = manager.audio:GetVoiceLength("story_v_out_324551", "324551028", "story_v_out_324551.awb") / 1000

					if var_120_18 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_12
					end

					if var_120_14.prefab_name ~= "" and arg_117_1.actors_[var_120_14.prefab_name] ~= nil then
						local var_120_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_14.prefab_name].transform, "story_v_out_324551", "324551028", "story_v_out_324551.awb")

						arg_117_1:RecordAudio("324551028", var_120_19)
						arg_117_1:RecordAudio("324551028", var_120_19)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_324551", "324551028", "story_v_out_324551.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_324551", "324551028", "story_v_out_324551.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_20 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_20 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_12) / var_120_20

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_12 + var_120_20 and arg_117_1.time_ < var_120_12 + var_120_20 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play324551029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 324551029
		arg_121_1.duration_ = 5.43

		local var_121_0 = {
			zh = 4.633,
			ja = 5.433
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play324551030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1054ui_story = arg_121_1.actors_["1054ui_story"].transform.localPosition

				local var_124_0 = GameObjectTools.GetOrAddComponent(arg_121_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_124_0 then
					var_124_0:EnableDynamicBone(false)
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_1)
				arg_121_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1054ui_story"].transform.position).z)
				arg_121_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1054ui_story"].transform.localEulerAngles = arg_121_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1054ui_story"].transform.position).z)
				arg_121_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1054ui_story"].transform.localEulerAngles = arg_121_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_124_2 = GameObjectTools.GetOrAddComponent(arg_121_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_124_2 then
					var_124_2:EnableDynamicBone(true)
				end
			end

			local var_124_3 = arg_121_1.actors_["6148ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos6148ui_story = var_124_3.localPosition

				local var_124_4 = GameObjectTools.GetOrAddComponent(var_124_3.gameObject, typeof(DynamicBoneHelper))

				if var_124_4 then
					var_124_4:EnableDynamicBone(false)
				end
			end

			local var_124_5 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_5)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles

				local var_124_6 = GameObjectTools.GetOrAddComponent(var_124_3.gameObject, typeof(DynamicBoneHelper))

				if var_124_6 then
					var_124_6:EnableDynamicBone(true)
				end
			end

			local var_124_7 = arg_121_1.actors_["1170ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1170ui_story = var_124_7.localPosition

				local var_124_8 = GameObjectTools.GetOrAddComponent(var_124_7.gameObject, typeof(DynamicBoneHelper))

				if var_124_8 then
					var_124_8:EnableDynamicBone(false)
				end
			end

			local var_124_9 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_9 then
				var_124_7.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1170ui_story, Vector3.New(0.03, -0.95, -6.08), (arg_121_1.time_ - 0) / var_124_9)
				var_124_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_7.position).x, (manager.ui.mainCamera.transform.position - var_124_7.position).y, (manager.ui.mainCamera.transform.position - var_124_7.position).z)
				var_124_7.localEulerAngles.z = 0
				var_124_7.localEulerAngles.x = 0
				var_124_7.localEulerAngles = var_124_7.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_9 and arg_121_1.time_ < 0 + var_124_9 + arg_124_0 then
				var_124_7.localPosition = Vector3.New(0.03, -0.95, -6.08)
				var_124_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_7.position).x, (manager.ui.mainCamera.transform.position - var_124_7.position).y, (manager.ui.mainCamera.transform.position - var_124_7.position).z)
				var_124_7.localEulerAngles.z = 0
				var_124_7.localEulerAngles.x = 0
				var_124_7.localEulerAngles = var_124_7.localEulerAngles

				local var_124_10 = GameObjectTools.GetOrAddComponent(var_124_7.gameObject, typeof(DynamicBoneHelper))

				if var_124_10 then
					var_124_10:EnableDynamicBone(true)
				end
			end

			local var_124_11 = arg_121_1.actors_["1170ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1170ui_story == nil then
				arg_121_1.var_.characterEffect1170ui_story = var_124_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_12 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_12 and not isNil(var_124_11) then
				if arg_121_1.var_.characterEffect1170ui_story and not isNil(var_124_11) then
					arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_12 and arg_121_1.time_ < 0 + var_124_12 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1170ui_story then
				arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_124_14 = arg_121_1.actors_["6148ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect6148ui_story == nil then
				arg_121_1.var_.characterEffect6148ui_story = var_124_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_15 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_15 and not isNil(var_124_14) then
				if arg_121_1.var_.characterEffect6148ui_story and not isNil(var_124_14) then
					arg_121_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_121_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_15)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_15 and arg_121_1.time_ < 0 + var_124_15 + arg_124_0 and not isNil(var_124_14) and arg_121_1.var_.characterEffect6148ui_story then
				arg_121_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_121_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_1")
			end

			local var_124_16 = 0
			local var_124_17 = 0.45

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(324551029)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_21 = 18 <= 0 and var_124_17 or var_124_17 * (utf8.len(var_124_19) / 18)

				if (18 <= 0 and var_124_17 or var_124_17 * (utf8.len(var_124_19) / 18)) > 0 and var_124_17 < var_124_21 then
					arg_121_1.talkMaxDuration = var_124_21

					if var_124_21 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_21 + var_124_16
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551029", "story_v_out_324551.awb") ~= 0 then
					local var_124_22 = manager.audio:GetVoiceLength("story_v_out_324551", "324551029", "story_v_out_324551.awb") / 1000

					if var_124_22 + var_124_16 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_16
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_324551", "324551029", "story_v_out_324551.awb")

						arg_121_1:RecordAudio("324551029", var_124_23)
						arg_121_1:RecordAudio("324551029", var_124_23)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_324551", "324551029", "story_v_out_324551.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_324551", "324551029", "story_v_out_324551.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_24 = math.max(var_124_17, arg_121_1.talkMaxDuration)

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_24 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_16) / var_124_24

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_16 + var_124_24 and arg_121_1.time_ < var_124_16 + var_124_24 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play324551030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 324551030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play324551031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1170ui_story = arg_125_1.actors_["1170ui_story"].transform.localPosition

				local var_128_0 = GameObjectTools.GetOrAddComponent(arg_125_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_128_0 then
					var_128_0:EnableDynamicBone(false)
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_1)
				arg_125_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1170ui_story"].transform.position).z)
				arg_125_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1170ui_story"].transform.localEulerAngles = arg_125_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1170ui_story"].transform.position).z)
				arg_125_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1170ui_story"].transform.localEulerAngles = arg_125_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_128_2 = GameObjectTools.GetOrAddComponent(arg_125_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_128_2 then
					var_128_2:EnableDynamicBone(true)
				end
			end

			local var_128_3 = arg_125_1.actors_["1170ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_3) and arg_125_1.var_.characterEffect1170ui_story == nil then
				arg_125_1.var_.characterEffect1170ui_story = var_128_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_4 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 and not isNil(var_128_3) then
				if arg_125_1.var_.characterEffect1170ui_story and not isNil(var_128_3) then
					arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_4)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 and not isNil(var_128_3) and arg_125_1.var_.characterEffect1170ui_story then
				arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			local var_128_5 = 0
			local var_128_6 = 0.975

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(324551030).content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 39 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_7) / 39)

				if (39 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_7) / 39)) > 0 and var_128_6 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_5
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_6, arg_125_1.talkMaxDuration)

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_5) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_5 + var_128_10 and arg_125_1.time_ < var_128_5 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play324551031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 324551031
		arg_129_1.duration_ = 7.37

		local var_129_0 = {
			zh = 4.366,
			ja = 7.366
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play324551032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1071ui_story = arg_129_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1071ui_story"].transform.position).z)
				arg_129_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1071ui_story"].transform.localEulerAngles = arg_129_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_129_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1071ui_story"].transform.position).z)
				arg_129_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1071ui_story"].transform.localEulerAngles = arg_129_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1071ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1071ui_story == nil then
				arg_129_1.var_.characterEffect1071ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1071ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1071ui_story then
				arg_129_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_132_4 = 0
			local var_132_5 = 0.6

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(324551031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 24 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 24)

				if (24 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 24)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551031", "story_v_out_324551.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_324551", "324551031", "story_v_out_324551.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_324551", "324551031", "story_v_out_324551.awb")

						arg_129_1:RecordAudio("324551031", var_132_11)
						arg_129_1:RecordAudio("324551031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_324551", "324551031", "story_v_out_324551.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_324551", "324551031", "story_v_out_324551.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play324551032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 324551032
		arg_133_1.duration_ = 3.3

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 3.3
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play324551033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1170ui_story = arg_133_1.actors_["1170ui_story"].transform.localPosition

				local var_136_0 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_0 then
					var_136_0:EnableDynamicBone(false)
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1170ui_story, Vector3.New(0.74, -0.95, -6.08), (arg_133_1.time_ - 0) / var_136_1)
				arg_133_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1170ui_story"].transform.position).z)
				arg_133_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1170ui_story"].transform.localEulerAngles = arg_133_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0.74, -0.95, -6.08)
				arg_133_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1170ui_story"].transform.position).z)
				arg_133_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1170ui_story"].transform.localEulerAngles = arg_133_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_136_2 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(true)
				end
			end

			local var_136_3 = arg_133_1.actors_["1170ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1170ui_story == nil then
				arg_133_1.var_.characterEffect1170ui_story = var_136_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 and not isNil(var_136_3) then
				if arg_133_1.var_.characterEffect1170ui_story and not isNil(var_136_3) then
					arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1170ui_story then
				arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_136_6 = arg_133_1.actors_["1071ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1071ui_story == nil then
				arg_133_1.var_.characterEffect1071ui_story = var_136_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_7 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 and not isNil(var_136_6) then
				if arg_133_1.var_.characterEffect1071ui_story and not isNil(var_136_6) then
					arg_133_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_7)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 and not isNil(var_136_6) and arg_133_1.var_.characterEffect1071ui_story then
				arg_133_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_136_8 = 0
			local var_136_9 = 0.2

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(324551032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 8 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 8)

				if (8 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 8)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551032", "story_v_out_324551.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_324551", "324551032", "story_v_out_324551.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_324551", "324551032", "story_v_out_324551.awb")

						arg_133_1:RecordAudio("324551032", var_136_15)
						arg_133_1:RecordAudio("324551032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_324551", "324551032", "story_v_out_324551.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_324551", "324551032", "story_v_out_324551.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play324551033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 324551033
		arg_137_1.duration_ = 6.53

		local var_137_0 = {
			zh = 4.9,
			ja = 6.533
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play324551034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1170ui_story = arg_137_1.actors_["1170ui_story"].transform.localPosition

				local var_140_0 = GameObjectTools.GetOrAddComponent(arg_137_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_140_0 then
					var_140_0:EnableDynamicBone(false)
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["1170ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1170ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_1)
				arg_137_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1170ui_story"].transform.position).z)
				arg_137_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1170ui_story"].transform.localEulerAngles = arg_137_1.actors_["1170ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["1170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1170ui_story"].transform.position).z)
				arg_137_1.actors_["1170ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1170ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1170ui_story"].transform.localEulerAngles = arg_137_1.actors_["1170ui_story"].transform.localEulerAngles

				local var_140_2 = GameObjectTools.GetOrAddComponent(arg_137_1.actors_["1170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(true)
				end
			end

			local var_140_3 = arg_137_1.actors_["1075ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1075ui_story = var_140_3.localPosition
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_3.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_137_1.time_ - 0) / var_140_4)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_3.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			local var_140_5 = arg_137_1.actors_["1075ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1075ui_story == nil then
				arg_137_1.var_.characterEffect1075ui_story = var_140_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.characterEffect1075ui_story and not isNil(var_140_5) then
					arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1075ui_story then
				arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_140_8 = arg_137_1.actors_["1170ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.characterEffect1170ui_story == nil then
				arg_137_1.var_.characterEffect1170ui_story = var_140_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_9 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_9 and not isNil(var_140_8) then
				if arg_137_1.var_.characterEffect1170ui_story and not isNil(var_140_8) then
					arg_137_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_9)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_9 and arg_137_1.time_ < 0 + var_140_9 + arg_140_0 and not isNil(var_140_8) and arg_137_1.var_.characterEffect1170ui_story then
				arg_137_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1170ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_140_10 = 0
			local var_140_11 = 0.525

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_12 = arg_137_1:GetWordFromCfg(324551033)
				local var_140_13 = arg_137_1:FormatText(var_140_12.content)

				arg_137_1.text_.text = var_140_13

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_15 = 21 <= 0 and var_140_11 or var_140_11 * (utf8.len(var_140_13) / 21)

				if (21 <= 0 and var_140_11 or var_140_11 * (utf8.len(var_140_13) / 21)) > 0 and var_140_11 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_10
					end
				end

				arg_137_1.text_.text = var_140_13
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551033", "story_v_out_324551.awb") ~= 0 then
					local var_140_16 = manager.audio:GetVoiceLength("story_v_out_324551", "324551033", "story_v_out_324551.awb") / 1000

					if var_140_16 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_10
					end

					if var_140_12.prefab_name ~= "" and arg_137_1.actors_[var_140_12.prefab_name] ~= nil then
						local var_140_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_12.prefab_name].transform, "story_v_out_324551", "324551033", "story_v_out_324551.awb")

						arg_137_1:RecordAudio("324551033", var_140_17)
						arg_137_1:RecordAudio("324551033", var_140_17)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_324551", "324551033", "story_v_out_324551.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_324551", "324551033", "story_v_out_324551.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = math.max(var_140_11, arg_137_1.talkMaxDuration)

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_10) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_10 + var_140_18 and arg_137_1.time_ < var_140_10 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play324551034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 324551034
		arg_141_1.duration_ = 9.4

		local var_141_0 = {
			zh = 7.866,
			ja = 9.4
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play324551035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1071ui_story"]) and arg_141_1.var_.characterEffect1071ui_story == nil then
				arg_141_1.var_.characterEffect1071ui_story = arg_141_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1071ui_story"]) then
				if arg_141_1.var_.characterEffect1071ui_story and not isNil(arg_141_1.actors_["1071ui_story"]) then
					arg_141_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1071ui_story"]) and arg_141_1.var_.characterEffect1071ui_story then
				arg_141_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_144_2 = arg_141_1.actors_["1075ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1075ui_story == nil then
				arg_141_1.var_.characterEffect1075ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect1075ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1075ui_story then
				arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_4 = 0
			local var_144_5 = 0.9

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(324551034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 36 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 36)

				if (36 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 36)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551034", "story_v_out_324551.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_324551", "324551034", "story_v_out_324551.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_324551", "324551034", "story_v_out_324551.awb")

						arg_141_1:RecordAudio("324551034", var_144_11)
						arg_141_1:RecordAudio("324551034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_324551", "324551034", "story_v_out_324551.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_324551", "324551034", "story_v_out_324551.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play324551035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 324551035
		arg_145_1.duration_ = 11.8

		local var_145_0 = {
			zh = 8.6,
			ja = 11.8
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
			arg_145_1.auto_ = false
		end

		function arg_145_1.playNext_(arg_147_0)
			arg_145_1.onStoryFinished_()
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.7

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(324551035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 28 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 28)

				if (28 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 28)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324551", "324551035", "story_v_out_324551.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_324551", "324551035", "story_v_out_324551.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_324551", "324551035", "story_v_out_324551.awb")

						arg_145_1:RecordAudio("324551035", var_148_6)
						arg_145_1:RecordAudio("324551035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_324551", "324551035", "story_v_out_324551.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_324551", "324551035", "story_v_out_324551.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27g",
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324551.awb"
	}
}
