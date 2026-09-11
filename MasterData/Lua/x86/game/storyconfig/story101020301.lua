return {
	Play102031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_1 = "B03b"

			if arg_1_1.bgs_.B03b == nil then
				local var_4_2 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_1)
				var_4_2.name = var_4_1
				var_4_2.transform.parent = arg_1_1.stage_.transform
				var_4_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_1] = var_4_2
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_3 = arg_1_1.bgs_.B03b:GetComponent("SpriteRenderer")

				if var_4_3 then
					arg_1_1.var_.alphaOldValueB03b = var_4_3.color.a
					arg_1_1.var_.alphaMatValueB03b = var_4_3
				end

				arg_1_1.var_.alphaOldValueB03b = 0
			end

			local var_4_4 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_4 then
				if arg_1_1.var_.alphaMatValueB03b then
					arg_1_1.var_.alphaMatValueB03b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB03b, 1, (arg_1_1.time_ - 0) / var_4_4)
					arg_1_1.var_.alphaMatValueB03b.color = arg_1_1.var_.alphaMatValueB03b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_4 and arg_1_1.time_ < 0 + var_4_4 + arg_4_0 and arg_1_1.var_.alphaMatValueB03b then
				arg_1_1.var_.alphaMatValueB03b.color.a = 1
				arg_1_1.var_.alphaMatValueB03b.color = arg_1_1.var_.alphaMatValueB03b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.B03b

				arg_1_1.bgs_.B03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_8 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_8 + 2 and arg_1_1.time_ < var_4_8 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 1.16666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.16666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme")

				local var_4_14 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102031001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 15 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 15)

				if (15 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 15)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play102031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 102031002
		arg_9_1.duration_ = 4.97

		local var_9_0 = {
			ja = 4.966,
			ko = 3.1,
			zh = 3.166,
			en = 2.5
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
				arg_9_0:Play102031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "4010ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["4010ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["4010ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["4010ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["4010ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect4010ui_story == nil then
				arg_9_1.var_.characterEffect4010ui_story = var_12_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_4 = 0.1

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 and not isNil(var_12_3) then
				if arg_9_1.var_.characterEffect4010ui_story and not isNil(var_12_3) then
					arg_9_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect4010ui_story then
				arg_9_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_12_6 = arg_9_1.actors_["4010ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos4010ui_story = var_12_6.localPosition
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_6.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_9_1.time_ - 0) / var_12_7)
				var_12_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_6.position).x, (manager.ui.mainCamera.transform.position - var_12_6.position).y, (manager.ui.mainCamera.transform.position - var_12_6.position).z)
				var_12_6.localEulerAngles.z = 0
				var_12_6.localEulerAngles.x = 0
				var_12_6.localEulerAngles = var_12_6.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_6.localPosition = Vector3.New(0, -1.59, -5.2)
				var_12_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_6.position).x, (manager.ui.mainCamera.transform.position - var_12_6.position).y, (manager.ui.mainCamera.transform.position - var_12_6.position).z)
				var_12_6.localEulerAngles.z = 0
				var_12_6.localEulerAngles.x = 0
				var_12_6.localEulerAngles = var_12_6.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(102031002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 12 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 12)

				if (12 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 12)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031002", "story_v_out_102031.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_102031", "102031002", "story_v_out_102031.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_102031", "102031002", "story_v_out_102031.awb")

						arg_9_1:RecordAudio("102031002", var_12_15)
						arg_9_1:RecordAudio("102031002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_102031", "102031002", "story_v_out_102031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_102031", "102031002", "story_v_out_102031.awb")
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play102031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 102031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play102031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos4010ui_story = arg_13_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["4010ui_story"].transform.position).z)
				arg_13_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["4010ui_story"].transform.localEulerAngles = arg_13_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["4010ui_story"].transform.position).z)
				arg_13_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["4010ui_story"].transform.localEulerAngles = arg_13_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_16_1 = 0
			local var_16_2 = 0.675

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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(102031003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 27 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 27)

				if (27 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 27)) > 0 and var_16_2 < var_16_5 then
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

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play102031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 102031004
		arg_17_1.duration_ = 6.1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play102031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0.5 < arg_17_1.time_ and arg_17_1.time_ <= 0.5 + arg_20_0 then
				arg_17_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_20_0 = 0.6

			if 0.5 <= arg_17_1.time_ and arg_17_1.time_ < 0.5 + var_20_0 then
				local var_20_1, var_20_2 = math.modf((arg_17_1.time_ - 0.5) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_20_2 * 0.13, var_20_2 * 0.13, var_20_2 * 0.13) + arg_17_1.var_.shakeOldPos
			end

			if arg_17_1.time_ >= 0.5 + var_20_0 and arg_17_1.time_ < 0.5 + var_20_0 + arg_20_0 then
				manager.ui.mainCamera.transform.localPosition = arg_17_1.var_.shakeOldPos
			end

			local var_20_3 = 0.733333333333333

			if 0.733333333333333 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_3 + 0.366666666666667 and arg_17_1.time_ < var_20_3 + 0.366666666666667 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_4 = 1.1
			local var_20_5 = 0.95

			if 1.1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_6 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_6:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(102031004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 38 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 38)

				if (38 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 38)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9
					var_20_4 = var_20_4 + 0.3

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = var_20_4 + 0.3
			local var_20_11 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play102031005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 102031005
		arg_23_1.duration_ = 10.5

		local var_23_0 = {
			ja = 10.5,
			ko = 8.433,
			zh = 6.666,
			en = 6.533
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play102031006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["4010ui_story"]) and arg_23_1.var_.characterEffect4010ui_story == nil then
				arg_23_1.var_.characterEffect4010ui_story = arg_23_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.1

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["4010ui_story"]) then
				if arg_23_1.var_.characterEffect4010ui_story and not isNil(arg_23_1.actors_["4010ui_story"]) then
					arg_23_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["4010ui_story"]) and arg_23_1.var_.characterEffect4010ui_story then
				arg_23_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_26_2 = arg_23_1.actors_["4010ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos4010ui_story = var_26_2.localPosition
			end

			local var_26_3 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 then
				var_26_2.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_23_1.time_ - 0) / var_26_3)
				var_26_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_2.position).x, (manager.ui.mainCamera.transform.position - var_26_2.position).y, (manager.ui.mainCamera.transform.position - var_26_2.position).z)
				var_26_2.localEulerAngles.z = 0
				var_26_2.localEulerAngles.x = 0
				var_26_2.localEulerAngles = var_26_2.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 then
				var_26_2.localPosition = Vector3.New(0, -1.59, -5.2)
				var_26_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_2.position).x, (manager.ui.mainCamera.transform.position - var_26_2.position).y, (manager.ui.mainCamera.transform.position - var_26_2.position).z)
				var_26_2.localEulerAngles.z = 0
				var_26_2.localEulerAngles.x = 0
				var_26_2.localEulerAngles = var_26_2.localEulerAngles
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_26_4 = 0
			local var_26_5 = 0.775

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_6 = arg_23_1:GetWordFromCfg(102031005)
				local var_26_7 = arg_23_1:FormatText(var_26_6.content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 31 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 31)

				if (31 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 31)) > 0 and var_26_5 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031005", "story_v_out_102031.awb") ~= 0 then
					local var_26_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031005", "story_v_out_102031.awb") / 1000

					if var_26_10 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_4
					end

					if var_26_6.prefab_name ~= "" and arg_23_1.actors_[var_26_6.prefab_name] ~= nil then
						local var_26_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_6.prefab_name].transform, "story_v_out_102031", "102031005", "story_v_out_102031.awb")

						arg_23_1:RecordAudio("102031005", var_26_11)
						arg_23_1:RecordAudio("102031005", var_26_11)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_102031", "102031005", "story_v_out_102031.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_102031", "102031005", "story_v_out_102031.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_12 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_12

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_12 and arg_23_1.time_ < var_26_4 + var_26_12 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play102031006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 102031006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play102031007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "3009ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["3009ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["3009ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["3009ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["3009ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_3) and arg_27_1.var_.characterEffect3009ui_story == nil then
				arg_27_1.var_.characterEffect3009ui_story = var_30_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_4 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 and not isNil(var_30_3) then
				if arg_27_1.var_.characterEffect3009ui_story and not isNil(var_30_3) then
					arg_27_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_27_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_4)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 and not isNil(var_30_3) and arg_27_1.var_.characterEffect3009ui_story then
				arg_27_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_27_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_30_5 = arg_27_1.actors_["4010ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos4010ui_story = var_30_5.localPosition
			end

			local var_30_6 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 then
				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_6)
				var_30_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_5.position).x, (manager.ui.mainCamera.transform.position - var_30_5.position).y, (manager.ui.mainCamera.transform.position - var_30_5.position).z)
				var_30_5.localEulerAngles.z = 0
				var_30_5.localEulerAngles.x = 0
				var_30_5.localEulerAngles = var_30_5.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(0, 100, 0)
				var_30_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_5.position).x, (manager.ui.mainCamera.transform.position - var_30_5.position).y, (manager.ui.mainCamera.transform.position - var_30_5.position).z)
				var_30_5.localEulerAngles.z = 0
				var_30_5.localEulerAngles.x = 0
				var_30_5.localEulerAngles = var_30_5.localEulerAngles
			end

			local var_30_7 = arg_27_1.actors_["3009ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos3009ui_story = var_30_7.localPosition
			end

			local var_30_8 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_8 then
				var_30_7.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos3009ui_story, Vector3.New(0, -1.75, -4.8), (arg_27_1.time_ - 0) / var_30_8)
				var_30_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_7.position).x, (manager.ui.mainCamera.transform.position - var_30_7.position).y, (manager.ui.mainCamera.transform.position - var_30_7.position).z)
				var_30_7.localEulerAngles.z = 0
				var_30_7.localEulerAngles.x = 0
				var_30_7.localEulerAngles = var_30_7.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_8 and arg_27_1.time_ < 0 + var_30_8 + arg_30_0 then
				var_30_7.localPosition = Vector3.New(0, -1.75, -4.8)
				var_30_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_7.position).x, (manager.ui.mainCamera.transform.position - var_30_7.position).y, (manager.ui.mainCamera.transform.position - var_30_7.position).z)
				var_30_7.localEulerAngles.z = 0
				var_30_7.localEulerAngles.x = 0
				var_30_7.localEulerAngles = var_30_7.localEulerAngles
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_30_9 = 0
			local var_30_10 = 0.575

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_11 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(102031006).content)

				arg_27_1.text_.text = var_30_11

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 23 <= 0 and var_30_10 or var_30_10 * (utf8.len(var_30_11) / 23)

				if (23 <= 0 and var_30_10 or var_30_10 * (utf8.len(var_30_11) / 23)) > 0 and var_30_10 < var_30_13 then
					arg_27_1.talkMaxDuration = var_30_13

					if var_30_13 + var_30_9 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_13 + var_30_9
					end
				end

				arg_27_1.text_.text = var_30_11
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_10, arg_27_1.talkMaxDuration)

			if var_30_9 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_9) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_9 + var_30_14 and arg_27_1.time_ < var_30_9 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play102031007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 102031007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play102031008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.9

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(102031007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 36 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 36)

				if (36 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 36)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play102031008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 102031008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play102031009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.5

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(102031008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 60 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 60)

				if (60 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 60)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play102031009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 102031009
		arg_39_1.duration_ = 3.9

		local var_39_0 = {
			ja = 3.9,
			ko = 3.833,
			zh = 2.8,
			en = 2.666666666666
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play102031010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["4010ui_story"]) and arg_39_1.var_.characterEffect4010ui_story == nil then
				arg_39_1.var_.characterEffect4010ui_story = arg_39_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.1

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["4010ui_story"]) then
				if arg_39_1.var_.characterEffect4010ui_story and not isNil(arg_39_1.actors_["4010ui_story"]) then
					arg_39_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["4010ui_story"]) and arg_39_1.var_.characterEffect4010ui_story then
				arg_39_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_42_2 = arg_39_1.actors_["3009ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos3009ui_story = var_42_2.localPosition

				arg_39_1:ShowWeapon(arg_39_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_42_3 = 0.5

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 then
				var_42_2.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_39_1.time_ - 0) / var_42_3)
				var_42_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_2.position).x, (manager.ui.mainCamera.transform.position - var_42_2.position).y, (manager.ui.mainCamera.transform.position - var_42_2.position).z)
				var_42_2.localEulerAngles.z = 0
				var_42_2.localEulerAngles.x = 0
				var_42_2.localEulerAngles = var_42_2.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 then
				var_42_2.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_42_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_2.position).x, (manager.ui.mainCamera.transform.position - var_42_2.position).y, (manager.ui.mainCamera.transform.position - var_42_2.position).z)
				var_42_2.localEulerAngles.z = 0
				var_42_2.localEulerAngles.x = 0
				var_42_2.localEulerAngles = var_42_2.localEulerAngles
			end

			local var_42_4 = arg_39_1.actors_["4010ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos4010ui_story = var_42_4.localPosition
			end

			local var_42_5 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				var_42_4.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_39_1.time_ - 0) / var_42_5)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				var_42_4.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_42_6 = 0
			local var_42_7 = 0.275

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:GetWordFromCfg(102031009)
				local var_42_9 = arg_39_1:FormatText(var_42_8.content)

				arg_39_1.text_.text = var_42_9

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_11 = 11 <= 0 and var_42_7 or var_42_7 * (utf8.len(var_42_9) / 11)

				if (11 <= 0 and var_42_7 or var_42_7 * (utf8.len(var_42_9) / 11)) > 0 and var_42_7 < var_42_11 then
					arg_39_1.talkMaxDuration = var_42_11

					if var_42_11 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_11 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_9
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031009", "story_v_out_102031.awb") ~= 0 then
					local var_42_12 = manager.audio:GetVoiceLength("story_v_out_102031", "102031009", "story_v_out_102031.awb") / 1000

					if var_42_12 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_6
					end

					if var_42_8.prefab_name ~= "" and arg_39_1.actors_[var_42_8.prefab_name] ~= nil then
						local var_42_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_8.prefab_name].transform, "story_v_out_102031", "102031009", "story_v_out_102031.awb")

						arg_39_1:RecordAudio("102031009", var_42_13)
						arg_39_1:RecordAudio("102031009", var_42_13)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_102031", "102031009", "story_v_out_102031.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_102031", "102031009", "story_v_out_102031.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_14 and arg_39_1.time_ < var_42_6 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play102031010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 102031010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play102031011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["4010ui_story"]) and arg_43_1.var_.characterEffect4010ui_story == nil then
				arg_43_1.var_.characterEffect4010ui_story = arg_43_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.1

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["4010ui_story"]) then
				if arg_43_1.var_.characterEffect4010ui_story and not isNil(arg_43_1.actors_["4010ui_story"]) then
					arg_43_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_43_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["4010ui_story"]) and arg_43_1.var_.characterEffect4010ui_story then
				arg_43_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_43_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_2")
			end

			local var_46_1 = 0
			local var_46_2 = 0.65

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(102031010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 26 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 26)

				if (26 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 26)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play102031011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 102031011
		arg_47_1.duration_ = 4.8

		local var_47_0 = {
			ja = 4.8,
			ko = 4.466,
			zh = 4.8,
			en = 4.533
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play102031012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["3009ui_story"]) and arg_47_1.var_.characterEffect3009ui_story == nil then
				arg_47_1.var_.characterEffect3009ui_story = arg_47_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.1

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["3009ui_story"]) then
				if arg_47_1.var_.characterEffect3009ui_story and not isNil(arg_47_1.actors_["3009ui_story"]) then
					arg_47_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["3009ui_story"]) and arg_47_1.var_.characterEffect3009ui_story then
				arg_47_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_50_2 = 0
			local var_50_3 = 0.65

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:GetWordFromCfg(102031011)
				local var_50_5 = arg_47_1:FormatText(var_50_4.content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 26 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 26)

				if (26 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 26)) > 0 and var_50_3 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031011", "story_v_out_102031.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_102031", "102031011", "story_v_out_102031.awb") / 1000

					if var_50_8 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_2
					end

					if var_50_4.prefab_name ~= "" and arg_47_1.actors_[var_50_4.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_4.prefab_name].transform, "story_v_out_102031", "102031011", "story_v_out_102031.awb")

						arg_47_1:RecordAudio("102031011", var_50_9)
						arg_47_1:RecordAudio("102031011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_102031", "102031011", "story_v_out_102031.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_102031", "102031011", "story_v_out_102031.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_10 and arg_47_1.time_ < var_50_2 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play102031012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 102031012
		arg_51_1.duration_ = 5

		local var_51_0 = {
			ja = 5,
			ko = 3.7,
			zh = 3.2,
			en = 3.3
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play102031013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["4010ui_story"]) and arg_51_1.var_.characterEffect4010ui_story == nil then
				arg_51_1.var_.characterEffect4010ui_story = arg_51_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.1

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["4010ui_story"]) then
				if arg_51_1.var_.characterEffect4010ui_story and not isNil(arg_51_1.actors_["4010ui_story"]) then
					arg_51_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["4010ui_story"]) and arg_51_1.var_.characterEffect4010ui_story then
				arg_51_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_54_2 = arg_51_1.actors_["3009ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect3009ui_story == nil then
				arg_51_1.var_.characterEffect3009ui_story = var_54_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_3 = 0.1

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.characterEffect3009ui_story and not isNil(var_54_2) then
					arg_51_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_51_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_3)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.characterEffect3009ui_story then
				arg_51_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_51_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_54_4 = 0
			local var_54_5 = 0.25

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(102031012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 9 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 9)

				if (9 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 9)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031012", "story_v_out_102031.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031012", "story_v_out_102031.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_102031", "102031012", "story_v_out_102031.awb")

						arg_51_1:RecordAudio("102031012", var_54_11)
						arg_51_1:RecordAudio("102031012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_102031", "102031012", "story_v_out_102031.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_102031", "102031012", "story_v_out_102031.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play102031013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 102031013
		arg_55_1.duration_ = 8.4

		local var_55_0 = {
			ja = 8.4,
			ko = 4,
			zh = 4.633,
			en = 4.166
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play102031014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["3009ui_story"]) and arg_55_1.var_.characterEffect3009ui_story == nil then
				arg_55_1.var_.characterEffect3009ui_story = arg_55_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.1

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["3009ui_story"]) then
				if arg_55_1.var_.characterEffect3009ui_story and not isNil(arg_55_1.actors_["3009ui_story"]) then
					arg_55_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["3009ui_story"]) and arg_55_1.var_.characterEffect3009ui_story then
				arg_55_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_58_2 = arg_55_1.actors_["4010ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect4010ui_story == nil then
				arg_55_1.var_.characterEffect4010ui_story = var_58_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_3 = 0.1

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.characterEffect4010ui_story and not isNil(var_58_2) then
					arg_55_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_55_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_3)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.characterEffect4010ui_story then
				arg_55_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_55_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.5

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(102031013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 20 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 20)

				if (20 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 20)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031013", "story_v_out_102031.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031013", "story_v_out_102031.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_102031", "102031013", "story_v_out_102031.awb")

						arg_55_1:RecordAudio("102031013", var_58_11)
						arg_55_1:RecordAudio("102031013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_102031", "102031013", "story_v_out_102031.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_102031", "102031013", "story_v_out_102031.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play102031014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 102031014
		arg_59_1.duration_ = 5.3

		local var_59_0 = {
			ja = 4.7,
			ko = 5.3,
			zh = 5.266,
			en = 2.833
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play102031015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["4010ui_story"]) and arg_59_1.var_.characterEffect4010ui_story == nil then
				arg_59_1.var_.characterEffect4010ui_story = arg_59_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.1

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["4010ui_story"]) then
				if arg_59_1.var_.characterEffect4010ui_story and not isNil(arg_59_1.actors_["4010ui_story"]) then
					arg_59_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["4010ui_story"]) and arg_59_1.var_.characterEffect4010ui_story then
				arg_59_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_62_2 = arg_59_1.actors_["3009ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect3009ui_story == nil then
				arg_59_1.var_.characterEffect3009ui_story = var_62_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_3 = 0.1

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.characterEffect3009ui_story and not isNil(var_62_2) then
					arg_59_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_59_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_3)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect3009ui_story then
				arg_59_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_59_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.45

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(102031014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 18 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 18)

				if (18 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 18)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031014", "story_v_out_102031.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031014", "story_v_out_102031.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_102031", "102031014", "story_v_out_102031.awb")

						arg_59_1:RecordAudio("102031014", var_62_11)
						arg_59_1:RecordAudio("102031014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_102031", "102031014", "story_v_out_102031.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_102031", "102031014", "story_v_out_102031.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play102031015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 102031015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play102031016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["4010ui_story"]) and arg_63_1.var_.characterEffect4010ui_story == nil then
				arg_63_1.var_.characterEffect4010ui_story = arg_63_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["4010ui_story"]) then
				if arg_63_1.var_.characterEffect4010ui_story and not isNil(arg_63_1.actors_["4010ui_story"]) then
					arg_63_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_63_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["4010ui_story"]) and arg_63_1.var_.characterEffect4010ui_story then
				arg_63_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_63_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action424")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_66_1 = 0
			local var_66_2 = 0.225

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(102031015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 9 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 9)

				if (9 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 9)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play102031016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 102031016
		arg_67_1.duration_ = 2.87

		local var_67_0 = {
			ja = 2.866,
			ko = 2,
			zh = 1.999999999999,
			en = 2.466
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play102031017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["4010ui_story"]) and arg_67_1.var_.characterEffect4010ui_story == nil then
				arg_67_1.var_.characterEffect4010ui_story = arg_67_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.1

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["4010ui_story"]) then
				if arg_67_1.var_.characterEffect4010ui_story and not isNil(arg_67_1.actors_["4010ui_story"]) then
					arg_67_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["4010ui_story"]) and arg_67_1.var_.characterEffect4010ui_story then
				arg_67_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.2

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(102031016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 8 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 8)

				if (8 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 8)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031016", "story_v_out_102031.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_102031", "102031016", "story_v_out_102031.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_out_102031", "102031016", "story_v_out_102031.awb")

						arg_67_1:RecordAudio("102031016", var_70_9)
						arg_67_1:RecordAudio("102031016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_102031", "102031016", "story_v_out_102031.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_102031", "102031016", "story_v_out_102031.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play102031017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 102031017
		arg_71_1.duration_ = 2

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play102031018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["3009ui_story"]) and arg_71_1.var_.characterEffect3009ui_story == nil then
				arg_71_1.var_.characterEffect3009ui_story = arg_71_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.1

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["3009ui_story"]) then
				if arg_71_1.var_.characterEffect3009ui_story and not isNil(arg_71_1.actors_["3009ui_story"]) then
					arg_71_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["3009ui_story"]) and arg_71_1.var_.characterEffect3009ui_story then
				arg_71_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_74_2 = arg_71_1.actors_["4010ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect4010ui_story == nil then
				arg_71_1.var_.characterEffect4010ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.1

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect4010ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_71_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect4010ui_story then
				arg_71_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_71_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(102031017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 4 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 4)

				if (4 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 4)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031017", "story_v_out_102031.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031017", "story_v_out_102031.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_102031", "102031017", "story_v_out_102031.awb")

						arg_71_1:RecordAudio("102031017", var_74_11)
						arg_71_1:RecordAudio("102031017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_102031", "102031017", "story_v_out_102031.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_102031", "102031017", "story_v_out_102031.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play102031018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 102031018
		arg_75_1.duration_ = 16.67

		local var_75_0 = {
			ja = 16.666,
			ko = 12.266,
			zh = 13.8,
			en = 11.733
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play102031019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["4010ui_story"]) and arg_75_1.var_.characterEffect4010ui_story == nil then
				arg_75_1.var_.characterEffect4010ui_story = arg_75_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.1

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["4010ui_story"]) then
				if arg_75_1.var_.characterEffect4010ui_story and not isNil(arg_75_1.actors_["4010ui_story"]) then
					arg_75_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["4010ui_story"]) and arg_75_1.var_.characterEffect4010ui_story then
				arg_75_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_78_2 = arg_75_1.actors_["3009ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect3009ui_story == nil then
				arg_75_1.var_.characterEffect3009ui_story = var_78_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_3 = 0.1

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.characterEffect3009ui_story and not isNil(var_78_2) then
					arg_75_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_75_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_3)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect3009ui_story then
				arg_75_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_75_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action443")
			end

			local var_78_4 = 0
			local var_78_5 = 1.15

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(102031018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 45 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 45)

				if (45 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 45)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031018", "story_v_out_102031.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031018", "story_v_out_102031.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_102031", "102031018", "story_v_out_102031.awb")

						arg_75_1:RecordAudio("102031018", var_78_11)
						arg_75_1:RecordAudio("102031018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_102031", "102031018", "story_v_out_102031.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_102031", "102031018", "story_v_out_102031.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_12 and arg_75_1.time_ < var_78_4 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play102031019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 102031019
		arg_79_1.duration_ = 3.57

		local var_79_0 = {
			ja = 3.566,
			ko = 2.866,
			zh = 2.166,
			en = 1.999999999999
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play102031020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["3009ui_story"]) and arg_79_1.var_.characterEffect3009ui_story == nil then
				arg_79_1.var_.characterEffect3009ui_story = arg_79_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.1

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["3009ui_story"]) then
				if arg_79_1.var_.characterEffect3009ui_story and not isNil(arg_79_1.actors_["3009ui_story"]) then
					arg_79_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["3009ui_story"]) and arg_79_1.var_.characterEffect3009ui_story then
				arg_79_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_82_2 = arg_79_1.actors_["4010ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect4010ui_story == nil then
				arg_79_1.var_.characterEffect4010ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.1

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.characterEffect4010ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_79_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_3)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect4010ui_story then
				arg_79_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_79_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_82_4 = 0
			local var_82_5 = 0.1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(102031019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 4 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 4)

				if (4 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 4)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031019", "story_v_out_102031.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031019", "story_v_out_102031.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_102031", "102031019", "story_v_out_102031.awb")

						arg_79_1:RecordAudio("102031019", var_82_11)
						arg_79_1:RecordAudio("102031019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_102031", "102031019", "story_v_out_102031.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_102031", "102031019", "story_v_out_102031.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play102031020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 102031020
		arg_83_1.duration_ = 13.07

		local var_83_0 = {
			ja = 13.066,
			ko = 7.2,
			zh = 8.366,
			en = 9.4
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play102031021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["4010ui_story"]) and arg_83_1.var_.characterEffect4010ui_story == nil then
				arg_83_1.var_.characterEffect4010ui_story = arg_83_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.1

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["4010ui_story"]) then
				if arg_83_1.var_.characterEffect4010ui_story and not isNil(arg_83_1.actors_["4010ui_story"]) then
					arg_83_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["4010ui_story"]) and arg_83_1.var_.characterEffect4010ui_story then
				arg_83_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_86_2 = arg_83_1.actors_["3009ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect3009ui_story == nil then
				arg_83_1.var_.characterEffect3009ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_3 = 0.1

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.characterEffect3009ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_83_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_3)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect3009ui_story then
				arg_83_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_83_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action3_2")
			end

			local var_86_4 = 0
			local var_86_5 = 0.85

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:GetWordFromCfg(102031020)
				local var_86_7 = arg_83_1:FormatText(var_86_6.content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 33 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 33)

				if (33 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 33)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031020", "story_v_out_102031.awb") ~= 0 then
					local var_86_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031020", "story_v_out_102031.awb") / 1000

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end

					if var_86_6.prefab_name ~= "" and arg_83_1.actors_[var_86_6.prefab_name] ~= nil then
						local var_86_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_6.prefab_name].transform, "story_v_out_102031", "102031020", "story_v_out_102031.awb")

						arg_83_1:RecordAudio("102031020", var_86_11)
						arg_83_1:RecordAudio("102031020", var_86_11)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_102031", "102031020", "story_v_out_102031.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_102031", "102031020", "story_v_out_102031.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_12 and arg_83_1.time_ < var_86_4 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play102031021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 102031021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play102031022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["4010ui_story"]) and arg_87_1.var_.characterEffect4010ui_story == nil then
				arg_87_1.var_.characterEffect4010ui_story = arg_87_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.1

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["4010ui_story"]) then
				if arg_87_1.var_.characterEffect4010ui_story and not isNil(arg_87_1.actors_["4010ui_story"]) then
					arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_87_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["4010ui_story"]) and arg_87_1.var_.characterEffect4010ui_story then
				arg_87_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_87_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.425

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(102031021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 17 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 17)

				if (17 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 17)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play102031022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 102031022
		arg_91_1.duration_ = 9

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play102031023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if arg_91_1.bgs_.S0204 == nil then
				local var_94_0 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0204")
				var_94_0.name = "S0204"
				var_94_0.transform.parent = arg_91_1.stage_.transform
				var_94_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_.S0204 = var_94_0
			end

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= 2 + arg_94_0 then
				local var_94_1 = arg_91_1.bgs_.S0204

				arg_91_1.bgs_.S0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_2 = var_94_1:GetComponent("SpriteRenderer")

				if var_94_2 and var_94_2.sprite then
					local var_94_3 = 2 * (var_94_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_1.transform.localScale = Vector3.New(var_94_3 / var_94_2.sprite.bounds.size.y < var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x and var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x or var_94_3 / var_94_2.sprite.bounds.size.y, var_94_3 / var_94_2.sprite.bounds.size.y < var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x and var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x or var_94_3 / var_94_2.sprite.bounds.size.y, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "S0204" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_4 = arg_91_1.actors_["4010ui_story"].transform

			if 1.967 < arg_91_1.time_ and arg_91_1.time_ <= 1.967 + arg_94_0 then
				arg_91_1.var_.moveOldPos4010ui_story = var_94_4.localPosition
			end

			local var_94_5 = 0.001

			if 1.967 <= arg_91_1.time_ and arg_91_1.time_ < 1.967 + var_94_5 then
				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 1.967) / var_94_5)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			if arg_91_1.time_ >= 1.967 + var_94_5 and arg_91_1.time_ < 1.967 + var_94_5 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(0, 100, 0)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			local var_94_6 = arg_91_1.actors_["3009ui_story"].transform

			if 1.967 < arg_91_1.time_ and arg_91_1.time_ <= 1.967 + arg_94_0 then
				arg_91_1.var_.moveOldPos3009ui_story = var_94_6.localPosition
			end

			local var_94_7 = 0.001

			if 1.967 <= arg_91_1.time_ and arg_91_1.time_ < 1.967 + var_94_7 then
				var_94_6.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 1.967) / var_94_7)
				var_94_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_6.position).x, (manager.ui.mainCamera.transform.position - var_94_6.position).y, (manager.ui.mainCamera.transform.position - var_94_6.position).z)
				var_94_6.localEulerAngles.z = 0
				var_94_6.localEulerAngles.x = 0
				var_94_6.localEulerAngles = var_94_6.localEulerAngles
			end

			if arg_91_1.time_ >= 1.967 + var_94_7 and arg_91_1.time_ < 1.967 + var_94_7 + arg_94_0 then
				var_94_6.localPosition = Vector3.New(0, 100, 0)
				var_94_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_6.position).x, (manager.ui.mainCamera.transform.position - var_94_6.position).y, (manager.ui.mainCamera.transform.position - var_94_6.position).z)
				var_94_6.localEulerAngles.z = 0
				var_94_6.localEulerAngles.x = 0
				var_94_6.localEulerAngles = var_94_6.localEulerAngles
			end

			local var_94_8 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_9 = 2

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 then
				local var_94_10 = Color.New(0, 0, 0)

				var_94_10.a = Mathf.Lerp(0, 1, (arg_91_1.time_ - var_94_8) / var_94_9)
				arg_91_1.mask_.color = var_94_10
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 then
				local var_94_11 = Color.New(0, 0, 0)

				var_94_11.a = 1
				arg_91_1.mask_.color = var_94_11
			end

			local var_94_12 = 2

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_13 = 2

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_13 then
				local var_94_14 = Color.New(0, 0, 0)

				var_94_14.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_12) / var_94_13)
				arg_91_1.mask_.color = var_94_14
			end

			if arg_91_1.time_ >= var_94_12 + var_94_13 and arg_91_1.time_ < var_94_12 + var_94_13 + arg_94_0 then
				local var_94_15 = Color.New(0, 0, 0)

				arg_91_1.mask_.enabled = false
				var_94_15.a = 0
				arg_91_1.mask_.color = var_94_15
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_16 = 4
			local var_94_17 = 1.35

			if 4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_18 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_18:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(102031022).content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 54 <= 0 and var_94_17 or var_94_17 * (utf8.len(var_94_19) / 54)

				if (54 <= 0 and var_94_17 or var_94_17 * (utf8.len(var_94_19) / 54)) > 0 and var_94_17 < var_94_21 then
					arg_91_1.talkMaxDuration = var_94_21
					var_94_16 = var_94_16 + 0.3

					if var_94_21 + var_94_16 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_16
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = var_94_16 + 0.3
			local var_94_23 = math.max(var_94_17, arg_91_1.talkMaxDuration)

			if var_94_16 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_22 + var_94_23 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_22) / var_94_23

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_22 + var_94_23 and arg_91_1.time_ < var_94_22 + var_94_23 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.967,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play102031023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 102031023
		arg_97_1.duration_ = 7.2

		local var_97_0 = {
			ja = 6,
			ko = 7.2,
			zh = 5.333,
			en = 7.066
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play102031024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(102031023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 25 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 25)

				if (25 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 25)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031023", "story_v_out_102031.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_102031", "102031023", "story_v_out_102031.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_102031", "102031023", "story_v_out_102031.awb")

						arg_97_1:RecordAudio("102031023", var_100_6)
						arg_97_1:RecordAudio("102031023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_102031", "102031023", "story_v_out_102031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_102031", "102031023", "story_v_out_102031.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play102031024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 102031024
		arg_101_1.duration_ = 13.8

		local var_101_0 = {
			ja = 13.8,
			ko = 8.733,
			zh = 7.566,
			en = 8.8
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play102031025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.9

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(102031024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 35 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 35)

				if (35 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 35)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031024", "story_v_out_102031.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_102031", "102031024", "story_v_out_102031.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_102031", "102031024", "story_v_out_102031.awb")

						arg_101_1:RecordAudio("102031024", var_104_6)
						arg_101_1:RecordAudio("102031024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_102031", "102031024", "story_v_out_102031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_102031", "102031024", "story_v_out_102031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play102031025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 102031025
		arg_105_1.duration_ = 6.6

		local var_105_0 = {
			ja = 3.2,
			ko = 5.033,
			zh = 5.833,
			en = 6.6
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play102031026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.775

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3009")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(102031025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 31 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 31)

				if (31 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 31)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031025", "story_v_out_102031.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_102031", "102031025", "story_v_out_102031.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_102031", "102031025", "story_v_out_102031.awb")

						arg_105_1:RecordAudio("102031025", var_108_6)
						arg_105_1:RecordAudio("102031025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_102031", "102031025", "story_v_out_102031.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_102031", "102031025", "story_v_out_102031.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play102031026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 102031026
		arg_109_1.duration_ = 7.63

		local var_109_0 = {
			ja = 5.266,
			ko = 4.6,
			zh = 7.633,
			en = 5.766
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play102031027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.625

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(102031026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 25 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 25)

				if (25 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 25)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031026", "story_v_out_102031.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_102031", "102031026", "story_v_out_102031.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_102031", "102031026", "story_v_out_102031.awb")

						arg_109_1:RecordAudio("102031026", var_112_6)
						arg_109_1:RecordAudio("102031026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_102031", "102031026", "story_v_out_102031.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_102031", "102031026", "story_v_out_102031.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play102031027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 102031027
		arg_113_1.duration_ = 5.63

		local var_113_0 = {
			ja = 5.633,
			ko = 4.133,
			zh = 2.8,
			en = 3.266
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play102031028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.375

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3009")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(102031027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 15 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 15)

				if (15 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 15)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031027", "story_v_out_102031.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_102031", "102031027", "story_v_out_102031.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_102031", "102031027", "story_v_out_102031.awb")

						arg_113_1:RecordAudio("102031027", var_116_6)
						arg_113_1:RecordAudio("102031027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_102031", "102031027", "story_v_out_102031.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_102031", "102031027", "story_v_out_102031.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play102031028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 102031028
		arg_117_1.duration_ = 9

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play102031029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 2 < arg_117_1.time_ and arg_117_1.time_ <= 2 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.B03b

				arg_117_1.bgs_.B03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "B03b" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_3 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_4 = 2

			if var_120_3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_3 + var_120_4 then
				local var_120_5 = Color.New(0, 0, 0)

				var_120_5.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_3) / var_120_4)
				arg_117_1.mask_.color = var_120_5
			end

			if arg_117_1.time_ >= var_120_3 + var_120_4 and arg_117_1.time_ < var_120_3 + var_120_4 + arg_120_0 then
				local var_120_6 = Color.New(0, 0, 0)

				var_120_6.a = 1
				arg_117_1.mask_.color = var_120_6
			end

			local var_120_7 = 2

			if 2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_8 = 2

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				local var_120_9 = Color.New(0, 0, 0)

				var_120_9.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_7) / var_120_8)
				arg_117_1.mask_.color = var_120_9
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				local var_120_10 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_10.a = 0
				arg_117_1.mask_.color = var_120_10
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_11 = 4
			local var_120_12 = 0.525

			if 4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_13 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_13:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(102031028).content)

				arg_117_1.text_.text = var_120_14

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 21 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 21)

				if (21 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 21)) > 0 and var_120_12 < var_120_16 then
					arg_117_1.talkMaxDuration = var_120_16
					var_120_11 = var_120_11 + 0.3

					if var_120_16 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_14
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_17 = var_120_11 + 0.3
			local var_120_18 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_17 + var_120_18 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_17) / var_120_18

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_17 + var_120_18 and arg_117_1.time_ < var_120_17 + var_120_18 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play102031029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 102031029
		arg_123_1.duration_ = 3.77

		local var_123_0 = {
			ja = 3.766,
			ko = 2.433333333332,
			zh = 3.133,
			en = 2.833
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
			arg_123_1.auto_ = false
		end

		function arg_123_1.playNext_(arg_125_0)
			arg_123_1.onStoryFinished_()
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["4010ui_story"]) and arg_123_1.var_.characterEffect4010ui_story == nil then
				arg_123_1.var_.characterEffect4010ui_story = arg_123_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.1

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["4010ui_story"]) then
				if arg_123_1.var_.characterEffect4010ui_story and not isNil(arg_123_1.actors_["4010ui_story"]) then
					arg_123_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["4010ui_story"]) and arg_123_1.var_.characterEffect4010ui_story then
				arg_123_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_126_2 = arg_123_1.actors_["4010ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos4010ui_story = var_126_2.localPosition
			end

			local var_126_3 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_123_1.time_ - 0) / var_126_3)
				var_126_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_2.position).x, (manager.ui.mainCamera.transform.position - var_126_2.position).y, (manager.ui.mainCamera.transform.position - var_126_2.position).z)
				var_126_2.localEulerAngles.z = 0
				var_126_2.localEulerAngles.x = 0
				var_126_2.localEulerAngles = var_126_2.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(0, -1.59, -5.2)
				var_126_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_2.position).x, (manager.ui.mainCamera.transform.position - var_126_2.position).y, (manager.ui.mainCamera.transform.position - var_126_2.position).z)
				var_126_2.localEulerAngles.z = 0
				var_126_2.localEulerAngles.x = 0
				var_126_2.localEulerAngles = var_126_2.localEulerAngles
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.15

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(102031029)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 6 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 6)

				if (6 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 6)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102031", "102031029", "story_v_out_102031.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_out_102031", "102031029", "story_v_out_102031.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_out_102031", "102031029", "story_v_out_102031.awb")

						arg_123_1:RecordAudio("102031029", var_126_11)
						arg_123_1:RecordAudio("102031029", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_102031", "102031029", "story_v_out_102031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_102031", "102031029", "story_v_out_102031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03b",
		"TextureConfig/Background/S0204"
	},
	voices = {
		"story_v_out_102031.awb"
	}
}
