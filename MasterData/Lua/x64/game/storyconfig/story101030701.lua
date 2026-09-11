return {
	Play103071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103071001
		arg_1_1.duration_ = 5.57

		local var_1_0 = {
			ja = 5.1,
			ko = 4.8,
			zh = 4.566,
			en = 5.566
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
				arg_1_0:Play103071002(arg_1_1)
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_machinegun", "")
			end

			local var_4_5 = "1148ui_story"

			if arg_1_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_4_6 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

				var_4_6.name = var_4_5
				var_4_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_5] = var_4_6

				local var_4_7 = var_4_6:GetComponentInChildren(typeof(CharacterEffect))

				var_4_7.enabled = true

				local var_4_8 = GameObjectTools.GetOrAddComponent(var_4_6, typeof(DynamicBoneHelper))

				if var_4_8 then
					var_4_8:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_7.transform, false)

				arg_1_1.var_[var_4_5 .. "Animator"] = var_4_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_5 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_5 .. "LipSync"] = var_4_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_9 = arg_1_1.actors_["1148ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_10 and arg_1_1.time_ < 2 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_4_12 = "B06b"

			if arg_1_1.bgs_.B06b == nil then
				local var_4_13 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_12)
				var_4_13.name = var_4_12
				var_4_13.transform.parent = arg_1_1.stage_.transform
				var_4_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_12] = var_4_13
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.B06b:GetComponent("SpriteRenderer")

				if var_4_14 then
					arg_1_1.var_.alphaOldValueB06b = var_4_14.color.a
					arg_1_1.var_.alphaMatValueB06b = var_4_14
				end

				arg_1_1.var_.alphaOldValueB06b = 0
			end

			local var_4_15 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_15 then
				if arg_1_1.var_.alphaMatValueB06b then
					arg_1_1.var_.alphaMatValueB06b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB06b, 1, (arg_1_1.time_ - 0) / var_4_15)
					arg_1_1.var_.alphaMatValueB06b.color = arg_1_1.var_.alphaMatValueB06b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_15 and arg_1_1.time_ < 0 + var_4_15 + arg_4_0 and arg_1_1.var_.alphaMatValueB06b then
				arg_1_1.var_.alphaMatValueB06b.color.a = 1
				arg_1_1.var_.alphaMatValueB06b.color = arg_1_1.var_.alphaMatValueB06b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.bgs_.B06b

				arg_1_1.bgs_.B06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_17 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_17 and var_4_17.sprite then
					local var_4_18 = 2 * (var_4_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_16.transform.localScale = Vector3.New(var_4_18 / var_4_17.sprite.bounds.size.y < var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x and var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x or var_4_18 / var_4_17.sprite.bounds.size.y, var_4_18 / var_4_17.sprite.bounds.size.y < var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x and var_4_18 * manager.ui.mainCameraCom_.aspect / var_4_17.sprite.bounds.size.x or var_4_18 / var_4_17.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_19 = arg_1_1.actors_["1148ui_story"].transform

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148ui_story = var_4_19.localPosition
			end

			local var_4_20 = 0.001

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_20 then
				var_4_19.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_1_1.time_ - 1) / var_4_20)
				var_4_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_19.position).x, (manager.ui.mainCamera.transform.position - var_4_19.position).y, (manager.ui.mainCamera.transform.position - var_4_19.position).z)
				var_4_19.localEulerAngles.z = 0
				var_4_19.localEulerAngles.x = 0
				var_4_19.localEulerAngles = var_4_19.localEulerAngles
			end

			if arg_1_1.time_ >= 1 + var_4_20 and arg_1_1.time_ < 1 + var_4_20 + arg_4_0 then
				var_4_19.localPosition = Vector3.New(0, -0.8, -6.2)
				var_4_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_19.position).x, (manager.ui.mainCamera.transform.position - var_4_19.position).y, (manager.ui.mainCamera.transform.position - var_4_19.position).z)
				var_4_19.localEulerAngles.z = 0
				var_4_19.localEulerAngles.x = 0
				var_4_19.localEulerAngles = var_4_19.localEulerAngles
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			local var_4_21 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_21 + 2 and arg_1_1.time_ < var_4_21 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(103071001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 12 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 12)

				if (12 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 12)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071001", "story_v_out_103071.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_103071", "103071001", "story_v_out_103071.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_103071", "103071001", "story_v_out_103071.awb")

						arg_1_1:RecordAudio("103071001", var_4_30)
						arg_1_1:RecordAudio("103071001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103071", "103071001", "story_v_out_103071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103071", "103071001", "story_v_out_103071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play103071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103071002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = arg_8_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) then
				if arg_8_1.var_.characterEffect1148ui_story and not isNil(arg_8_1.actors_["1148ui_story"]) then
					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story then
				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_11_1 = arg_8_1.actors_["1148ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1148ui_story = var_11_1.localPosition
			end

			local var_11_2 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_2 then
				var_11_1.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_2)
				var_11_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_1.position).x, (manager.ui.mainCamera.transform.position - var_11_1.position).y, (manager.ui.mainCamera.transform.position - var_11_1.position).z)
				var_11_1.localEulerAngles.z = 0
				var_11_1.localEulerAngles.x = 0
				var_11_1.localEulerAngles = var_11_1.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_2 and arg_8_1.time_ < 0 + var_11_2 + arg_11_0 then
				var_11_1.localPosition = Vector3.New(0, 100, 0)
				var_11_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_1.position).x, (manager.ui.mainCamera.transform.position - var_11_1.position).y, (manager.ui.mainCamera.transform.position - var_11_1.position).z)
				var_11_1.localEulerAngles.z = 0
				var_11_1.localEulerAngles.x = 0
				var_11_1.localEulerAngles = var_11_1.localEulerAngles
			end

			local var_11_3 = 0
			local var_11_4 = 0.85

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_5 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(103071002).content)

				arg_8_1.text_.text = var_11_5

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_7 = 34 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 34)

				if (34 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 34)) > 0 and var_11_4 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_3 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_3
					end
				end

				arg_8_1.text_.text = var_11_5
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_4, arg_8_1.talkMaxDuration)

			if var_11_3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_3 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_3) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_3 + var_11_8 and arg_8_1.time_ < var_11_3 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play103071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103071003
		arg_12_1.duration_ = 4.9

		local var_12_0 = {
			ja = 4.4,
			ko = 4.9,
			zh = 3.9,
			en = 4.166
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
				arg_12_0:Play103071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1059ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1059ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1059ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1059ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1059ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1059ui_story == nil then
				arg_12_1.var_.characterEffect1059ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1059ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1059ui_story then
				arg_12_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_15_6 = arg_12_1.actors_["1059ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1059ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_15_8 = 0
			local var_15_9 = 0.525

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_10 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_10:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_11 = arg_12_1:GetWordFromCfg(103071003)
				local var_15_12 = arg_12_1:FormatText(var_15_11.content)

				arg_12_1.text_.text = var_15_12

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_14 = 21 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_12) / 21)

				if (21 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_12) / 21)) > 0 and var_15_9 < var_15_14 then
					arg_12_1.talkMaxDuration = var_15_14
					var_15_8 = var_15_8 + 0.3

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_12
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071003", "story_v_out_103071.awb") ~= 0 then
					local var_15_15 = manager.audio:GetVoiceLength("story_v_out_103071", "103071003", "story_v_out_103071.awb") / 1000

					if var_15_15 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_8
					end

					if var_15_11.prefab_name ~= "" and arg_12_1.actors_[var_15_11.prefab_name] ~= nil then
						local var_15_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_11.prefab_name].transform, "story_v_out_103071", "103071003", "story_v_out_103071.awb")

						arg_12_1:RecordAudio("103071003", var_15_16)
						arg_12_1:RecordAudio("103071003", var_15_16)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103071", "103071003", "story_v_out_103071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103071", "103071003", "story_v_out_103071.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_17 = var_15_8 + 0.3
			local var_15_18 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_17) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play103071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 103071004
		arg_18_1.duration_ = 4.7

		local var_18_0 = {
			ja = 3.666,
			ko = 3.166,
			zh = 3.033,
			en = 4.7
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play103071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1148ui_story"]) and arg_18_1.var_.characterEffect1148ui_story == nil then
				arg_18_1.var_.characterEffect1148ui_story = arg_18_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_0 = 0.1

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1148ui_story"]) then
				if arg_18_1.var_.characterEffect1148ui_story and not isNil(arg_18_1.actors_["1148ui_story"]) then
					arg_18_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1148ui_story"]) and arg_18_1.var_.characterEffect1148ui_story then
				arg_18_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_21_2 = arg_18_1.actors_["1059ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.characterEffect1059ui_story == nil then
				arg_18_1.var_.characterEffect1059ui_story = var_21_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_3 = 0.1

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_3 and not isNil(var_21_2) then
				if arg_18_1.var_.characterEffect1059ui_story and not isNil(var_21_2) then
					arg_18_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_18_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_18_1.time_ - 0) / var_21_3)
				end
			end

			if arg_18_1.time_ >= 0 + var_21_3 and arg_18_1.time_ < 0 + var_21_3 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.characterEffect1059ui_story then
				arg_18_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_18_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_21_4 = arg_18_1.actors_["1148ui_story"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1148ui_story = var_21_4.localPosition
			end

			local var_21_5 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_5 then
				var_21_4.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_18_1.time_ - 0) / var_21_5)
				var_21_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_4.position).x, (manager.ui.mainCamera.transform.position - var_21_4.position).y, (manager.ui.mainCamera.transform.position - var_21_4.position).z)
				var_21_4.localEulerAngles.z = 0
				var_21_4.localEulerAngles.x = 0
				var_21_4.localEulerAngles = var_21_4.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_5 and arg_18_1.time_ < 0 + var_21_5 + arg_21_0 then
				var_21_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_21_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_4.position).x, (manager.ui.mainCamera.transform.position - var_21_4.position).y, (manager.ui.mainCamera.transform.position - var_21_4.position).z)
				var_21_4.localEulerAngles.z = 0
				var_21_4.localEulerAngles.x = 0
				var_21_4.localEulerAngles = var_21_4.localEulerAngles
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_21_6 = 0
			local var_21_7 = 0.325

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_8 = arg_18_1:GetWordFromCfg(103071004)
				local var_21_9 = arg_18_1:FormatText(var_21_8.content)

				arg_18_1.text_.text = var_21_9

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_11 = 13 <= 0 and var_21_7 or var_21_7 * (utf8.len(var_21_9) / 13)

				if (13 <= 0 and var_21_7 or var_21_7 * (utf8.len(var_21_9) / 13)) > 0 and var_21_7 < var_21_11 then
					arg_18_1.talkMaxDuration = var_21_11

					if var_21_11 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_11 + var_21_6
					end
				end

				arg_18_1.text_.text = var_21_9
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071004", "story_v_out_103071.awb") ~= 0 then
					local var_21_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071004", "story_v_out_103071.awb") / 1000

					if var_21_12 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_12 + var_21_6
					end

					if var_21_8.prefab_name ~= "" and arg_18_1.actors_[var_21_8.prefab_name] ~= nil then
						local var_21_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_8.prefab_name].transform, "story_v_out_103071", "103071004", "story_v_out_103071.awb")

						arg_18_1:RecordAudio("103071004", var_21_13)
						arg_18_1:RecordAudio("103071004", var_21_13)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_103071", "103071004", "story_v_out_103071.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_103071", "103071004", "story_v_out_103071.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_14 = math.max(var_21_7, arg_18_1.talkMaxDuration)

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_14 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_6) / var_21_14

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_6 + var_21_14 and arg_18_1.time_ < var_21_6 + var_21_14 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
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

		arg_18_1:InitPlayNodeList()
	end,
	Play103071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 103071005
		arg_22_1.duration_ = 5.07

		local var_22_0 = {
			ja = 5.066,
			ko = 2.6,
			zh = 2.866,
			en = 2.733
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play103071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["1059ui_story"]) and arg_22_1.var_.characterEffect1059ui_story == nil then
				arg_22_1.var_.characterEffect1059ui_story = arg_22_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_0 = 0.1

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["1059ui_story"]) then
				if arg_22_1.var_.characterEffect1059ui_story and not isNil(arg_22_1.actors_["1059ui_story"]) then
					arg_22_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["1059ui_story"]) and arg_22_1.var_.characterEffect1059ui_story then
				arg_22_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_25_2 = arg_22_1.actors_["1148ui_story"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.characterEffect1148ui_story == nil then
				arg_22_1.var_.characterEffect1148ui_story = var_25_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_3 = 0.1

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_3 and not isNil(var_25_2) then
				if arg_22_1.var_.characterEffect1148ui_story and not isNil(var_25_2) then
					arg_22_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_22_1.time_ - 0) / var_25_3)
				end
			end

			if arg_22_1.time_ >= 0 + var_25_3 and arg_22_1.time_ < 0 + var_25_3 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.characterEffect1148ui_story then
				arg_22_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action424")
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_25_4 = 0
			local var_25_5 = 0.275

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_6 = arg_22_1:GetWordFromCfg(103071005)
				local var_25_7 = arg_22_1:FormatText(var_25_6.content)

				arg_22_1.text_.text = var_25_7

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_9 = 11 <= 0 and var_25_5 or var_25_5 * (utf8.len(var_25_7) / 11)

				if (11 <= 0 and var_25_5 or var_25_5 * (utf8.len(var_25_7) / 11)) > 0 and var_25_5 < var_25_9 then
					arg_22_1.talkMaxDuration = var_25_9

					if var_25_9 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_9 + var_25_4
					end
				end

				arg_22_1.text_.text = var_25_7
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071005", "story_v_out_103071.awb") ~= 0 then
					local var_25_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071005", "story_v_out_103071.awb") / 1000

					if var_25_10 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_10 + var_25_4
					end

					if var_25_6.prefab_name ~= "" and arg_22_1.actors_[var_25_6.prefab_name] ~= nil then
						local var_25_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_6.prefab_name].transform, "story_v_out_103071", "103071005", "story_v_out_103071.awb")

						arg_22_1:RecordAudio("103071005", var_25_11)
						arg_22_1:RecordAudio("103071005", var_25_11)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_103071", "103071005", "story_v_out_103071.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_103071", "103071005", "story_v_out_103071.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_12 = math.max(var_25_5, arg_22_1.talkMaxDuration)

			if var_25_4 <= arg_22_1.time_ and arg_22_1.time_ < var_25_4 + var_25_12 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_4) / var_25_12

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_4 + var_25_12 and arg_22_1.time_ < var_25_4 + var_25_12 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play103071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 103071006
		arg_26_1.duration_ = 6.47

		local var_26_0 = {
			ja = 6.466,
			ko = 3.366,
			zh = 3,
			en = 3.9
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play103071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["1148ui_story"]) and arg_26_1.var_.characterEffect1148ui_story == nil then
				arg_26_1.var_.characterEffect1148ui_story = arg_26_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.1

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["1148ui_story"]) then
				if arg_26_1.var_.characterEffect1148ui_story and not isNil(arg_26_1.actors_["1148ui_story"]) then
					arg_26_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["1148ui_story"]) and arg_26_1.var_.characterEffect1148ui_story then
				arg_26_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_29_2 = arg_26_1.actors_["1059ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.characterEffect1059ui_story == nil then
				arg_26_1.var_.characterEffect1059ui_story = var_29_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_3 = 0.1

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_3 and not isNil(var_29_2) then
				if arg_26_1.var_.characterEffect1059ui_story and not isNil(var_29_2) then
					arg_26_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_3)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_3 and arg_26_1.time_ < 0 + var_29_3 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.characterEffect1059ui_story then
				arg_26_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_29_4 = 0
			local var_29_5 = 0.375

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(103071006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 15 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 15)

				if (15 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 15)) > 0 and var_29_5 < var_29_9 then
					arg_26_1.talkMaxDuration = var_29_9

					if var_29_9 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071006", "story_v_out_103071.awb") ~= 0 then
					local var_29_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071006", "story_v_out_103071.awb") / 1000

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end

					if var_29_6.prefab_name ~= "" and arg_26_1.actors_[var_29_6.prefab_name] ~= nil then
						local var_29_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_6.prefab_name].transform, "story_v_out_103071", "103071006", "story_v_out_103071.awb")

						arg_26_1:RecordAudio("103071006", var_29_11)
						arg_26_1:RecordAudio("103071006", var_29_11)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_103071", "103071006", "story_v_out_103071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_103071", "103071006", "story_v_out_103071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_12 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_12 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_12

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_12 and arg_26_1.time_ < var_29_4 + var_29_12 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play103071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 103071007
		arg_30_1.duration_ = 5.17

		local var_30_0 = {
			ja = 5.166,
			ko = 3.366,
			zh = 3.433,
			en = 4.566
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play103071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_3", "se_story_3_shoot", "")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_33_1 = 0
			local var_33_2 = 0.325

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:GetWordFromCfg(103071007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_6 = 12 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_4) / 12)

				if (12 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_4) / 12)) > 0 and var_33_2 < var_33_6 then
					arg_30_1.talkMaxDuration = var_33_6

					if var_33_6 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_6 + var_33_1
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071007", "story_v_out_103071.awb") ~= 0 then
					local var_33_7 = manager.audio:GetVoiceLength("story_v_out_103071", "103071007", "story_v_out_103071.awb") / 1000

					if var_33_7 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_1
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_103071", "103071007", "story_v_out_103071.awb")

						arg_30_1:RecordAudio("103071007", var_33_8)
						arg_30_1:RecordAudio("103071007", var_33_8)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_103071", "103071007", "story_v_out_103071.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_103071", "103071007", "story_v_out_103071.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_9 = math.max(var_33_2, arg_30_1.talkMaxDuration)

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_9 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_1) / var_33_9

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_1 + var_33_9 and arg_30_1.time_ < var_33_1 + var_33_9 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play103071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 103071008
		arg_34_1.duration_ = 2.23

		local var_34_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play103071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_37_0 = 0.600000023841858

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				local var_37_1, var_37_2 = math.modf((arg_34_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_37_2 * 0.13, var_37_2 * 0.13, var_37_2 * 0.13) + arg_34_1.var_.shakeOldPosMainCamera
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				manager.ui.mainCamera.transform.localPosition = arg_34_1.var_.shakeOldPosMainCamera
			end

			local var_37_3 = "1035ui_story"

			if arg_34_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_37_4 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_34_1.stage_.transform)

				var_37_4.name = var_37_3
				var_37_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_[var_37_3] = var_37_4

				local var_37_5 = var_37_4:GetComponentInChildren(typeof(CharacterEffect))

				var_37_5.enabled = true

				local var_37_6 = GameObjectTools.GetOrAddComponent(var_37_4, typeof(DynamicBoneHelper))

				if var_37_6 then
					var_37_6:EnableDynamicBone(false)
				end

				arg_34_1:ShowWeapon(var_37_5.transform, false)

				arg_34_1.var_[var_37_3 .. "Animator"] = var_37_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_34_1.var_[var_37_3 .. "Animator"].applyRootMotion = true
				arg_34_1.var_[var_37_3 .. "LipSync"] = var_37_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action3_1")
			end

			local var_37_7 = arg_34_1.actors_["1035ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1035ui_story = var_37_7.localPosition
			end

			local var_37_8 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_8 then
				var_37_7.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_34_1.time_ - 0) / var_37_8)
				var_37_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_7.position).x, (manager.ui.mainCamera.transform.position - var_37_7.position).y, (manager.ui.mainCamera.transform.position - var_37_7.position).z)
				var_37_7.localEulerAngles.z = 0
				var_37_7.localEulerAngles.x = 0
				var_37_7.localEulerAngles = var_37_7.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_8 and arg_34_1.time_ < 0 + var_37_8 + arg_37_0 then
				var_37_7.localPosition = Vector3.New(0, -1.05, -5.6)
				var_37_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_7.position).x, (manager.ui.mainCamera.transform.position - var_37_7.position).y, (manager.ui.mainCamera.transform.position - var_37_7.position).z)
				var_37_7.localEulerAngles.z = 0
				var_37_7.localEulerAngles.x = 0
				var_37_7.localEulerAngles = var_37_7.localEulerAngles
			end

			local var_37_9 = arg_34_1.actors_["1148ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1148ui_story = var_37_9.localPosition
			end

			local var_37_10 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_10 then
				var_37_9.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_10)
				var_37_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_9.position).x, (manager.ui.mainCamera.transform.position - var_37_9.position).y, (manager.ui.mainCamera.transform.position - var_37_9.position).z)
				var_37_9.localEulerAngles.z = 0
				var_37_9.localEulerAngles.x = 0
				var_37_9.localEulerAngles = var_37_9.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_10 and arg_34_1.time_ < 0 + var_37_10 + arg_37_0 then
				var_37_9.localPosition = Vector3.New(0, 100, 0)
				var_37_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_9.position).x, (manager.ui.mainCamera.transform.position - var_37_9.position).y, (manager.ui.mainCamera.transform.position - var_37_9.position).z)
				var_37_9.localEulerAngles.z = 0
				var_37_9.localEulerAngles.x = 0
				var_37_9.localEulerAngles = var_37_9.localEulerAngles
			end

			local var_37_11 = arg_34_1.actors_["1059ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1059ui_story = var_37_11.localPosition
			end

			local var_37_12 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_12 then
				var_37_11.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_12)
				var_37_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_11.position).x, (manager.ui.mainCamera.transform.position - var_37_11.position).y, (manager.ui.mainCamera.transform.position - var_37_11.position).z)
				var_37_11.localEulerAngles.z = 0
				var_37_11.localEulerAngles.x = 0
				var_37_11.localEulerAngles = var_37_11.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_12 and arg_34_1.time_ < 0 + var_37_12 + arg_37_0 then
				var_37_11.localPosition = Vector3.New(0, 100, 0)
				var_37_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_11.position).x, (manager.ui.mainCamera.transform.position - var_37_11.position).y, (manager.ui.mainCamera.transform.position - var_37_11.position).z)
				var_37_11.localEulerAngles.z = 0
				var_37_11.localEulerAngles.x = 0
				var_37_11.localEulerAngles = var_37_11.localEulerAngles
			end

			local var_37_13 = arg_34_1.actors_["1035ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_13) and arg_34_1.var_.characterEffect1035ui_story == nil then
				arg_34_1.var_.characterEffect1035ui_story = var_37_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_14 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_14 and not isNil(var_37_13) then
				if arg_34_1.var_.characterEffect1035ui_story and not isNil(var_37_13) then
					arg_34_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_14 and arg_34_1.time_ < 0 + var_37_14 + arg_37_0 and not isNil(var_37_13) and arg_34_1.var_.characterEffect1035ui_story then
				arg_34_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_37_16 = 0
			local var_37_17 = 0.125

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_16 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_18 = arg_34_1:GetWordFromCfg(103071008)
				local var_37_19 = arg_34_1:FormatText(var_37_18.content)

				arg_34_1.text_.text = var_37_19

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_21 = 5 <= 0 and var_37_17 or var_37_17 * (utf8.len(var_37_19) / 5)

				if (5 <= 0 and var_37_17 or var_37_17 * (utf8.len(var_37_19) / 5)) > 0 and var_37_17 < var_37_21 then
					arg_34_1.talkMaxDuration = var_37_21

					if var_37_21 + var_37_16 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_21 + var_37_16
					end
				end

				arg_34_1.text_.text = var_37_19
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071008", "story_v_out_103071.awb") ~= 0 then
					local var_37_22 = manager.audio:GetVoiceLength("story_v_out_103071", "103071008", "story_v_out_103071.awb") / 1000

					if var_37_22 + var_37_16 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_16
					end

					if var_37_18.prefab_name ~= "" and arg_34_1.actors_[var_37_18.prefab_name] ~= nil then
						local var_37_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_18.prefab_name].transform, "story_v_out_103071", "103071008", "story_v_out_103071.awb")

						arg_34_1:RecordAudio("103071008", var_37_23)
						arg_34_1:RecordAudio("103071008", var_37_23)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_103071", "103071008", "story_v_out_103071.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_103071", "103071008", "story_v_out_103071.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_24 = math.max(var_37_17, arg_34_1.talkMaxDuration)

			if var_37_16 <= arg_34_1.time_ and arg_34_1.time_ < var_37_16 + var_37_24 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_16) / var_37_24

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_16 + var_37_24 and arg_34_1.time_ < var_37_16 + var_37_24 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play103071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 103071009
		arg_38_1.duration_ = 10.47

		local var_38_0 = {
			ja = 10.466,
			ko = 7.933,
			zh = 7.266,
			en = 9.7
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play103071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1148ui_story"]) and arg_38_1.var_.characterEffect1148ui_story == nil then
				arg_38_1.var_.characterEffect1148ui_story = arg_38_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.1

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1148ui_story"]) then
				if arg_38_1.var_.characterEffect1148ui_story and not isNil(arg_38_1.actors_["1148ui_story"]) then
					arg_38_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1148ui_story"]) and arg_38_1.var_.characterEffect1148ui_story then
				arg_38_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action465")
			end

			local var_41_2 = arg_38_1.actors_["1035ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1035ui_story = var_41_2.localPosition
			end

			local var_41_3 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 then
				var_41_2.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_38_1.time_ - 0) / var_41_3)
				var_41_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_2.position).x, (manager.ui.mainCamera.transform.position - var_41_2.position).y, (manager.ui.mainCamera.transform.position - var_41_2.position).z)
				var_41_2.localEulerAngles.z = 0
				var_41_2.localEulerAngles.x = 0
				var_41_2.localEulerAngles = var_41_2.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 then
				var_41_2.localPosition = Vector3.New(0, 100, 0)
				var_41_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_2.position).x, (manager.ui.mainCamera.transform.position - var_41_2.position).y, (manager.ui.mainCamera.transform.position - var_41_2.position).z)
				var_41_2.localEulerAngles.z = 0
				var_41_2.localEulerAngles.x = 0
				var_41_2.localEulerAngles = var_41_2.localEulerAngles
			end

			local var_41_4 = arg_38_1.actors_["1148ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1148ui_story = var_41_4.localPosition
			end

			local var_41_5 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_5 then
				var_41_4.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_38_1.time_ - 0) / var_41_5)
				var_41_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_4.position).x, (manager.ui.mainCamera.transform.position - var_41_4.position).y, (manager.ui.mainCamera.transform.position - var_41_4.position).z)
				var_41_4.localEulerAngles.z = 0
				var_41_4.localEulerAngles.x = 0
				var_41_4.localEulerAngles = var_41_4.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_5 and arg_38_1.time_ < 0 + var_41_5 + arg_41_0 then
				var_41_4.localPosition = Vector3.New(0, -0.8, -6.2)
				var_41_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_4.position).x, (manager.ui.mainCamera.transform.position - var_41_4.position).y, (manager.ui.mainCamera.transform.position - var_41_4.position).z)
				var_41_4.localEulerAngles.z = 0
				var_41_4.localEulerAngles.x = 0
				var_41_4.localEulerAngles = var_41_4.localEulerAngles
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_41_6 = 0
			local var_41_7 = 0.875

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_8 = arg_38_1:GetWordFromCfg(103071009)
				local var_41_9 = arg_38_1:FormatText(var_41_8.content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 35 <= 0 and var_41_7 or var_41_7 * (utf8.len(var_41_9) / 35)

				if (35 <= 0 and var_41_7 or var_41_7 * (utf8.len(var_41_9) / 35)) > 0 and var_41_7 < var_41_11 then
					arg_38_1.talkMaxDuration = var_41_11

					if var_41_11 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071009", "story_v_out_103071.awb") ~= 0 then
					local var_41_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071009", "story_v_out_103071.awb") / 1000

					if var_41_12 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_6
					end

					if var_41_8.prefab_name ~= "" and arg_38_1.actors_[var_41_8.prefab_name] ~= nil then
						local var_41_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_8.prefab_name].transform, "story_v_out_103071", "103071009", "story_v_out_103071.awb")

						arg_38_1:RecordAudio("103071009", var_41_13)
						arg_38_1:RecordAudio("103071009", var_41_13)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_103071", "103071009", "story_v_out_103071.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_103071", "103071009", "story_v_out_103071.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play103071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 103071010
		arg_42_1.duration_ = 9.83

		local var_42_0 = {
			ja = 9.833,
			ko = 6.566,
			zh = 6.1,
			en = 7.866
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play103071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action457")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_45_0 = 0
			local var_45_1 = 0.575

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_2 = arg_42_1:GetWordFromCfg(103071010)
				local var_45_3 = arg_42_1:FormatText(var_45_2.content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 24 <= 0 and var_45_1 or var_45_1 * (utf8.len(var_45_3) / 24)

				if (24 <= 0 and var_45_1 or var_45_1 * (utf8.len(var_45_3) / 24)) > 0 and var_45_1 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071010", "story_v_out_103071.awb") ~= 0 then
					local var_45_6 = manager.audio:GetVoiceLength("story_v_out_103071", "103071010", "story_v_out_103071.awb") / 1000

					if var_45_6 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_6 + var_45_0
					end

					if var_45_2.prefab_name ~= "" and arg_42_1.actors_[var_45_2.prefab_name] ~= nil then
						local var_45_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_2.prefab_name].transform, "story_v_out_103071", "103071010", "story_v_out_103071.awb")

						arg_42_1:RecordAudio("103071010", var_45_7)
						arg_42_1:RecordAudio("103071010", var_45_7)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_103071", "103071010", "story_v_out_103071.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_103071", "103071010", "story_v_out_103071.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_8 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_8 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_8

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_8 and arg_42_1.time_ < var_45_0 + var_45_8 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play103071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 103071011
		arg_46_1.duration_ = 4.37

		local var_46_0 = {
			ja = 3.966,
			ko = 4.166,
			zh = 3.233,
			en = 4.366
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play103071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1035ui_story = arg_46_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_49_0 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 then
				arg_46_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_46_1.time_ - 0) / var_49_0)
				arg_46_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1035ui_story"].transform.position).z)
				arg_46_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1035ui_story"].transform.localEulerAngles = arg_46_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 then
				arg_46_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.6)
				arg_46_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1035ui_story"].transform.position).z)
				arg_46_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1035ui_story"].transform.localEulerAngles = arg_46_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_49_1 = arg_46_1.actors_["1148ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1148ui_story = var_49_1.localPosition
			end

			local var_49_2 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_2 then
				var_49_1.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_2)
				var_49_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_1.position).x, (manager.ui.mainCamera.transform.position - var_49_1.position).y, (manager.ui.mainCamera.transform.position - var_49_1.position).z)
				var_49_1.localEulerAngles.z = 0
				var_49_1.localEulerAngles.x = 0
				var_49_1.localEulerAngles = var_49_1.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_2 and arg_46_1.time_ < 0 + var_49_2 + arg_49_0 then
				var_49_1.localPosition = Vector3.New(0, 100, 0)
				var_49_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_1.position).x, (manager.ui.mainCamera.transform.position - var_49_1.position).y, (manager.ui.mainCamera.transform.position - var_49_1.position).z)
				var_49_1.localEulerAngles.z = 0
				var_49_1.localEulerAngles.x = 0
				var_49_1.localEulerAngles = var_49_1.localEulerAngles
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action6_1")
			end

			local var_49_3 = 0
			local var_49_4 = 0.375

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_3 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_5 = arg_46_1:GetWordFromCfg(103071011)
				local var_49_6 = arg_46_1:FormatText(var_49_5.content)

				arg_46_1.text_.text = var_49_6

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_8 = 15 <= 0 and var_49_4 or var_49_4 * (utf8.len(var_49_6) / 15)

				if (15 <= 0 and var_49_4 or var_49_4 * (utf8.len(var_49_6) / 15)) > 0 and var_49_4 < var_49_8 then
					arg_46_1.talkMaxDuration = var_49_8

					if var_49_8 + var_49_3 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_3
					end
				end

				arg_46_1.text_.text = var_49_6
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071011", "story_v_out_103071.awb") ~= 0 then
					local var_49_9 = manager.audio:GetVoiceLength("story_v_out_103071", "103071011", "story_v_out_103071.awb") / 1000

					if var_49_9 + var_49_3 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_9 + var_49_3
					end

					if var_49_5.prefab_name ~= "" and arg_46_1.actors_[var_49_5.prefab_name] ~= nil then
						local var_49_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_5.prefab_name].transform, "story_v_out_103071", "103071011", "story_v_out_103071.awb")

						arg_46_1:RecordAudio("103071011", var_49_10)
						arg_46_1:RecordAudio("103071011", var_49_10)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_103071", "103071011", "story_v_out_103071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_103071", "103071011", "story_v_out_103071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_11 = math.max(var_49_4, arg_46_1.talkMaxDuration)

			if var_49_3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_3 + var_49_11 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_3) / var_49_11

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_3 + var_49_11 and arg_46_1.time_ < var_49_3 + var_49_11 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play103071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 103071012
		arg_50_1.duration_ = 4.07

		local var_50_0 = {
			ja = 3,
			ko = 3,
			zh = 2.333,
			en = 4.066
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play103071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1148ui_story"]) and arg_50_1.var_.characterEffect1148ui_story == nil then
				arg_50_1.var_.characterEffect1148ui_story = arg_50_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1148ui_story"]) then
				if arg_50_1.var_.characterEffect1148ui_story and not isNil(arg_50_1.actors_["1148ui_story"]) then
					arg_50_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1148ui_story"]) and arg_50_1.var_.characterEffect1148ui_story then
				arg_50_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action472")
			end

			local var_53_2 = arg_50_1.actors_["1035ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1035ui_story = var_53_2.localPosition
			end

			local var_53_3 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_3)
				var_53_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_2.position).x, (manager.ui.mainCamera.transform.position - var_53_2.position).y, (manager.ui.mainCamera.transform.position - var_53_2.position).z)
				var_53_2.localEulerAngles.z = 0
				var_53_2.localEulerAngles.x = 0
				var_53_2.localEulerAngles = var_53_2.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(0, 100, 0)
				var_53_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_2.position).x, (manager.ui.mainCamera.transform.position - var_53_2.position).y, (manager.ui.mainCamera.transform.position - var_53_2.position).z)
				var_53_2.localEulerAngles.z = 0
				var_53_2.localEulerAngles.x = 0
				var_53_2.localEulerAngles = var_53_2.localEulerAngles
			end

			local var_53_4 = arg_50_1.actors_["1148ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1148ui_story = var_53_4.localPosition
			end

			local var_53_5 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_5 then
				var_53_4.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_50_1.time_ - 0) / var_53_5)
				var_53_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_4.position).x, (manager.ui.mainCamera.transform.position - var_53_4.position).y, (manager.ui.mainCamera.transform.position - var_53_4.position).z)
				var_53_4.localEulerAngles.z = 0
				var_53_4.localEulerAngles.x = 0
				var_53_4.localEulerAngles = var_53_4.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_5 and arg_50_1.time_ < 0 + var_53_5 + arg_53_0 then
				var_53_4.localPosition = Vector3.New(0, -0.8, -6.2)
				var_53_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_4.position).x, (manager.ui.mainCamera.transform.position - var_53_4.position).y, (manager.ui.mainCamera.transform.position - var_53_4.position).z)
				var_53_4.localEulerAngles.z = 0
				var_53_4.localEulerAngles.x = 0
				var_53_4.localEulerAngles = var_53_4.localEulerAngles
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_53_6 = 0
			local var_53_7 = 0.225

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_8 = arg_50_1:GetWordFromCfg(103071012)
				local var_53_9 = arg_50_1:FormatText(var_53_8.content)

				arg_50_1.text_.text = var_53_9

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 9 <= 0 and var_53_7 or var_53_7 * (utf8.len(var_53_9) / 9)

				if (9 <= 0 and var_53_7 or var_53_7 * (utf8.len(var_53_9) / 9)) > 0 and var_53_7 < var_53_11 then
					arg_50_1.talkMaxDuration = var_53_11

					if var_53_11 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_9
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071012", "story_v_out_103071.awb") ~= 0 then
					local var_53_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071012", "story_v_out_103071.awb") / 1000

					if var_53_12 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_12 + var_53_6
					end

					if var_53_8.prefab_name ~= "" and arg_50_1.actors_[var_53_8.prefab_name] ~= nil then
						local var_53_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_8.prefab_name].transform, "story_v_out_103071", "103071012", "story_v_out_103071.awb")

						arg_50_1:RecordAudio("103071012", var_53_13)
						arg_50_1:RecordAudio("103071012", var_53_13)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_103071", "103071012", "story_v_out_103071.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_103071", "103071012", "story_v_out_103071.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_14 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_14 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_14

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_14 and arg_50_1.time_ < var_53_6 + var_53_14 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play103071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 103071013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play103071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1148ui_story"]) and arg_54_1.var_.characterEffect1148ui_story == nil then
				arg_54_1.var_.characterEffect1148ui_story = arg_54_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1148ui_story"]) then
				if arg_54_1.var_.characterEffect1148ui_story and not isNil(arg_54_1.actors_["1148ui_story"]) then
					arg_54_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_0)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1148ui_story"]) and arg_54_1.var_.characterEffect1148ui_story then
				arg_54_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_57_1 = arg_54_1.actors_["1148ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1148ui_story = var_57_1.localPosition
			end

			local var_57_2 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 then
				var_57_1.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_54_1.time_ - 0) / var_57_2)
				var_57_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_1.position).x, (manager.ui.mainCamera.transform.position - var_57_1.position).y, (manager.ui.mainCamera.transform.position - var_57_1.position).z)
				var_57_1.localEulerAngles.z = 0
				var_57_1.localEulerAngles.x = 0
				var_57_1.localEulerAngles = var_57_1.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 then
				var_57_1.localPosition = Vector3.New(0, 100, 0)
				var_57_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_1.position).x, (manager.ui.mainCamera.transform.position - var_57_1.position).y, (manager.ui.mainCamera.transform.position - var_57_1.position).z)
				var_57_1.localEulerAngles.z = 0
				var_57_1.localEulerAngles.x = 0
				var_57_1.localEulerAngles = var_57_1.localEulerAngles
			end

			local var_57_3 = 0
			local var_57_4 = 0.625

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_3 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_5 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(103071013).content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 25 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_5) / 25)

				if (25 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_5) / 25)) > 0 and var_57_4 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_3 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_3
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_8 = math.max(var_57_4, arg_54_1.talkMaxDuration)

			if var_57_3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_3 + var_57_8 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_3) / var_57_8

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_3 + var_57_8 and arg_54_1.time_ < var_57_3 + var_57_8 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play103071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 103071014
		arg_58_1.duration_ = 4.4

		local var_58_0 = {
			ja = 4.4,
			ko = 2.866,
			zh = 3.166,
			en = 3.9
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
				arg_58_0:Play103071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_1")
			end

			local var_61_0 = arg_58_1.actors_["1035ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1035ui_story = var_61_0.localPosition
			end

			local var_61_1 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_1 then
				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_58_1.time_ - 0) / var_61_1)
				var_61_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_0.position).x, (manager.ui.mainCamera.transform.position - var_61_0.position).y, (manager.ui.mainCamera.transform.position - var_61_0.position).z)
				var_61_0.localEulerAngles.z = 0
				var_61_0.localEulerAngles.x = 0
				var_61_0.localEulerAngles = var_61_0.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_1 and arg_58_1.time_ < 0 + var_61_1 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0, -1.05, -5.6)
				var_61_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_0.position).x, (manager.ui.mainCamera.transform.position - var_61_0.position).y, (manager.ui.mainCamera.transform.position - var_61_0.position).z)
				var_61_0.localEulerAngles.z = 0
				var_61_0.localEulerAngles.x = 0
				var_61_0.localEulerAngles = var_61_0.localEulerAngles
			end

			local var_61_2 = 0
			local var_61_3 = 0.175

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_4 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_4:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_5 = arg_58_1:GetWordFromCfg(103071014)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_8 = 7 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_6) / 7)

				if (7 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_6) / 7)) > 0 and var_61_3 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8
					var_61_2 = var_61_2 + 0.3

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071014", "story_v_out_103071.awb") ~= 0 then
					local var_61_9 = manager.audio:GetVoiceLength("story_v_out_103071", "103071014", "story_v_out_103071.awb") / 1000

					if var_61_9 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_2
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_103071", "103071014", "story_v_out_103071.awb")

						arg_58_1:RecordAudio("103071014", var_61_10)
						arg_58_1:RecordAudio("103071014", var_61_10)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_103071", "103071014", "story_v_out_103071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_103071", "103071014", "story_v_out_103071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_11 = var_61_2 + 0.3
			local var_61_12 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_11) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_11 + var_61_12 and arg_58_1.time_ < var_61_11 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play103071015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 103071015
		arg_64_1.duration_ = 4.63

		local var_64_0 = {
			ja = 3.8,
			ko = 3.766,
			zh = 2.066,
			en = 4.633
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
				arg_64_0:Play103071016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action4_2")
			end

			local var_67_0 = 0
			local var_67_1 = 0.275

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_2 = arg_64_1:GetWordFromCfg(103071015)
				local var_67_3 = arg_64_1:FormatText(var_67_2.content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 11 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 11)

				if (11 <= 0 and var_67_1 or var_67_1 * (utf8.len(var_67_3) / 11)) > 0 and var_67_1 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071015", "story_v_out_103071.awb") ~= 0 then
					local var_67_6 = manager.audio:GetVoiceLength("story_v_out_103071", "103071015", "story_v_out_103071.awb") / 1000

					if var_67_6 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_0
					end

					if var_67_2.prefab_name ~= "" and arg_64_1.actors_[var_67_2.prefab_name] ~= nil then
						local var_67_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_2.prefab_name].transform, "story_v_out_103071", "103071015", "story_v_out_103071.awb")

						arg_64_1:RecordAudio("103071015", var_67_7)
						arg_64_1:RecordAudio("103071015", var_67_7)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_103071", "103071015", "story_v_out_103071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_103071", "103071015", "story_v_out_103071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_8 and arg_64_1.time_ < var_67_0 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play103071016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 103071016
		arg_68_1.duration_ = 9.47

		local var_68_0 = {
			ja = 9.466,
			ko = 8.033,
			zh = 6.733,
			en = 7.766
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
				arg_68_0:Play103071017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) and arg_68_1.var_.characterEffect1148ui_story == nil then
				arg_68_1.var_.characterEffect1148ui_story = arg_68_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) then
				if arg_68_1.var_.characterEffect1148ui_story and not isNil(arg_68_1.actors_["1148ui_story"]) then
					arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1148ui_story"]) and arg_68_1.var_.characterEffect1148ui_story then
				arg_68_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1148ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1148ui_story = var_71_2.localPosition
			end

			local var_71_3 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_68_1.time_ - 0) / var_71_3)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(0, -0.8, -6.2)
				var_71_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_2.position).x, (manager.ui.mainCamera.transform.position - var_71_2.position).y, (manager.ui.mainCamera.transform.position - var_71_2.position).z)
				var_71_2.localEulerAngles.z = 0
				var_71_2.localEulerAngles.x = 0
				var_71_2.localEulerAngles = var_71_2.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_71_4 = arg_68_1.actors_["1035ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1035ui_story = var_71_4.localPosition
			end

			local var_71_5 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_5 then
				var_71_4.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_5)
				var_71_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_4.position).x, (manager.ui.mainCamera.transform.position - var_71_4.position).y, (manager.ui.mainCamera.transform.position - var_71_4.position).z)
				var_71_4.localEulerAngles.z = 0
				var_71_4.localEulerAngles.x = 0
				var_71_4.localEulerAngles = var_71_4.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_5 and arg_68_1.time_ < 0 + var_71_5 + arg_71_0 then
				var_71_4.localPosition = Vector3.New(0, 100, 0)
				var_71_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_4.position).x, (manager.ui.mainCamera.transform.position - var_71_4.position).y, (manager.ui.mainCamera.transform.position - var_71_4.position).z)
				var_71_4.localEulerAngles.z = 0
				var_71_4.localEulerAngles.x = 0
				var_71_4.localEulerAngles = var_71_4.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_71_6 = 0
			local var_71_7 = 0.8

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:GetWordFromCfg(103071016)
				local var_71_9 = arg_68_1:FormatText(var_71_8.content)

				arg_68_1.text_.text = var_71_9

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 32 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_9) / 32)

				if (32 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_9) / 32)) > 0 and var_71_7 < var_71_11 then
					arg_68_1.talkMaxDuration = var_71_11

					if var_71_11 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_9
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071016", "story_v_out_103071.awb") ~= 0 then
					local var_71_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071016", "story_v_out_103071.awb") / 1000

					if var_71_12 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_12 + var_71_6
					end

					if var_71_8.prefab_name ~= "" and arg_68_1.actors_[var_71_8.prefab_name] ~= nil then
						local var_71_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_8.prefab_name].transform, "story_v_out_103071", "103071016", "story_v_out_103071.awb")

						arg_68_1:RecordAudio("103071016", var_71_13)
						arg_68_1:RecordAudio("103071016", var_71_13)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_103071", "103071016", "story_v_out_103071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_103071", "103071016", "story_v_out_103071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_14 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_14 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_14

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_14 and arg_68_1.time_ < var_71_6 + var_71_14 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play103071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 103071017
		arg_72_1.duration_ = 11.93

		local var_72_0 = {
			ja = 11.666,
			ko = 11.933,
			zh = 7.7,
			en = 10.466
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
				arg_72_0:Play103071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:AudioAction("play", "effect", "se_story_3", "se_story_3_snipe", "")
			end

			local var_75_1 = arg_72_1.actors_["1148ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1148ui_story = var_75_1.localPosition
			end

			local var_75_2 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 then
				var_75_1.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_2)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 then
				var_75_1.localPosition = Vector3.New(0, 100, 0)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			local var_75_3 = arg_72_1.actors_["1035ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1035ui_story = var_75_3.localPosition
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_72_1.time_ - 0) / var_75_4)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0, -1.05, -5.6)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action2_1")
			end

			if 1.5 < arg_72_1.time_ and arg_72_1.time_ <= 1.5 + arg_75_0 then
				arg_72_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action423")
			end

			local var_75_5 = manager.ui.mainCamera.transform

			if 1.025 < arg_72_1.time_ and arg_72_1.time_ <= 1.025 + arg_75_0 then
				arg_72_1.var_.shakeOldPos = var_75_5.localPosition
			end

			local var_75_6 = 0.4

			if 1.025 <= arg_72_1.time_ and arg_72_1.time_ < 1.025 + var_75_6 then
				local var_75_7, var_75_8 = math.modf((arg_72_1.time_ - 1.025) / 0.099)

				var_75_5.localPosition = Vector3.New(var_75_8 * 0.13, var_75_8 * 0.13, var_75_8 * 0.13) + arg_72_1.var_.shakeOldPos
			end

			if arg_72_1.time_ >= 1.025 + var_75_6 and arg_72_1.time_ < 1.025 + var_75_6 + arg_75_0 then
				var_75_5.localPosition = arg_72_1.var_.shakeOldPos
			end

			local var_75_9 = 0
			local var_75_10 = 1.025

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_11 = arg_72_1:GetWordFromCfg(103071017)
				local var_75_12 = arg_72_1:FormatText(var_75_11.content)

				arg_72_1.text_.text = var_75_12

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_14 = 41 <= 0 and var_75_10 or var_75_10 * (utf8.len(var_75_12) / 41)

				if (41 <= 0 and var_75_10 or var_75_10 * (utf8.len(var_75_12) / 41)) > 0 and var_75_10 < var_75_14 then
					arg_72_1.talkMaxDuration = var_75_14

					if var_75_14 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_9
					end
				end

				arg_72_1.text_.text = var_75_12
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071017", "story_v_out_103071.awb") ~= 0 then
					local var_75_15 = manager.audio:GetVoiceLength("story_v_out_103071", "103071017", "story_v_out_103071.awb") / 1000

					if var_75_15 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_9
					end

					if var_75_11.prefab_name ~= "" and arg_72_1.actors_[var_75_11.prefab_name] ~= nil then
						local var_75_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_11.prefab_name].transform, "story_v_out_103071", "103071017", "story_v_out_103071.awb")

						arg_72_1:RecordAudio("103071017", var_75_16)
						arg_72_1:RecordAudio("103071017", var_75_16)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_103071", "103071017", "story_v_out_103071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_103071", "103071017", "story_v_out_103071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_17 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_17 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_17

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_17 and arg_72_1.time_ < var_75_9 + var_75_17 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play103071018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 103071018
		arg_76_1.duration_ = 5.67

		local var_76_0 = {
			ja = 5.666,
			ko = 4.6,
			zh = 3.666,
			en = 4.933
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
				arg_76_0:Play103071019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1148ui_story"]) and arg_76_1.var_.characterEffect1148ui_story == nil then
				arg_76_1.var_.characterEffect1148ui_story = arg_76_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1148ui_story"]) then
				if arg_76_1.var_.characterEffect1148ui_story and not isNil(arg_76_1.actors_["1148ui_story"]) then
					arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1148ui_story"]) and arg_76_1.var_.characterEffect1148ui_story then
				arg_76_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action497")
			end

			local var_79_2 = arg_76_1.actors_["1148ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1148ui_story = var_79_2.localPosition
			end

			local var_79_3 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 then
				var_79_2.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_76_1.time_ - 0) / var_79_3)
				var_79_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_2.position).x, (manager.ui.mainCamera.transform.position - var_79_2.position).y, (manager.ui.mainCamera.transform.position - var_79_2.position).z)
				var_79_2.localEulerAngles.z = 0
				var_79_2.localEulerAngles.x = 0
				var_79_2.localEulerAngles = var_79_2.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 then
				var_79_2.localPosition = Vector3.New(0, -0.8, -6.2)
				var_79_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_2.position).x, (manager.ui.mainCamera.transform.position - var_79_2.position).y, (manager.ui.mainCamera.transform.position - var_79_2.position).z)
				var_79_2.localEulerAngles.z = 0
				var_79_2.localEulerAngles.x = 0
				var_79_2.localEulerAngles = var_79_2.localEulerAngles
			end

			local var_79_4 = arg_76_1.actors_["1035ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1035ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0, 100, 0)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_79_6 = 0
			local var_79_7 = 0.35

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(103071018)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 14 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 14)

				if (14 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 14)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071018", "story_v_out_103071.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071018", "story_v_out_103071.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_103071", "103071018", "story_v_out_103071.awb")

						arg_76_1:RecordAudio("103071018", var_79_13)
						arg_76_1:RecordAudio("103071018", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_103071", "103071018", "story_v_out_103071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_103071", "103071018", "story_v_out_103071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play103071019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 103071019
		arg_80_1.duration_ = 4.53

		local var_80_0 = {
			ja = 4.066,
			ko = 4.533,
			zh = 3.533,
			en = 2.733
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
				arg_80_0:Play103071020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1059ui_story"]) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = arg_80_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1059ui_story"]) then
				if arg_80_1.var_.characterEffect1059ui_story and not isNil(arg_80_1.actors_["1059ui_story"]) then
					arg_80_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1059ui_story"]) and arg_80_1.var_.characterEffect1059ui_story then
				arg_80_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1148ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1148ui_story == nil then
				arg_80_1.var_.characterEffect1148ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect1148ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1148ui_story then
				arg_80_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_83_4 = arg_80_1.actors_["1148ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1148ui_story = var_83_4.localPosition
			end

			local var_83_5 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 then
				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_80_1.time_ - 0) / var_83_5)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(0, -0.8, -6.2)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			local var_83_6 = arg_80_1.actors_["1148ui_story"].transform

			if 0.033 < arg_80_1.time_ and arg_80_1.time_ <= 0.033 + arg_83_0 then
				arg_80_1.var_.moveOldPos1148ui_story = var_83_6.localPosition
			end

			local var_83_7 = 0.5

			if 0.033 <= arg_80_1.time_ and arg_80_1.time_ < 0.033 + var_83_7 then
				var_83_6.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_80_1.time_ - 0.033) / var_83_7)
				var_83_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_6.position).x, (manager.ui.mainCamera.transform.position - var_83_6.position).y, (manager.ui.mainCamera.transform.position - var_83_6.position).z)
				var_83_6.localEulerAngles.z = 0
				var_83_6.localEulerAngles.x = 0
				var_83_6.localEulerAngles = var_83_6.localEulerAngles
			end

			if arg_80_1.time_ >= 0.033 + var_83_7 and arg_80_1.time_ < 0.033 + var_83_7 + arg_83_0 then
				var_83_6.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_83_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_6.position).x, (manager.ui.mainCamera.transform.position - var_83_6.position).y, (manager.ui.mainCamera.transform.position - var_83_6.position).z)
				var_83_6.localEulerAngles.z = 0
				var_83_6.localEulerAngles.x = 0
				var_83_6.localEulerAngles = var_83_6.localEulerAngles
			end

			local var_83_8 = arg_80_1.actors_["1059ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1059ui_story = var_83_8.localPosition
			end

			local var_83_9 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_9 then
				var_83_8.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_80_1.time_ - 0) / var_83_9)
				var_83_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_8.position).x, (manager.ui.mainCamera.transform.position - var_83_8.position).y, (manager.ui.mainCamera.transform.position - var_83_8.position).z)
				var_83_8.localEulerAngles.z = 0
				var_83_8.localEulerAngles.x = 0
				var_83_8.localEulerAngles = var_83_8.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_9 and arg_80_1.time_ < 0 + var_83_9 + arg_83_0 then
				var_83_8.localPosition = Vector3.New(0.7, -1.05, -6)
				var_83_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_8.position).x, (manager.ui.mainCamera.transform.position - var_83_8.position).y, (manager.ui.mainCamera.transform.position - var_83_8.position).z)
				var_83_8.localEulerAngles.z = 0
				var_83_8.localEulerAngles.x = 0
				var_83_8.localEulerAngles = var_83_8.localEulerAngles
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action7_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_83_10 = 0
			local var_83_11 = 0.375

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_12 = arg_80_1:GetWordFromCfg(103071019)
				local var_83_13 = arg_80_1:FormatText(var_83_12.content)

				arg_80_1.text_.text = var_83_13

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_15 = 15 <= 0 and var_83_11 or var_83_11 * (utf8.len(var_83_13) / 15)

				if (15 <= 0 and var_83_11 or var_83_11 * (utf8.len(var_83_13) / 15)) > 0 and var_83_11 < var_83_15 then
					arg_80_1.talkMaxDuration = var_83_15

					if var_83_15 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_15 + var_83_10
					end
				end

				arg_80_1.text_.text = var_83_13
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071019", "story_v_out_103071.awb") ~= 0 then
					local var_83_16 = manager.audio:GetVoiceLength("story_v_out_103071", "103071019", "story_v_out_103071.awb") / 1000

					if var_83_16 + var_83_10 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_16 + var_83_10
					end

					if var_83_12.prefab_name ~= "" and arg_80_1.actors_[var_83_12.prefab_name] ~= nil then
						local var_83_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_12.prefab_name].transform, "story_v_out_103071", "103071019", "story_v_out_103071.awb")

						arg_80_1:RecordAudio("103071019", var_83_17)
						arg_80_1:RecordAudio("103071019", var_83_17)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_103071", "103071019", "story_v_out_103071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_103071", "103071019", "story_v_out_103071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_18 = math.max(var_83_11, arg_80_1.talkMaxDuration)

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_18 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_10) / var_83_18

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_10 + var_83_18 and arg_80_1.time_ < var_83_10 + var_83_18 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play103071020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 103071020
		arg_84_1.duration_ = 9

		local var_84_0 = {
			ja = 9,
			ko = 7.1,
			zh = 5.9,
			en = 8.9
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
				arg_84_0:Play103071021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1148ui_story"]) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = arg_84_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1148ui_story"]) then
				if arg_84_1.var_.characterEffect1148ui_story and not isNil(arg_84_1.actors_["1148ui_story"]) then
					arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1148ui_story"]) and arg_84_1.var_.characterEffect1148ui_story then
				arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["1059ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1059ui_story == nil then
				arg_84_1.var_.characterEffect1059ui_story = var_87_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_3 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 and not isNil(var_87_2) then
				if arg_84_1.var_.characterEffect1059ui_story and not isNil(var_87_2) then
					arg_84_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_3)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 and not isNil(var_87_2) and arg_84_1.var_.characterEffect1059ui_story then
				arg_84_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action473")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_87_4 = 0
			local var_87_5 = 0.7

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(103071020)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 28 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 28)

				if (28 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 28)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071020", "story_v_out_103071.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071020", "story_v_out_103071.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_103071", "103071020", "story_v_out_103071.awb")

						arg_84_1:RecordAudio("103071020", var_87_11)
						arg_84_1:RecordAudio("103071020", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_103071", "103071020", "story_v_out_103071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_103071", "103071020", "story_v_out_103071.awb")
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
	Play103071021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 103071021
		arg_88_1.duration_ = 6.1

		local var_88_0 = {
			ja = 6.1,
			ko = 4.833,
			zh = 3.133,
			en = 3.833
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
				arg_88_0:Play103071022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1035ui_story = arg_88_1.actors_["1035ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1035ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1035ui_story"].transform.position).z)
				arg_88_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1035ui_story"].transform.localEulerAngles = arg_88_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1035ui_story"].transform.localPosition = Vector3.New(0, -1.05, -5.6)
				arg_88_1.actors_["1035ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1035ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1035ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1035ui_story"].transform.position).z)
				arg_88_1.actors_["1035ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1035ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1035ui_story"].transform.localEulerAngles = arg_88_1.actors_["1035ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1059ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1059ui_story = var_91_1.localPosition
			end

			local var_91_2 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 then
				var_91_1.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_2)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 then
				var_91_1.localPosition = Vector3.New(0, 100, 0)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			local var_91_3 = arg_88_1.actors_["1148ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1148ui_story = var_91_3.localPosition
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_3.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_4)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_3.localPosition = Vector3.New(0, 100, 0)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action11_1")
			end

			local var_91_5 = arg_88_1.actors_["1035ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1035ui_story == nil then
				arg_88_1.var_.characterEffect1035ui_story = var_91_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_6 and not isNil(var_91_5) then
				if arg_88_1.var_.characterEffect1035ui_story and not isNil(var_91_5) then
					arg_88_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_6 and arg_88_1.time_ < 0 + var_91_6 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1035ui_story then
				arg_88_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_91_8 = 0
			local var_91_9 = 0.375

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(103071021)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 15 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 15)

				if (15 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 15)) > 0 and var_91_9 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071021", "story_v_out_103071.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_103071", "103071021", "story_v_out_103071.awb") / 1000

					if var_91_14 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_8
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_103071", "103071021", "story_v_out_103071.awb")

						arg_88_1:RecordAudio("103071021", var_91_15)
						arg_88_1:RecordAudio("103071021", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_103071", "103071021", "story_v_out_103071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_103071", "103071021", "story_v_out_103071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_16 and arg_88_1.time_ < var_91_8 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play103071022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 103071022
		arg_92_1.duration_ = 6.6

		local var_92_0 = {
			ja = 6.6,
			ko = 5.266,
			zh = 4.2,
			en = 5.433
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
				arg_92_0:Play103071023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action442")
			end

			local var_95_0 = 0
			local var_95_1 = 0.475

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(103071022)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 19 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 19)

				if (19 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 19)) > 0 and var_95_1 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071022", "story_v_out_103071.awb") ~= 0 then
					local var_95_6 = manager.audio:GetVoiceLength("story_v_out_103071", "103071022", "story_v_out_103071.awb") / 1000

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end

					if var_95_2.prefab_name ~= "" and arg_92_1.actors_[var_95_2.prefab_name] ~= nil then
						local var_95_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_2.prefab_name].transform, "story_v_out_103071", "103071022", "story_v_out_103071.awb")

						arg_92_1:RecordAudio("103071022", var_95_7)
						arg_92_1:RecordAudio("103071022", var_95_7)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_103071", "103071022", "story_v_out_103071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_103071", "103071022", "story_v_out_103071.awb")
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
	Play103071023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 103071023
		arg_96_1.duration_ = 9.03

		local var_96_0 = {
			ja = 9.033,
			ko = 6.066,
			zh = 6.933,
			en = 6.133
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
				arg_96_0:Play103071024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action426")
			end

			if 1.5 < arg_96_1.time_ and arg_96_1.time_ <= 1.5 + arg_99_0 then
				arg_96_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action467")
			end

			local var_99_0 = 0
			local var_99_1 = 0.675

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_2 = arg_96_1:GetWordFromCfg(103071023)
				local var_99_3 = arg_96_1:FormatText(var_99_2.content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 27 <= 0 and var_99_1 or var_99_1 * (utf8.len(var_99_3) / 27)

				if (27 <= 0 and var_99_1 or var_99_1 * (utf8.len(var_99_3) / 27)) > 0 and var_99_1 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071023", "story_v_out_103071.awb") ~= 0 then
					local var_99_6 = manager.audio:GetVoiceLength("story_v_out_103071", "103071023", "story_v_out_103071.awb") / 1000

					if var_99_6 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_0
					end

					if var_99_2.prefab_name ~= "" and arg_96_1.actors_[var_99_2.prefab_name] ~= nil then
						local var_99_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_2.prefab_name].transform, "story_v_out_103071", "103071023", "story_v_out_103071.awb")

						arg_96_1:RecordAudio("103071023", var_99_7)
						arg_96_1:RecordAudio("103071023", var_99_7)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_103071", "103071023", "story_v_out_103071.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_103071", "103071023", "story_v_out_103071.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_8 and arg_96_1.time_ < var_99_0 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play103071024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 103071024
		arg_100_1.duration_ = 2.9

		local var_100_0 = {
			ja = 1.999999999999,
			ko = 2.533,
			zh = 1.999999999999,
			en = 2.9
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
				arg_100_0:Play103071025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) and arg_100_1.var_.characterEffect1148ui_story == nil then
				arg_100_1.var_.characterEffect1148ui_story = arg_100_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) then
				if arg_100_1.var_.characterEffect1148ui_story and not isNil(arg_100_1.actors_["1148ui_story"]) then
					arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1148ui_story"]) and arg_100_1.var_.characterEffect1148ui_story then
				arg_100_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["1148ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1148ui_story = var_103_2.localPosition
			end

			local var_103_3 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_100_1.time_ - 0) / var_103_3)
				var_103_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_2.position).x, (manager.ui.mainCamera.transform.position - var_103_2.position).y, (manager.ui.mainCamera.transform.position - var_103_2.position).z)
				var_103_2.localEulerAngles.z = 0
				var_103_2.localEulerAngles.x = 0
				var_103_2.localEulerAngles = var_103_2.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_103_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_2.position).x, (manager.ui.mainCamera.transform.position - var_103_2.position).y, (manager.ui.mainCamera.transform.position - var_103_2.position).z)
				var_103_2.localEulerAngles.z = 0
				var_103_2.localEulerAngles.x = 0
				var_103_2.localEulerAngles = var_103_2.localEulerAngles
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_103_4 = arg_100_1.actors_["1035ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1035ui_story = var_103_4.localPosition
			end

			local var_103_5 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_5 then
				var_103_4.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_5)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_5 and arg_100_1.time_ < 0 + var_103_5 + arg_103_0 then
				var_103_4.localPosition = Vector3.New(0, 100, 0)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_103_6 = 0
			local var_103_7 = 0.2

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_8 = arg_100_1:GetWordFromCfg(103071024)
				local var_103_9 = arg_100_1:FormatText(var_103_8.content)

				arg_100_1.text_.text = var_103_9

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 8 <= 0 and var_103_7 or var_103_7 * (utf8.len(var_103_9) / 8)

				if (8 <= 0 and var_103_7 or var_103_7 * (utf8.len(var_103_9) / 8)) > 0 and var_103_7 < var_103_11 then
					arg_100_1.talkMaxDuration = var_103_11

					if var_103_11 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_9
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071024", "story_v_out_103071.awb") ~= 0 then
					local var_103_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071024", "story_v_out_103071.awb") / 1000

					if var_103_12 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_12 + var_103_6
					end

					if var_103_8.prefab_name ~= "" and arg_100_1.actors_[var_103_8.prefab_name] ~= nil then
						local var_103_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_8.prefab_name].transform, "story_v_out_103071", "103071024", "story_v_out_103071.awb")

						arg_100_1:RecordAudio("103071024", var_103_13)
						arg_100_1:RecordAudio("103071024", var_103_13)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_103071", "103071024", "story_v_out_103071.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_103071", "103071024", "story_v_out_103071.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_14 and arg_100_1.time_ < var_103_6 + var_103_14 + arg_103_0 then
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

		arg_100_1:InitPlayNodeList()
	end,
	Play103071025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 103071025
		arg_104_1.duration_ = 2

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play103071026(arg_104_1)
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

			local var_107_2 = arg_104_1.actors_["1148ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1148ui_story then
				arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action1_1")
			end

			local var_107_4 = arg_104_1.actors_["1059ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1059ui_story = var_107_4.localPosition
			end

			local var_107_5 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 then
				var_107_4.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_104_1.time_ - 0) / var_107_5)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 then
				var_107_4.localPosition = Vector3.New(0.7, -1.05, -6)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_107_6 = 0
			local var_107_7 = 0.175

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
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

				local var_107_8 = arg_104_1:GetWordFromCfg(103071025)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 7 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 7)

				if (7 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 7)) > 0 and var_107_7 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071025", "story_v_out_103071.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071025", "story_v_out_103071.awb") / 1000

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_out_103071", "103071025", "story_v_out_103071.awb")

						arg_104_1:RecordAudio("103071025", var_107_13)
						arg_104_1:RecordAudio("103071025", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_103071", "103071025", "story_v_out_103071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_103071", "103071025", "story_v_out_103071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
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
	Play103071026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 103071026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play103071027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1059ui_story"]) and arg_108_1.var_.characterEffect1059ui_story == nil then
				arg_108_1.var_.characterEffect1059ui_story = arg_108_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1059ui_story"]) then
				if arg_108_1.var_.characterEffect1059ui_story and not isNil(arg_108_1.actors_["1059ui_story"]) then
					arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1059ui_story"]) and arg_108_1.var_.characterEffect1059ui_story then
				arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_111_1 = arg_108_1.actors_["1148ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1148ui_story = var_111_1.localPosition
			end

			local var_111_2 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 then
				var_111_1.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_2)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 then
				var_111_1.localPosition = Vector3.New(0, 100, 0)
				var_111_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_1.position).x, (manager.ui.mainCamera.transform.position - var_111_1.position).y, (manager.ui.mainCamera.transform.position - var_111_1.position).z)
				var_111_1.localEulerAngles.z = 0
				var_111_1.localEulerAngles.x = 0
				var_111_1.localEulerAngles = var_111_1.localEulerAngles
			end

			local var_111_3 = arg_108_1.actors_["1059ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1059ui_story = var_111_3.localPosition
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_3.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_4)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_3.localPosition = Vector3.New(0, 100, 0)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			local var_111_5 = 0
			local var_111_6 = 0.425

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				arg_108_1.dialog_:SetActive(true)

				arg_108_1.dialogCg_.alpha = 0

				local var_111_7 = LeanTween.value(arg_108_1.dialog_, 0, 1, 0.3)

				var_111_7:setOnUpdate(LuaHelper.FloatAction(function(arg_112_0)
					arg_108_1.dialogCg_.alpha = arg_112_0
				end))
				var_111_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_108_1.dialog_)
					var_111_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_108_1.duration_ = arg_108_1.duration_ + 0.3

				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(103071026).content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 17 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 17)

				if (17 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 17)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10
					var_111_5 = var_111_5 + 0.3

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_11 = var_111_5 + 0.3
			local var_111_12 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 + 0.3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_11) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_11 + var_111_12 and arg_108_1.time_ < var_111_11 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play103071027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 103071027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play103071028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = false

				arg_114_1:SetGaussion(false)
			end

			local var_117_0 = 0.5

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				local var_117_1 = Color.New(1, 1, 1)

				var_117_1.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.mask_.color = var_117_1
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				local var_117_2 = Color.New(1, 1, 1)

				arg_114_1.mask_.enabled = false
				var_117_2.a = 0
				arg_114_1.mask_.color = var_117_2
			end

			local var_117_3 = manager.ui.mainCamera.transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.shakeOldPosMainCamera = var_117_3.localPosition
			end

			local var_117_4 = 0.600000023841858

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				local var_117_5, var_117_6 = math.modf((arg_114_1.time_ - 0) / 0.066)

				var_117_3.localPosition = Vector3.New(var_117_6 * 0.13, var_117_6 * 0.13, var_117_6 * 0.13) + arg_114_1.var_.shakeOldPosMainCamera
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_3.localPosition = arg_114_1.var_.shakeOldPosMainCamera
			end

			local var_117_7 = 0
			local var_117_8 = 1.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_9 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(103071027).content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_11 = 53 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 53)

				if (53 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 53)) > 0 and var_117_8 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_7 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_7
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_8, arg_114_1.talkMaxDuration)

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_7) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_7 + var_117_12 and arg_114_1.time_ < var_117_7 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play103071028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 103071028
		arg_118_1.duration_ = 2

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play103071029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1059ui_story"]) and arg_118_1.var_.characterEffect1059ui_story == nil then
				arg_118_1.var_.characterEffect1059ui_story = arg_118_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1059ui_story"]) then
				if arg_118_1.var_.characterEffect1059ui_story and not isNil(arg_118_1.actors_["1059ui_story"]) then
					arg_118_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1059ui_story"]) and arg_118_1.var_.characterEffect1059ui_story then
				arg_118_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["1059ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1059ui_story = var_121_2.localPosition
			end

			local var_121_3 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 then
				var_121_2.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_118_1.time_ - 0) / var_121_3)
				var_121_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_2.position).x, (manager.ui.mainCamera.transform.position - var_121_2.position).y, (manager.ui.mainCamera.transform.position - var_121_2.position).z)
				var_121_2.localEulerAngles.z = 0
				var_121_2.localEulerAngles.x = 0
				var_121_2.localEulerAngles = var_121_2.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 then
				var_121_2.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_121_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_2.position).x, (manager.ui.mainCamera.transform.position - var_121_2.position).y, (manager.ui.mainCamera.transform.position - var_121_2.position).z)
				var_121_2.localEulerAngles.z = 0
				var_121_2.localEulerAngles.x = 0
				var_121_2.localEulerAngles = var_121_2.localEulerAngles
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.1

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(103071028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 4 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 4)

				if (4 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 4)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071028", "story_v_out_103071.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071028", "story_v_out_103071.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_103071", "103071028", "story_v_out_103071.awb")

						arg_118_1:RecordAudio("103071028", var_121_11)
						arg_118_1:RecordAudio("103071028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_103071", "103071028", "story_v_out_103071.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_103071", "103071028", "story_v_out_103071.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play103071029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 103071029
		arg_122_1.duration_ = 2

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play103071030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_1", "se_story_1_apollo_bow", "")
			end

			local var_125_1 = arg_122_1.actors_["1148ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1148ui_story == nil then
				arg_122_1.var_.characterEffect1148ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect1148ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1148ui_story then
				arg_122_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["1059ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1059ui_story == nil then
				arg_122_1.var_.characterEffect1059ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_5 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_5 and not isNil(var_125_4) then
				if arg_122_1.var_.characterEffect1059ui_story and not isNil(var_125_4) then
					arg_122_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_5)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_5 and arg_122_1.time_ < 0 + var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1059ui_story then
				arg_122_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_125_6 = arg_122_1.actors_["1148ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1148ui_story = var_125_6.localPosition
			end

			local var_125_7 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				var_125_6.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_122_1.time_ - 0) / var_125_7)
				var_125_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_6.position).x, (manager.ui.mainCamera.transform.position - var_125_6.position).y, (manager.ui.mainCamera.transform.position - var_125_6.position).z)
				var_125_6.localEulerAngles.z = 0
				var_125_6.localEulerAngles.x = 0
				var_125_6.localEulerAngles = var_125_6.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				var_125_6.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_125_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_6.position).x, (manager.ui.mainCamera.transform.position - var_125_6.position).y, (manager.ui.mainCamera.transform.position - var_125_6.position).z)
				var_125_6.localEulerAngles.z = 0
				var_125_6.localEulerAngles.x = 0
				var_125_6.localEulerAngles = var_125_6.localEulerAngles
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_125_8 = 0
			local var_125_9 = 0.125

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:GetWordFromCfg(103071029)
				local var_125_11 = arg_122_1:FormatText(var_125_10.content)

				arg_122_1.text_.text = var_125_11

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 5 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 5)

				if (5 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 5)) > 0 and var_125_9 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_11
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071029", "story_v_out_103071.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_103071", "103071029", "story_v_out_103071.awb") / 1000

					if var_125_14 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_8
					end

					if var_125_10.prefab_name ~= "" and arg_122_1.actors_[var_125_10.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_10.prefab_name].transform, "story_v_out_103071", "103071029", "story_v_out_103071.awb")

						arg_122_1:RecordAudio("103071029", var_125_15)
						arg_122_1:RecordAudio("103071029", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_103071", "103071029", "story_v_out_103071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_103071", "103071029", "story_v_out_103071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_16 and arg_122_1.time_ < var_125_8 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play103071030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 103071030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play103071031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1148ui_story"]) and arg_126_1.var_.characterEffect1148ui_story == nil then
				arg_126_1.var_.characterEffect1148ui_story = arg_126_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1148ui_story"]) then
				if arg_126_1.var_.characterEffect1148ui_story and not isNil(arg_126_1.actors_["1148ui_story"]) then
					arg_126_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1148ui_story"]) and arg_126_1.var_.characterEffect1148ui_story then
				arg_126_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_129_1 = arg_126_1.actors_["1059ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1059ui_story = var_129_1.localPosition
			end

			local var_129_2 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 then
				var_129_1.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_2)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 then
				var_129_1.localPosition = Vector3.New(0, 100, 0)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			local var_129_3 = arg_126_1.actors_["1148ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1148ui_story = var_129_3.localPosition
			end

			local var_129_4 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				var_129_3.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_4)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				var_129_3.localPosition = Vector3.New(0, 100, 0)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			local var_129_5 = 0
			local var_129_6 = 1.35

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_7 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_7:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_8 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(103071030).content)

				arg_126_1.text_.text = var_129_8

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_10 = 54 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 54)

				if (54 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 54)) > 0 and var_129_6 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10
					var_129_5 = var_129_5 + 0.3

					if var_129_10 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_8
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_11 = var_129_5 + 0.3
			local var_129_12 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_11 + var_129_12 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_11) / var_129_12

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_11 + var_129_12 and arg_126_1.time_ < var_129_11 + var_129_12 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play103071031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 103071031
		arg_132_1.duration_ = 4.8

		local var_132_0 = {
			ja = 3.4,
			ko = 4.8,
			zh = 3,
			en = 3.2
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
				arg_132_0:Play103071032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1148ui_story"]) and arg_132_1.var_.characterEffect1148ui_story == nil then
				arg_132_1.var_.characterEffect1148ui_story = arg_132_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1148ui_story"]) then
				if arg_132_1.var_.characterEffect1148ui_story and not isNil(arg_132_1.actors_["1148ui_story"]) then
					arg_132_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1148ui_story"]) and arg_132_1.var_.characterEffect1148ui_story then
				arg_132_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_135_2 = arg_132_1.actors_["1148ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1148ui_story = var_135_2.localPosition
			end

			local var_135_3 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 then
				var_135_2.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_3)
				var_135_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_2.position).x, (manager.ui.mainCamera.transform.position - var_135_2.position).y, (manager.ui.mainCamera.transform.position - var_135_2.position).z)
				var_135_2.localEulerAngles.z = 0
				var_135_2.localEulerAngles.x = 0
				var_135_2.localEulerAngles = var_135_2.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 then
				var_135_2.localPosition = Vector3.New(0, 100, 0)
				var_135_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_2.position).x, (manager.ui.mainCamera.transform.position - var_135_2.position).y, (manager.ui.mainCamera.transform.position - var_135_2.position).z)
				var_135_2.localEulerAngles.z = 0
				var_135_2.localEulerAngles.x = 0
				var_135_2.localEulerAngles = var_135_2.localEulerAngles
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action8_2")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_135_4 = 0
			local var_135_5 = 0.225

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
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

				local var_135_6 = arg_132_1:GetWordFromCfg(103071031)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 9 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 9)

				if (9 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 9)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071031", "story_v_out_103071.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071031", "story_v_out_103071.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_103071", "103071031", "story_v_out_103071.awb")

						arg_132_1:RecordAudio("103071031", var_135_11)
						arg_132_1:RecordAudio("103071031", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_103071", "103071031", "story_v_out_103071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_103071", "103071031", "story_v_out_103071.awb")
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

		arg_132_1.nodeConfigList_ = {
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

		arg_132_1:InitPlayNodeList()
	end,
	Play103071032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 103071032
		arg_136_1.duration_ = 8.7

		local var_136_0 = {
			ja = 8.7,
			ko = 4.3,
			zh = 6.6,
			en = 7.266
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
				arg_136_0:Play103071033(arg_136_1)
			end
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
				var_139_4.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_5)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 then
				var_139_4.localPosition = Vector3.New(0, 100, 0)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			local var_139_6 = arg_136_1.actors_["1059ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1059ui_story = var_139_6.localPosition
			end

			local var_139_7 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				var_139_6.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_136_1.time_ - 0) / var_139_7)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				var_139_6.localPosition = Vector3.New(0, -1.05, -6)
				var_139_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_6.position).x, (manager.ui.mainCamera.transform.position - var_139_6.position).y, (manager.ui.mainCamera.transform.position - var_139_6.position).z)
				var_139_6.localEulerAngles.z = 0
				var_139_6.localEulerAngles.x = 0
				var_139_6.localEulerAngles = var_139_6.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action6_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_139_8 = 0
			local var_139_9 = 0.725

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
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

				local var_139_10 = arg_136_1:GetWordFromCfg(103071032)
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

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071032", "story_v_out_103071.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_103071", "103071032", "story_v_out_103071.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_103071", "103071032", "story_v_out_103071.awb")

						arg_136_1:RecordAudio("103071032", var_139_15)
						arg_136_1:RecordAudio("103071032", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_103071", "103071032", "story_v_out_103071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_103071", "103071032", "story_v_out_103071.awb")
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

		arg_136_1:InitPlayNodeList()
	end,
	Play103071033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 103071033
		arg_140_1.duration_ = 10.17

		local var_140_0 = {
			ja = 10.166,
			ko = 5.766,
			zh = 5.733,
			en = 6.566
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
				arg_140_0:Play103071034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1148ui_story"]) and arg_140_1.var_.characterEffect1148ui_story == nil then
				arg_140_1.var_.characterEffect1148ui_story = arg_140_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1148ui_story"]) then
				if arg_140_1.var_.characterEffect1148ui_story and not isNil(arg_140_1.actors_["1148ui_story"]) then
					arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1148ui_story"]) and arg_140_1.var_.characterEffect1148ui_story then
				arg_140_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_143_2 = arg_140_1.actors_["1059ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1059ui_story == nil then
				arg_140_1.var_.characterEffect1059ui_story = var_143_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_3 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.characterEffect1059ui_story and not isNil(var_143_2) then
					arg_140_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_3)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.characterEffect1059ui_story then
				arg_140_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_143_4 = arg_140_1.actors_["1059ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1059ui_story = var_143_4.localPosition
			end

			local var_143_5 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_5 then
				var_143_4.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_140_1.time_ - 0) / var_143_5)
				var_143_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_4.position).x, (manager.ui.mainCamera.transform.position - var_143_4.position).y, (manager.ui.mainCamera.transform.position - var_143_4.position).z)
				var_143_4.localEulerAngles.z = 0
				var_143_4.localEulerAngles.x = 0
				var_143_4.localEulerAngles = var_143_4.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_5 and arg_140_1.time_ < 0 + var_143_5 + arg_143_0 then
				var_143_4.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_143_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_4.position).x, (manager.ui.mainCamera.transform.position - var_143_4.position).y, (manager.ui.mainCamera.transform.position - var_143_4.position).z)
				var_143_4.localEulerAngles.z = 0
				var_143_4.localEulerAngles.x = 0
				var_143_4.localEulerAngles = var_143_4.localEulerAngles
			end

			local var_143_6 = arg_140_1.actors_["1059ui_story"].transform

			if 0.033 < arg_140_1.time_ and arg_140_1.time_ <= 0.033 + arg_143_0 then
				arg_140_1.var_.moveOldPos1059ui_story = var_143_6.localPosition
			end

			local var_143_7 = 0.5

			if 0.033 <= arg_140_1.time_ and arg_140_1.time_ < 0.033 + var_143_7 then
				var_143_6.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_140_1.time_ - 0.033) / var_143_7)
				var_143_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_6.position).x, (manager.ui.mainCamera.transform.position - var_143_6.position).y, (manager.ui.mainCamera.transform.position - var_143_6.position).z)
				var_143_6.localEulerAngles.z = 0
				var_143_6.localEulerAngles.x = 0
				var_143_6.localEulerAngles = var_143_6.localEulerAngles
			end

			if arg_140_1.time_ >= 0.033 + var_143_7 and arg_140_1.time_ < 0.033 + var_143_7 + arg_143_0 then
				var_143_6.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_143_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_6.position).x, (manager.ui.mainCamera.transform.position - var_143_6.position).y, (manager.ui.mainCamera.transform.position - var_143_6.position).z)
				var_143_6.localEulerAngles.z = 0
				var_143_6.localEulerAngles.x = 0
				var_143_6.localEulerAngles = var_143_6.localEulerAngles
			end

			local var_143_8 = arg_140_1.actors_["1148ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1148ui_story = var_143_8.localPosition
			end

			local var_143_9 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_9 then
				var_143_8.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_140_1.time_ - 0) / var_143_9)
				var_143_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_8.position).x, (manager.ui.mainCamera.transform.position - var_143_8.position).y, (manager.ui.mainCamera.transform.position - var_143_8.position).z)
				var_143_8.localEulerAngles.z = 0
				var_143_8.localEulerAngles.x = 0
				var_143_8.localEulerAngles = var_143_8.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_9 and arg_140_1.time_ < 0 + var_143_9 + arg_143_0 then
				var_143_8.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_143_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_8.position).x, (manager.ui.mainCamera.transform.position - var_143_8.position).y, (manager.ui.mainCamera.transform.position - var_143_8.position).z)
				var_143_8.localEulerAngles.z = 0
				var_143_8.localEulerAngles.x = 0
				var_143_8.localEulerAngles = var_143_8.localEulerAngles
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_143_10 = 0
			local var_143_11 = 0.8

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_12 = arg_140_1:GetWordFromCfg(103071033)
				local var_143_13 = arg_140_1:FormatText(var_143_12.content)

				arg_140_1.text_.text = var_143_13

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_15 = 32 <= 0 and var_143_11 or var_143_11 * (utf8.len(var_143_13) / 32)

				if (32 <= 0 and var_143_11 or var_143_11 * (utf8.len(var_143_13) / 32)) > 0 and var_143_11 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_10 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_10
					end
				end

				arg_140_1.text_.text = var_143_13
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071033", "story_v_out_103071.awb") ~= 0 then
					local var_143_16 = manager.audio:GetVoiceLength("story_v_out_103071", "103071033", "story_v_out_103071.awb") / 1000

					if var_143_16 + var_143_10 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_16 + var_143_10
					end

					if var_143_12.prefab_name ~= "" and arg_140_1.actors_[var_143_12.prefab_name] ~= nil then
						local var_143_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_12.prefab_name].transform, "story_v_out_103071", "103071033", "story_v_out_103071.awb")

						arg_140_1:RecordAudio("103071033", var_143_17)
						arg_140_1:RecordAudio("103071033", var_143_17)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_103071", "103071033", "story_v_out_103071.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_103071", "103071033", "story_v_out_103071.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_18 = math.max(var_143_11, arg_140_1.talkMaxDuration)

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_18 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_10) / var_143_18

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_10 + var_143_18 and arg_140_1.time_ < var_143_10 + var_143_18 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
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

		arg_140_1:InitPlayNodeList()
	end,
	Play103071034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 103071034
		arg_144_1.duration_ = 10.5

		local var_144_0 = {
			ja = 10.5,
			ko = 8.733,
			zh = 7.5,
			en = 8.2
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
				arg_144_0:Play103071035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1059ui_story"]) and arg_144_1.var_.characterEffect1059ui_story == nil then
				arg_144_1.var_.characterEffect1059ui_story = arg_144_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1059ui_story"]) then
				if arg_144_1.var_.characterEffect1059ui_story and not isNil(arg_144_1.actors_["1059ui_story"]) then
					arg_144_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1059ui_story"]) and arg_144_1.var_.characterEffect1059ui_story then
				arg_144_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_147_2 = arg_144_1.actors_["1148ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1148ui_story == nil then
				arg_144_1.var_.characterEffect1148ui_story = var_147_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_3 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.characterEffect1148ui_story and not isNil(var_147_2) then
					arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_3)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1148ui_story then
				arg_144_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action464")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_147_4 = 0
			local var_147_5 = 0.925

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(103071034)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 37 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 37)

				if (37 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 37)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071034", "story_v_out_103071.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_103071", "103071034", "story_v_out_103071.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_103071", "103071034", "story_v_out_103071.awb")

						arg_144_1:RecordAudio("103071034", var_147_11)
						arg_144_1:RecordAudio("103071034", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_103071", "103071034", "story_v_out_103071.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_103071", "103071034", "story_v_out_103071.awb")
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
	Play103071035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 103071035
		arg_148_1.duration_ = 8.37

		local var_148_0 = {
			ja = 8.366,
			ko = 7.166,
			zh = 7.4,
			en = 6.8
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
				arg_148_0:Play103071036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1035ui_story"]) and arg_148_1.var_.characterEffect1035ui_story == nil then
				arg_148_1.var_.characterEffect1035ui_story = arg_148_1.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1035ui_story"]) then
				if arg_148_1.var_.characterEffect1035ui_story and not isNil(arg_148_1.actors_["1035ui_story"]) then
					arg_148_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1035ui_story"]) and arg_148_1.var_.characterEffect1035ui_story then
				arg_148_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			local var_151_2 = arg_148_1.actors_["1059ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1059ui_story = var_151_2.localPosition
			end

			local var_151_3 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_3)
				var_151_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_2.position).x, (manager.ui.mainCamera.transform.position - var_151_2.position).y, (manager.ui.mainCamera.transform.position - var_151_2.position).z)
				var_151_2.localEulerAngles.z = 0
				var_151_2.localEulerAngles.x = 0
				var_151_2.localEulerAngles = var_151_2.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(0, 100, 0)
				var_151_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_2.position).x, (manager.ui.mainCamera.transform.position - var_151_2.position).y, (manager.ui.mainCamera.transform.position - var_151_2.position).z)
				var_151_2.localEulerAngles.z = 0
				var_151_2.localEulerAngles.x = 0
				var_151_2.localEulerAngles = var_151_2.localEulerAngles
			end

			local var_151_4 = arg_148_1.actors_["1148ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1148ui_story = var_151_4.localPosition
			end

			local var_151_5 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 then
				var_151_4.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_5)
				var_151_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_4.position).x, (manager.ui.mainCamera.transform.position - var_151_4.position).y, (manager.ui.mainCamera.transform.position - var_151_4.position).z)
				var_151_4.localEulerAngles.z = 0
				var_151_4.localEulerAngles.x = 0
				var_151_4.localEulerAngles = var_151_4.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 then
				var_151_4.localPosition = Vector3.New(0, 100, 0)
				var_151_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_4.position).x, (manager.ui.mainCamera.transform.position - var_151_4.position).y, (manager.ui.mainCamera.transform.position - var_151_4.position).z)
				var_151_4.localEulerAngles.z = 0
				var_151_4.localEulerAngles.x = 0
				var_151_4.localEulerAngles = var_151_4.localEulerAngles
			end

			local var_151_6 = arg_148_1.actors_["1035ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1035ui_story = var_151_6.localPosition
			end

			local var_151_7 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				var_151_6.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1035ui_story, Vector3.New(0, -1.05, -5.6), (arg_148_1.time_ - 0) / var_151_7)
				var_151_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_6.position).x, (manager.ui.mainCamera.transform.position - var_151_6.position).y, (manager.ui.mainCamera.transform.position - var_151_6.position).z)
				var_151_6.localEulerAngles.z = 0
				var_151_6.localEulerAngles.x = 0
				var_151_6.localEulerAngles = var_151_6.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				var_151_6.localPosition = Vector3.New(0, -1.05, -5.6)
				var_151_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_6.position).x, (manager.ui.mainCamera.transform.position - var_151_6.position).y, (manager.ui.mainCamera.transform.position - var_151_6.position).z)
				var_151_6.localEulerAngles.z = 0
				var_151_6.localEulerAngles.x = 0
				var_151_6.localEulerAngles = var_151_6.localEulerAngles
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action8_1")
			end

			local var_151_8 = 0
			local var_151_9 = 0.825

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_10 = arg_148_1:GetWordFromCfg(103071035)
				local var_151_11 = arg_148_1:FormatText(var_151_10.content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 33 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 33)

				if (33 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 33)) > 0 and var_151_9 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071035", "story_v_out_103071.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_103071", "103071035", "story_v_out_103071.awb") / 1000

					if var_151_14 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_8
					end

					if var_151_10.prefab_name ~= "" and arg_148_1.actors_[var_151_10.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_10.prefab_name].transform, "story_v_out_103071", "103071035", "story_v_out_103071.awb")

						arg_148_1:RecordAudio("103071035", var_151_15)
						arg_148_1:RecordAudio("103071035", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_103071", "103071035", "story_v_out_103071.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_103071", "103071035", "story_v_out_103071.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_16 and arg_148_1.time_ < var_151_8 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play103071036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 103071036
		arg_152_1.duration_ = 6

		local var_152_0 = {
			ja = 6,
			ko = 3.866,
			zh = 3.866,
			en = 4.4
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
				arg_152_0:Play103071037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1059ui_story"]) and arg_152_1.var_.characterEffect1059ui_story == nil then
				arg_152_1.var_.characterEffect1059ui_story = arg_152_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1059ui_story"]) then
				if arg_152_1.var_.characterEffect1059ui_story and not isNil(arg_152_1.actors_["1059ui_story"]) then
					arg_152_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1059ui_story"]) and arg_152_1.var_.characterEffect1059ui_story then
				arg_152_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_155_2 = arg_152_1.actors_["1059ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1059ui_story = var_155_2.localPosition
			end

			local var_155_3 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_152_1.time_ - 0) / var_155_3)
				var_155_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_2.position).x, (manager.ui.mainCamera.transform.position - var_155_2.position).y, (manager.ui.mainCamera.transform.position - var_155_2.position).z)
				var_155_2.localEulerAngles.z = 0
				var_155_2.localEulerAngles.x = 0
				var_155_2.localEulerAngles = var_155_2.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(0, -1.05, -6)
				var_155_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_2.position).x, (manager.ui.mainCamera.transform.position - var_155_2.position).y, (manager.ui.mainCamera.transform.position - var_155_2.position).z)
				var_155_2.localEulerAngles.z = 0
				var_155_2.localEulerAngles.x = 0
				var_155_2.localEulerAngles = var_155_2.localEulerAngles
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_155_4 = arg_152_1.actors_["1035ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1035ui_story = var_155_4.localPosition
			end

			local var_155_5 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 then
				var_155_4.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_5)
				var_155_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_4.position).x, (manager.ui.mainCamera.transform.position - var_155_4.position).y, (manager.ui.mainCamera.transform.position - var_155_4.position).z)
				var_155_4.localEulerAngles.z = 0
				var_155_4.localEulerAngles.x = 0
				var_155_4.localEulerAngles = var_155_4.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 then
				var_155_4.localPosition = Vector3.New(0, 100, 0)
				var_155_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_4.position).x, (manager.ui.mainCamera.transform.position - var_155_4.position).y, (manager.ui.mainCamera.transform.position - var_155_4.position).z)
				var_155_4.localEulerAngles.z = 0
				var_155_4.localEulerAngles.x = 0
				var_155_4.localEulerAngles = var_155_4.localEulerAngles
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_155_6 = 0
			local var_155_7 = 0.45

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:GetWordFromCfg(103071036)
				local var_155_9 = arg_152_1:FormatText(var_155_8.content)

				arg_152_1.text_.text = var_155_9

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 18 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 18)

				if (18 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 18)) > 0 and var_155_7 < var_155_11 then
					arg_152_1.talkMaxDuration = var_155_11

					if var_155_11 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_9
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071036", "story_v_out_103071.awb") ~= 0 then
					local var_155_12 = manager.audio:GetVoiceLength("story_v_out_103071", "103071036", "story_v_out_103071.awb") / 1000

					if var_155_12 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_6
					end

					if var_155_8.prefab_name ~= "" and arg_152_1.actors_[var_155_8.prefab_name] ~= nil then
						local var_155_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_8.prefab_name].transform, "story_v_out_103071", "103071036", "story_v_out_103071.awb")

						arg_152_1:RecordAudio("103071036", var_155_13)
						arg_152_1:RecordAudio("103071036", var_155_13)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_103071", "103071036", "story_v_out_103071.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_103071", "103071036", "story_v_out_103071.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play103071037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 103071037
		arg_156_1.duration_ = 4

		local var_156_0 = {
			ja = 4,
			ko = 2.833,
			zh = 2.866,
			en = 2.566
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
			arg_156_1.auto_ = false
		end

		function arg_156_1.playNext_(arg_158_0)
			arg_156_1.onStoryFinished_()
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action423")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_159_0 = 0
			local var_159_1 = 0.225

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(103071037)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 9 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 9)

				if (9 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 9)) > 0 and var_159_1 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103071", "103071037", "story_v_out_103071.awb") ~= 0 then
					local var_159_6 = manager.audio:GetVoiceLength("story_v_out_103071", "103071037", "story_v_out_103071.awb") / 1000

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end

					if var_159_2.prefab_name ~= "" and arg_156_1.actors_[var_159_2.prefab_name] ~= nil then
						local var_159_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_2.prefab_name].transform, "story_v_out_103071", "103071037", "story_v_out_103071.awb")

						arg_156_1:RecordAudio("103071037", var_159_7)
						arg_156_1:RecordAudio("103071037", var_159_7)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_103071", "103071037", "story_v_out_103071.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_103071", "103071037", "story_v_out_103071.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06b"
	},
	voices = {
		"story_v_out_103071.awb"
	}
}
