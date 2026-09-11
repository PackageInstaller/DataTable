return {
	Play426071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2007a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007a")
				var_4_0.name = "ST2007a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2007a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2007a

				arg_1_1.bgs_.ST2007a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2007a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(426071001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 40 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 40)

				if (40 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 40)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play426071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426071002
		arg_9_1.duration_ = 2.43

		local var_9_0 = {
			zh = 2.433,
			ja = 1.999999999999
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
				arg_9_0:Play426071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "6148ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["6148ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["6148ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["6148ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["6148ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos6148ui_story = var_12_3.localPosition

				local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_4 then
					var_12_4:EnableDynamicBone(false)
				end
			end

			local var_12_5 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_5 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_9_1.time_ - 0) / var_12_5)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_5 and arg_9_1.time_ < 0 + var_12_5 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles

				local var_12_6 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_6 then
					var_12_6:EnableDynamicBone(true)
				end
			end

			local var_12_7 = arg_9_1.actors_["6148ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect6148ui_story == nil then
				arg_9_1.var_.characterEffect6148ui_story = var_12_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_8 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 and not isNil(var_12_7) then
				if arg_9_1.var_.characterEffect6148ui_story and not isNil(var_12_7) then
					arg_9_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect6148ui_story then
				arg_9_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_12_10 = 0
			local var_12_11 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(426071002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 11 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 11)

				if (11 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 11)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071002", "story_v_out_426071.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_426071", "426071002", "story_v_out_426071.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_426071", "426071002", "story_v_out_426071.awb")

						arg_9_1:RecordAudio("426071002", var_12_17)
						arg_9_1:RecordAudio("426071002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_426071", "426071002", "story_v_out_426071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_426071", "426071002", "story_v_out_426071.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play426071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426071003
		arg_13_1.duration_ = 7.73

		local var_13_0 = {
			zh = 7.733,
			ja = 4.066
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
				arg_13_0:Play426071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1054ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1054ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1054ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1054ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1054ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1054ui_story = var_16_3.localPosition

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_13_1.time_ - 0) / var_16_5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(true)
				end
			end

			local var_16_7 = arg_13_1.actors_["1054ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1054ui_story == nil then
				arg_13_1.var_.characterEffect1054ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect1054ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1054ui_story then
				arg_13_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_16_10 = arg_13_1.actors_["6148ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect6148ui_story == nil then
				arg_13_1.var_.characterEffect6148ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect6148ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_13_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect6148ui_story then
				arg_13_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_13_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_16_12 = 0
			local var_16_13 = 0.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(426071003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 23 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 23)

				if (23 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 23)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071003", "story_v_out_426071.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_426071", "426071003", "story_v_out_426071.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_426071", "426071003", "story_v_out_426071.awb")

						arg_13_1:RecordAudio("426071003", var_16_19)
						arg_13_1:RecordAudio("426071003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_426071", "426071003", "story_v_out_426071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_426071", "426071003", "story_v_out_426071.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_20 and arg_13_1.time_ < var_16_12 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play426071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426071004
		arg_17_1.duration_ = 2.93

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 2.933
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
				arg_17_0:Play426071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos6148ui_story = arg_17_1.actors_["6148ui_story"].transform.localPosition

				local var_20_0 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_0 then
					var_20_0:EnableDynamicBone(false)
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_17_1.time_ - 0) / var_20_1)
				arg_17_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["6148ui_story"].transform.position).z)
				arg_17_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["6148ui_story"].transform.localEulerAngles = arg_17_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_17_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["6148ui_story"].transform.position).z)
				arg_17_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["6148ui_story"].transform.localEulerAngles = arg_17_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_20_2 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(true)
				end
			end

			local var_20_3 = arg_17_1.actors_["6148ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect6148ui_story == nil then
				arg_17_1.var_.characterEffect6148ui_story = var_20_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_4 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 and not isNil(var_20_3) then
				if arg_17_1.var_.characterEffect6148ui_story and not isNil(var_20_3) then
					arg_17_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect6148ui_story then
				arg_17_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_20_6 = arg_17_1.actors_["1054ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1054ui_story == nil then
				arg_17_1.var_.characterEffect1054ui_story = var_20_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_7 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 and not isNil(var_20_6) then
				if arg_17_1.var_.characterEffect1054ui_story and not isNil(var_20_6) then
					arg_17_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_7)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 and not isNil(var_20_6) and arg_17_1.var_.characterEffect1054ui_story then
				arg_17_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			local var_20_8 = 0
			local var_20_9 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(426071004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 3 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 3)

				if (3 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 3)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071004", "story_v_out_426071.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_426071", "426071004", "story_v_out_426071.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_426071", "426071004", "story_v_out_426071.awb")

						arg_17_1:RecordAudio("426071004", var_20_15)
						arg_17_1:RecordAudio("426071004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_426071", "426071004", "story_v_out_426071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_426071", "426071004", "story_v_out_426071.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play426071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426071005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play426071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["6148ui_story"]) and arg_21_1.var_.characterEffect6148ui_story == nil then
				arg_21_1.var_.characterEffect6148ui_story = arg_21_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["6148ui_story"]) then
				if arg_21_1.var_.characterEffect6148ui_story and not isNil(arg_21_1.actors_["6148ui_story"]) then
					arg_21_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_21_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["6148ui_story"]) and arg_21_1.var_.characterEffect6148ui_story then
				arg_21_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_21_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0.766666666666667 < arg_21_1.time_ and arg_21_1.time_ <= 0.766666666666667 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_chair", "")
			end

			local var_24_2 = 0
			local var_24_3 = 1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(426071005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 40 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 40)

				if (40 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 40)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play426071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 426071006
		arg_25_1.duration_ = 5.47

		local var_25_0 = {
			zh = 5.466,
			ja = 5.266
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
				arg_25_0:Play426071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos6148ui_story = arg_25_1.actors_["6148ui_story"].transform.localPosition

				local var_28_0 = GameObjectTools.GetOrAddComponent(arg_25_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_28_0 then
					var_28_0:EnableDynamicBone(false)
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_25_1.time_ - 0) / var_28_1)
				arg_25_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["6148ui_story"].transform.position).z)
				arg_25_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["6148ui_story"].transform.localEulerAngles = arg_25_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_25_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["6148ui_story"].transform.position).z)
				arg_25_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["6148ui_story"].transform.localEulerAngles = arg_25_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_28_2 = GameObjectTools.GetOrAddComponent(arg_25_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(true)
				end
			end

			local var_28_3 = arg_25_1.actors_["6148ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect6148ui_story == nil then
				arg_25_1.var_.characterEffect6148ui_story = var_28_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_4 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 and not isNil(var_28_3) then
				if arg_25_1.var_.characterEffect6148ui_story and not isNil(var_28_3) then
					arg_25_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect6148ui_story then
				arg_25_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 0.525

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:GetWordFromCfg(426071006)
				local var_28_9 = arg_25_1:FormatText(var_28_8.content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 21 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 21)

				if (21 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_9) / 21)) > 0 and var_28_7 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071006", "story_v_out_426071.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071006", "story_v_out_426071.awb") / 1000

					if var_28_12 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_6
					end

					if var_28_8.prefab_name ~= "" and arg_25_1.actors_[var_28_8.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_8.prefab_name].transform, "story_v_out_426071", "426071006", "story_v_out_426071.awb")

						arg_25_1:RecordAudio("426071006", var_28_13)
						arg_25_1:RecordAudio("426071006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_426071", "426071006", "story_v_out_426071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_426071", "426071006", "story_v_out_426071.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_14 and arg_25_1.time_ < var_28_6 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play426071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 426071007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play426071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos6148ui_story = arg_29_1.actors_["6148ui_story"].transform.localPosition

				local var_32_0 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_0 then
					var_32_0:EnableDynamicBone(false)
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_1)
				arg_29_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).z)
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles = arg_29_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).z)
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles = arg_29_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_32_2 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(true)
				end
			end

			local var_32_3 = arg_29_1.actors_["1054ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1054ui_story = var_32_3.localPosition

				local var_32_4 = GameObjectTools.GetOrAddComponent(var_32_3.gameObject, typeof(DynamicBoneHelper))

				if var_32_4 then
					var_32_4:EnableDynamicBone(false)
				end
			end

			local var_32_5 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_5)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, 100, 0)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles

				local var_32_6 = GameObjectTools.GetOrAddComponent(var_32_3.gameObject, typeof(DynamicBoneHelper))

				if var_32_6 then
					var_32_6:EnableDynamicBone(true)
				end
			end

			local var_32_7 = arg_29_1.actors_["6148ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect6148ui_story == nil then
				arg_29_1.var_.characterEffect6148ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_8 and not isNil(var_32_7) then
				if arg_29_1.var_.characterEffect6148ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_29_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_8)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_8 and arg_29_1.time_ < 0 + var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect6148ui_story then
				arg_29_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_29_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_32_9 = 0
			local var_32_10 = 1.05

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_11 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(426071007).content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 42 <= 0 and var_32_10 or var_32_10 * (utf8.len(var_32_11) / 42)

				if (42 <= 0 and var_32_10 or var_32_10 * (utf8.len(var_32_11) / 42)) > 0 and var_32_10 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_9 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_9
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_10, arg_29_1.talkMaxDuration)

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_9) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_9 + var_32_14 and arg_29_1.time_ < var_32_9 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play426071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 426071008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play426071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(426071008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 40 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 40)

				if (40 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 40)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play426071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 426071009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play426071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.95

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(426071009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 38 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 38)

				if (38 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 38)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play426071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 426071010
		arg_41_1.duration_ = 5.8

		local var_41_0 = {
			zh = 5.8,
			ja = 5.3
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
				arg_41_0:Play426071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1054ui_story = arg_41_1.actors_["1054ui_story"].transform.localPosition

				local var_44_0 = GameObjectTools.GetOrAddComponent(arg_41_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_44_0 then
					var_44_0:EnableDynamicBone(false)
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_41_1.time_ - 0) / var_44_1)
				arg_41_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1054ui_story"].transform.position).z)
				arg_41_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1054ui_story"].transform.localEulerAngles = arg_41_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_41_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1054ui_story"].transform.position).z)
				arg_41_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1054ui_story"].transform.localEulerAngles = arg_41_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_44_2 = GameObjectTools.GetOrAddComponent(arg_41_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_44_2 then
					var_44_2:EnableDynamicBone(true)
				end
			end

			local var_44_3 = arg_41_1.actors_["1054ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1054ui_story == nil then
				arg_41_1.var_.characterEffect1054ui_story = var_44_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_4 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 and not isNil(var_44_3) then
				if arg_41_1.var_.characterEffect1054ui_story and not isNil(var_44_3) then
					arg_41_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1054ui_story then
				arg_41_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.525

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(426071010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 21 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 21)

				if (21 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 21)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071010", "story_v_out_426071.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071010", "story_v_out_426071.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_426071", "426071010", "story_v_out_426071.awb")

						arg_41_1:RecordAudio("426071010", var_44_13)
						arg_41_1:RecordAudio("426071010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_426071", "426071010", "story_v_out_426071.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_426071", "426071010", "story_v_out_426071.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play426071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 426071011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play426071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1054ui_story"]) and arg_45_1.var_.characterEffect1054ui_story == nil then
				arg_45_1.var_.characterEffect1054ui_story = arg_45_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1054ui_story"]) then
				if arg_45_1.var_.characterEffect1054ui_story and not isNil(arg_45_1.actors_["1054ui_story"]) then
					arg_45_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1054ui_story"]) and arg_45_1.var_.characterEffect1054ui_story then
				arg_45_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.55

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(426071011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 22 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 22)

				if (22 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 22)) > 0 and var_48_2 < var_48_5 then
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

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play426071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 426071012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play426071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.575

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(426071012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 23 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 23)

				if (23 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 23)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play426071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 426071013
		arg_53_1.duration_ = 2

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play426071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1054ui_story = arg_53_1.actors_["1054ui_story"].transform.localPosition

				local var_56_0 = GameObjectTools.GetOrAddComponent(arg_53_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_56_0 then
					var_56_0:EnableDynamicBone(false)
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_53_1.time_ - 0) / var_56_1)
				arg_53_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1054ui_story"].transform.position).z)
				arg_53_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1054ui_story"].transform.localEulerAngles = arg_53_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_53_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1054ui_story"].transform.position).z)
				arg_53_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1054ui_story"].transform.localEulerAngles = arg_53_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_56_2 = GameObjectTools.GetOrAddComponent(arg_53_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(true)
				end
			end

			local var_56_3 = arg_53_1.actors_["1054ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect1054ui_story == nil then
				arg_53_1.var_.characterEffect1054ui_story = var_56_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_4 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 and not isNil(var_56_3) then
				if arg_53_1.var_.characterEffect1054ui_story and not isNil(var_56_3) then
					arg_53_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect1054ui_story then
				arg_53_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			local var_56_6 = 0
			local var_56_7 = 0.075

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(426071013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 3 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 3)

				if (3 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 3)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071013", "story_v_out_426071.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071013", "story_v_out_426071.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_426071", "426071013", "story_v_out_426071.awb")

						arg_53_1:RecordAudio("426071013", var_56_13)
						arg_53_1:RecordAudio("426071013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_426071", "426071013", "story_v_out_426071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_426071", "426071013", "story_v_out_426071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play426071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 426071014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play426071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1054ui_story"]) and arg_57_1.var_.characterEffect1054ui_story == nil then
				arg_57_1.var_.characterEffect1054ui_story = arg_57_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1054ui_story"]) then
				if arg_57_1.var_.characterEffect1054ui_story and not isNil(arg_57_1.actors_["1054ui_story"]) then
					arg_57_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1054ui_story"]) and arg_57_1.var_.characterEffect1054ui_story then
				arg_57_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.075

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(426071014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 3 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 3)

				if (3 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 3)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play426071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 426071015
		arg_61_1.duration_ = 10.5

		local var_61_0 = {
			zh = 9.2,
			ja = 10.5
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
				arg_61_0:Play426071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1054ui_story = arg_61_1.actors_["1054ui_story"].transform.localPosition

				local var_64_0 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_0 then
					var_64_0:EnableDynamicBone(false)
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_61_1.time_ - 0) / var_64_1)
				arg_61_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).z)
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles = arg_61_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_61_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1054ui_story"].transform.position).z)
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1054ui_story"].transform.localEulerAngles = arg_61_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_64_2 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(true)
				end
			end

			local var_64_3 = arg_61_1.actors_["1054ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1054ui_story == nil then
				arg_61_1.var_.characterEffect1054ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect1054ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1054ui_story then
				arg_61_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action435")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.775

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(426071015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 31 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 31)

				if (31 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 31)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071015", "story_v_out_426071.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071015", "story_v_out_426071.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_426071", "426071015", "story_v_out_426071.awb")

						arg_61_1:RecordAudio("426071015", var_64_13)
						arg_61_1:RecordAudio("426071015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_426071", "426071015", "story_v_out_426071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_426071", "426071015", "story_v_out_426071.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play426071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 426071016
		arg_65_1.duration_ = 12.87

		local var_65_0 = {
			zh = 12,
			ja = 12.866
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
				arg_65_0:Play426071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_68_0 = 0
			local var_68_1 = 0.85

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(426071016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 34 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 34)

				if (34 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 34)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071016", "story_v_out_426071.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_out_426071", "426071016", "story_v_out_426071.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_out_426071", "426071016", "story_v_out_426071.awb")

						arg_65_1:RecordAudio("426071016", var_68_7)
						arg_65_1:RecordAudio("426071016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_426071", "426071016", "story_v_out_426071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_426071", "426071016", "story_v_out_426071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play426071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 426071017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play426071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1054ui_story = arg_69_1.actors_["1054ui_story"].transform.localPosition

				local var_72_0 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_0 then
					var_72_0:EnableDynamicBone(false)
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_1)
				arg_69_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).z)
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles = arg_69_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1054ui_story"].transform.position).z)
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1054ui_story"].transform.localEulerAngles = arg_69_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_72_2 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(true)
				end
			end

			local var_72_3 = arg_69_1.actors_["1054ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1054ui_story == nil then
				arg_69_1.var_.characterEffect1054ui_story = var_72_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 and not isNil(var_72_3) then
				if arg_69_1.var_.characterEffect1054ui_story and not isNil(var_72_3) then
					arg_69_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_4)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1054ui_story then
				arg_69_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0.35 < arg_69_1.time_ and arg_69_1.time_ <= 0.35 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_150", "se_story_150_chair02", "")
			end

			local var_72_6 = manager.ui.mainCamera.transform

			if 0.35 < arg_69_1.time_ and arg_69_1.time_ <= 0.35 + arg_72_0 then
				arg_69_1.var_.shakeOldPos = var_72_6.localPosition
			end

			local var_72_7 = 0.3

			if 0.35 <= arg_69_1.time_ and arg_69_1.time_ < 0.35 + var_72_7 then
				local var_72_8, var_72_9 = math.modf((arg_69_1.time_ - 0.35) / 0.066)

				var_72_6.localPosition = Vector3.New(var_72_9 * 0.13, var_72_9 * 0.13, var_72_9 * 0.13) + arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.time_ >= 0.35 + var_72_7 and arg_69_1.time_ < 0.35 + var_72_7 + arg_72_0 then
				var_72_6.localPosition = arg_69_1.var_.shakeOldPos
			end

			local var_72_10 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_10 + 0.65 and arg_69_1.time_ < var_72_10 + 0.65 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_11 = 0
			local var_72_12 = 1.35

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_13 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_13:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_14 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(426071017).content)

				arg_69_1.text_.text = var_72_14

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_16 = 54 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 54)

				if (54 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_14) / 54)) > 0 and var_72_12 < var_72_16 then
					arg_69_1.talkMaxDuration = var_72_16
					var_72_11 = var_72_11 + 0.3

					if var_72_16 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_14
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_17 = var_72_11 + 0.3
			local var_72_18 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_17 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_17) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_17 + var_72_18 and arg_69_1.time_ < var_72_17 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play426071018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 426071018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play426071019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.15

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(426071018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 6 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 6)

				if (6 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 6)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play426071019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 426071019
		arg_79_1.duration_ = 5.77

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play426071020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_0 = arg_79_1.var_.effectzhuizhuzhuanchang1

				if not arg_79_1.var_.effectzhuizhuzhuanchang1 then
					var_82_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_82_0.name = "zhuizhuzhuanchang1"
					arg_79_1.var_.effectzhuizhuzhuanchang1 = var_82_0
				else
					var_82_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_82_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_82_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_82_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_82_0.transform.localScale = Vector3.New(var_82_0.transform.localScale.x * var_82_2, var_82_0.transform.localScale.y * var_82_2, var_82_0.transform.localScale.z * var_82_2)
			end

			local var_82_3 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_3 + 1.5 and arg_79_1.time_ < var_82_3 + 1.5 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_4 = 0.766666666666667
			local var_82_5 = 1.125

			if 0.766666666666667 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_6 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_6:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(426071019).content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 45 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 45)

				if (45 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 45)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9
					var_82_4 = var_82_4 + 0.3

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = var_82_4 + 0.3
			local var_82_11 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_10) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play426071020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 426071020
		arg_85_1.duration_ = 6.7

		local var_85_0 = {
			zh = 6.7,
			ja = 6.166
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play426071021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_9000

			if arg_85_1.bgs_.ST2012a == nil then
				local var_88_0 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2012a")
				var_88_0.name = "ST2012a"
				var_88_0.transform.parent = arg_85_1.stage_.transform
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_.ST2012a = var_88_0
			end

			if 0.840250000823289 < arg_85_1.time_ and arg_85_1.time_ <= 0.840250000823289 + arg_88_0 then
				local var_88_1 = arg_85_1.bgs_.ST2012a

				arg_85_1.bgs_.ST2012a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_2 = var_88_1:GetComponent("SpriteRenderer")

				if var_88_2 and var_88_2.sprite then
					local var_88_3 = 2 * (var_88_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_1.transform.localScale = Vector3.New(var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "ST2012a" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_4 = 2

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			if arg_85_1.time_ >= var_88_4 + 0.3 and arg_85_1.time_ < var_88_4 + 0.3 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			local var_88_5 = arg_85_1.actors_["6148ui_story"].transform

			if 1.8 < arg_85_1.time_ and arg_85_1.time_ <= 1.8 + arg_88_0 then
				arg_85_1.var_.moveOldPos6148ui_story = var_88_5.localPosition

				local var_88_6 = GameObjectTools.GetOrAddComponent(var_88_5.gameObject, typeof(DynamicBoneHelper))

				if var_88_6 then
					var_88_6:EnableDynamicBone(false)
				end
			end

			local var_88_7 = 0.001

			if 1.8 <= arg_85_1.time_ and arg_85_1.time_ < 1.8 + var_88_7 then
				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_85_1.time_ - 1.8) / var_88_7)
				var_88_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_5.position).x, (manager.ui.mainCamera.transform.position - var_88_5.position).y, (manager.ui.mainCamera.transform.position - var_88_5.position).z)
				var_88_5.localEulerAngles.z = 0
				var_88_5.localEulerAngles.x = 0
				var_88_5.localEulerAngles = var_88_5.localEulerAngles
			end

			if arg_85_1.time_ >= 1.8 + var_88_7 and arg_85_1.time_ < 1.8 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(0, -0.985, -6)
				var_88_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_5.position).x, (manager.ui.mainCamera.transform.position - var_88_5.position).y, (manager.ui.mainCamera.transform.position - var_88_5.position).z)
				var_88_5.localEulerAngles.z = 0
				var_88_5.localEulerAngles.x = 0
				var_88_5.localEulerAngles = var_88_5.localEulerAngles

				local var_88_8 = GameObjectTools.GetOrAddComponent(var_88_5.gameObject, typeof(DynamicBoneHelper))

				if var_88_8 then
					var_88_8:EnableDynamicBone(true)
				end
			end

			local var_88_9 = arg_85_1.actors_["6148ui_story"]

			if 1.8 < arg_85_1.time_ and arg_85_1.time_ <= 1.8 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect6148ui_story == nil then
				arg_85_1.var_.characterEffect6148ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_10 = 0.200000002980232

			if 1.8 <= arg_85_1.time_ and arg_85_1.time_ < 1.8 + var_88_10 and not isNil(var_88_9) then
				if arg_85_1.var_.characterEffect6148ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 1.8 + var_88_10 and arg_85_1.time_ < 1.8 + var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect6148ui_story then
				arg_85_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 1.8 < arg_85_1.time_ and arg_85_1.time_ <= 1.8 + arg_88_0 then
				arg_85_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			if 1.8 < arg_85_1.time_ and arg_85_1.time_ <= 1.8 + arg_88_0 then
				arg_85_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_88_12 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_12 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			if arg_85_1.time_ >= var_88_12 + 2 and arg_85_1.time_ < var_88_12 + 2 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				local var_88_13 = arg_85_1.var_.effectzhuizhuzhuanchang1

				if not arg_85_1.var_.effectzhuizhuzhuanchang1 then
					var_88_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_88_13.name = "zhuizhuzhuanchang1"
					arg_85_1.var_.effectzhuizhuzhuanchang1 = var_88_13
				else
					var_88_13.transform:SetParent(var_88_9000)
				end

				var_88_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_88_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_88_15 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_88_13.transform.localScale = Vector3.New(var_88_13.transform.localScale.x * var_88_15, var_88_13.transform.localScale.y * var_88_15, var_88_13.transform.localScale.z * var_88_15)
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_16 = 2
			local var_88_17 = 0.25

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_16 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_18 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_18:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_19 = arg_85_1:GetWordFromCfg(426071020)
				local var_88_20 = arg_85_1:FormatText(var_88_19.content)

				arg_85_1.text_.text = var_88_20

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_22 = 10 <= 0 and var_88_17 or var_88_17 * (utf8.len(var_88_20) / 10)

				if (10 <= 0 and var_88_17 or var_88_17 * (utf8.len(var_88_20) / 10)) > 0 and var_88_17 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22
					var_88_16 = var_88_16 + 0.3

					if var_88_22 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_16
					end
				end

				arg_85_1.text_.text = var_88_20
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071020", "story_v_out_426071.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_426071", "426071020", "story_v_out_426071.awb") / 1000

					if var_88_23 + var_88_16 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_16
					end

					if var_88_19.prefab_name ~= "" and arg_85_1.actors_[var_88_19.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_19.prefab_name].transform, "story_v_out_426071", "426071020", "story_v_out_426071.awb")

						arg_85_1:RecordAudio("426071020", var_88_24)
						arg_85_1:RecordAudio("426071020", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_426071", "426071020", "story_v_out_426071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_426071", "426071020", "story_v_out_426071.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = var_88_16 + 0.3
			local var_88_26 = math.max(var_88_17, arg_85_1.talkMaxDuration)

			if var_88_16 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_25 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_25) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_25 + var_88_26 and arg_85_1.time_ < var_88_25 + var_88_26 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play426071021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 426071021
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play426071022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos6148ui_story = arg_91_1.actors_["6148ui_story"].transform.localPosition

				local var_94_0 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_0 then
					var_94_0:EnableDynamicBone(false)
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_1)
				arg_91_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["6148ui_story"].transform.position).z)
				arg_91_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["6148ui_story"].transform.localEulerAngles = arg_91_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["6148ui_story"].transform.position).z)
				arg_91_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["6148ui_story"].transform.localEulerAngles = arg_91_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_94_2 = GameObjectTools.GetOrAddComponent(arg_91_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(true)
				end
			end

			local var_94_3 = arg_91_1.actors_["6148ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect6148ui_story == nil then
				arg_91_1.var_.characterEffect6148ui_story = var_94_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_4 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 and not isNil(var_94_3) then
				if arg_91_1.var_.characterEffect6148ui_story and not isNil(var_94_3) then
					arg_91_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_91_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_4)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 and not isNil(var_94_3) and arg_91_1.var_.characterEffect6148ui_story then
				arg_91_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_91_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_94_5 = 0
			local var_94_6 = 0.9

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_7 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(426071021).content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 36 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 36)

				if (36 <= 0 and var_94_6 or var_94_6 * (utf8.len(var_94_7) / 36)) > 0 and var_94_6 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_5 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_5
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_6, arg_91_1.talkMaxDuration)

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_5) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_5 + var_94_10 and arg_91_1.time_ < var_94_5 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play426071022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 426071022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play426071023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.35

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(426071022).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 14 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 14)

				if (14 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 14)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play426071023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 426071023
		arg_99_1.duration_ = 2.47

		local var_99_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play426071024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos6148ui_story = arg_99_1.actors_["6148ui_story"].transform.localPosition

				local var_102_0 = GameObjectTools.GetOrAddComponent(arg_99_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_102_0 then
					var_102_0:EnableDynamicBone(false)
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_99_1.time_ - 0) / var_102_1)
				arg_99_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["6148ui_story"].transform.position).z)
				arg_99_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["6148ui_story"].transform.localEulerAngles = arg_99_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_99_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["6148ui_story"].transform.position).z)
				arg_99_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["6148ui_story"].transform.localEulerAngles = arg_99_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_102_2 = GameObjectTools.GetOrAddComponent(arg_99_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_102_2 then
					var_102_2:EnableDynamicBone(true)
				end
			end

			local var_102_3 = arg_99_1.actors_["6148ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect6148ui_story == nil then
				arg_99_1.var_.characterEffect6148ui_story = var_102_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_4 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 and not isNil(var_102_3) then
				if arg_99_1.var_.characterEffect6148ui_story and not isNil(var_102_3) then
					arg_99_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 and not isNil(var_102_3) and arg_99_1.var_.characterEffect6148ui_story then
				arg_99_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_102_6 = 0
			local var_102_7 = 0.175

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(426071023)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 7 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 7)

				if (7 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 7)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071023", "story_v_out_426071.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071023", "story_v_out_426071.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_426071", "426071023", "story_v_out_426071.awb")

						arg_99_1:RecordAudio("426071023", var_102_13)
						arg_99_1:RecordAudio("426071023", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_426071", "426071023", "story_v_out_426071.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_426071", "426071023", "story_v_out_426071.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play426071024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 426071024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play426071025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["6148ui_story"]) and arg_103_1.var_.characterEffect6148ui_story == nil then
				arg_103_1.var_.characterEffect6148ui_story = arg_103_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["6148ui_story"]) then
				if arg_103_1.var_.characterEffect6148ui_story and not isNil(arg_103_1.actors_["6148ui_story"]) then
					arg_103_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_103_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["6148ui_story"]) and arg_103_1.var_.characterEffect6148ui_story then
				arg_103_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_103_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.75

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(426071024).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 30 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 30)

				if (30 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 30)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play426071025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 426071025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play426071026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.525

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(426071025).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 21 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 21)

				if (21 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 21)) > 0 and var_110_0 < var_110_3 then
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
	Play426071026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 426071026
		arg_111_1.duration_ = 4

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play426071027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos6148ui_story = arg_111_1.actors_["6148ui_story"].transform.localPosition

				local var_114_0 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_0 then
					var_114_0:EnableDynamicBone(false)
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_111_1.time_ - 0) / var_114_1)
				arg_111_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).z)
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles = arg_111_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_111_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["6148ui_story"].transform.position).z)
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["6148ui_story"].transform.localEulerAngles = arg_111_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_114_2 = GameObjectTools.GetOrAddComponent(arg_111_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(true)
				end
			end

			local var_114_3 = arg_111_1.actors_["6148ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect6148ui_story == nil then
				arg_111_1.var_.characterEffect6148ui_story = var_114_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_4 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 and not isNil(var_114_3) then
				if arg_111_1.var_.characterEffect6148ui_story and not isNil(var_114_3) then
					arg_111_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 and not isNil(var_114_3) and arg_111_1.var_.characterEffect6148ui_story then
				arg_111_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_114_6 = 0
			local var_114_7 = 0.2

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_8 = arg_111_1:GetWordFromCfg(426071026)
				local var_114_9 = arg_111_1:FormatText(var_114_8.content)

				arg_111_1.text_.text = var_114_9

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 8 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 8)

				if (8 <= 0 and var_114_7 or var_114_7 * (utf8.len(var_114_9) / 8)) > 0 and var_114_7 < var_114_11 then
					arg_111_1.talkMaxDuration = var_114_11

					if var_114_11 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_9
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071026", "story_v_out_426071.awb") ~= 0 then
					local var_114_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071026", "story_v_out_426071.awb") / 1000

					if var_114_12 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_12 + var_114_6
					end

					if var_114_8.prefab_name ~= "" and arg_111_1.actors_[var_114_8.prefab_name] ~= nil then
						local var_114_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_8.prefab_name].transform, "story_v_out_426071", "426071026", "story_v_out_426071.awb")

						arg_111_1:RecordAudio("426071026", var_114_13)
						arg_111_1:RecordAudio("426071026", var_114_13)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_426071", "426071026", "story_v_out_426071.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_426071", "426071026", "story_v_out_426071.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
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

		arg_111_1:InitPlayNodeList()
	end,
	Play426071027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 426071027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play426071028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["6148ui_story"]) and arg_115_1.var_.characterEffect6148ui_story == nil then
				arg_115_1.var_.characterEffect6148ui_story = arg_115_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["6148ui_story"]) then
				if arg_115_1.var_.characterEffect6148ui_story and not isNil(arg_115_1.actors_["6148ui_story"]) then
					arg_115_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_115_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_0)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["6148ui_story"]) and arg_115_1.var_.characterEffect6148ui_story then
				arg_115_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_115_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_118_1 = 0
			local var_118_2 = 0.625

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(426071027).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 25 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 25)

				if (25 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 25)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_6 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_6 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_6

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_6 and arg_115_1.time_ < var_118_1 + var_118_6 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play426071028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 426071028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play426071029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.525

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(426071028).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 21 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 21)

				if (21 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 21)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play426071029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 426071029
		arg_123_1.duration_ = 10.97

		local var_123_0 = {
			zh = 6.6,
			ja = 10.966
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
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play426071030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos6148ui_story = arg_123_1.actors_["6148ui_story"].transform.localPosition

				local var_126_0 = GameObjectTools.GetOrAddComponent(arg_123_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_126_0 then
					var_126_0:EnableDynamicBone(false)
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_123_1.time_ - 0) / var_126_1)
				arg_123_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["6148ui_story"].transform.position).z)
				arg_123_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["6148ui_story"].transform.localEulerAngles = arg_123_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_123_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["6148ui_story"].transform.position).z)
				arg_123_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["6148ui_story"].transform.localEulerAngles = arg_123_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_126_2 = GameObjectTools.GetOrAddComponent(arg_123_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(true)
				end
			end

			local var_126_3 = arg_123_1.actors_["6148ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect6148ui_story == nil then
				arg_123_1.var_.characterEffect6148ui_story = var_126_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_4 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 and not isNil(var_126_3) then
				if arg_123_1.var_.characterEffect6148ui_story and not isNil(var_126_3) then
					arg_123_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect6148ui_story then
				arg_123_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action446")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_126_6 = 0
			local var_126_7 = 0.675

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_8 = arg_123_1:GetWordFromCfg(426071029)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 27 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 27)

				if (27 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 27)) > 0 and var_126_7 < var_126_11 then
					arg_123_1.talkMaxDuration = var_126_11

					if var_126_11 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071029", "story_v_out_426071.awb") ~= 0 then
					local var_126_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071029", "story_v_out_426071.awb") / 1000

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_426071", "426071029", "story_v_out_426071.awb")

						arg_123_1:RecordAudio("426071029", var_126_13)
						arg_123_1:RecordAudio("426071029", var_126_13)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_426071", "426071029", "story_v_out_426071.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_426071", "426071029", "story_v_out_426071.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play426071030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 426071030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play426071031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["6148ui_story"]) and arg_127_1.var_.characterEffect6148ui_story == nil then
				arg_127_1.var_.characterEffect6148ui_story = arg_127_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["6148ui_story"]) then
				if arg_127_1.var_.characterEffect6148ui_story and not isNil(arg_127_1.actors_["6148ui_story"]) then
					arg_127_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_127_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["6148ui_story"]) and arg_127_1.var_.characterEffect6148ui_story then
				arg_127_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_127_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.3

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(426071030).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 12 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 12)

				if (12 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 12)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play426071031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 426071031
		arg_131_1.duration_ = 2.97

		local var_131_0 = {
			zh = 2.3,
			ja = 2.966
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play426071032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos6148ui_story = arg_131_1.actors_["6148ui_story"].transform.localPosition

				local var_134_0 = GameObjectTools.GetOrAddComponent(arg_131_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_134_0 then
					var_134_0:EnableDynamicBone(false)
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_131_1.time_ - 0) / var_134_1)
				arg_131_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["6148ui_story"].transform.position).z)
				arg_131_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["6148ui_story"].transform.localEulerAngles = arg_131_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_131_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["6148ui_story"].transform.position).z)
				arg_131_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["6148ui_story"].transform.localEulerAngles = arg_131_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_134_2 = GameObjectTools.GetOrAddComponent(arg_131_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_134_2 then
					var_134_2:EnableDynamicBone(true)
				end
			end

			local var_134_3 = arg_131_1.actors_["6148ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_3) and arg_131_1.var_.characterEffect6148ui_story == nil then
				arg_131_1.var_.characterEffect6148ui_story = var_134_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_4 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 and not isNil(var_134_3) then
				if arg_131_1.var_.characterEffect6148ui_story and not isNil(var_134_3) then
					arg_131_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 and not isNil(var_134_3) and arg_131_1.var_.characterEffect6148ui_story then
				arg_131_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_134_6 = 0
			local var_134_7 = 0.275

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(426071031)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 11 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 11)

				if (11 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 11)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071031", "story_v_out_426071.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071031", "story_v_out_426071.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_426071", "426071031", "story_v_out_426071.awb")

						arg_131_1:RecordAudio("426071031", var_134_13)
						arg_131_1:RecordAudio("426071031", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_426071", "426071031", "story_v_out_426071.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_426071", "426071031", "story_v_out_426071.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play426071032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 426071032
		arg_135_1.duration_ = 7.77

		local var_135_0 = {
			zh = 6.033,
			ja = 7.766
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
				arg_135_0:Play426071033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.7

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(426071032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 28 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 28)

				if (28 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 28)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071032", "story_v_out_426071.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071032", "story_v_out_426071.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_426071", "426071032", "story_v_out_426071.awb")

						arg_135_1:RecordAudio("426071032", var_138_6)
						arg_135_1:RecordAudio("426071032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_426071", "426071032", "story_v_out_426071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_426071", "426071032", "story_v_out_426071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play426071033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 426071033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play426071034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["6148ui_story"]) and arg_139_1.var_.characterEffect6148ui_story == nil then
				arg_139_1.var_.characterEffect6148ui_story = arg_139_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["6148ui_story"]) then
				if arg_139_1.var_.characterEffect6148ui_story and not isNil(arg_139_1.actors_["6148ui_story"]) then
					arg_139_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_139_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["6148ui_story"]) and arg_139_1.var_.characterEffect6148ui_story then
				arg_139_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_139_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.65

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(426071033).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 26 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 26)

				if (26 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 26)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play426071034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 426071034
		arg_143_1.duration_ = 5.83

		local var_143_0 = {
			zh = 3.966,
			ja = 5.833
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play426071035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos6148ui_story = arg_143_1.actors_["6148ui_story"].transform.localPosition

				local var_146_0 = GameObjectTools.GetOrAddComponent(arg_143_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_146_0 then
					var_146_0:EnableDynamicBone(false)
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_143_1.time_ - 0) / var_146_1)
				arg_143_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["6148ui_story"].transform.position).z)
				arg_143_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["6148ui_story"].transform.localEulerAngles = arg_143_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_143_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["6148ui_story"].transform.position).z)
				arg_143_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["6148ui_story"].transform.localEulerAngles = arg_143_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_146_2 = GameObjectTools.GetOrAddComponent(arg_143_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_146_2 then
					var_146_2:EnableDynamicBone(true)
				end
			end

			local var_146_3 = arg_143_1.actors_["6148ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.characterEffect6148ui_story == nil then
				arg_143_1.var_.characterEffect6148ui_story = var_146_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_4 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 and not isNil(var_146_3) then
				if arg_143_1.var_.characterEffect6148ui_story and not isNil(var_146_3) then
					arg_143_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 and not isNil(var_146_3) and arg_143_1.var_.characterEffect6148ui_story then
				arg_143_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_146_6 = 0
			local var_146_7 = 0.375

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(426071034)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 15 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 15)

				if (15 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 15)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071034", "story_v_out_426071.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071034", "story_v_out_426071.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_426071", "426071034", "story_v_out_426071.awb")

						arg_143_1:RecordAudio("426071034", var_146_13)
						arg_143_1:RecordAudio("426071034", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_426071", "426071034", "story_v_out_426071.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_426071", "426071034", "story_v_out_426071.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play426071035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426071035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play426071036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["6148ui_story"]) and arg_147_1.var_.characterEffect6148ui_story == nil then
				arg_147_1.var_.characterEffect6148ui_story = arg_147_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["6148ui_story"]) then
				if arg_147_1.var_.characterEffect6148ui_story and not isNil(arg_147_1.actors_["6148ui_story"]) then
					arg_147_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_147_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["6148ui_story"]) and arg_147_1.var_.characterEffect6148ui_story then
				arg_147_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_147_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.625

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(426071035).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 25 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 25)

				if (25 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 25)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play426071036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426071036
		arg_151_1.duration_ = 5.37

		local var_151_0 = {
			zh = 5.066,
			ja = 5.366
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426071037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) and arg_151_1.var_.characterEffect6148ui_story == nil then
				arg_151_1.var_.characterEffect6148ui_story = arg_151_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) then
				if arg_151_1.var_.characterEffect6148ui_story and not isNil(arg_151_1.actors_["6148ui_story"]) then
					arg_151_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) and arg_151_1.var_.characterEffect6148ui_story then
				arg_151_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			local var_154_2 = 0
			local var_154_3 = 0.575

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:GetWordFromCfg(426071036)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 23 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 23)

				if (23 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 23)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071036", "story_v_out_426071.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_426071", "426071036", "story_v_out_426071.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_426071", "426071036", "story_v_out_426071.awb")

						arg_151_1:RecordAudio("426071036", var_154_9)
						arg_151_1:RecordAudio("426071036", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_426071", "426071036", "story_v_out_426071.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_426071", "426071036", "story_v_out_426071.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play426071037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426071037
		arg_155_1.duration_ = 8.77

		local var_155_0 = {
			zh = 7.466,
			ja = 8.766
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play426071038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.975

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(426071037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 39 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 39)

				if (39 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 39)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071037", "story_v_out_426071.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071037", "story_v_out_426071.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_426071", "426071037", "story_v_out_426071.awb")

						arg_155_1:RecordAudio("426071037", var_158_6)
						arg_155_1:RecordAudio("426071037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_426071", "426071037", "story_v_out_426071.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_426071", "426071037", "story_v_out_426071.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play426071038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426071038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426071039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["6148ui_story"]) and arg_159_1.var_.characterEffect6148ui_story == nil then
				arg_159_1.var_.characterEffect6148ui_story = arg_159_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["6148ui_story"]) then
				if arg_159_1.var_.characterEffect6148ui_story and not isNil(arg_159_1.actors_["6148ui_story"]) then
					arg_159_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_159_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_0)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["6148ui_story"]) and arg_159_1.var_.characterEffect6148ui_story then
				arg_159_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_159_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_162_1 = 0
			local var_162_2 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(426071038).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 14 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 14)

				if (14 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 14)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play426071039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426071039
		arg_163_1.duration_ = 7.63

		local var_163_0 = {
			zh = 6.766,
			ja = 7.633
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play426071040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos6148ui_story = arg_163_1.actors_["6148ui_story"].transform.localPosition

				local var_166_0 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_0 then
					var_166_0:EnableDynamicBone(false)
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_163_1.time_ - 0) / var_166_1)
				arg_163_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).z)
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles = arg_163_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_163_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).z)
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles = arg_163_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_166_2 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(true)
				end
			end

			local var_166_3 = arg_163_1.actors_["6148ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect6148ui_story == nil then
				arg_163_1.var_.characterEffect6148ui_story = var_166_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_4 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 and not isNil(var_166_3) then
				if arg_163_1.var_.characterEffect6148ui_story and not isNil(var_166_3) then
					arg_163_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect6148ui_story then
				arg_163_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.75

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_8 = arg_163_1:GetWordFromCfg(426071039)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 30 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 30)

				if (30 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 30)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071039", "story_v_out_426071.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071039", "story_v_out_426071.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_426071", "426071039", "story_v_out_426071.awb")

						arg_163_1:RecordAudio("426071039", var_166_13)
						arg_163_1:RecordAudio("426071039", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_426071", "426071039", "story_v_out_426071.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_426071", "426071039", "story_v_out_426071.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play426071040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426071040
		arg_167_1.duration_ = 9.37

		local var_167_0 = {
			zh = 9.366,
			ja = 5.566
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play426071041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.95

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(426071040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 38 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 38)

				if (38 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 38)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071040", "story_v_out_426071.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071040", "story_v_out_426071.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_426071", "426071040", "story_v_out_426071.awb")

						arg_167_1:RecordAudio("426071040", var_170_6)
						arg_167_1:RecordAudio("426071040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_426071", "426071040", "story_v_out_426071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_426071", "426071040", "story_v_out_426071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play426071041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426071041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426071042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["6148ui_story"]) and arg_171_1.var_.characterEffect6148ui_story == nil then
				arg_171_1.var_.characterEffect6148ui_story = arg_171_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["6148ui_story"]) then
				if arg_171_1.var_.characterEffect6148ui_story and not isNil(arg_171_1.actors_["6148ui_story"]) then
					arg_171_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_171_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["6148ui_story"]) and arg_171_1.var_.characterEffect6148ui_story then
				arg_171_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_171_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.55

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
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

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(426071041).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 22 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 22)

				if (22 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 22)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play426071042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 426071042
		arg_175_1.duration_ = 13.3

		local var_175_0 = {
			zh = 9.4,
			ja = 13.3
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
				arg_175_0:Play426071043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["6148ui_story"]) and arg_175_1.var_.characterEffect6148ui_story == nil then
				arg_175_1.var_.characterEffect6148ui_story = arg_175_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["6148ui_story"]) then
				if arg_175_1.var_.characterEffect6148ui_story and not isNil(arg_175_1.actors_["6148ui_story"]) then
					arg_175_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["6148ui_story"]) and arg_175_1.var_.characterEffect6148ui_story then
				arg_175_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action464")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_178_2 = 0
			local var_178_3 = 1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_4 = arg_175_1:GetWordFromCfg(426071042)
				local var_178_5 = arg_175_1:FormatText(var_178_4.content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 40 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 40)

				if (40 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 40)) > 0 and var_178_3 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071042", "story_v_out_426071.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_426071", "426071042", "story_v_out_426071.awb") / 1000

					if var_178_8 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_2
					end

					if var_178_4.prefab_name ~= "" and arg_175_1.actors_[var_178_4.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_4.prefab_name].transform, "story_v_out_426071", "426071042", "story_v_out_426071.awb")

						arg_175_1:RecordAudio("426071042", var_178_9)
						arg_175_1:RecordAudio("426071042", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_426071", "426071042", "story_v_out_426071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_426071", "426071042", "story_v_out_426071.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_3, arg_175_1.talkMaxDuration)

			if var_178_2 <= arg_175_1.time_ and arg_175_1.time_ < var_178_2 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_2) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_2 + var_178_10 and arg_175_1.time_ < var_178_2 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play426071043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 426071043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play426071044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["6148ui_story"]) and arg_179_1.var_.characterEffect6148ui_story == nil then
				arg_179_1.var_.characterEffect6148ui_story = arg_179_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["6148ui_story"]) then
				if arg_179_1.var_.characterEffect6148ui_story and not isNil(arg_179_1.actors_["6148ui_story"]) then
					arg_179_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_179_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["6148ui_story"]) and arg_179_1.var_.characterEffect6148ui_story then
				arg_179_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_179_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.65

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
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

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(426071043).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 26 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 26)

				if (26 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 26)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play426071044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 426071044
		arg_183_1.duration_ = 13.53

		local var_183_0 = {
			zh = 13.533,
			ja = 11
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
				arg_183_0:Play426071045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["6148ui_story"]) and arg_183_1.var_.characterEffect6148ui_story == nil then
				arg_183_1.var_.characterEffect6148ui_story = arg_183_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["6148ui_story"]) then
				if arg_183_1.var_.characterEffect6148ui_story and not isNil(arg_183_1.actors_["6148ui_story"]) then
					arg_183_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["6148ui_story"]) and arg_183_1.var_.characterEffect6148ui_story then
				arg_183_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_186_2 = 0
			local var_186_3 = 1.05

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_4 = arg_183_1:GetWordFromCfg(426071044)
				local var_186_5 = arg_183_1:FormatText(var_186_4.content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 42 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 42)

				if (42 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 42)) > 0 and var_186_3 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071044", "story_v_out_426071.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_426071", "426071044", "story_v_out_426071.awb") / 1000

					if var_186_8 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_2
					end

					if var_186_4.prefab_name ~= "" and arg_183_1.actors_[var_186_4.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_4.prefab_name].transform, "story_v_out_426071", "426071044", "story_v_out_426071.awb")

						arg_183_1:RecordAudio("426071044", var_186_9)
						arg_183_1:RecordAudio("426071044", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_426071", "426071044", "story_v_out_426071.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_426071", "426071044", "story_v_out_426071.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_10 and arg_183_1.time_ < var_186_2 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play426071045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 426071045
		arg_187_1.duration_ = 9.57

		local var_187_0 = {
			zh = 7.4,
			ja = 9.566
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
				arg_187_0:Play426071046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.825

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(426071045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 33 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 33)

				if (33 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 33)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071045", "story_v_out_426071.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071045", "story_v_out_426071.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_426071", "426071045", "story_v_out_426071.awb")

						arg_187_1:RecordAudio("426071045", var_190_6)
						arg_187_1:RecordAudio("426071045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_426071", "426071045", "story_v_out_426071.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_426071", "426071045", "story_v_out_426071.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play426071046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 426071046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play426071047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["6148ui_story"]) and arg_191_1.var_.characterEffect6148ui_story == nil then
				arg_191_1.var_.characterEffect6148ui_story = arg_191_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["6148ui_story"]) then
				if arg_191_1.var_.characterEffect6148ui_story and not isNil(arg_191_1.actors_["6148ui_story"]) then
					arg_191_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_191_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["6148ui_story"]) and arg_191_1.var_.characterEffect6148ui_story then
				arg_191_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_191_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 0.775

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(426071046).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 31 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 31)

				if (31 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 31)) > 0 and var_194_2 < var_194_5 then
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
	Play426071047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426071047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play426071048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.5

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(426071047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 20 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 20)

				if (20 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 20)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play426071048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426071048
		arg_199_1.duration_ = 9.4

		local var_199_0 = {
			zh = 7.766,
			ja = 9.4
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
				arg_199_0:Play426071049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos6148ui_story = arg_199_1.actors_["6148ui_story"].transform.localPosition

				local var_202_0 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_0 then
					var_202_0:EnableDynamicBone(false)
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_199_1.time_ - 0) / var_202_1)
				arg_199_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).z)
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles = arg_199_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_199_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).z)
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles = arg_199_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_202_2 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(true)
				end
			end

			local var_202_3 = arg_199_1.actors_["6148ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_3) and arg_199_1.var_.characterEffect6148ui_story == nil then
				arg_199_1.var_.characterEffect6148ui_story = var_202_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_4 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 and not isNil(var_202_3) then
				if arg_199_1.var_.characterEffect6148ui_story and not isNil(var_202_3) then
					arg_199_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 and not isNil(var_202_3) and arg_199_1.var_.characterEffect6148ui_story then
				arg_199_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_202_6 = 0
			local var_202_7 = 0.9

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(426071048)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 36 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 36)

				if (36 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 36)) > 0 and var_202_7 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071048", "story_v_out_426071.awb") ~= 0 then
					local var_202_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071048", "story_v_out_426071.awb") / 1000

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end

					if var_202_8.prefab_name ~= "" and arg_199_1.actors_[var_202_8.prefab_name] ~= nil then
						local var_202_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_8.prefab_name].transform, "story_v_out_426071", "426071048", "story_v_out_426071.awb")

						arg_199_1:RecordAudio("426071048", var_202_13)
						arg_199_1:RecordAudio("426071048", var_202_13)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_426071", "426071048", "story_v_out_426071.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_426071", "426071048", "story_v_out_426071.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_14 and arg_199_1.time_ < var_202_6 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play426071049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426071049
		arg_203_1.duration_ = 4.53

		local var_203_0 = {
			zh = 3.333,
			ja = 4.533
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
				arg_203_0:Play426071050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.45

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(426071049)
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

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071049", "story_v_out_426071.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071049", "story_v_out_426071.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_426071", "426071049", "story_v_out_426071.awb")

						arg_203_1:RecordAudio("426071049", var_206_6)
						arg_203_1:RecordAudio("426071049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426071", "426071049", "story_v_out_426071.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426071", "426071049", "story_v_out_426071.awb")
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
	Play426071050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426071050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play426071051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["6148ui_story"]) and arg_207_1.var_.characterEffect6148ui_story == nil then
				arg_207_1.var_.characterEffect6148ui_story = arg_207_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["6148ui_story"]) then
				if arg_207_1.var_.characterEffect6148ui_story and not isNil(arg_207_1.actors_["6148ui_story"]) then
					arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_207_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["6148ui_story"]) and arg_207_1.var_.characterEffect6148ui_story then
				arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_207_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.075

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(426071050).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 3 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 3)

				if (3 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 3)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play426071051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426071051
		arg_211_1.duration_ = 4.13

		local var_211_0 = {
			zh = 3.9,
			ja = 4.133
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
				arg_211_0:Play426071052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos6148ui_story = arg_211_1.actors_["6148ui_story"].transform.localPosition

				local var_214_0 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_0 then
					var_214_0:EnableDynamicBone(false)
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_211_1.time_ - 0) / var_214_1)
				arg_211_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).z)
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles = arg_211_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_211_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).z)
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles = arg_211_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_214_2 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(true)
				end
			end

			local var_214_3 = arg_211_1.actors_["6148ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect6148ui_story == nil then
				arg_211_1.var_.characterEffect6148ui_story = var_214_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_4 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 and not isNil(var_214_3) then
				if arg_211_1.var_.characterEffect6148ui_story and not isNil(var_214_3) then
					arg_211_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect6148ui_story then
				arg_211_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action425")
			end

			local var_214_6 = 0
			local var_214_7 = 0.475

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(426071051)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 19 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 19)

				if (19 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 19)) > 0 and var_214_7 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071051", "story_v_out_426071.awb") ~= 0 then
					local var_214_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071051", "story_v_out_426071.awb") / 1000

					if var_214_12 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_6
					end

					if var_214_8.prefab_name ~= "" and arg_211_1.actors_[var_214_8.prefab_name] ~= nil then
						local var_214_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_8.prefab_name].transform, "story_v_out_426071", "426071051", "story_v_out_426071.awb")

						arg_211_1:RecordAudio("426071051", var_214_13)
						arg_211_1:RecordAudio("426071051", var_214_13)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_426071", "426071051", "story_v_out_426071.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_426071", "426071051", "story_v_out_426071.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_14 and arg_211_1.time_ < var_214_6 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play426071052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426071052
		arg_215_1.duration_ = 10.47

		local var_215_0 = {
			zh = 6.7,
			ja = 10.466
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play426071053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.825

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(426071052)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 33 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 33)

				if (33 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 33)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071052", "story_v_out_426071.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071052", "story_v_out_426071.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_426071", "426071052", "story_v_out_426071.awb")

						arg_215_1:RecordAudio("426071052", var_218_6)
						arg_215_1:RecordAudio("426071052", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_426071", "426071052", "story_v_out_426071.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_426071", "426071052", "story_v_out_426071.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play426071053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426071053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426071054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["6148ui_story"]) and arg_219_1.var_.characterEffect6148ui_story == nil then
				arg_219_1.var_.characterEffect6148ui_story = arg_219_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["6148ui_story"]) then
				if arg_219_1.var_.characterEffect6148ui_story and not isNil(arg_219_1.actors_["6148ui_story"]) then
					arg_219_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_219_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["6148ui_story"]) and arg_219_1.var_.characterEffect6148ui_story then
				arg_219_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_219_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.6

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(426071053).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 24 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 24)

				if (24 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 24)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play426071054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 426071054
		arg_223_1.duration_ = 9.97

		local var_223_0 = {
			zh = 8.966,
			ja = 9.966
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play426071055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos6148ui_story = arg_223_1.actors_["6148ui_story"].transform.localPosition

				local var_226_0 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_0 then
					var_226_0:EnableDynamicBone(false)
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_223_1.time_ - 0) / var_226_1)
				arg_223_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).z)
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles = arg_223_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_223_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["6148ui_story"].transform.position).z)
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["6148ui_story"].transform.localEulerAngles = arg_223_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_226_2 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_2 then
					var_226_2:EnableDynamicBone(true)
				end
			end

			local var_226_3 = arg_223_1.actors_["6148ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect6148ui_story == nil then
				arg_223_1.var_.characterEffect6148ui_story = var_226_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_4 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 and not isNil(var_226_3) then
				if arg_223_1.var_.characterEffect6148ui_story and not isNil(var_226_3) then
					arg_223_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 and not isNil(var_226_3) and arg_223_1.var_.characterEffect6148ui_story then
				arg_223_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_226_6 = 0
			local var_226_7 = 1.025

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(426071054)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 41 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 41)

				if (41 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 41)) > 0 and var_226_7 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071054", "story_v_out_426071.awb") ~= 0 then
					local var_226_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071054", "story_v_out_426071.awb") / 1000

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end

					if var_226_8.prefab_name ~= "" and arg_223_1.actors_[var_226_8.prefab_name] ~= nil then
						local var_226_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_8.prefab_name].transform, "story_v_out_426071", "426071054", "story_v_out_426071.awb")

						arg_223_1:RecordAudio("426071054", var_226_13)
						arg_223_1:RecordAudio("426071054", var_226_13)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_426071", "426071054", "story_v_out_426071.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_426071", "426071054", "story_v_out_426071.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play426071055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 426071055
		arg_227_1.duration_ = 4.2

		local var_227_0 = {
			zh = 4.2,
			ja = 3.166
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play426071056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.5

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(426071055)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 20 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 20)

				if (20 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 20)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071055", "story_v_out_426071.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071055", "story_v_out_426071.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_426071", "426071055", "story_v_out_426071.awb")

						arg_227_1:RecordAudio("426071055", var_230_6)
						arg_227_1:RecordAudio("426071055", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_426071", "426071055", "story_v_out_426071.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_426071", "426071055", "story_v_out_426071.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play426071056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 426071056
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play426071057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.bgs_.ST2007 == nil then
				local var_234_0 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_234_0.name = "ST2007"
				var_234_0.transform.parent = arg_231_1.stage_.transform
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_.ST2007 = var_234_0
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_1 = arg_231_1.bgs_.ST2007

				arg_231_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_2 = var_234_1:GetComponent("SpriteRenderer")

				if var_234_2 and var_234_2.sprite then
					local var_234_3 = 2 * (var_234_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_1.transform.localScale = Vector3.New(var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "ST2007" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_4 = 4

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_4 + 0.3 and arg_231_1.time_ < var_234_4 + 0.3 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			local var_234_5 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_6 = 2

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_5) / var_234_6)
				arg_231_1.mask_.color = var_234_7
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 then
				local var_234_8 = Color.New(0, 0, 0)

				var_234_8.a = 1
				arg_231_1.mask_.color = var_234_8
			end

			local var_234_9 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_9 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_10 = 2

			if var_234_9 <= arg_231_1.time_ and arg_231_1.time_ < var_234_9 + var_234_10 then
				local var_234_11 = Color.New(0, 0, 0)

				var_234_11.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_9) / var_234_10)
				arg_231_1.mask_.color = var_234_11
			end

			if arg_231_1.time_ >= var_234_9 + var_234_10 and arg_231_1.time_ < var_234_9 + var_234_10 + arg_234_0 then
				local var_234_12 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_12.a = 0
				arg_231_1.mask_.color = var_234_12
			end

			local var_234_13 = arg_231_1.actors_["6148ui_story"].transform

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 then
				arg_231_1.var_.moveOldPos6148ui_story = var_234_13.localPosition

				local var_234_14 = GameObjectTools.GetOrAddComponent(var_234_13.gameObject, typeof(DynamicBoneHelper))

				if var_234_14 then
					var_234_14:EnableDynamicBone(false)
				end
			end

			local var_234_15 = 0.001

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_15 then
				var_234_13.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.96599999815226) / var_234_15)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_15 and arg_231_1.time_ < 1.96599999815226 + var_234_15 + arg_234_0 then
				var_234_13.localPosition = Vector3.New(0, 100, 0)
				var_234_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_13.position).x, (manager.ui.mainCamera.transform.position - var_234_13.position).y, (manager.ui.mainCamera.transform.position - var_234_13.position).z)
				var_234_13.localEulerAngles.z = 0
				var_234_13.localEulerAngles.x = 0
				var_234_13.localEulerAngles = var_234_13.localEulerAngles

				local var_234_16 = GameObjectTools.GetOrAddComponent(var_234_13.gameObject, typeof(DynamicBoneHelper))

				if var_234_16 then
					var_234_16:EnableDynamicBone(true)
				end
			end

			local var_234_17 = arg_231_1.actors_["6148ui_story"]

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 and not isNil(var_234_17) and arg_231_1.var_.characterEffect6148ui_story == nil then
				arg_231_1.var_.characterEffect6148ui_story = var_234_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_18 = 0.034000001847744

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_18 and not isNil(var_234_17) then
				if arg_231_1.var_.characterEffect6148ui_story and not isNil(var_234_17) then
					arg_231_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_231_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 1.96599999815226) / var_234_18)
				end
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_18 and arg_231_1.time_ < 1.96599999815226 + var_234_18 + arg_234_0 and not isNil(var_234_17) and arg_231_1.var_.characterEffect6148ui_story then
				arg_231_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_231_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				arg_231_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_234_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_231_1.bgmTxt_.text ~= var_234_21 and arg_231_1.bgmTxt_.text ~= "" then
						if arg_231_1.bgmTxt2_.text ~= "" then
							arg_231_1.bgmTxt_.text = arg_231_1.bgmTxt2_.text
						end

						arg_231_1.bgmTxt2_.text = var_234_21

						arg_231_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_231_1.bgmTxt_.text = var_234_21
						arg_231_1.bgmTxt2_.text = var_234_21
					end

					if arg_231_1.bgmTimer then
						arg_231_1.bgmTimer:Stop()

						arg_231_1.bgmTimer = nil
					end

					if arg_231_1.settingData.show_music_name == 1 then
						arg_231_1.musicController:SetSelectedState("show")
						arg_231_1.musicAnimator_:Play("open", 0, 0)

						if arg_231_1.settingData.music_time ~= 0 then
							arg_231_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_231_1.settingData.music_time), function()
								if arg_231_1 == nil or isNil(arg_231_1.bgmTxt_) then
									return
								end

								arg_231_1.musicController:SetSelectedState("hide")
								arg_231_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_22 = 4
			local var_234_23 = 0.625

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_22 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_24 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_24:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_231_1.dialogCg_.alpha = arg_236_0
				end))
				var_234_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_25 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(426071056).content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_27 = 25 <= 0 and var_234_23 or var_234_23 * (utf8.len(var_234_25) / 25)

				if (25 <= 0 and var_234_23 or var_234_23 * (utf8.len(var_234_25) / 25)) > 0 and var_234_23 < var_234_27 then
					arg_231_1.talkMaxDuration = var_234_27
					var_234_22 = var_234_22 + 0.3

					if var_234_27 + var_234_22 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_27 + var_234_22
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_28 = var_234_22 + 0.3
			local var_234_29 = math.max(var_234_23, arg_231_1.talkMaxDuration)

			if var_234_22 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_28 + var_234_29 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_28) / var_234_29

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_28 + var_234_29 and arg_231_1.time_ < var_234_28 + var_234_29 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play426071057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 426071057
		arg_238_1.duration_ = 2.77

		local var_238_0 = {
			zh = 2.766,
			ja = 2.333
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play426071058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos6148ui_story = arg_238_1.actors_["6148ui_story"].transform.localPosition

				local var_241_0 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_0 then
					var_241_0:EnableDynamicBone(false)
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_238_1.time_ - 0) / var_241_1)
				arg_238_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["6148ui_story"].transform.position).z)
				arg_238_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["6148ui_story"].transform.localEulerAngles = arg_238_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_238_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["6148ui_story"].transform.position).z)
				arg_238_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["6148ui_story"].transform.localEulerAngles = arg_238_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_241_2 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(true)
				end
			end

			local var_241_3 = arg_238_1.actors_["6148ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_3) and arg_238_1.var_.characterEffect6148ui_story == nil then
				arg_238_1.var_.characterEffect6148ui_story = var_241_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_4 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 and not isNil(var_241_3) then
				if arg_238_1.var_.characterEffect6148ui_story and not isNil(var_241_3) then
					arg_238_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 and not isNil(var_241_3) and arg_238_1.var_.characterEffect6148ui_story then
				arg_238_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_241_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_8 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_8

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_8
						arg_238_1.bgmTxt2_.text = var_241_8
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_238_1.time_ and arg_238_1.time_ <= 0.3 + arg_241_0 then
				arg_238_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_241_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_11 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_11

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_11
						arg_238_1.bgmTxt2_.text = var_241_11
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_241_12 = 0
			local var_241_13 = 0.225

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_12 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_14 = arg_238_1:GetWordFromCfg(426071057)
				local var_241_15 = arg_238_1:FormatText(var_241_14.content)

				arg_238_1.text_.text = var_241_15

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_17 = 9 <= 0 and var_241_13 or var_241_13 * (utf8.len(var_241_15) / 9)

				if (9 <= 0 and var_241_13 or var_241_13 * (utf8.len(var_241_15) / 9)) > 0 and var_241_13 < var_241_17 then
					arg_238_1.talkMaxDuration = var_241_17

					if var_241_17 + var_241_12 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_17 + var_241_12
					end
				end

				arg_238_1.text_.text = var_241_15
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071057", "story_v_out_426071.awb") ~= 0 then
					local var_241_18 = manager.audio:GetVoiceLength("story_v_out_426071", "426071057", "story_v_out_426071.awb") / 1000

					if var_241_18 + var_241_12 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_18 + var_241_12
					end

					if var_241_14.prefab_name ~= "" and arg_238_1.actors_[var_241_14.prefab_name] ~= nil then
						local var_241_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_14.prefab_name].transform, "story_v_out_426071", "426071057", "story_v_out_426071.awb")

						arg_238_1:RecordAudio("426071057", var_241_19)
						arg_238_1:RecordAudio("426071057", var_241_19)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_426071", "426071057", "story_v_out_426071.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_426071", "426071057", "story_v_out_426071.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_20 = math.max(var_241_13, arg_238_1.talkMaxDuration)

			if var_241_12 <= arg_238_1.time_ and arg_238_1.time_ < var_241_12 + var_241_20 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_12) / var_241_20

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_12 + var_241_20 and arg_238_1.time_ < var_241_12 + var_241_20 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play426071058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 426071058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play426071059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos6148ui_story = arg_244_1.actors_["6148ui_story"].transform.localPosition

				local var_247_0 = GameObjectTools.GetOrAddComponent(arg_244_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_247_0 then
					var_247_0:EnableDynamicBone(false)
				end
			end

			local var_247_1 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_1 then
				arg_244_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_1)
				arg_244_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["6148ui_story"].transform.position).z)
				arg_244_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["6148ui_story"].transform.localEulerAngles = arg_244_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_1 and arg_244_1.time_ < 0 + var_247_1 + arg_247_0 then
				arg_244_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["6148ui_story"].transform.position).z)
				arg_244_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["6148ui_story"].transform.localEulerAngles = arg_244_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_247_2 = GameObjectTools.GetOrAddComponent(arg_244_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_247_2 then
					var_247_2:EnableDynamicBone(true)
				end
			end

			local var_247_3 = arg_244_1.actors_["6148ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect6148ui_story == nil then
				arg_244_1.var_.characterEffect6148ui_story = var_247_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_4 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 and not isNil(var_247_3) then
				if arg_244_1.var_.characterEffect6148ui_story and not isNil(var_247_3) then
					arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_244_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_4)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 and not isNil(var_247_3) and arg_244_1.var_.characterEffect6148ui_story then
				arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_244_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_247_5 = 0
			local var_247_6 = 0.85

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(426071058).content)

				arg_244_1.text_.text = var_247_7

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_9 = 34 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 34)

				if (34 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_7) / 34)) > 0 and var_247_6 < var_247_9 then
					arg_244_1.talkMaxDuration = var_247_9

					if var_247_9 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_9 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_7
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_10 and arg_244_1.time_ < var_247_5 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
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

		arg_244_1:InitPlayNodeList()
	end,
	Play426071059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 426071059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play426071060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.15

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(426071059).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 6 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 6)

				if (6 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 6)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play426071060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 426071060
		arg_252_1.duration_ = 2.93

		local var_252_0 = {
			zh = 2.266,
			ja = 2.933
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play426071061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos6148ui_story = arg_252_1.actors_["6148ui_story"].transform.localPosition

				local var_255_0 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_0 then
					var_255_0:EnableDynamicBone(false)
				end
			end

			local var_255_1 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				arg_252_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_252_1.time_ - 0) / var_255_1)
				arg_252_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["6148ui_story"].transform.position).z)
				arg_252_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["6148ui_story"].transform.localEulerAngles = arg_252_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				arg_252_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_252_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["6148ui_story"].transform.position).z)
				arg_252_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["6148ui_story"].transform.localEulerAngles = arg_252_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_255_2 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(true)
				end
			end

			local var_255_3 = arg_252_1.actors_["6148ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect6148ui_story == nil then
				arg_252_1.var_.characterEffect6148ui_story = var_255_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_4 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 and not isNil(var_255_3) then
				if arg_252_1.var_.characterEffect6148ui_story and not isNil(var_255_3) then
					arg_252_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect6148ui_story then
				arg_252_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_255_6 = 0
			local var_255_7 = 0.225

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:GetWordFromCfg(426071060)
				local var_255_9 = arg_252_1:FormatText(var_255_8.content)

				arg_252_1.text_.text = var_255_9

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 9 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 9)

				if (9 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 9)) > 0 and var_255_7 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_9
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071060", "story_v_out_426071.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071060", "story_v_out_426071.awb") / 1000

					if var_255_12 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_6
					end

					if var_255_8.prefab_name ~= "" and arg_252_1.actors_[var_255_8.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_8.prefab_name].transform, "story_v_out_426071", "426071060", "story_v_out_426071.awb")

						arg_252_1:RecordAudio("426071060", var_255_13)
						arg_252_1:RecordAudio("426071060", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_426071", "426071060", "story_v_out_426071.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_426071", "426071060", "story_v_out_426071.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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

		arg_252_1:InitPlayNodeList()
	end,
	Play426071061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 426071061
		arg_256_1.duration_ = 6.53

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play426071062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if arg_256_1.bgs_.STblack == nil then
				local var_259_0 = Object.Instantiate(arg_256_1.paintGo_)

				var_259_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_259_0.name = "STblack"
				var_259_0.transform.parent = arg_256_1.stage_.transform
				var_259_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.bgs_.STblack = var_259_0
			end

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 then
				local var_259_1 = arg_256_1.bgs_.STblack

				arg_256_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_259_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_259_2 = var_259_1:GetComponent("SpriteRenderer")

				if var_259_2 and var_259_2.sprite then
					local var_259_3 = 2 * (var_259_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_259_1.transform.localScale = Vector3.New(var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, var_259_3 / var_259_2.sprite.bounds.size.y < var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x and var_259_3 * manager.ui.mainCameraCom_.aspect / var_259_2.sprite.bounds.size.x or var_259_3 / var_259_2.sprite.bounds.size.y, 0)
				end

				for iter_259_0, iter_259_1 in pairs(arg_256_1.bgs_) do
					if iter_259_0 ~= "STblack" then
						iter_259_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_259_4 = 4

			if 4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			if arg_256_1.time_ >= var_259_4 + 0.3 and arg_256_1.time_ < var_259_4 + 0.3 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			local var_259_5 = 0

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_6 = 2

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 then
				local var_259_7 = Color.New(0, 0, 0)

				var_259_7.a = Mathf.Lerp(0, 1, (arg_256_1.time_ - var_259_5) / var_259_6)
				arg_256_1.mask_.color = var_259_7
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 then
				local var_259_8 = Color.New(0, 0, 0)

				var_259_8.a = 1
				arg_256_1.mask_.color = var_259_8
			end

			local var_259_9 = 2

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= var_259_9 + arg_259_0 then
				arg_256_1.mask_.enabled = true
				arg_256_1.mask_.raycastTarget = true

				arg_256_1:SetGaussion(false)
			end

			local var_259_10 = 2

			if var_259_9 <= arg_256_1.time_ and arg_256_1.time_ < var_259_9 + var_259_10 then
				local var_259_11 = Color.New(0, 0, 0)

				var_259_11.a = Mathf.Lerp(1, 0, (arg_256_1.time_ - var_259_9) / var_259_10)
				arg_256_1.mask_.color = var_259_11
			end

			if arg_256_1.time_ >= var_259_9 + var_259_10 and arg_256_1.time_ < var_259_9 + var_259_10 + arg_259_0 then
				local var_259_12 = Color.New(0, 0, 0)

				arg_256_1.mask_.enabled = false
				var_259_12.a = 0
				arg_256_1.mask_.color = var_259_12
			end

			local var_259_13 = arg_256_1.actors_["6148ui_story"].transform

			if 1.96599999815226 < arg_256_1.time_ and arg_256_1.time_ <= 1.96599999815226 + arg_259_0 then
				arg_256_1.var_.moveOldPos6148ui_story = var_259_13.localPosition

				local var_259_14 = GameObjectTools.GetOrAddComponent(var_259_13.gameObject, typeof(DynamicBoneHelper))

				if var_259_14 then
					var_259_14:EnableDynamicBone(false)
				end
			end

			local var_259_15 = 0.001

			if 1.96599999815226 <= arg_256_1.time_ and arg_256_1.time_ < 1.96599999815226 + var_259_15 then
				var_259_13.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_256_1.time_ - 1.96599999815226) / var_259_15)
				var_259_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_13.position).x, (manager.ui.mainCamera.transform.position - var_259_13.position).y, (manager.ui.mainCamera.transform.position - var_259_13.position).z)
				var_259_13.localEulerAngles.z = 0
				var_259_13.localEulerAngles.x = 0
				var_259_13.localEulerAngles = var_259_13.localEulerAngles
			end

			if arg_256_1.time_ >= 1.96599999815226 + var_259_15 and arg_256_1.time_ < 1.96599999815226 + var_259_15 + arg_259_0 then
				var_259_13.localPosition = Vector3.New(0, 100, 0)
				var_259_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_13.position).x, (manager.ui.mainCamera.transform.position - var_259_13.position).y, (manager.ui.mainCamera.transform.position - var_259_13.position).z)
				var_259_13.localEulerAngles.z = 0
				var_259_13.localEulerAngles.x = 0
				var_259_13.localEulerAngles = var_259_13.localEulerAngles

				local var_259_16 = GameObjectTools.GetOrAddComponent(var_259_13.gameObject, typeof(DynamicBoneHelper))

				if var_259_16 then
					var_259_16:EnableDynamicBone(true)
				end
			end

			local var_259_17 = arg_256_1.actors_["6148ui_story"]

			if 1.96599999815226 < arg_256_1.time_ and arg_256_1.time_ <= 1.96599999815226 + arg_259_0 and not isNil(var_259_17) and arg_256_1.var_.characterEffect6148ui_story == nil then
				arg_256_1.var_.characterEffect6148ui_story = var_259_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_18 = 0.034000001847744

			if 1.96599999815226 <= arg_256_1.time_ and arg_256_1.time_ < 1.96599999815226 + var_259_18 and not isNil(var_259_17) then
				if arg_256_1.var_.characterEffect6148ui_story and not isNil(var_259_17) then
					arg_256_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_256_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 1.96599999815226) / var_259_18)
				end
			end

			if arg_256_1.time_ >= 1.96599999815226 + var_259_18 and arg_256_1.time_ < 1.96599999815226 + var_259_18 + arg_259_0 and not isNil(var_259_17) and arg_256_1.var_.characterEffect6148ui_story then
				arg_256_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_256_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 2 < arg_256_1.time_ and arg_256_1.time_ <= 2 + arg_259_0 then
				arg_256_1.fswbg_:SetActive(false)
				arg_256_1.dialog_:SetActive(false)
				SetActive(arg_256_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_256_1:ShowNextGo(false)
			end

			local var_259_19 = 2.33333333333333
			local var_259_20 = manager.audio:GetVoiceLength("story_v_out_426071", "426071061", "story_v_out_426071.awb") / 1000

			if var_259_20 > 0 and 4.2 < var_259_20 and var_259_20 + var_259_19 > arg_256_1.duration_ then
				arg_256_1.duration_ = var_259_20 + var_259_19
			end

			if var_259_19 < arg_256_1.time_ and arg_256_1.time_ <= var_259_19 + arg_259_0 then
				arg_256_1:AudioAction("play", "voice", "story_v_out_426071", "426071061", "story_v_out_426071.awb")
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426071061,
				charCount = 14,
				enableLayoutChange = true,
				duration = 0.933333333333333,
				groupID = "wujiudexin",
				startTime = 2.33333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play426071062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 426071062
		arg_260_1.duration_ = 4.2

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play426071063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = manager.audio:GetVoiceLength("story_v_out_426071", "426071062", "story_v_out_426071.awb") / 1000

			if var_263_0 > 0 and 4.2 < var_263_0 and var_263_0 + 0 > arg_260_1.duration_ then
				arg_260_1.duration_ = var_263_0 + 0
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:AudioAction("play", "voice", "story_v_out_426071", "426071062", "story_v_out_426071.awb")
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426071062,
				charCount = 29,
				enableLayoutChange = true,
				duration = 1.93333333333333,
				groupID = "wujiudexin",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play426071063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 426071063
		arg_264_1.duration_ = 4.2

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play426071064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = manager.audio:GetVoiceLength("story_v_out_426071", "426071063", "story_v_out_426071.awb") / 1000

			if var_267_0 > 0 and 4.2 < var_267_0 and var_267_0 + 0 > arg_264_1.duration_ then
				arg_264_1.duration_ = var_267_0 + 0
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:AudioAction("play", "voice", "story_v_out_426071", "426071063", "story_v_out_426071.awb")
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426071063,
				charCount = 38,
				enableLayoutChange = true,
				duration = 2.53333333333333,
				groupID = "wujiudexin",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play426071064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 426071064
		arg_268_1.duration_ = 4.2

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play426071065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = manager.audio:GetVoiceLength("story_v_out_426071", "426071064", "story_v_out_426071.awb") / 1000

			if var_271_0 > 0 and 4.2 < var_271_0 and var_271_0 + 0 > arg_268_1.duration_ then
				arg_268_1.duration_ = var_271_0 + 0
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:AudioAction("play", "voice", "story_v_out_426071", "426071064", "story_v_out_426071.awb")
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426071064,
				charCount = 36,
				enableLayoutChange = true,
				duration = 2.4,
				groupID = "wujiudexin",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play426071065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 426071065
		arg_272_1.duration_ = 4.2

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play426071066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = manager.audio:GetVoiceLength("story_v_out_426071", "426071065", "story_v_out_426071.awb") / 1000

			if var_275_0 > 0 and 4.2 < var_275_0 and var_275_0 + 0 > arg_272_1.duration_ then
				arg_272_1.duration_ = var_275_0 + 0
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:AudioAction("play", "voice", "story_v_out_426071", "426071065", "story_v_out_426071.awb")
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 426071065,
				charCount = 11,
				enableLayoutChange = true,
				duration = 0.733333333333333,
				groupID = "wujiudexin",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play426071066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 426071066
		arg_276_1.duration_ = 9

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play426071067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 2 < arg_276_1.time_ and arg_276_1.time_ <= 2 + arg_279_0 then
				local var_279_0 = arg_276_1.bgs_.ST2007

				arg_276_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_279_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_279_1 = var_279_0:GetComponent("SpriteRenderer")

				if var_279_1 and var_279_1.sprite then
					local var_279_2 = 2 * (var_279_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_279_0.transform.localScale = Vector3.New(var_279_2 / var_279_1.sprite.bounds.size.y < var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x and var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x or var_279_2 / var_279_1.sprite.bounds.size.y, var_279_2 / var_279_1.sprite.bounds.size.y < var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x and var_279_2 * manager.ui.mainCameraCom_.aspect / var_279_1.sprite.bounds.size.x or var_279_2 / var_279_1.sprite.bounds.size.y, 0)
				end

				for iter_279_0, iter_279_1 in pairs(arg_276_1.bgs_) do
					if iter_279_0 ~= "ST2007" then
						iter_279_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_279_3 = 4

			if 4 < arg_276_1.time_ and arg_276_1.time_ <= var_279_3 + arg_279_0 then
				arg_276_1.allBtn_.enabled = false
			end

			if arg_276_1.time_ >= var_279_3 + 0.3 and arg_276_1.time_ < var_279_3 + 0.3 + arg_279_0 then
				arg_276_1.allBtn_.enabled = true
			end

			local var_279_4 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_5 = 2

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_5 then
				local var_279_6 = Color.New(0, 0, 0)

				var_279_6.a = Mathf.Lerp(0, 1, (arg_276_1.time_ - var_279_4) / var_279_5)
				arg_276_1.mask_.color = var_279_6
			end

			if arg_276_1.time_ >= var_279_4 + var_279_5 and arg_276_1.time_ < var_279_4 + var_279_5 + arg_279_0 then
				local var_279_7 = Color.New(0, 0, 0)

				var_279_7.a = 1
				arg_276_1.mask_.color = var_279_7
			end

			local var_279_8 = 2

			if 2 < arg_276_1.time_ and arg_276_1.time_ <= var_279_8 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_9 = 2

			if var_279_8 <= arg_276_1.time_ and arg_276_1.time_ < var_279_8 + var_279_9 then
				local var_279_10 = Color.New(0, 0, 0)

				var_279_10.a = Mathf.Lerp(1, 0, (arg_276_1.time_ - var_279_8) / var_279_9)
				arg_276_1.mask_.color = var_279_10
			end

			if arg_276_1.time_ >= var_279_8 + var_279_9 and arg_276_1.time_ < var_279_8 + var_279_9 + arg_279_0 then
				local var_279_11 = Color.New(0, 0, 0)

				arg_276_1.mask_.enabled = false
				var_279_11.a = 0
				arg_276_1.mask_.color = var_279_11
			end

			if 2.66666666666667 < arg_276_1.time_ and arg_276_1.time_ <= 2.66666666666667 + arg_279_0 then
				arg_276_1:AudioAction("play", "effect", "se_story_150", "se_story_150_foley_pinch_paper", "")
			end

			if arg_276_1.frameCnt_ <= 1 then
				arg_276_1.dialog_:SetActive(false)
			end

			local var_279_13 = 4
			local var_279_14 = 0.875

			if 4 < arg_276_1.time_ and arg_276_1.time_ <= var_279_13 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_15 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_15:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_16 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(426071066).content)

				arg_276_1.text_.text = var_279_16

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_18 = 35 <= 0 and var_279_14 or var_279_14 * (utf8.len(var_279_16) / 35)

				if (35 <= 0 and var_279_14 or var_279_14 * (utf8.len(var_279_16) / 35)) > 0 and var_279_14 < var_279_18 then
					arg_276_1.talkMaxDuration = var_279_18
					var_279_13 = var_279_13 + 0.3

					if var_279_18 + var_279_13 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_18 + var_279_13
					end
				end

				arg_276_1.text_.text = var_279_16
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_19 = var_279_13 + 0.3
			local var_279_20 = math.max(var_279_14, arg_276_1.talkMaxDuration)

			if var_279_13 + 0.3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_19 + var_279_20 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_19) / var_279_20

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_19 + var_279_20 and arg_276_1.time_ < var_279_19 + var_279_20 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				groupID = "wujiudexin",
				duration = 0.125,
				className = "StoryTextGroupNode",
				startTime = 1.875,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play426071067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 426071067
		arg_282_1.duration_ = 7.4

		local var_282_0 = {
			zh = 7.4,
			ja = 6.766
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play426071068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos6148ui_story = arg_282_1.actors_["6148ui_story"].transform.localPosition

				local var_285_0 = GameObjectTools.GetOrAddComponent(arg_282_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_285_0 then
					var_285_0:EnableDynamicBone(false)
				end
			end

			local var_285_1 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				arg_282_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_282_1.time_ - 0) / var_285_1)
				arg_282_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["6148ui_story"].transform.position).z)
				arg_282_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["6148ui_story"].transform.localEulerAngles = arg_282_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 then
				arg_282_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_282_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["6148ui_story"].transform.position).z)
				arg_282_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["6148ui_story"].transform.localEulerAngles = arg_282_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_285_2 = GameObjectTools.GetOrAddComponent(arg_282_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_285_2 then
					var_285_2:EnableDynamicBone(true)
				end
			end

			local var_285_3 = arg_282_1.actors_["6148ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_3) and arg_282_1.var_.characterEffect6148ui_story == nil then
				arg_282_1.var_.characterEffect6148ui_story = var_285_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_4 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 and not isNil(var_285_3) then
				if arg_282_1.var_.characterEffect6148ui_story and not isNil(var_285_3) then
					arg_282_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 and not isNil(var_285_3) and arg_282_1.var_.characterEffect6148ui_story then
				arg_282_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_285_6 = 0
			local var_285_7 = 0.675

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_8 = arg_282_1:GetWordFromCfg(426071067)
				local var_285_9 = arg_282_1:FormatText(var_285_8.content)

				arg_282_1.text_.text = var_285_9

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_11 = 27 <= 0 and var_285_7 or var_285_7 * (utf8.len(var_285_9) / 27)

				if (27 <= 0 and var_285_7 or var_285_7 * (utf8.len(var_285_9) / 27)) > 0 and var_285_7 < var_285_11 then
					arg_282_1.talkMaxDuration = var_285_11

					if var_285_11 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_9
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071067", "story_v_out_426071.awb") ~= 0 then
					local var_285_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071067", "story_v_out_426071.awb") / 1000

					if var_285_12 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_12 + var_285_6
					end

					if var_285_8.prefab_name ~= "" and arg_282_1.actors_[var_285_8.prefab_name] ~= nil then
						local var_285_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_8.prefab_name].transform, "story_v_out_426071", "426071067", "story_v_out_426071.awb")

						arg_282_1:RecordAudio("426071067", var_285_13)
						arg_282_1:RecordAudio("426071067", var_285_13)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_426071", "426071067", "story_v_out_426071.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_426071", "426071067", "story_v_out_426071.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_14 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_14 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_14

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_14 and arg_282_1.time_ < var_285_6 + var_285_14 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
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

		arg_282_1:InitPlayNodeList()
	end,
	Play426071068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 426071068
		arg_286_1.duration_ = 9.73

		local var_286_0 = {
			zh = 7.866,
			ja = 9.733
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play426071069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos6148ui_story = arg_286_1.actors_["6148ui_story"].transform.localPosition

				local var_289_0 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_0 then
					var_289_0:EnableDynamicBone(false)
				end
			end

			local var_289_1 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_1 then
				arg_286_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_286_1.time_ - 0) / var_289_1)
				arg_286_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["6148ui_story"].transform.position).z)
				arg_286_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["6148ui_story"].transform.localEulerAngles = arg_286_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_1 and arg_286_1.time_ < 0 + var_289_1 + arg_289_0 then
				arg_286_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_286_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["6148ui_story"].transform.position).z)
				arg_286_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["6148ui_story"].transform.localEulerAngles = arg_286_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_289_2 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_2 then
					var_289_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_289_3 = 0
			local var_289_4 = 0.875

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_3 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_5 = arg_286_1:GetWordFromCfg(426071068)
				local var_289_6 = arg_286_1:FormatText(var_289_5.content)

				arg_286_1.text_.text = var_289_6

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_8 = 35 <= 0 and var_289_4 or var_289_4 * (utf8.len(var_289_6) / 35)

				if (35 <= 0 and var_289_4 or var_289_4 * (utf8.len(var_289_6) / 35)) > 0 and var_289_4 < var_289_8 then
					arg_286_1.talkMaxDuration = var_289_8

					if var_289_8 + var_289_3 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_3
					end
				end

				arg_286_1.text_.text = var_289_6
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071068", "story_v_out_426071.awb") ~= 0 then
					local var_289_9 = manager.audio:GetVoiceLength("story_v_out_426071", "426071068", "story_v_out_426071.awb") / 1000

					if var_289_9 + var_289_3 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_3
					end

					if var_289_5.prefab_name ~= "" and arg_286_1.actors_[var_289_5.prefab_name] ~= nil then
						local var_289_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_5.prefab_name].transform, "story_v_out_426071", "426071068", "story_v_out_426071.awb")

						arg_286_1:RecordAudio("426071068", var_289_10)
						arg_286_1:RecordAudio("426071068", var_289_10)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_426071", "426071068", "story_v_out_426071.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_426071", "426071068", "story_v_out_426071.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_11 = math.max(var_289_4, arg_286_1.talkMaxDuration)

			if var_289_3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_3 + var_289_11 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_3) / var_289_11

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_3 + var_289_11 and arg_286_1.time_ < var_289_3 + var_289_11 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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

		arg_286_1:InitPlayNodeList()
	end,
	Play426071069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 426071069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play426071070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["6148ui_story"]) and arg_290_1.var_.characterEffect6148ui_story == nil then
				arg_290_1.var_.characterEffect6148ui_story = arg_290_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["6148ui_story"]) then
				if arg_290_1.var_.characterEffect6148ui_story and not isNil(arg_290_1.actors_["6148ui_story"]) then
					arg_290_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_290_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["6148ui_story"]) and arg_290_1.var_.characterEffect6148ui_story then
				arg_290_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_290_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.225

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(426071069).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 9 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 9)

				if (9 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 9)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play426071070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 426071070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play426071071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.65

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(426071070).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 26 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 26)

				if (26 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 26)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play426071071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 426071071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play426071072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.9

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(426071071).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 36 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 36)

				if (36 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 36)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play426071072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 426071072
		arg_302_1.duration_ = 2

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play426071073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos6148ui_story = arg_302_1.actors_["6148ui_story"].transform.localPosition

				local var_305_0 = GameObjectTools.GetOrAddComponent(arg_302_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_305_0 then
					var_305_0:EnableDynamicBone(false)
				end
			end

			local var_305_1 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_1 then
				arg_302_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_302_1.time_ - 0) / var_305_1)
				arg_302_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["6148ui_story"].transform.position).z)
				arg_302_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["6148ui_story"].transform.localEulerAngles = arg_302_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_1 and arg_302_1.time_ < 0 + var_305_1 + arg_305_0 then
				arg_302_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_302_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["6148ui_story"].transform.position).z)
				arg_302_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["6148ui_story"].transform.localEulerAngles = arg_302_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_305_2 = GameObjectTools.GetOrAddComponent(arg_302_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_305_2 then
					var_305_2:EnableDynamicBone(true)
				end
			end

			local var_305_3 = arg_302_1.actors_["6148ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_3) and arg_302_1.var_.characterEffect6148ui_story == nil then
				arg_302_1.var_.characterEffect6148ui_story = var_305_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_4 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 and not isNil(var_305_3) then
				if arg_302_1.var_.characterEffect6148ui_story and not isNil(var_305_3) then
					arg_302_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 and not isNil(var_305_3) and arg_302_1.var_.characterEffect6148ui_story then
				arg_302_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_305_6 = 0
			local var_305_7 = 0.15

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_8 = arg_302_1:GetWordFromCfg(426071072)
				local var_305_9 = arg_302_1:FormatText(var_305_8.content)

				arg_302_1.text_.text = var_305_9

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 6 <= 0 and var_305_7 or var_305_7 * (utf8.len(var_305_9) / 6)

				if (6 <= 0 and var_305_7 or var_305_7 * (utf8.len(var_305_9) / 6)) > 0 and var_305_7 < var_305_11 then
					arg_302_1.talkMaxDuration = var_305_11

					if var_305_11 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_9
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071072", "story_v_out_426071.awb") ~= 0 then
					local var_305_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071072", "story_v_out_426071.awb") / 1000

					if var_305_12 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_6
					end

					if var_305_8.prefab_name ~= "" and arg_302_1.actors_[var_305_8.prefab_name] ~= nil then
						local var_305_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_8.prefab_name].transform, "story_v_out_426071", "426071072", "story_v_out_426071.awb")

						arg_302_1:RecordAudio("426071072", var_305_13)
						arg_302_1:RecordAudio("426071072", var_305_13)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_426071", "426071072", "story_v_out_426071.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_426071", "426071072", "story_v_out_426071.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_14 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_14 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_14

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_14 and arg_302_1.time_ < var_305_6 + var_305_14 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	Play426071073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 426071073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play426071074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["6148ui_story"]) and arg_306_1.var_.characterEffect6148ui_story == nil then
				arg_306_1.var_.characterEffect6148ui_story = arg_306_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["6148ui_story"]) then
				if arg_306_1.var_.characterEffect6148ui_story and not isNil(arg_306_1.actors_["6148ui_story"]) then
					arg_306_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_306_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["6148ui_story"]) and arg_306_1.var_.characterEffect6148ui_story then
				arg_306_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_306_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.15

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(426071073).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 6 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 6)

				if (6 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 6)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play426071074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 426071074
		arg_310_1.duration_ = 2

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play426071075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos6148ui_story = arg_310_1.actors_["6148ui_story"].transform.localPosition

				local var_313_0 = GameObjectTools.GetOrAddComponent(arg_310_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_313_0 then
					var_313_0:EnableDynamicBone(false)
				end
			end

			local var_313_1 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_1 then
				arg_310_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_310_1.time_ - 0) / var_313_1)
				arg_310_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["6148ui_story"].transform.position).z)
				arg_310_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["6148ui_story"].transform.localEulerAngles = arg_310_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_1 and arg_310_1.time_ < 0 + var_313_1 + arg_313_0 then
				arg_310_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_310_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["6148ui_story"].transform.position).z)
				arg_310_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["6148ui_story"].transform.localEulerAngles = arg_310_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_313_2 = GameObjectTools.GetOrAddComponent(arg_310_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_313_2 then
					var_313_2:EnableDynamicBone(true)
				end
			end

			local var_313_3 = arg_310_1.actors_["6148ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_3) and arg_310_1.var_.characterEffect6148ui_story == nil then
				arg_310_1.var_.characterEffect6148ui_story = var_313_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_4 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 and not isNil(var_313_3) then
				if arg_310_1.var_.characterEffect6148ui_story and not isNil(var_313_3) then
					arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 and not isNil(var_313_3) and arg_310_1.var_.characterEffect6148ui_story then
				arg_310_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_313_6 = 0
			local var_313_7 = 0.1

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_8 = arg_310_1:GetWordFromCfg(426071074)
				local var_313_9 = arg_310_1:FormatText(var_313_8.content)

				arg_310_1.text_.text = var_313_9

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_11 = 4 <= 0 and var_313_7 or var_313_7 * (utf8.len(var_313_9) / 4)

				if (4 <= 0 and var_313_7 or var_313_7 * (utf8.len(var_313_9) / 4)) > 0 and var_313_7 < var_313_11 then
					arg_310_1.talkMaxDuration = var_313_11

					if var_313_11 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_6
					end
				end

				arg_310_1.text_.text = var_313_9
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071074", "story_v_out_426071.awb") ~= 0 then
					local var_313_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071074", "story_v_out_426071.awb") / 1000

					if var_313_12 + var_313_6 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_12 + var_313_6
					end

					if var_313_8.prefab_name ~= "" and arg_310_1.actors_[var_313_8.prefab_name] ~= nil then
						local var_313_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_8.prefab_name].transform, "story_v_out_426071", "426071074", "story_v_out_426071.awb")

						arg_310_1:RecordAudio("426071074", var_313_13)
						arg_310_1:RecordAudio("426071074", var_313_13)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_426071", "426071074", "story_v_out_426071.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_426071", "426071074", "story_v_out_426071.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_14 = math.max(var_313_7, arg_310_1.talkMaxDuration)

			if var_313_6 <= arg_310_1.time_ and arg_310_1.time_ < var_313_6 + var_313_14 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_6) / var_313_14

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_6 + var_313_14 and arg_310_1.time_ < var_313_6 + var_313_14 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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

		arg_310_1:InitPlayNodeList()
	end,
	Play426071075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 426071075
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play426071076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["6148ui_story"]) and arg_314_1.var_.characterEffect6148ui_story == nil then
				arg_314_1.var_.characterEffect6148ui_story = arg_314_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["6148ui_story"]) then
				if arg_314_1.var_.characterEffect6148ui_story and not isNil(arg_314_1.actors_["6148ui_story"]) then
					arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_314_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_0)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["6148ui_story"]) and arg_314_1.var_.characterEffect6148ui_story then
				arg_314_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_314_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_317_1 = 0
			local var_317_2 = 0.825

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_3 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(426071075).content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 33 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 33)

				if (33 <= 0 and var_317_2 or var_317_2 * (utf8.len(var_317_3) / 33)) > 0 and var_317_2 < var_317_5 then
					arg_314_1.talkMaxDuration = var_317_5

					if var_317_5 + var_317_1 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + var_317_1
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_6 = math.max(var_317_2, arg_314_1.talkMaxDuration)

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_6 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_1) / var_317_6

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_1 + var_317_6 and arg_314_1.time_ < var_317_1 + var_317_6 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play426071076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 426071076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play426071077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.525

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(426071076).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 21 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 21)

				if (21 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 21)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play426071077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 426071077
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play426071078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.65

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(426071077).content)

				arg_322_1.text_.text = var_325_1

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_3 = 26 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 26)

				if (26 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 26)) > 0 and var_325_0 < var_325_3 then
					arg_322_1.talkMaxDuration = var_325_3

					if var_325_3 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_3 + 0
					end
				end

				arg_322_1.text_.text = var_325_1
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_4 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_4

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play426071078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 426071078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play426071079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos6148ui_story = arg_326_1.actors_["6148ui_story"].transform.localPosition

				local var_329_0 = GameObjectTools.GetOrAddComponent(arg_326_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_329_0 then
					var_329_0:EnableDynamicBone(false)
				end
			end

			local var_329_1 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_1 then
				arg_326_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 0) / var_329_1)
				arg_326_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["6148ui_story"].transform.position).z)
				arg_326_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["6148ui_story"].transform.localEulerAngles = arg_326_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_1 and arg_326_1.time_ < 0 + var_329_1 + arg_329_0 then
				arg_326_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["6148ui_story"].transform.position).z)
				arg_326_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["6148ui_story"].transform.localEulerAngles = arg_326_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_329_2 = GameObjectTools.GetOrAddComponent(arg_326_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_329_2 then
					var_329_2:EnableDynamicBone(true)
				end
			end

			local var_329_3 = 0
			local var_329_4 = 0.55

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_3 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_5 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(426071078).content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 22 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 22)

				if (22 <= 0 and var_329_4 or var_329_4 * (utf8.len(var_329_5) / 22)) > 0 and var_329_4 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_3 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_3
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_4, arg_326_1.talkMaxDuration)

			if var_329_3 <= arg_326_1.time_ and arg_326_1.time_ < var_329_3 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_3) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_3 + var_329_8 and arg_326_1.time_ < var_329_3 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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

		arg_326_1:InitPlayNodeList()
	end,
	Play426071079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 426071079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play426071080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.175

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(426071079).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 7 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 7)

				if (7 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 7)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play426071080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 426071080
		arg_334_1.duration_ = 16.03

		local var_334_0 = {
			zh = 10.099999999999,
			ja = 16.032999999999
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play426071081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if arg_334_1.bgs_.ST37 == nil then
				local var_337_0 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_337_0.name = "ST37"
				var_337_0.transform.parent = arg_334_1.stage_.transform
				var_337_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_.ST37 = var_337_0
			end

			if 2 < arg_334_1.time_ and arg_334_1.time_ <= 2 + arg_337_0 then
				local var_337_1 = arg_334_1.bgs_.ST37

				arg_334_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_337_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_2 = var_337_1:GetComponent("SpriteRenderer")

				if var_337_2 and var_337_2.sprite then
					local var_337_3 = 2 * (var_337_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_337_1.transform.localScale = Vector3.New(var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "ST37" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_4 = 3.999999999999

			if 3.999999999999 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			if arg_334_1.time_ >= var_337_4 + 0.3 and arg_334_1.time_ < var_337_4 + 0.3 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_5 = 0

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_6 = 2

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_6 then
				local var_337_7 = Color.New(0, 0, 0)

				var_337_7.a = Mathf.Lerp(0, 1, (arg_334_1.time_ - var_337_5) / var_337_6)
				arg_334_1.mask_.color = var_337_7
			end

			if arg_334_1.time_ >= var_337_5 + var_337_6 and arg_334_1.time_ < var_337_5 + var_337_6 + arg_337_0 then
				local var_337_8 = Color.New(0, 0, 0)

				var_337_8.a = 1
				arg_334_1.mask_.color = var_337_8
			end

			local var_337_9 = 2

			if 2 < arg_334_1.time_ and arg_334_1.time_ <= var_337_9 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_10 = 2

			if var_337_9 <= arg_334_1.time_ and arg_334_1.time_ < var_337_9 + var_337_10 then
				local var_337_11 = Color.New(0, 0, 0)

				var_337_11.a = Mathf.Lerp(1, 0, (arg_334_1.time_ - var_337_9) / var_337_10)
				arg_334_1.mask_.color = var_337_11
			end

			if arg_334_1.time_ >= var_337_9 + var_337_10 and arg_334_1.time_ < var_337_9 + var_337_10 + arg_337_0 then
				local var_337_12 = Color.New(0, 0, 0)

				arg_334_1.mask_.enabled = false
				var_337_12.a = 0
				arg_334_1.mask_.color = var_337_12
			end

			if 2.16666666666667 < arg_334_1.time_ and arg_334_1.time_ <= 2.16666666666667 + arg_337_0 then
				arg_334_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 2.64166666666667 < arg_334_1.time_ and arg_334_1.time_ <= 2.64166666666667 + arg_337_0 then
				arg_334_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_15 = 3.999999999999
			local var_337_16 = 0.575

			if 3.999999999999 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_17 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_17:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_18 = arg_334_1:GetWordFromCfg(426071080)
				local var_337_19 = arg_334_1:FormatText(var_337_18.content)

				arg_334_1.text_.text = var_337_19

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_21 = 23 <= 0 and var_337_16 or var_337_16 * (utf8.len(var_337_19) / 23)

				if (23 <= 0 and var_337_16 or var_337_16 * (utf8.len(var_337_19) / 23)) > 0 and var_337_16 < var_337_21 then
					arg_334_1.talkMaxDuration = var_337_21
					var_337_15 = var_337_15 + 0.3

					if var_337_21 + var_337_15 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_21 + var_337_15
					end
				end

				arg_334_1.text_.text = var_337_19
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071080", "story_v_out_426071.awb") ~= 0 then
					local var_337_22 = manager.audio:GetVoiceLength("story_v_out_426071", "426071080", "story_v_out_426071.awb") / 1000

					if var_337_22 + var_337_15 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_22 + var_337_15
					end

					if var_337_18.prefab_name ~= "" and arg_334_1.actors_[var_337_18.prefab_name] ~= nil then
						local var_337_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_18.prefab_name].transform, "story_v_out_426071", "426071080", "story_v_out_426071.awb")

						arg_334_1:RecordAudio("426071080", var_337_23)
						arg_334_1:RecordAudio("426071080", var_337_23)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_426071", "426071080", "story_v_out_426071.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_426071", "426071080", "story_v_out_426071.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_24 = var_337_15 + 0.3
			local var_337_25 = math.max(var_337_16, arg_334_1.talkMaxDuration)

			if var_337_15 + 0.3 <= arg_334_1.time_ and arg_334_1.time_ < var_337_24 + var_337_25 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_24) / var_337_25

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_24 + var_337_25 and arg_334_1.time_ < var_337_24 + var_337_25 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play426071081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 426071081
		arg_340_1.duration_ = 13

		local var_340_0 = {
			zh = 12.133,
			ja = 13
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play426071082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 1.025

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_1 = arg_340_1:GetWordFromCfg(426071081)
				local var_343_2 = arg_340_1:FormatText(var_343_1.content)

				arg_340_1.text_.text = var_343_2

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 41 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 41)

				if (41 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_2) / 41)) > 0 and var_343_0 < var_343_4 then
					arg_340_1.talkMaxDuration = var_343_4

					if var_343_4 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_4 + 0
					end
				end

				arg_340_1.text_.text = var_343_2
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071081", "story_v_out_426071.awb") ~= 0 then
					local var_343_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071081", "story_v_out_426071.awb") / 1000

					if var_343_5 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_5 + 0
					end

					if var_343_1.prefab_name ~= "" and arg_340_1.actors_[var_343_1.prefab_name] ~= nil then
						local var_343_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_1.prefab_name].transform, "story_v_out_426071", "426071081", "story_v_out_426071.awb")

						arg_340_1:RecordAudio("426071081", var_343_6)
						arg_340_1:RecordAudio("426071081", var_343_6)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_426071", "426071081", "story_v_out_426071.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_426071", "426071081", "story_v_out_426071.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_7 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_7

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play426071082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 426071082
		arg_344_1.duration_ = 12.03

		local var_344_0 = {
			zh = 8,
			ja = 12.033
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play426071083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0.5 < arg_344_1.time_ and arg_344_1.time_ <= 0.5 + arg_347_0 then
				arg_344_1:AudioAction("play", "effect", "se_story_143", "se_story_143_knock", "")
			end

			local var_347_1 = 0
			local var_347_2 = 0.5

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(426071082)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_6 = 20 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 20)

				if (20 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 20)) > 0 and var_347_2 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071082", "story_v_out_426071.awb") ~= 0 then
					local var_347_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071082", "story_v_out_426071.awb") / 1000

					if var_347_7 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_1
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_426071", "426071082", "story_v_out_426071.awb")

						arg_344_1:RecordAudio("426071082", var_347_8)
						arg_344_1:RecordAudio("426071082", var_347_8)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_426071", "426071082", "story_v_out_426071.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_426071", "426071082", "story_v_out_426071.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_9 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_9 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_9

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_9 and arg_344_1.time_ < var_347_1 + var_347_9 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play426071083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 426071083
		arg_348_1.duration_ = 5.63

		local var_348_0 = {
			zh = 5.633,
			ja = 5.566
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play426071084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0.833767599659041 < arg_348_1.time_ and arg_348_1.time_ <= 0.833767599659041 + arg_351_0 then
				arg_348_1:AudioAction("play", "effect", "se_story_143", "se_story_143_knock02", "")
			end

			local var_351_1 = 0
			local var_351_2 = 0.375

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(426071083)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_6 = 15 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_4) / 15)

				if (15 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_4) / 15)) > 0 and var_351_2 < var_351_6 then
					arg_348_1.talkMaxDuration = var_351_6

					if var_351_6 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_1
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071083", "story_v_out_426071.awb") ~= 0 then
					local var_351_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071083", "story_v_out_426071.awb") / 1000

					if var_351_7 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_1
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_426071", "426071083", "story_v_out_426071.awb")

						arg_348_1:RecordAudio("426071083", var_351_8)
						arg_348_1:RecordAudio("426071083", var_351_8)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_426071", "426071083", "story_v_out_426071.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_426071", "426071083", "story_v_out_426071.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_9 = math.max(var_351_2, arg_348_1.talkMaxDuration)

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_9 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_1) / var_351_9

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_1 + var_351_9 and arg_348_1.time_ < var_351_1 + var_351_9 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play426071084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 426071084
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play426071085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 1.175

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_1 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(426071084).content)

				arg_352_1.text_.text = var_355_1

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_3 = 47 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 47)

				if (47 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 47)) > 0 and var_355_0 < var_355_3 then
					arg_352_1.talkMaxDuration = var_355_3

					if var_355_3 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_3 + 0
					end
				end

				arg_352_1.text_.text = var_355_1
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_4 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_4

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play426071085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 426071085
		arg_356_1.duration_ = 3.03

		local var_356_0 = {
			zh = 3.033,
			ja = 2.933
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play426071086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1054ui_story = arg_356_1.actors_["1054ui_story"].transform.localPosition

				local var_359_0 = GameObjectTools.GetOrAddComponent(arg_356_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_359_0 then
					var_359_0:EnableDynamicBone(false)
				end
			end

			local var_359_1 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_1 then
				arg_356_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_356_1.time_ - 0) / var_359_1)
				arg_356_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1054ui_story"].transform.position).z)
				arg_356_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1054ui_story"].transform.localEulerAngles = arg_356_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_1 and arg_356_1.time_ < 0 + var_359_1 + arg_359_0 then
				arg_356_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_356_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1054ui_story"].transform.position).z)
				arg_356_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1054ui_story"].transform.localEulerAngles = arg_356_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_359_2 = GameObjectTools.GetOrAddComponent(arg_356_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_359_2 then
					var_359_2:EnableDynamicBone(true)
				end
			end

			local var_359_3 = arg_356_1.actors_["1054ui_story"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_3) and arg_356_1.var_.characterEffect1054ui_story == nil then
				arg_356_1.var_.characterEffect1054ui_story = var_359_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_4 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_4 and not isNil(var_359_3) then
				if arg_356_1.var_.characterEffect1054ui_story and not isNil(var_359_3) then
					arg_356_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_4 and arg_356_1.time_ < 0 + var_359_4 + arg_359_0 and not isNil(var_359_3) and arg_356_1.var_.characterEffect1054ui_story then
				arg_356_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_359_6 = 0
			local var_359_7 = 0.15

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_6 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_8 = arg_356_1:GetWordFromCfg(426071085)
				local var_359_9 = arg_356_1:FormatText(var_359_8.content)

				arg_356_1.text_.text = var_359_9

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_11 = 6 <= 0 and var_359_7 or var_359_7 * (utf8.len(var_359_9) / 6)

				if (6 <= 0 and var_359_7 or var_359_7 * (utf8.len(var_359_9) / 6)) > 0 and var_359_7 < var_359_11 then
					arg_356_1.talkMaxDuration = var_359_11

					if var_359_11 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_11 + var_359_6
					end
				end

				arg_356_1.text_.text = var_359_9
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071085", "story_v_out_426071.awb") ~= 0 then
					local var_359_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071085", "story_v_out_426071.awb") / 1000

					if var_359_12 + var_359_6 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_12 + var_359_6
					end

					if var_359_8.prefab_name ~= "" and arg_356_1.actors_[var_359_8.prefab_name] ~= nil then
						local var_359_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_8.prefab_name].transform, "story_v_out_426071", "426071085", "story_v_out_426071.awb")

						arg_356_1:RecordAudio("426071085", var_359_13)
						arg_356_1:RecordAudio("426071085", var_359_13)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_426071", "426071085", "story_v_out_426071.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_426071", "426071085", "story_v_out_426071.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_14 = math.max(var_359_7, arg_356_1.talkMaxDuration)

			if var_359_6 <= arg_356_1.time_ and arg_356_1.time_ < var_359_6 + var_359_14 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_6) / var_359_14

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_6 + var_359_14 and arg_356_1.time_ < var_359_6 + var_359_14 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
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

		arg_356_1:InitPlayNodeList()
	end,
	Play426071086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 426071086
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play426071087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos1054ui_story = arg_360_1.actors_["1054ui_story"].transform.localPosition

				local var_363_0 = GameObjectTools.GetOrAddComponent(arg_360_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_363_0 then
					var_363_0:EnableDynamicBone(false)
				end
			end

			local var_363_1 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_1 then
				arg_360_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_360_1.time_ - 0) / var_363_1)
				arg_360_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1054ui_story"].transform.position).z)
				arg_360_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1054ui_story"].transform.localEulerAngles = arg_360_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_1 and arg_360_1.time_ < 0 + var_363_1 + arg_363_0 then
				arg_360_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_360_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["1054ui_story"].transform.position).z)
				arg_360_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["1054ui_story"].transform.localEulerAngles = arg_360_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_363_2 = GameObjectTools.GetOrAddComponent(arg_360_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_363_2 then
					var_363_2:EnableDynamicBone(true)
				end
			end

			local var_363_3 = arg_360_1.actors_["1054ui_story"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_3) and arg_360_1.var_.characterEffect1054ui_story == nil then
				arg_360_1.var_.characterEffect1054ui_story = var_363_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_4 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 and not isNil(var_363_3) then
				if arg_360_1.var_.characterEffect1054ui_story and not isNil(var_363_3) then
					arg_360_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_360_1.time_ - 0) / var_363_4)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 and not isNil(var_363_3) and arg_360_1.var_.characterEffect1054ui_story then
				arg_360_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_363_5 = 0
			local var_363_6 = 0.95

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_5 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_7 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(426071086).content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 38 <= 0 and var_363_6 or var_363_6 * (utf8.len(var_363_7) / 38)

				if (38 <= 0 and var_363_6 or var_363_6 * (utf8.len(var_363_7) / 38)) > 0 and var_363_6 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_5 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_5
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_10 = math.max(var_363_6, arg_360_1.talkMaxDuration)

			if var_363_5 <= arg_360_1.time_ and arg_360_1.time_ < var_363_5 + var_363_10 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_5) / var_363_10

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_5 + var_363_10 and arg_360_1.time_ < var_363_5 + var_363_10 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
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

		arg_360_1:InitPlayNodeList()
	end,
	Play426071087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 426071087
		arg_364_1.duration_ = 5.67

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play426071088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0.366666666666667 < arg_364_1.time_ and arg_364_1.time_ <= 0.366666666666667 + arg_367_0 then
				arg_364_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_367_0 = 0.3

			if 0.366666666666667 <= arg_364_1.time_ and arg_364_1.time_ < 0.366666666666667 + var_367_0 then
				local var_367_1, var_367_2 = math.modf((arg_364_1.time_ - 0.366666666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_367_2 * 0.13, var_367_2 * 0.13, var_367_2 * 0.13) + arg_364_1.var_.shakeOldPos
			end

			if arg_364_1.time_ >= 0.366666666666667 + var_367_0 and arg_364_1.time_ < 0.366666666666667 + var_367_0 + arg_367_0 then
				manager.ui.mainCamera.transform.localPosition = arg_364_1.var_.shakeOldPos
			end

			local var_367_3 = 0

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_3 + arg_367_0 then
				arg_364_1.allBtn_.enabled = false
			end

			if arg_364_1.time_ >= var_367_3 + 0.666666666666667 and arg_364_1.time_ < var_367_3 + 0.666666666666667 + arg_367_0 then
				arg_364_1.allBtn_.enabled = true
			end

			if arg_364_1.frameCnt_ <= 1 then
				arg_364_1.dialog_:SetActive(false)
			end

			local var_367_4 = 0.666666666666667
			local var_367_5 = 0.85

			if 0.666666666666667 < arg_364_1.time_ and arg_364_1.time_ <= var_367_4 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0

				arg_364_1.dialog_:SetActive(true)

				arg_364_1.dialogCg_.alpha = 0

				local var_367_6 = LeanTween.value(arg_364_1.dialog_, 0, 1, 0.3)

				var_367_6:setOnUpdate(LuaHelper.FloatAction(function(arg_368_0)
					arg_364_1.dialogCg_.alpha = arg_368_0
				end))
				var_367_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_364_1.dialog_)
					var_367_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_364_1.duration_ = arg_364_1.duration_ + 0.3

				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_7 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(426071087).content)

				arg_364_1.text_.text = var_367_7

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_9 = 34 <= 0 and var_367_5 or var_367_5 * (utf8.len(var_367_7) / 34)

				if (34 <= 0 and var_367_5 or var_367_5 * (utf8.len(var_367_7) / 34)) > 0 and var_367_5 < var_367_9 then
					arg_364_1.talkMaxDuration = var_367_9
					var_367_4 = var_367_4 + 0.3

					if var_367_9 + var_367_4 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_9 + var_367_4
					end
				end

				arg_364_1.text_.text = var_367_7
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = var_367_4 + 0.3
			local var_367_11 = math.max(var_367_5, arg_364_1.talkMaxDuration)

			if var_367_4 + 0.3 <= arg_364_1.time_ and arg_364_1.time_ < var_367_10 + var_367_11 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_10) / var_367_11

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_10 + var_367_11 and arg_364_1.time_ < var_367_10 + var_367_11 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play426071088 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 426071088
		arg_370_1.duration_ = 9.67

		local var_370_0 = {
			zh = 6.133,
			ja = 9.666
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play426071089(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.325

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_1 = arg_370_1:GetWordFromCfg(426071088)
				local var_373_2 = arg_370_1:FormatText(var_373_1.content)

				arg_370_1.text_.text = var_373_2

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_4 = 13 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 13)

				if (13 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 13)) > 0 and var_373_0 < var_373_4 then
					arg_370_1.talkMaxDuration = var_373_4

					if var_373_4 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_4 + 0
					end
				end

				arg_370_1.text_.text = var_373_2
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071088", "story_v_out_426071.awb") ~= 0 then
					local var_373_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071088", "story_v_out_426071.awb") / 1000

					if var_373_5 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + 0
					end

					if var_373_1.prefab_name ~= "" and arg_370_1.actors_[var_373_1.prefab_name] ~= nil then
						local var_373_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_1.prefab_name].transform, "story_v_out_426071", "426071088", "story_v_out_426071.awb")

						arg_370_1:RecordAudio("426071088", var_373_6)
						arg_370_1:RecordAudio("426071088", var_373_6)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_426071", "426071088", "story_v_out_426071.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_426071", "426071088", "story_v_out_426071.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_7 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_7

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play426071089 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 426071089
		arg_374_1.duration_ = 6

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play426071090(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1054ui_story = arg_374_1.actors_["1054ui_story"].transform.localPosition

				local var_377_0 = GameObjectTools.GetOrAddComponent(arg_374_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_377_0 then
					var_377_0:EnableDynamicBone(false)
				end
			end

			local var_377_1 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_1 then
				arg_374_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_374_1.time_ - 0) / var_377_1)
				arg_374_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1054ui_story"].transform.position).z)
				arg_374_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1054ui_story"].transform.localEulerAngles = arg_374_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_1 and arg_374_1.time_ < 0 + var_377_1 + arg_377_0 then
				arg_374_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_374_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1054ui_story"].transform.position).z)
				arg_374_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1054ui_story"].transform.localEulerAngles = arg_374_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_377_2 = GameObjectTools.GetOrAddComponent(arg_374_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_377_2 then
					var_377_2:EnableDynamicBone(true)
				end
			end

			if 0.6 < arg_374_1.time_ and arg_374_1.time_ <= 0.6 + arg_377_0 then
				arg_374_1:AudioAction("play", "effect", "se_story_5", "se_story_5_back", "")
			end

			local var_377_4 = arg_374_1.bgs_.ST37.transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPosST37 = var_377_4.localPosition
			end

			local var_377_5 = 1.46666666666667

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_5 then
				var_377_4.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPosST37, Vector3.New(0, 1, 9.5), (arg_374_1.time_ - 0) / var_377_5)
			end

			if arg_374_1.time_ >= 0 + var_377_5 and arg_374_1.time_ < 0 + var_377_5 + arg_377_0 then
				var_377_4.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_377_6 = 0

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_6 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			if arg_374_1.time_ >= var_377_6 + 1.46666666666667 and arg_374_1.time_ < var_377_6 + 1.46666666666667 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			if arg_374_1.frameCnt_ <= 1 then
				arg_374_1.dialog_:SetActive(false)
			end

			local var_377_7 = 1
			local var_377_8 = 0.95

			if 1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_7 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				arg_374_1.dialog_:SetActive(true)

				arg_374_1.dialogCg_.alpha = 0

				local var_377_9 = LeanTween.value(arg_374_1.dialog_, 0, 1, 0.3)

				var_377_9:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_374_1.dialogCg_.alpha = arg_378_0
				end))
				var_377_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_374_1.dialog_)
					var_377_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_374_1.duration_ = arg_374_1.duration_ + 0.3

				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_10 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(426071089).content)

				arg_374_1.text_.text = var_377_10

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_12 = 38 <= 0 and var_377_8 or var_377_8 * (utf8.len(var_377_10) / 38)

				if (38 <= 0 and var_377_8 or var_377_8 * (utf8.len(var_377_10) / 38)) > 0 and var_377_8 < var_377_12 then
					arg_374_1.talkMaxDuration = var_377_12
					var_377_7 = var_377_7 + 0.3

					if var_377_12 + var_377_7 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_12 + var_377_7
					end
				end

				arg_374_1.text_.text = var_377_10
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_13 = var_377_7 + 0.3
			local var_377_14 = math.max(var_377_8, arg_374_1.talkMaxDuration)

			if var_377_7 + 0.3 <= arg_374_1.time_ and arg_374_1.time_ < var_377_13 + var_377_14 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_13) / var_377_14

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_13 + var_377_14 and arg_374_1.time_ < var_377_13 + var_377_14 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
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
				needEase = true,
				actorName = "ST37",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.46666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play426071090 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 426071090
		arg_380_1.duration_ = 3.1

		local var_380_0 = {
			zh = 3.1,
			ja = 2.066
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play426071091(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1054ui_story = arg_380_1.actors_["1054ui_story"].transform.localPosition

				local var_383_0 = GameObjectTools.GetOrAddComponent(arg_380_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_383_0 then
					var_383_0:EnableDynamicBone(false)
				end
			end

			local var_383_1 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_1 then
				arg_380_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_380_1.time_ - 0) / var_383_1)
				arg_380_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1054ui_story"].transform.position).z)
				arg_380_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1054ui_story"].transform.localEulerAngles = arg_380_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_1 and arg_380_1.time_ < 0 + var_383_1 + arg_383_0 then
				arg_380_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_380_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1054ui_story"].transform.position).z)
				arg_380_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1054ui_story"].transform.localEulerAngles = arg_380_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_383_2 = GameObjectTools.GetOrAddComponent(arg_380_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_383_2 then
					var_383_2:EnableDynamicBone(true)
				end
			end

			local var_383_3 = arg_380_1.actors_["1054ui_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_3) and arg_380_1.var_.characterEffect1054ui_story == nil then
				arg_380_1.var_.characterEffect1054ui_story = var_383_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_4 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 and not isNil(var_383_3) then
				if arg_380_1.var_.characterEffect1054ui_story and not isNil(var_383_3) then
					arg_380_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 and not isNil(var_383_3) and arg_380_1.var_.characterEffect1054ui_story then
				arg_380_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_383_6 = 0
			local var_383_7 = 0.25

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_6 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_8 = arg_380_1:GetWordFromCfg(426071090)
				local var_383_9 = arg_380_1:FormatText(var_383_8.content)

				arg_380_1.text_.text = var_383_9

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_11 = 10 <= 0 and var_383_7 or var_383_7 * (utf8.len(var_383_9) / 10)

				if (10 <= 0 and var_383_7 or var_383_7 * (utf8.len(var_383_9) / 10)) > 0 and var_383_7 < var_383_11 then
					arg_380_1.talkMaxDuration = var_383_11

					if var_383_11 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_11 + var_383_6
					end
				end

				arg_380_1.text_.text = var_383_9
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071090", "story_v_out_426071.awb") ~= 0 then
					local var_383_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071090", "story_v_out_426071.awb") / 1000

					if var_383_12 + var_383_6 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_12 + var_383_6
					end

					if var_383_8.prefab_name ~= "" and arg_380_1.actors_[var_383_8.prefab_name] ~= nil then
						local var_383_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_8.prefab_name].transform, "story_v_out_426071", "426071090", "story_v_out_426071.awb")

						arg_380_1:RecordAudio("426071090", var_383_13)
						arg_380_1:RecordAudio("426071090", var_383_13)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_426071", "426071090", "story_v_out_426071.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_426071", "426071090", "story_v_out_426071.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_14 = math.max(var_383_7, arg_380_1.talkMaxDuration)

			if var_383_6 <= arg_380_1.time_ and arg_380_1.time_ < var_383_6 + var_383_14 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_6) / var_383_14

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_6 + var_383_14 and arg_380_1.time_ < var_383_6 + var_383_14 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
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

		arg_380_1:InitPlayNodeList()
	end,
	Play426071091 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 426071091
		arg_384_1.duration_ = 12.27

		local var_384_0 = {
			zh = 12.266,
			ja = 10.8
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play426071092(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["1054ui_story"]) and arg_384_1.var_.characterEffect1054ui_story == nil then
				arg_384_1.var_.characterEffect1054ui_story = arg_384_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_0 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["1054ui_story"]) then
				if arg_384_1.var_.characterEffect1054ui_story and not isNil(arg_384_1.actors_["1054ui_story"]) then
					arg_384_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_384_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_384_1.time_ - 0) / var_387_0)
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["1054ui_story"]) and arg_384_1.var_.characterEffect1054ui_story then
				arg_384_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_384_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_387_1 = 0
			local var_387_2 = 0.975

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(426071091)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_6 = 39 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_4) / 39)

				if (39 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_4) / 39)) > 0 and var_387_2 < var_387_6 then
					arg_384_1.talkMaxDuration = var_387_6

					if var_387_6 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_6 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071091", "story_v_out_426071.awb") ~= 0 then
					local var_387_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071091", "story_v_out_426071.awb") / 1000

					if var_387_7 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_1
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_426071", "426071091", "story_v_out_426071.awb")

						arg_384_1:RecordAudio("426071091", var_387_8)
						arg_384_1:RecordAudio("426071091", var_387_8)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_426071", "426071091", "story_v_out_426071.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_426071", "426071091", "story_v_out_426071.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_9 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_9 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_9

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_9 and arg_384_1.time_ < var_387_1 + var_387_9 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play426071092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 426071092
		arg_388_1.duration_ = 9.13

		local var_388_0 = {
			zh = 9.133,
			ja = 4.733
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play426071093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1054ui_story = arg_388_1.actors_["1054ui_story"].transform.localPosition

				local var_391_0 = GameObjectTools.GetOrAddComponent(arg_388_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_391_0 then
					var_391_0:EnableDynamicBone(false)
				end
			end

			local var_391_1 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_1 then
				arg_388_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_388_1.time_ - 0) / var_391_1)
				arg_388_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1054ui_story"].transform.position).z)
				arg_388_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1054ui_story"].transform.localEulerAngles = arg_388_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_1 and arg_388_1.time_ < 0 + var_391_1 + arg_391_0 then
				arg_388_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_388_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1054ui_story"].transform.position).z)
				arg_388_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1054ui_story"].transform.localEulerAngles = arg_388_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_391_2 = GameObjectTools.GetOrAddComponent(arg_388_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_391_2 then
					var_391_2:EnableDynamicBone(true)
				end
			end

			local var_391_3 = arg_388_1.actors_["1054ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_3) and arg_388_1.var_.characterEffect1054ui_story == nil then
				arg_388_1.var_.characterEffect1054ui_story = var_391_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_4 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 and not isNil(var_391_3) then
				if arg_388_1.var_.characterEffect1054ui_story and not isNil(var_391_3) then
					arg_388_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 and not isNil(var_391_3) and arg_388_1.var_.characterEffect1054ui_story then
				arg_388_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_391_6 = 0
			local var_391_7 = 0.55

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_8 = arg_388_1:GetWordFromCfg(426071092)
				local var_391_9 = arg_388_1:FormatText(var_391_8.content)

				arg_388_1.text_.text = var_391_9

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_11 = 22 <= 0 and var_391_7 or var_391_7 * (utf8.len(var_391_9) / 22)

				if (22 <= 0 and var_391_7 or var_391_7 * (utf8.len(var_391_9) / 22)) > 0 and var_391_7 < var_391_11 then
					arg_388_1.talkMaxDuration = var_391_11

					if var_391_11 + var_391_6 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_11 + var_391_6
					end
				end

				arg_388_1.text_.text = var_391_9
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071092", "story_v_out_426071.awb") ~= 0 then
					local var_391_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071092", "story_v_out_426071.awb") / 1000

					if var_391_12 + var_391_6 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_12 + var_391_6
					end

					if var_391_8.prefab_name ~= "" and arg_388_1.actors_[var_391_8.prefab_name] ~= nil then
						local var_391_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_8.prefab_name].transform, "story_v_out_426071", "426071092", "story_v_out_426071.awb")

						arg_388_1:RecordAudio("426071092", var_391_13)
						arg_388_1:RecordAudio("426071092", var_391_13)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_426071", "426071092", "story_v_out_426071.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_426071", "426071092", "story_v_out_426071.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_14 = math.max(var_391_7, arg_388_1.talkMaxDuration)

			if var_391_6 <= arg_388_1.time_ and arg_388_1.time_ < var_391_6 + var_391_14 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_6) / var_391_14

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_6 + var_391_14 and arg_388_1.time_ < var_391_6 + var_391_14 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
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

		arg_388_1:InitPlayNodeList()
	end,
	Play426071093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 426071093
		arg_392_1.duration_ = 6.1

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play426071094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1054ui_story = arg_392_1.actors_["1054ui_story"].transform.localPosition

				local var_395_0 = GameObjectTools.GetOrAddComponent(arg_392_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_395_0 then
					var_395_0:EnableDynamicBone(false)
				end
			end

			local var_395_1 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_1 then
				arg_392_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_392_1.time_ - 0) / var_395_1)
				arg_392_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1054ui_story"].transform.position).z)
				arg_392_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1054ui_story"].transform.localEulerAngles = arg_392_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_1 and arg_392_1.time_ < 0 + var_395_1 + arg_395_0 then
				arg_392_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_392_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1054ui_story"].transform.position).z)
				arg_392_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1054ui_story"].transform.localEulerAngles = arg_392_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_395_2 = GameObjectTools.GetOrAddComponent(arg_392_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_395_2 then
					var_395_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_395_3 = 0
			local var_395_4 = 0.45

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_3 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_5 = arg_392_1:GetWordFromCfg(426071093)
				local var_395_6 = arg_392_1:FormatText(var_395_5.content)

				arg_392_1.text_.text = var_395_6

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_8 = 18 <= 0 and var_395_4 or var_395_4 * (utf8.len(var_395_6) / 18)

				if (18 <= 0 and var_395_4 or var_395_4 * (utf8.len(var_395_6) / 18)) > 0 and var_395_4 < var_395_8 then
					arg_392_1.talkMaxDuration = var_395_8

					if var_395_8 + var_395_3 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_3
					end
				end

				arg_392_1.text_.text = var_395_6
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071093", "story_v_out_426071.awb") ~= 0 then
					local var_395_9 = manager.audio:GetVoiceLength("story_v_out_426071", "426071093", "story_v_out_426071.awb") / 1000

					if var_395_9 + var_395_3 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_9 + var_395_3
					end

					if var_395_5.prefab_name ~= "" and arg_392_1.actors_[var_395_5.prefab_name] ~= nil then
						local var_395_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_5.prefab_name].transform, "story_v_out_426071", "426071093", "story_v_out_426071.awb")

						arg_392_1:RecordAudio("426071093", var_395_10)
						arg_392_1:RecordAudio("426071093", var_395_10)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_426071", "426071093", "story_v_out_426071.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_426071", "426071093", "story_v_out_426071.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_11 = math.max(var_395_4, arg_392_1.talkMaxDuration)

			if var_395_3 <= arg_392_1.time_ and arg_392_1.time_ < var_395_3 + var_395_11 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_3) / var_395_11

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_3 + var_395_11 and arg_392_1.time_ < var_395_3 + var_395_11 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
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

		arg_392_1:InitPlayNodeList()
	end,
	Play426071094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 426071094
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play426071095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1054ui_story"]) and arg_396_1.var_.characterEffect1054ui_story == nil then
				arg_396_1.var_.characterEffect1054ui_story = arg_396_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1054ui_story"]) then
				if arg_396_1.var_.characterEffect1054ui_story and not isNil(arg_396_1.actors_["1054ui_story"]) then
					arg_396_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_0)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1054ui_story"]) and arg_396_1.var_.characterEffect1054ui_story then
				arg_396_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_399_1 = 0
			local var_399_2 = 1.1

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_3 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(426071094).content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 44 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 44)

				if (44 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 44)) > 0 and var_399_2 < var_399_5 then
					arg_396_1.talkMaxDuration = var_399_5

					if var_399_5 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_6 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_6 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_6

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_6 and arg_396_1.time_ < var_399_1 + var_399_6 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play426071095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 426071095
		arg_400_1.duration_ = 12.27

		local var_400_0 = {
			zh = 8,
			ja = 12.266
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play426071096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.825

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_1 = arg_400_1:GetWordFromCfg(426071095)
				local var_403_2 = arg_400_1:FormatText(var_403_1.content)

				arg_400_1.text_.text = var_403_2

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 33 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 33)

				if (33 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 33)) > 0 and var_403_0 < var_403_4 then
					arg_400_1.talkMaxDuration = var_403_4

					if var_403_4 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_4 + 0
					end
				end

				arg_400_1.text_.text = var_403_2
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071095", "story_v_out_426071.awb") ~= 0 then
					local var_403_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071095", "story_v_out_426071.awb") / 1000

					if var_403_5 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + 0
					end

					if var_403_1.prefab_name ~= "" and arg_400_1.actors_[var_403_1.prefab_name] ~= nil then
						local var_403_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_1.prefab_name].transform, "story_v_out_426071", "426071095", "story_v_out_426071.awb")

						arg_400_1:RecordAudio("426071095", var_403_6)
						arg_400_1:RecordAudio("426071095", var_403_6)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_426071", "426071095", "story_v_out_426071.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_426071", "426071095", "story_v_out_426071.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_7 and arg_400_1.time_ < 0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play426071096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 426071096
		arg_404_1.duration_ = 6.5

		local var_404_0 = {
			zh = 6.5,
			ja = 5.333
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play426071097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1054ui_story"]) and arg_404_1.var_.characterEffect1054ui_story == nil then
				arg_404_1.var_.characterEffect1054ui_story = arg_404_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1054ui_story"]) then
				if arg_404_1.var_.characterEffect1054ui_story and not isNil(arg_404_1.actors_["1054ui_story"]) then
					arg_404_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1054ui_story"]) and arg_404_1.var_.characterEffect1054ui_story then
				arg_404_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_407_2 = 0
			local var_407_3 = 0.475

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_2 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_4 = arg_404_1:GetWordFromCfg(426071096)
				local var_407_5 = arg_404_1:FormatText(var_407_4.content)

				arg_404_1.text_.text = var_407_5

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_7 = 19 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 19)

				if (19 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 19)) > 0 and var_407_3 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_2
					end
				end

				arg_404_1.text_.text = var_407_5
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071096", "story_v_out_426071.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_out_426071", "426071096", "story_v_out_426071.awb") / 1000

					if var_407_8 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_2
					end

					if var_407_4.prefab_name ~= "" and arg_404_1.actors_[var_407_4.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_4.prefab_name].transform, "story_v_out_426071", "426071096", "story_v_out_426071.awb")

						arg_404_1:RecordAudio("426071096", var_407_9)
						arg_404_1:RecordAudio("426071096", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_426071", "426071096", "story_v_out_426071.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_426071", "426071096", "story_v_out_426071.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_3, arg_404_1.talkMaxDuration)

			if var_407_2 <= arg_404_1.time_ and arg_404_1.time_ < var_407_2 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_2) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_2 + var_407_10 and arg_404_1.time_ < var_407_2 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play426071097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 426071097
		arg_408_1.duration_ = 1.5

		local var_408_0 = {
			zh = 1.266,
			ja = 1.5
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play426071098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["1054ui_story"]) and arg_408_1.var_.characterEffect1054ui_story == nil then
				arg_408_1.var_.characterEffect1054ui_story = arg_408_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_0 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["1054ui_story"]) then
				if arg_408_1.var_.characterEffect1054ui_story and not isNil(arg_408_1.actors_["1054ui_story"]) then
					arg_408_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_0)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["1054ui_story"]) and arg_408_1.var_.characterEffect1054ui_story then
				arg_408_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_411_1 = 0
			local var_411_2 = 0.075

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_3 = arg_408_1:GetWordFromCfg(426071097)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_6 = 3 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_4) / 3)

				if (3 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_4) / 3)) > 0 and var_411_2 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_1
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071097", "story_v_out_426071.awb") ~= 0 then
					local var_411_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071097", "story_v_out_426071.awb") / 1000

					if var_411_7 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_1
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_426071", "426071097", "story_v_out_426071.awb")

						arg_408_1:RecordAudio("426071097", var_411_8)
						arg_408_1:RecordAudio("426071097", var_411_8)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_426071", "426071097", "story_v_out_426071.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_426071", "426071097", "story_v_out_426071.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_9 = math.max(var_411_2, arg_408_1.talkMaxDuration)

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_9 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_1) / var_411_9

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_1 + var_411_9 and arg_408_1.time_ < var_411_1 + var_411_9 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play426071098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 426071098
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play426071099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.85

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_1 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(426071098).content)

				arg_412_1.text_.text = var_415_1

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_3 = 34 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 34)

				if (34 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 34)) > 0 and var_415_0 < var_415_3 then
					arg_412_1.talkMaxDuration = var_415_3

					if var_415_3 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_3 + 0
					end
				end

				arg_412_1.text_.text = var_415_1
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_4 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_4

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play426071099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 426071099
		arg_416_1.duration_ = 7.13

		local var_416_0 = {
			zh = 7.133,
			ja = 6
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play426071100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.275

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:GetWordFromCfg(426071099)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 11 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 11)

				if (11 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 11)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071099", "story_v_out_426071.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071099", "story_v_out_426071.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_426071", "426071099", "story_v_out_426071.awb")

						arg_416_1:RecordAudio("426071099", var_419_6)
						arg_416_1:RecordAudio("426071099", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_426071", "426071099", "story_v_out_426071.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_426071", "426071099", "story_v_out_426071.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play426071100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 426071100
		arg_420_1.duration_ = 14.43

		local var_420_0 = {
			zh = 14.433,
			ja = 13.733
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play426071101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.925

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_1 = arg_420_1:GetWordFromCfg(426071100)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 37 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 37)

				if (37 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 37)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071100", "story_v_out_426071.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071100", "story_v_out_426071.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_out_426071", "426071100", "story_v_out_426071.awb")

						arg_420_1:RecordAudio("426071100", var_423_6)
						arg_420_1:RecordAudio("426071100", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_426071", "426071100", "story_v_out_426071.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_426071", "426071100", "story_v_out_426071.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_7 = math.max(var_423_0, arg_420_1.talkMaxDuration)

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - 0) / var_423_7

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play426071101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 426071101
		arg_424_1.duration_ = 4.3

		local var_424_0 = {
			zh = 2.733,
			ja = 4.3
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play426071102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["1054ui_story"]) and arg_424_1.var_.characterEffect1054ui_story == nil then
				arg_424_1.var_.characterEffect1054ui_story = arg_424_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_0 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["1054ui_story"]) then
				if arg_424_1.var_.characterEffect1054ui_story and not isNil(arg_424_1.actors_["1054ui_story"]) then
					arg_424_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["1054ui_story"]) and arg_424_1.var_.characterEffect1054ui_story then
				arg_424_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_427_2 = 0
			local var_427_3 = 0.35

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_2 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_4 = arg_424_1:GetWordFromCfg(426071101)
				local var_427_5 = arg_424_1:FormatText(var_427_4.content)

				arg_424_1.text_.text = var_427_5

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_7 = 14 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_5) / 14)

				if (14 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_5) / 14)) > 0 and var_427_3 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_2
					end
				end

				arg_424_1.text_.text = var_427_5
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071101", "story_v_out_426071.awb") ~= 0 then
					local var_427_8 = manager.audio:GetVoiceLength("story_v_out_426071", "426071101", "story_v_out_426071.awb") / 1000

					if var_427_8 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_8 + var_427_2
					end

					if var_427_4.prefab_name ~= "" and arg_424_1.actors_[var_427_4.prefab_name] ~= nil then
						local var_427_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_4.prefab_name].transform, "story_v_out_426071", "426071101", "story_v_out_426071.awb")

						arg_424_1:RecordAudio("426071101", var_427_9)
						arg_424_1:RecordAudio("426071101", var_427_9)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_426071", "426071101", "story_v_out_426071.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_426071", "426071101", "story_v_out_426071.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_10 = math.max(var_427_3, arg_424_1.talkMaxDuration)

			if var_427_2 <= arg_424_1.time_ and arg_424_1.time_ < var_427_2 + var_427_10 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_2) / var_427_10

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_2 + var_427_10 and arg_424_1.time_ < var_427_2 + var_427_10 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play426071102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 426071102
		arg_428_1.duration_ = 4.33

		local var_428_0 = {
			zh = 3.266,
			ja = 4.333
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play426071103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(arg_428_1.actors_["1054ui_story"]) and arg_428_1.var_.characterEffect1054ui_story == nil then
				arg_428_1.var_.characterEffect1054ui_story = arg_428_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_0 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 and not isNil(arg_428_1.actors_["1054ui_story"]) then
				if arg_428_1.var_.characterEffect1054ui_story and not isNil(arg_428_1.actors_["1054ui_story"]) then
					arg_428_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_0)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 and not isNil(arg_428_1.actors_["1054ui_story"]) and arg_428_1.var_.characterEffect1054ui_story then
				arg_428_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_431_1 = 0
			local var_431_2 = 0.35

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_3 = arg_428_1:GetWordFromCfg(426071102)
				local var_431_4 = arg_428_1:FormatText(var_431_3.content)

				arg_428_1.text_.text = var_431_4

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_6 = 14 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_4) / 14)

				if (14 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_4) / 14)) > 0 and var_431_2 < var_431_6 then
					arg_428_1.talkMaxDuration = var_431_6

					if var_431_6 + var_431_1 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_6 + var_431_1
					end
				end

				arg_428_1.text_.text = var_431_4
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071102", "story_v_out_426071.awb") ~= 0 then
					local var_431_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071102", "story_v_out_426071.awb") / 1000

					if var_431_7 + var_431_1 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_1
					end

					if var_431_3.prefab_name ~= "" and arg_428_1.actors_[var_431_3.prefab_name] ~= nil then
						local var_431_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_3.prefab_name].transform, "story_v_out_426071", "426071102", "story_v_out_426071.awb")

						arg_428_1:RecordAudio("426071102", var_431_8)
						arg_428_1:RecordAudio("426071102", var_431_8)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_426071", "426071102", "story_v_out_426071.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_426071", "426071102", "story_v_out_426071.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_9 = math.max(var_431_2, arg_428_1.talkMaxDuration)

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_9 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_1) / var_431_9

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_1 + var_431_9 and arg_428_1.time_ < var_431_1 + var_431_9 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play426071103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 426071103
		arg_432_1.duration_ = 11.13

		local var_432_0 = {
			zh = 11.133,
			ja = 8.666
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play426071104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.925

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_1 = arg_432_1:GetWordFromCfg(426071103)
				local var_435_2 = arg_432_1:FormatText(var_435_1.content)

				arg_432_1.text_.text = var_435_2

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 37 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 37)

				if (37 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_2) / 37)) > 0 and var_435_0 < var_435_4 then
					arg_432_1.talkMaxDuration = var_435_4

					if var_435_4 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_4 + 0
					end
				end

				arg_432_1.text_.text = var_435_2
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071103", "story_v_out_426071.awb") ~= 0 then
					local var_435_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071103", "story_v_out_426071.awb") / 1000

					if var_435_5 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + 0
					end

					if var_435_1.prefab_name ~= "" and arg_432_1.actors_[var_435_1.prefab_name] ~= nil then
						local var_435_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_1.prefab_name].transform, "story_v_out_426071", "426071103", "story_v_out_426071.awb")

						arg_432_1:RecordAudio("426071103", var_435_6)
						arg_432_1:RecordAudio("426071103", var_435_6)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_426071", "426071103", "story_v_out_426071.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_426071", "426071103", "story_v_out_426071.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play426071104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 426071104
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play426071105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.675

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(426071104).content)

				arg_436_1.text_.text = var_439_1

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_3 = 27 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 27)

				if (27 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 27)) > 0 and var_439_0 < var_439_3 then
					arg_436_1.talkMaxDuration = var_439_3

					if var_439_3 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_3 + 0
					end
				end

				arg_436_1.text_.text = var_439_1
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_4 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_4

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play426071105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 426071105
		arg_440_1.duration_ = 4.9

		local var_440_0 = {
			zh = 4.9,
			ja = 4.7
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play426071106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos1054ui_story = arg_440_1.actors_["1054ui_story"].transform.localPosition

				local var_443_0 = GameObjectTools.GetOrAddComponent(arg_440_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_443_0 then
					var_443_0:EnableDynamicBone(false)
				end
			end

			local var_443_1 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_1 then
				arg_440_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_440_1.time_ - 0) / var_443_1)
				arg_440_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1054ui_story"].transform.position).z)
				arg_440_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1054ui_story"].transform.localEulerAngles = arg_440_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_1 and arg_440_1.time_ < 0 + var_443_1 + arg_443_0 then
				arg_440_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_440_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["1054ui_story"].transform.position).z)
				arg_440_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["1054ui_story"].transform.localEulerAngles = arg_440_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_443_2 = GameObjectTools.GetOrAddComponent(arg_440_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_443_2 then
					var_443_2:EnableDynamicBone(true)
				end
			end

			local var_443_3 = arg_440_1.actors_["1054ui_story"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_3) and arg_440_1.var_.characterEffect1054ui_story == nil then
				arg_440_1.var_.characterEffect1054ui_story = var_443_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_4 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 and not isNil(var_443_3) then
				if arg_440_1.var_.characterEffect1054ui_story and not isNil(var_443_3) then
					arg_440_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 and not isNil(var_443_3) and arg_440_1.var_.characterEffect1054ui_story then
				arg_440_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			local var_443_6 = 0
			local var_443_7 = 0.425

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_6 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_8 = arg_440_1:GetWordFromCfg(426071105)
				local var_443_9 = arg_440_1:FormatText(var_443_8.content)

				arg_440_1.text_.text = var_443_9

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_11 = 17 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 17)

				if (17 <= 0 and var_443_7 or var_443_7 * (utf8.len(var_443_9) / 17)) > 0 and var_443_7 < var_443_11 then
					arg_440_1.talkMaxDuration = var_443_11

					if var_443_11 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_6
					end
				end

				arg_440_1.text_.text = var_443_9
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071105", "story_v_out_426071.awb") ~= 0 then
					local var_443_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071105", "story_v_out_426071.awb") / 1000

					if var_443_12 + var_443_6 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_6
					end

					if var_443_8.prefab_name ~= "" and arg_440_1.actors_[var_443_8.prefab_name] ~= nil then
						local var_443_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_8.prefab_name].transform, "story_v_out_426071", "426071105", "story_v_out_426071.awb")

						arg_440_1:RecordAudio("426071105", var_443_13)
						arg_440_1:RecordAudio("426071105", var_443_13)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_426071", "426071105", "story_v_out_426071.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_426071", "426071105", "story_v_out_426071.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_7, arg_440_1.talkMaxDuration)

			if var_443_6 <= arg_440_1.time_ and arg_440_1.time_ < var_443_6 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_6) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_6 + var_443_14 and arg_440_1.time_ < var_443_6 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
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

		arg_440_1:InitPlayNodeList()
	end,
	Play426071106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 426071106
		arg_444_1.duration_ = 7.67

		local var_444_0 = {
			zh = 7.6,
			ja = 7.666
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play426071107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["1054ui_story"]) and arg_444_1.var_.characterEffect1054ui_story == nil then
				arg_444_1.var_.characterEffect1054ui_story = arg_444_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["1054ui_story"]) then
				if arg_444_1.var_.characterEffect1054ui_story and not isNil(arg_444_1.actors_["1054ui_story"]) then
					arg_444_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_0)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["1054ui_story"]) and arg_444_1.var_.characterEffect1054ui_story then
				arg_444_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_447_1 = 0
			local var_447_2 = 0.725

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_3 = arg_444_1:GetWordFromCfg(426071106)
				local var_447_4 = arg_444_1:FormatText(var_447_3.content)

				arg_444_1.text_.text = var_447_4

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_6 = 29 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 29)

				if (29 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_4) / 29)) > 0 and var_447_2 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_1
					end
				end

				arg_444_1.text_.text = var_447_4
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071106", "story_v_out_426071.awb") ~= 0 then
					local var_447_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071106", "story_v_out_426071.awb") / 1000

					if var_447_7 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_7 + var_447_1
					end

					if var_447_3.prefab_name ~= "" and arg_444_1.actors_[var_447_3.prefab_name] ~= nil then
						local var_447_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_3.prefab_name].transform, "story_v_out_426071", "426071106", "story_v_out_426071.awb")

						arg_444_1:RecordAudio("426071106", var_447_8)
						arg_444_1:RecordAudio("426071106", var_447_8)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_426071", "426071106", "story_v_out_426071.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_426071", "426071106", "story_v_out_426071.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_9 = math.max(var_447_2, arg_444_1.talkMaxDuration)

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_9 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_1) / var_447_9

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_1 + var_447_9 and arg_444_1.time_ < var_447_1 + var_447_9 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play426071107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 426071107
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play426071108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			local var_451_0 = 0
			local var_451_1 = 0.975

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_2 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(426071107).content)

				arg_448_1.text_.text = var_451_2

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 39 <= 0 and var_451_1 or var_451_1 * (utf8.len(var_451_2) / 39)

				if (39 <= 0 and var_451_1 or var_451_1 * (utf8.len(var_451_2) / 39)) > 0 and var_451_1 < var_451_4 then
					arg_448_1.talkMaxDuration = var_451_4

					if var_451_4 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_4 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_2
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_5 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_5 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_5

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_5 and arg_448_1.time_ < var_451_0 + var_451_5 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play426071108 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 426071108
		arg_452_1.duration_ = 2.07

		local var_452_0 = {
			zh = 2.066,
			ja = 1.6
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play426071109(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.1

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_1 = arg_452_1:GetWordFromCfg(426071108)
				local var_455_2 = arg_452_1:FormatText(var_455_1.content)

				arg_452_1.text_.text = var_455_2

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_4 = 4 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_2) / 4)

				if (4 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_2) / 4)) > 0 and var_455_0 < var_455_4 then
					arg_452_1.talkMaxDuration = var_455_4

					if var_455_4 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_4 + 0
					end
				end

				arg_452_1.text_.text = var_455_2
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071108", "story_v_out_426071.awb") ~= 0 then
					local var_455_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071108", "story_v_out_426071.awb") / 1000

					if var_455_5 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + 0
					end

					if var_455_1.prefab_name ~= "" and arg_452_1.actors_[var_455_1.prefab_name] ~= nil then
						local var_455_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_1.prefab_name].transform, "story_v_out_426071", "426071108", "story_v_out_426071.awb")

						arg_452_1:RecordAudio("426071108", var_455_6)
						arg_452_1:RecordAudio("426071108", var_455_6)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_426071", "426071108", "story_v_out_426071.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_426071", "426071108", "story_v_out_426071.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_7 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_7 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_7

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_7 and arg_452_1.time_ < 0 + var_455_7 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play426071109 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 426071109
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play426071110(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 1

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_1 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(426071109).content)

				arg_456_1.text_.text = var_459_1

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_3 = 40 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 40)

				if (40 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 40)) > 0 and var_459_0 < var_459_3 then
					arg_456_1.talkMaxDuration = var_459_3

					if var_459_3 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_3 + 0
					end
				end

				arg_456_1.text_.text = var_459_1
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_4 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_4

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play426071110 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 426071110
		arg_460_1.duration_ = 5.57

		local var_460_0 = {
			zh = 2.233,
			ja = 5.566
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play426071111(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1054ui_story = arg_460_1.actors_["1054ui_story"].transform.localPosition

				local var_463_0 = GameObjectTools.GetOrAddComponent(arg_460_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_463_0 then
					var_463_0:EnableDynamicBone(false)
				end
			end

			local var_463_1 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_1 then
				arg_460_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_460_1.time_ - 0) / var_463_1)
				arg_460_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1054ui_story"].transform.position).z)
				arg_460_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1054ui_story"].transform.localEulerAngles = arg_460_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_1 and arg_460_1.time_ < 0 + var_463_1 + arg_463_0 then
				arg_460_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_460_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1054ui_story"].transform.position).z)
				arg_460_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1054ui_story"].transform.localEulerAngles = arg_460_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_463_2 = GameObjectTools.GetOrAddComponent(arg_460_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_463_2 then
					var_463_2:EnableDynamicBone(true)
				end
			end

			local var_463_3 = arg_460_1.actors_["1054ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_3) and arg_460_1.var_.characterEffect1054ui_story == nil then
				arg_460_1.var_.characterEffect1054ui_story = var_463_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_4 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_4 and not isNil(var_463_3) then
				if arg_460_1.var_.characterEffect1054ui_story and not isNil(var_463_3) then
					arg_460_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_4 and arg_460_1.time_ < 0 + var_463_4 + arg_463_0 and not isNil(var_463_3) and arg_460_1.var_.characterEffect1054ui_story then
				arg_460_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_463_6 = 0
			local var_463_7 = 0.275

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_6 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_8 = arg_460_1:GetWordFromCfg(426071110)
				local var_463_9 = arg_460_1:FormatText(var_463_8.content)

				arg_460_1.text_.text = var_463_9

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_11 = 11 <= 0 and var_463_7 or var_463_7 * (utf8.len(var_463_9) / 11)

				if (11 <= 0 and var_463_7 or var_463_7 * (utf8.len(var_463_9) / 11)) > 0 and var_463_7 < var_463_11 then
					arg_460_1.talkMaxDuration = var_463_11

					if var_463_11 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_11 + var_463_6
					end
				end

				arg_460_1.text_.text = var_463_9
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071110", "story_v_out_426071.awb") ~= 0 then
					local var_463_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071110", "story_v_out_426071.awb") / 1000

					if var_463_12 + var_463_6 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_12 + var_463_6
					end

					if var_463_8.prefab_name ~= "" and arg_460_1.actors_[var_463_8.prefab_name] ~= nil then
						local var_463_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_8.prefab_name].transform, "story_v_out_426071", "426071110", "story_v_out_426071.awb")

						arg_460_1:RecordAudio("426071110", var_463_13)
						arg_460_1:RecordAudio("426071110", var_463_13)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_426071", "426071110", "story_v_out_426071.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_426071", "426071110", "story_v_out_426071.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_14 = math.max(var_463_7, arg_460_1.talkMaxDuration)

			if var_463_6 <= arg_460_1.time_ and arg_460_1.time_ < var_463_6 + var_463_14 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_6) / var_463_14

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_6 + var_463_14 and arg_460_1.time_ < var_463_6 + var_463_14 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
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

		arg_460_1:InitPlayNodeList()
	end,
	Play426071111 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 426071111
		arg_464_1.duration_ = 10.87

		local var_464_0 = {
			zh = 7.9,
			ja = 10.866
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play426071112(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1054ui_story"]) and arg_464_1.var_.characterEffect1054ui_story == nil then
				arg_464_1.var_.characterEffect1054ui_story = arg_464_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1054ui_story"]) then
				if arg_464_1.var_.characterEffect1054ui_story and not isNil(arg_464_1.actors_["1054ui_story"]) then
					arg_464_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_0)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1054ui_story"]) and arg_464_1.var_.characterEffect1054ui_story then
				arg_464_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_467_1 = 0
			local var_467_2 = 0.55

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:GetWordFromCfg(426071111)
				local var_467_4 = arg_464_1:FormatText(var_467_3.content)

				arg_464_1.text_.text = var_467_4

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_6 = 22 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_4) / 22)

				if (22 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_4) / 22)) > 0 and var_467_2 < var_467_6 then
					arg_464_1.talkMaxDuration = var_467_6

					if var_467_6 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_6 + var_467_1
					end
				end

				arg_464_1.text_.text = var_467_4
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071111", "story_v_out_426071.awb") ~= 0 then
					local var_467_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071111", "story_v_out_426071.awb") / 1000

					if var_467_7 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_7 + var_467_1
					end

					if var_467_3.prefab_name ~= "" and arg_464_1.actors_[var_467_3.prefab_name] ~= nil then
						local var_467_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_3.prefab_name].transform, "story_v_out_426071", "426071111", "story_v_out_426071.awb")

						arg_464_1:RecordAudio("426071111", var_467_8)
						arg_464_1:RecordAudio("426071111", var_467_8)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_426071", "426071111", "story_v_out_426071.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_426071", "426071111", "story_v_out_426071.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_9 = math.max(var_467_2, arg_464_1.talkMaxDuration)

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_9 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_1) / var_467_9

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_1 + var_467_9 and arg_464_1.time_ < var_467_1 + var_467_9 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play426071112 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 426071112
		arg_468_1.duration_ = 10.07

		local var_468_0 = {
			zh = 5.533,
			ja = 10.066
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play426071113(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.5

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_1 = arg_468_1:GetWordFromCfg(426071112)
				local var_471_2 = arg_468_1:FormatText(var_471_1.content)

				arg_468_1.text_.text = var_471_2

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 20 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 20)

				if (20 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 20)) > 0 and var_471_0 < var_471_4 then
					arg_468_1.talkMaxDuration = var_471_4

					if var_471_4 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_4 + 0
					end
				end

				arg_468_1.text_.text = var_471_2
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071112", "story_v_out_426071.awb") ~= 0 then
					local var_471_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071112", "story_v_out_426071.awb") / 1000

					if var_471_5 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_5 + 0
					end

					if var_471_1.prefab_name ~= "" and arg_468_1.actors_[var_471_1.prefab_name] ~= nil then
						local var_471_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_1.prefab_name].transform, "story_v_out_426071", "426071112", "story_v_out_426071.awb")

						arg_468_1:RecordAudio("426071112", var_471_6)
						arg_468_1:RecordAudio("426071112", var_471_6)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_426071", "426071112", "story_v_out_426071.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_426071", "426071112", "story_v_out_426071.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_7 and arg_468_1.time_ < 0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play426071113 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 426071113
		arg_472_1.duration_ = 4.9

		local var_472_0 = {
			zh = 4.9,
			ja = 4.133
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play426071114(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0.475

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_1 = arg_472_1:GetWordFromCfg(426071113)
				local var_475_2 = arg_472_1:FormatText(var_475_1.content)

				arg_472_1.text_.text = var_475_2

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 19 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 19)

				if (19 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 19)) > 0 and var_475_0 < var_475_4 then
					arg_472_1.talkMaxDuration = var_475_4

					if var_475_4 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_4 + 0
					end
				end

				arg_472_1.text_.text = var_475_2
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071113", "story_v_out_426071.awb") ~= 0 then
					local var_475_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071113", "story_v_out_426071.awb") / 1000

					if var_475_5 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + 0
					end

					if var_475_1.prefab_name ~= "" and arg_472_1.actors_[var_475_1.prefab_name] ~= nil then
						local var_475_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_1.prefab_name].transform, "story_v_out_426071", "426071113", "story_v_out_426071.awb")

						arg_472_1:RecordAudio("426071113", var_475_6)
						arg_472_1:RecordAudio("426071113", var_475_6)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_426071", "426071113", "story_v_out_426071.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_426071", "426071113", "story_v_out_426071.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_0, arg_472_1.talkMaxDuration)

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - 0) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= 0 + var_475_7 and arg_472_1.time_ < 0 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play426071114 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 426071114
		arg_476_1.duration_ = 2.07

		local var_476_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play426071115(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.var_.moveOldPos1054ui_story = arg_476_1.actors_["1054ui_story"].transform.localPosition

				local var_479_0 = GameObjectTools.GetOrAddComponent(arg_476_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_479_0 then
					var_479_0:EnableDynamicBone(false)
				end
			end

			local var_479_1 = 0.001

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_1 then
				arg_476_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_476_1.time_ - 0) / var_479_1)
				arg_476_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_476_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["1054ui_story"].transform.position).z)
				arg_476_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_476_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_476_1.actors_["1054ui_story"].transform.localEulerAngles = arg_476_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_476_1.time_ >= 0 + var_479_1 and arg_476_1.time_ < 0 + var_479_1 + arg_479_0 then
				arg_476_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_476_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_476_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_476_1.actors_["1054ui_story"].transform.position).z)
				arg_476_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_476_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_476_1.actors_["1054ui_story"].transform.localEulerAngles = arg_476_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_479_2 = GameObjectTools.GetOrAddComponent(arg_476_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_479_2 then
					var_479_2:EnableDynamicBone(true)
				end
			end

			local var_479_3 = arg_476_1.actors_["1054ui_story"]

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(var_479_3) and arg_476_1.var_.characterEffect1054ui_story == nil then
				arg_476_1.var_.characterEffect1054ui_story = var_479_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_4 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 and not isNil(var_479_3) then
				if arg_476_1.var_.characterEffect1054ui_story and not isNil(var_479_3) then
					arg_476_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 and not isNil(var_479_3) and arg_476_1.var_.characterEffect1054ui_story then
				arg_476_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_479_6 = 0
			local var_479_7 = 0.075

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_6 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_8 = arg_476_1:GetWordFromCfg(426071114)
				local var_479_9 = arg_476_1:FormatText(var_479_8.content)

				arg_476_1.text_.text = var_479_9

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_11 = 3 <= 0 and var_479_7 or var_479_7 * (utf8.len(var_479_9) / 3)

				if (3 <= 0 and var_479_7 or var_479_7 * (utf8.len(var_479_9) / 3)) > 0 and var_479_7 < var_479_11 then
					arg_476_1.talkMaxDuration = var_479_11

					if var_479_11 + var_479_6 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_11 + var_479_6
					end
				end

				arg_476_1.text_.text = var_479_9
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071114", "story_v_out_426071.awb") ~= 0 then
					local var_479_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071114", "story_v_out_426071.awb") / 1000

					if var_479_12 + var_479_6 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_12 + var_479_6
					end

					if var_479_8.prefab_name ~= "" and arg_476_1.actors_[var_479_8.prefab_name] ~= nil then
						local var_479_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_8.prefab_name].transform, "story_v_out_426071", "426071114", "story_v_out_426071.awb")

						arg_476_1:RecordAudio("426071114", var_479_13)
						arg_476_1:RecordAudio("426071114", var_479_13)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_426071", "426071114", "story_v_out_426071.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_426071", "426071114", "story_v_out_426071.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_14 = math.max(var_479_7, arg_476_1.talkMaxDuration)

			if var_479_6 <= arg_476_1.time_ and arg_476_1.time_ < var_479_6 + var_479_14 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_6) / var_479_14

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_6 + var_479_14 and arg_476_1.time_ < var_479_6 + var_479_14 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
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

		arg_476_1:InitPlayNodeList()
	end,
	Play426071115 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 426071115
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play426071116(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(arg_480_1.actors_["1054ui_story"]) and arg_480_1.var_.characterEffect1054ui_story == nil then
				arg_480_1.var_.characterEffect1054ui_story = arg_480_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_0 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 and not isNil(arg_480_1.actors_["1054ui_story"]) then
				if arg_480_1.var_.characterEffect1054ui_story and not isNil(arg_480_1.actors_["1054ui_story"]) then
					arg_480_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_480_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_480_1.time_ - 0) / var_483_0)
				end
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 and not isNil(arg_480_1.actors_["1054ui_story"]) and arg_480_1.var_.characterEffect1054ui_story then
				arg_480_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_480_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_483_1 = 0
			local var_483_2 = 0.875

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_3 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(426071115).content)

				arg_480_1.text_.text = var_483_3

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_5 = 35 <= 0 and var_483_2 or var_483_2 * (utf8.len(var_483_3) / 35)

				if (35 <= 0 and var_483_2 or var_483_2 * (utf8.len(var_483_3) / 35)) > 0 and var_483_2 < var_483_5 then
					arg_480_1.talkMaxDuration = var_483_5

					if var_483_5 + var_483_1 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_5 + var_483_1
					end
				end

				arg_480_1.text_.text = var_483_3
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_6 = math.max(var_483_2, arg_480_1.talkMaxDuration)

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_6 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_1) / var_483_6

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_1 + var_483_6 and arg_480_1.time_ < var_483_1 + var_483_6 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play426071116 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 426071116
		arg_484_1.duration_ = 4

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play426071117(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.var_.moveOldPos1054ui_story = arg_484_1.actors_["1054ui_story"].transform.localPosition

				local var_487_0 = GameObjectTools.GetOrAddComponent(arg_484_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_487_0 then
					var_487_0:EnableDynamicBone(false)
				end
			end

			local var_487_1 = 0.001

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_1 then
				arg_484_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_484_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_484_1.time_ - 0) / var_487_1)
				arg_484_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_484_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1054ui_story"].transform.position).z)
				arg_484_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_484_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_484_1.actors_["1054ui_story"].transform.localEulerAngles = arg_484_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_484_1.time_ >= 0 + var_487_1 and arg_484_1.time_ < 0 + var_487_1 + arg_487_0 then
				arg_484_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_484_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_484_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_484_1.actors_["1054ui_story"].transform.position).z)
				arg_484_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_484_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_484_1.actors_["1054ui_story"].transform.localEulerAngles = arg_484_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_487_2 = GameObjectTools.GetOrAddComponent(arg_484_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_487_2 then
					var_487_2:EnableDynamicBone(true)
				end
			end

			local var_487_3 = arg_484_1.actors_["1054ui_story"]

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(var_487_3) and arg_484_1.var_.characterEffect1054ui_story == nil then
				arg_484_1.var_.characterEffect1054ui_story = var_487_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_4 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_4 and not isNil(var_487_3) then
				if arg_484_1.var_.characterEffect1054ui_story and not isNil(var_487_3) then
					arg_484_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_484_1.time_ >= 0 + var_487_4 and arg_484_1.time_ < 0 + var_487_4 + arg_487_0 and not isNil(var_487_3) and arg_484_1.var_.characterEffect1054ui_story then
				arg_484_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_487_6 = 0
			local var_487_7 = 0.35

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_6 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_8 = arg_484_1:GetWordFromCfg(426071116)
				local var_487_9 = arg_484_1:FormatText(var_487_8.content)

				arg_484_1.text_.text = var_487_9

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_11 = 14 <= 0 and var_487_7 or var_487_7 * (utf8.len(var_487_9) / 14)

				if (14 <= 0 and var_487_7 or var_487_7 * (utf8.len(var_487_9) / 14)) > 0 and var_487_7 < var_487_11 then
					arg_484_1.talkMaxDuration = var_487_11

					if var_487_11 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_11 + var_487_6
					end
				end

				arg_484_1.text_.text = var_487_9
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071116", "story_v_out_426071.awb") ~= 0 then
					local var_487_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071116", "story_v_out_426071.awb") / 1000

					if var_487_12 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_12 + var_487_6
					end

					if var_487_8.prefab_name ~= "" and arg_484_1.actors_[var_487_8.prefab_name] ~= nil then
						local var_487_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_8.prefab_name].transform, "story_v_out_426071", "426071116", "story_v_out_426071.awb")

						arg_484_1:RecordAudio("426071116", var_487_13)
						arg_484_1:RecordAudio("426071116", var_487_13)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_out_426071", "426071116", "story_v_out_426071.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_out_426071", "426071116", "story_v_out_426071.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_14 = math.max(var_487_7, arg_484_1.talkMaxDuration)

			if var_487_6 <= arg_484_1.time_ and arg_484_1.time_ < var_487_6 + var_487_14 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_6) / var_487_14

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_6 + var_487_14 and arg_484_1.time_ < var_487_6 + var_487_14 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {
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

		arg_484_1:InitPlayNodeList()
	end,
	Play426071117 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 426071117
		arg_488_1.duration_ = 15.87

		local var_488_0 = {
			zh = 8.8,
			ja = 15.866
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play426071118(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["1054ui_story"]) and arg_488_1.var_.characterEffect1054ui_story == nil then
				arg_488_1.var_.characterEffect1054ui_story = arg_488_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_0 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["1054ui_story"]) then
				if arg_488_1.var_.characterEffect1054ui_story and not isNil(arg_488_1.actors_["1054ui_story"]) then
					arg_488_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_488_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_488_1.time_ - 0) / var_491_0)
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["1054ui_story"]) and arg_488_1.var_.characterEffect1054ui_story then
				arg_488_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_488_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_491_1 = 0
			local var_491_2 = 0.65

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_3 = arg_488_1:GetWordFromCfg(426071117)
				local var_491_4 = arg_488_1:FormatText(var_491_3.content)

				arg_488_1.text_.text = var_491_4

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_6 = 26 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_4) / 26)

				if (26 <= 0 and var_491_2 or var_491_2 * (utf8.len(var_491_4) / 26)) > 0 and var_491_2 < var_491_6 then
					arg_488_1.talkMaxDuration = var_491_6

					if var_491_6 + var_491_1 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_6 + var_491_1
					end
				end

				arg_488_1.text_.text = var_491_4
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071117", "story_v_out_426071.awb") ~= 0 then
					local var_491_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071117", "story_v_out_426071.awb") / 1000

					if var_491_7 + var_491_1 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_7 + var_491_1
					end

					if var_491_3.prefab_name ~= "" and arg_488_1.actors_[var_491_3.prefab_name] ~= nil then
						local var_491_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_3.prefab_name].transform, "story_v_out_426071", "426071117", "story_v_out_426071.awb")

						arg_488_1:RecordAudio("426071117", var_491_8)
						arg_488_1:RecordAudio("426071117", var_491_8)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_426071", "426071117", "story_v_out_426071.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_426071", "426071117", "story_v_out_426071.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_9 = math.max(var_491_2, arg_488_1.talkMaxDuration)

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_9 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_1) / var_491_9

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_1 + var_491_9 and arg_488_1.time_ < var_491_1 + var_491_9 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play426071118 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 426071118
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play426071119(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0.775

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_1 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(426071118).content)

				arg_492_1.text_.text = var_495_1

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_3 = 31 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_1) / 31)

				if (31 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_1) / 31)) > 0 and var_495_0 < var_495_3 then
					arg_492_1.talkMaxDuration = var_495_3

					if var_495_3 + 0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_3 + 0
					end
				end

				arg_492_1.text_.text = var_495_1
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_4 = math.max(var_495_0, arg_492_1.talkMaxDuration)

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_4 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - 0) / var_495_4

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= 0 + var_495_4 and arg_492_1.time_ < 0 + var_495_4 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play426071119 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 426071119
		arg_496_1.duration_ = 17.3

		local var_496_0 = {
			zh = 11.533,
			ja = 17.3
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play426071120(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0.9

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_1 = arg_496_1:GetWordFromCfg(426071119)
				local var_499_2 = arg_496_1:FormatText(var_499_1.content)

				arg_496_1.text_.text = var_499_2

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_4 = 36 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 36)

				if (36 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 36)) > 0 and var_499_0 < var_499_4 then
					arg_496_1.talkMaxDuration = var_499_4

					if var_499_4 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_4 + 0
					end
				end

				arg_496_1.text_.text = var_499_2
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071119", "story_v_out_426071.awb") ~= 0 then
					local var_499_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071119", "story_v_out_426071.awb") / 1000

					if var_499_5 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_5 + 0
					end

					if var_499_1.prefab_name ~= "" and arg_496_1.actors_[var_499_1.prefab_name] ~= nil then
						local var_499_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_1.prefab_name].transform, "story_v_out_426071", "426071119", "story_v_out_426071.awb")

						arg_496_1:RecordAudio("426071119", var_499_6)
						arg_496_1:RecordAudio("426071119", var_499_6)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_426071", "426071119", "story_v_out_426071.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_426071", "426071119", "story_v_out_426071.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_7 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_7 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_7

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_7 and arg_496_1.time_ < 0 + var_499_7 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play426071120 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 426071120
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play426071121(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.8

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(426071120).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 32 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 32)

				if (32 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 32)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play426071121 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 426071121
		arg_504_1.duration_ = 10.13

		local var_504_0 = {
			zh = 10.133,
			ja = 8.9
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play426071122(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.var_.moveOldPos1054ui_story = arg_504_1.actors_["1054ui_story"].transform.localPosition

				local var_507_0 = GameObjectTools.GetOrAddComponent(arg_504_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_507_0 then
					var_507_0:EnableDynamicBone(false)
				end
			end

			local var_507_1 = 0.001

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_1 then
				arg_504_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_504_1.time_ - 0) / var_507_1)
				arg_504_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["1054ui_story"].transform.position).z)
				arg_504_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["1054ui_story"].transform.localEulerAngles = arg_504_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_504_1.time_ >= 0 + var_507_1 and arg_504_1.time_ < 0 + var_507_1 + arg_507_0 then
				arg_504_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_504_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["1054ui_story"].transform.position).z)
				arg_504_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["1054ui_story"].transform.localEulerAngles = arg_504_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_507_2 = GameObjectTools.GetOrAddComponent(arg_504_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_507_2 then
					var_507_2:EnableDynamicBone(true)
				end
			end

			local var_507_3 = arg_504_1.actors_["1054ui_story"]

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(var_507_3) and arg_504_1.var_.characterEffect1054ui_story == nil then
				arg_504_1.var_.characterEffect1054ui_story = var_507_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_4 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 and not isNil(var_507_3) then
				if arg_504_1.var_.characterEffect1054ui_story and not isNil(var_507_3) then
					arg_504_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 and not isNil(var_507_3) and arg_504_1.var_.characterEffect1054ui_story then
				arg_504_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_507_6 = 0
			local var_507_7 = 0.65

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_6 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_8 = arg_504_1:GetWordFromCfg(426071121)
				local var_507_9 = arg_504_1:FormatText(var_507_8.content)

				arg_504_1.text_.text = var_507_9

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_11 = 26 <= 0 and var_507_7 or var_507_7 * (utf8.len(var_507_9) / 26)

				if (26 <= 0 and var_507_7 or var_507_7 * (utf8.len(var_507_9) / 26)) > 0 and var_507_7 < var_507_11 then
					arg_504_1.talkMaxDuration = var_507_11

					if var_507_11 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_11 + var_507_6
					end
				end

				arg_504_1.text_.text = var_507_9
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071121", "story_v_out_426071.awb") ~= 0 then
					local var_507_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071121", "story_v_out_426071.awb") / 1000

					if var_507_12 + var_507_6 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_12 + var_507_6
					end

					if var_507_8.prefab_name ~= "" and arg_504_1.actors_[var_507_8.prefab_name] ~= nil then
						local var_507_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_8.prefab_name].transform, "story_v_out_426071", "426071121", "story_v_out_426071.awb")

						arg_504_1:RecordAudio("426071121", var_507_13)
						arg_504_1:RecordAudio("426071121", var_507_13)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_426071", "426071121", "story_v_out_426071.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_426071", "426071121", "story_v_out_426071.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_14 = math.max(var_507_7, arg_504_1.talkMaxDuration)

			if var_507_6 <= arg_504_1.time_ and arg_504_1.time_ < var_507_6 + var_507_14 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_6) / var_507_14

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_6 + var_507_14 and arg_504_1.time_ < var_507_6 + var_507_14 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
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

		arg_504_1:InitPlayNodeList()
	end,
	Play426071122 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 426071122
		arg_508_1.duration_ = 6.1

		local var_508_0 = {
			zh = 6.1,
			ja = 4.866
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play426071123(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos1054ui_story = arg_508_1.actors_["1054ui_story"].transform.localPosition

				local var_511_0 = GameObjectTools.GetOrAddComponent(arg_508_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_511_0 then
					var_511_0:EnableDynamicBone(false)
				end
			end

			local var_511_1 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_1 then
				arg_508_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_508_1.time_ - 0) / var_511_1)
				arg_508_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1054ui_story"].transform.position).z)
				arg_508_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["1054ui_story"].transform.localEulerAngles = arg_508_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_508_1.time_ >= 0 + var_511_1 and arg_508_1.time_ < 0 + var_511_1 + arg_511_0 then
				arg_508_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_508_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["1054ui_story"].transform.position).z)
				arg_508_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["1054ui_story"].transform.localEulerAngles = arg_508_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_511_2 = GameObjectTools.GetOrAddComponent(arg_508_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_511_2 then
					var_511_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_511_3 = 0
			local var_511_4 = 0.375

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_3 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_5 = arg_508_1:GetWordFromCfg(426071122)
				local var_511_6 = arg_508_1:FormatText(var_511_5.content)

				arg_508_1.text_.text = var_511_6

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_8 = 15 <= 0 and var_511_4 or var_511_4 * (utf8.len(var_511_6) / 15)

				if (15 <= 0 and var_511_4 or var_511_4 * (utf8.len(var_511_6) / 15)) > 0 and var_511_4 < var_511_8 then
					arg_508_1.talkMaxDuration = var_511_8

					if var_511_8 + var_511_3 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_8 + var_511_3
					end
				end

				arg_508_1.text_.text = var_511_6
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071122", "story_v_out_426071.awb") ~= 0 then
					local var_511_9 = manager.audio:GetVoiceLength("story_v_out_426071", "426071122", "story_v_out_426071.awb") / 1000

					if var_511_9 + var_511_3 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_3
					end

					if var_511_5.prefab_name ~= "" and arg_508_1.actors_[var_511_5.prefab_name] ~= nil then
						local var_511_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_5.prefab_name].transform, "story_v_out_426071", "426071122", "story_v_out_426071.awb")

						arg_508_1:RecordAudio("426071122", var_511_10)
						arg_508_1:RecordAudio("426071122", var_511_10)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_426071", "426071122", "story_v_out_426071.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_426071", "426071122", "story_v_out_426071.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_11 = math.max(var_511_4, arg_508_1.talkMaxDuration)

			if var_511_3 <= arg_508_1.time_ and arg_508_1.time_ < var_511_3 + var_511_11 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_3) / var_511_11

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_3 + var_511_11 and arg_508_1.time_ < var_511_3 + var_511_11 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
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

		arg_508_1:InitPlayNodeList()
	end,
	Play426071123 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 426071123
		arg_512_1.duration_ = 9.4

		local var_512_0 = {
			zh = 9.4,
			ja = 9.2
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play426071124(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(arg_512_1.actors_["1054ui_story"]) and arg_512_1.var_.characterEffect1054ui_story == nil then
				arg_512_1.var_.characterEffect1054ui_story = arg_512_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_0 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 and not isNil(arg_512_1.actors_["1054ui_story"]) then
				if arg_512_1.var_.characterEffect1054ui_story and not isNil(arg_512_1.actors_["1054ui_story"]) then
					arg_512_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_512_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_512_1.time_ - 0) / var_515_0)
				end
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 and not isNil(arg_512_1.actors_["1054ui_story"]) and arg_512_1.var_.characterEffect1054ui_story then
				arg_512_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_512_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_515_1 = 0
			local var_515_2 = 0.675

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_3 = arg_512_1:GetWordFromCfg(426071123)
				local var_515_4 = arg_512_1:FormatText(var_515_3.content)

				arg_512_1.text_.text = var_515_4

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_6 = 27 <= 0 and var_515_2 or var_515_2 * (utf8.len(var_515_4) / 27)

				if (27 <= 0 and var_515_2 or var_515_2 * (utf8.len(var_515_4) / 27)) > 0 and var_515_2 < var_515_6 then
					arg_512_1.talkMaxDuration = var_515_6

					if var_515_6 + var_515_1 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_6 + var_515_1
					end
				end

				arg_512_1.text_.text = var_515_4
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071123", "story_v_out_426071.awb") ~= 0 then
					local var_515_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071123", "story_v_out_426071.awb") / 1000

					if var_515_7 + var_515_1 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_1
					end

					if var_515_3.prefab_name ~= "" and arg_512_1.actors_[var_515_3.prefab_name] ~= nil then
						local var_515_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_3.prefab_name].transform, "story_v_out_426071", "426071123", "story_v_out_426071.awb")

						arg_512_1:RecordAudio("426071123", var_515_8)
						arg_512_1:RecordAudio("426071123", var_515_8)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_426071", "426071123", "story_v_out_426071.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_426071", "426071123", "story_v_out_426071.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_9 = math.max(var_515_2, arg_512_1.talkMaxDuration)

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_9 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_1) / var_515_9

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_1 + var_515_9 and arg_512_1.time_ < var_515_1 + var_515_9 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play426071124 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 426071124
		arg_516_1.duration_ = 7.97

		local var_516_0 = {
			zh = 6.466,
			ja = 7.966
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play426071125(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0.55

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, true)
				arg_516_1.iconController_:SetSelectedState("hero")

				arg_516_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_516_1.callingController_:SetSelectedState("normal")

				arg_516_1.keyicon_.color = Color.New(1, 1, 1)
				arg_516_1.icon_.color = Color.New(1, 1, 1)

				local var_519_1 = arg_516_1:GetWordFromCfg(426071124)
				local var_519_2 = arg_516_1:FormatText(var_519_1.content)

				arg_516_1.text_.text = var_519_2

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_4 = 22 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_2) / 22)

				if (22 <= 0 and var_519_0 or var_519_0 * (utf8.len(var_519_2) / 22)) > 0 and var_519_0 < var_519_4 then
					arg_516_1.talkMaxDuration = var_519_4

					if var_519_4 + 0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_4 + 0
					end
				end

				arg_516_1.text_.text = var_519_2
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071124", "story_v_out_426071.awb") ~= 0 then
					local var_519_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071124", "story_v_out_426071.awb") / 1000

					if var_519_5 + 0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_5 + 0
					end

					if var_519_1.prefab_name ~= "" and arg_516_1.actors_[var_519_1.prefab_name] ~= nil then
						local var_519_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_1.prefab_name].transform, "story_v_out_426071", "426071124", "story_v_out_426071.awb")

						arg_516_1:RecordAudio("426071124", var_519_6)
						arg_516_1:RecordAudio("426071124", var_519_6)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_out_426071", "426071124", "story_v_out_426071.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_out_426071", "426071124", "story_v_out_426071.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_7 = math.max(var_519_0, arg_516_1.talkMaxDuration)

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_7 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - 0) / var_519_7

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= 0 + var_519_7 and arg_516_1.time_ < 0 + var_519_7 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play426071125 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 426071125
		arg_520_1.duration_ = 4.83

		local var_520_0 = {
			zh = 4.2,
			ja = 4.833
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play426071126(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.var_.moveOldPos1054ui_story = arg_520_1.actors_["1054ui_story"].transform.localPosition

				local var_523_0 = GameObjectTools.GetOrAddComponent(arg_520_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_523_0 then
					var_523_0:EnableDynamicBone(false)
				end
			end

			local var_523_1 = 0.001

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_1 then
				arg_520_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_520_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_520_1.time_ - 0) / var_523_1)
				arg_520_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1054ui_story"].transform.position).z)
				arg_520_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1054ui_story"].transform.localEulerAngles = arg_520_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_520_1.time_ >= 0 + var_523_1 and arg_520_1.time_ < 0 + var_523_1 + arg_523_0 then
				arg_520_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_520_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_520_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_520_1.actors_["1054ui_story"].transform.position).z)
				arg_520_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_520_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_520_1.actors_["1054ui_story"].transform.localEulerAngles = arg_520_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_523_2 = GameObjectTools.GetOrAddComponent(arg_520_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_523_2 then
					var_523_2:EnableDynamicBone(true)
				end
			end

			local var_523_3 = arg_520_1.actors_["1054ui_story"]

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(var_523_3) and arg_520_1.var_.characterEffect1054ui_story == nil then
				arg_520_1.var_.characterEffect1054ui_story = var_523_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_4 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_4 and not isNil(var_523_3) then
				if arg_520_1.var_.characterEffect1054ui_story and not isNil(var_523_3) then
					arg_520_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_520_1.time_ >= 0 + var_523_4 and arg_520_1.time_ < 0 + var_523_4 + arg_523_0 and not isNil(var_523_3) and arg_520_1.var_.characterEffect1054ui_story then
				arg_520_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_523_6 = 0
			local var_523_7 = 0.45

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_6 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, false)
				arg_520_1.callingController_:SetSelectedState("normal")

				local var_523_8 = arg_520_1:GetWordFromCfg(426071125)
				local var_523_9 = arg_520_1:FormatText(var_523_8.content)

				arg_520_1.text_.text = var_523_9

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_11 = 18 <= 0 and var_523_7 or var_523_7 * (utf8.len(var_523_9) / 18)

				if (18 <= 0 and var_523_7 or var_523_7 * (utf8.len(var_523_9) / 18)) > 0 and var_523_7 < var_523_11 then
					arg_520_1.talkMaxDuration = var_523_11

					if var_523_11 + var_523_6 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_11 + var_523_6
					end
				end

				arg_520_1.text_.text = var_523_9
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071125", "story_v_out_426071.awb") ~= 0 then
					local var_523_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071125", "story_v_out_426071.awb") / 1000

					if var_523_12 + var_523_6 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_12 + var_523_6
					end

					if var_523_8.prefab_name ~= "" and arg_520_1.actors_[var_523_8.prefab_name] ~= nil then
						local var_523_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_8.prefab_name].transform, "story_v_out_426071", "426071125", "story_v_out_426071.awb")

						arg_520_1:RecordAudio("426071125", var_523_13)
						arg_520_1:RecordAudio("426071125", var_523_13)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_426071", "426071125", "story_v_out_426071.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_426071", "426071125", "story_v_out_426071.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_14 = math.max(var_523_7, arg_520_1.talkMaxDuration)

			if var_523_6 <= arg_520_1.time_ and arg_520_1.time_ < var_523_6 + var_523_14 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_6) / var_523_14

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_6 + var_523_14 and arg_520_1.time_ < var_523_6 + var_523_14 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {
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

		arg_520_1:InitPlayNodeList()
	end,
	Play426071126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 426071126
		arg_524_1.duration_ = 8.97

		local var_524_0 = {
			zh = 8.966,
			ja = 7.466
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play426071127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 and not isNil(arg_524_1.actors_["1054ui_story"]) and arg_524_1.var_.characterEffect1054ui_story == nil then
				arg_524_1.var_.characterEffect1054ui_story = arg_524_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_0 = 0.200000002980232

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 and not isNil(arg_524_1.actors_["1054ui_story"]) then
				if arg_524_1.var_.characterEffect1054ui_story and not isNil(arg_524_1.actors_["1054ui_story"]) then
					arg_524_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_524_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_524_1.time_ - 0) / var_527_0)
				end
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 and not isNil(arg_524_1.actors_["1054ui_story"]) and arg_524_1.var_.characterEffect1054ui_story then
				arg_524_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_524_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_527_1 = 0
			local var_527_2 = 0.925

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, true)
				arg_524_1.iconController_:SetSelectedState("hero")

				arg_524_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_524_1.callingController_:SetSelectedState("normal")

				arg_524_1.keyicon_.color = Color.New(1, 1, 1)
				arg_524_1.icon_.color = Color.New(1, 1, 1)

				local var_527_3 = arg_524_1:GetWordFromCfg(426071126)
				local var_527_4 = arg_524_1:FormatText(var_527_3.content)

				arg_524_1.text_.text = var_527_4

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_6 = 37 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_4) / 37)

				if (37 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_4) / 37)) > 0 and var_527_2 < var_527_6 then
					arg_524_1.talkMaxDuration = var_527_6

					if var_527_6 + var_527_1 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_6 + var_527_1
					end
				end

				arg_524_1.text_.text = var_527_4
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071126", "story_v_out_426071.awb") ~= 0 then
					local var_527_7 = manager.audio:GetVoiceLength("story_v_out_426071", "426071126", "story_v_out_426071.awb") / 1000

					if var_527_7 + var_527_1 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_7 + var_527_1
					end

					if var_527_3.prefab_name ~= "" and arg_524_1.actors_[var_527_3.prefab_name] ~= nil then
						local var_527_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_3.prefab_name].transform, "story_v_out_426071", "426071126", "story_v_out_426071.awb")

						arg_524_1:RecordAudio("426071126", var_527_8)
						arg_524_1:RecordAudio("426071126", var_527_8)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_426071", "426071126", "story_v_out_426071.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_426071", "426071126", "story_v_out_426071.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_9 = math.max(var_527_2, arg_524_1.talkMaxDuration)

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_9 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_1) / var_527_9

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_1 + var_527_9 and arg_524_1.time_ < var_527_1 + var_527_9 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play426071127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 426071127
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play426071128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 1.4

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(426071127).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 56 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 56)

				if (56 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 56)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play426071128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 426071128
		arg_532_1.duration_ = 4.2

		local var_532_0 = {
			zh = 2.466,
			ja = 4.2
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play426071129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.var_.moveOldPos1054ui_story = arg_532_1.actors_["1054ui_story"].transform.localPosition

				local var_535_0 = GameObjectTools.GetOrAddComponent(arg_532_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_535_0 then
					var_535_0:EnableDynamicBone(false)
				end
			end

			local var_535_1 = 0.001

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_1 then
				arg_532_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_532_1.time_ - 0) / var_535_1)
				arg_532_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_532_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1054ui_story"].transform.position).z)
				arg_532_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_532_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_532_1.actors_["1054ui_story"].transform.localEulerAngles = arg_532_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_532_1.time_ >= 0 + var_535_1 and arg_532_1.time_ < 0 + var_535_1 + arg_535_0 then
				arg_532_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_532_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_532_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_532_1.actors_["1054ui_story"].transform.position).z)
				arg_532_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_532_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_532_1.actors_["1054ui_story"].transform.localEulerAngles = arg_532_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_535_2 = GameObjectTools.GetOrAddComponent(arg_532_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_535_2 then
					var_535_2:EnableDynamicBone(true)
				end
			end

			local var_535_3 = arg_532_1.actors_["1054ui_story"]

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 and not isNil(var_535_3) and arg_532_1.var_.characterEffect1054ui_story == nil then
				arg_532_1.var_.characterEffect1054ui_story = var_535_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_4 = 0.200000002980232

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 and not isNil(var_535_3) then
				if arg_532_1.var_.characterEffect1054ui_story and not isNil(var_535_3) then
					arg_532_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 and not isNil(var_535_3) and arg_532_1.var_.characterEffect1054ui_story then
				arg_532_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_535_6 = 0
			local var_535_7 = 0.25

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_6 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_8 = arg_532_1:GetWordFromCfg(426071128)
				local var_535_9 = arg_532_1:FormatText(var_535_8.content)

				arg_532_1.text_.text = var_535_9

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_11 = 10 <= 0 and var_535_7 or var_535_7 * (utf8.len(var_535_9) / 10)

				if (10 <= 0 and var_535_7 or var_535_7 * (utf8.len(var_535_9) / 10)) > 0 and var_535_7 < var_535_11 then
					arg_532_1.talkMaxDuration = var_535_11

					if var_535_11 + var_535_6 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_11 + var_535_6
					end
				end

				arg_532_1.text_.text = var_535_9
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071128", "story_v_out_426071.awb") ~= 0 then
					local var_535_12 = manager.audio:GetVoiceLength("story_v_out_426071", "426071128", "story_v_out_426071.awb") / 1000

					if var_535_12 + var_535_6 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_12 + var_535_6
					end

					if var_535_8.prefab_name ~= "" and arg_532_1.actors_[var_535_8.prefab_name] ~= nil then
						local var_535_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_8.prefab_name].transform, "story_v_out_426071", "426071128", "story_v_out_426071.awb")

						arg_532_1:RecordAudio("426071128", var_535_13)
						arg_532_1:RecordAudio("426071128", var_535_13)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_426071", "426071128", "story_v_out_426071.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_426071", "426071128", "story_v_out_426071.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_14 = math.max(var_535_7, arg_532_1.talkMaxDuration)

			if var_535_6 <= arg_532_1.time_ and arg_532_1.time_ < var_535_6 + var_535_14 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_6) / var_535_14

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_6 + var_535_14 and arg_532_1.time_ < var_535_6 + var_535_14 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
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

		arg_532_1:InitPlayNodeList()
	end,
	Play426071129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 426071129
		arg_536_1.duration_ = 5

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play426071130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 and not isNil(arg_536_1.actors_["1054ui_story"]) and arg_536_1.var_.characterEffect1054ui_story == nil then
				arg_536_1.var_.characterEffect1054ui_story = arg_536_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_0 = 0.200000002980232

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_0 and not isNil(arg_536_1.actors_["1054ui_story"]) then
				if arg_536_1.var_.characterEffect1054ui_story and not isNil(arg_536_1.actors_["1054ui_story"]) then
					arg_536_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_536_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_536_1.time_ - 0) / var_539_0)
				end
			end

			if arg_536_1.time_ >= 0 + var_539_0 and arg_536_1.time_ < 0 + var_539_0 + arg_539_0 and not isNil(arg_536_1.actors_["1054ui_story"]) and arg_536_1.var_.characterEffect1054ui_story then
				arg_536_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_536_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_539_1 = arg_536_1.actors_["1054ui_story"].transform

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.var_.moveOldPos1054ui_story = var_539_1.localPosition

				local var_539_2 = GameObjectTools.GetOrAddComponent(var_539_1.gameObject, typeof(DynamicBoneHelper))

				if var_539_2 then
					var_539_2:EnableDynamicBone(false)
				end
			end

			local var_539_3 = 0.001

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_3 then
				var_539_1.localPosition = Vector3.Lerp(arg_536_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_536_1.time_ - 0) / var_539_3)
				var_539_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_539_1.position).x, (manager.ui.mainCamera.transform.position - var_539_1.position).y, (manager.ui.mainCamera.transform.position - var_539_1.position).z)
				var_539_1.localEulerAngles.z = 0
				var_539_1.localEulerAngles.x = 0
				var_539_1.localEulerAngles = var_539_1.localEulerAngles
			end

			if arg_536_1.time_ >= 0 + var_539_3 and arg_536_1.time_ < 0 + var_539_3 + arg_539_0 then
				var_539_1.localPosition = Vector3.New(0, 100, 0)
				var_539_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_539_1.position).x, (manager.ui.mainCamera.transform.position - var_539_1.position).y, (manager.ui.mainCamera.transform.position - var_539_1.position).z)
				var_539_1.localEulerAngles.z = 0
				var_539_1.localEulerAngles.x = 0
				var_539_1.localEulerAngles = var_539_1.localEulerAngles

				local var_539_4 = GameObjectTools.GetOrAddComponent(var_539_1.gameObject, typeof(DynamicBoneHelper))

				if var_539_4 then
					var_539_4:EnableDynamicBone(true)
				end
			end

			local var_539_5 = 0
			local var_539_6 = 1

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= var_539_5 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, false)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_7 = arg_536_1:FormatText(arg_536_1:GetWordFromCfg(426071129).content)

				arg_536_1.text_.text = var_539_7

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_9 = 40 <= 0 and var_539_6 or var_539_6 * (utf8.len(var_539_7) / 40)

				if (40 <= 0 and var_539_6 or var_539_6 * (utf8.len(var_539_7) / 40)) > 0 and var_539_6 < var_539_9 then
					arg_536_1.talkMaxDuration = var_539_9

					if var_539_9 + var_539_5 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_9 + var_539_5
					end
				end

				arg_536_1.text_.text = var_539_7
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)
				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_10 = math.max(var_539_6, arg_536_1.talkMaxDuration)

			if var_539_5 <= arg_536_1.time_ and arg_536_1.time_ < var_539_5 + var_539_10 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_5) / var_539_10

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_5 + var_539_10 and arg_536_1.time_ < var_539_5 + var_539_10 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {
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

		arg_536_1:InitPlayNodeList()
	end,
	Play426071130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 426071130
		arg_540_1.duration_ = 11.1

		local var_540_0 = {
			zh = 11.1,
			ja = 9.7
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play426071131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.775

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_1 = arg_540_1:GetWordFromCfg(426071130)
				local var_543_2 = arg_540_1:FormatText(var_543_1.content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 31 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 31)

				if (31 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 31)) > 0 and var_543_0 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + 0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071130", "story_v_out_426071.awb") ~= 0 then
					local var_543_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071130", "story_v_out_426071.awb") / 1000

					if var_543_5 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + 0
					end

					if var_543_1.prefab_name ~= "" and arg_540_1.actors_[var_543_1.prefab_name] ~= nil then
						local var_543_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_1.prefab_name].transform, "story_v_out_426071", "426071130", "story_v_out_426071.awb")

						arg_540_1:RecordAudio("426071130", var_543_6)
						arg_540_1:RecordAudio("426071130", var_543_6)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_426071", "426071130", "story_v_out_426071.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_426071", "426071130", "story_v_out_426071.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_7 and arg_540_1.time_ < 0 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play426071131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 426071131
		arg_544_1.duration_ = 15.1

		local var_544_0 = {
			zh = 15.1,
			ja = 12.1
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play426071132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 1.15

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_1 = arg_544_1:GetWordFromCfg(426071131)
				local var_547_2 = arg_544_1:FormatText(var_547_1.content)

				arg_544_1.text_.text = var_547_2

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_4 = 46 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 46)

				if (46 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 46)) > 0 and var_547_0 < var_547_4 then
					arg_544_1.talkMaxDuration = var_547_4

					if var_547_4 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_4 + 0
					end
				end

				arg_544_1.text_.text = var_547_2
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071131", "story_v_out_426071.awb") ~= 0 then
					local var_547_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071131", "story_v_out_426071.awb") / 1000

					if var_547_5 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + 0
					end

					if var_547_1.prefab_name ~= "" and arg_544_1.actors_[var_547_1.prefab_name] ~= nil then
						local var_547_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_1.prefab_name].transform, "story_v_out_426071", "426071131", "story_v_out_426071.awb")

						arg_544_1:RecordAudio("426071131", var_547_6)
						arg_544_1:RecordAudio("426071131", var_547_6)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_426071", "426071131", "story_v_out_426071.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_426071", "426071131", "story_v_out_426071.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_7 = math.max(var_547_0, arg_544_1.talkMaxDuration)

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_7 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - 0) / var_547_7

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= 0 + var_547_7 and arg_544_1.time_ < 0 + var_547_7 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play426071132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 426071132
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play426071133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.var_.moveOldPos1054ui_story = arg_548_1.actors_["1054ui_story"].transform.localPosition

				local var_551_0 = GameObjectTools.GetOrAddComponent(arg_548_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_551_0 then
					var_551_0:EnableDynamicBone(false)
				end
			end

			local var_551_1 = 0.001

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_1 then
				arg_548_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_548_1.time_ - 0) / var_551_1)
				arg_548_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_548_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1054ui_story"].transform.position).z)
				arg_548_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_548_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_548_1.actors_["1054ui_story"].transform.localEulerAngles = arg_548_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_548_1.time_ >= 0 + var_551_1 and arg_548_1.time_ < 0 + var_551_1 + arg_551_0 then
				arg_548_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_548_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_548_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_548_1.actors_["1054ui_story"].transform.position).z)
				arg_548_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_548_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_548_1.actors_["1054ui_story"].transform.localEulerAngles = arg_548_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_551_2 = GameObjectTools.GetOrAddComponent(arg_548_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_551_2 then
					var_551_2:EnableDynamicBone(true)
				end
			end

			local var_551_3 = 0
			local var_551_4 = 0.925

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= var_551_3 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_5 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(426071132).content)

				arg_548_1.text_.text = var_551_5

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_7 = 37 <= 0 and var_551_4 or var_551_4 * (utf8.len(var_551_5) / 37)

				if (37 <= 0 and var_551_4 or var_551_4 * (utf8.len(var_551_5) / 37)) > 0 and var_551_4 < var_551_7 then
					arg_548_1.talkMaxDuration = var_551_7

					if var_551_7 + var_551_3 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_7 + var_551_3
					end
				end

				arg_548_1.text_.text = var_551_5
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_8 = math.max(var_551_4, arg_548_1.talkMaxDuration)

			if var_551_3 <= arg_548_1.time_ and arg_548_1.time_ < var_551_3 + var_551_8 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_3) / var_551_8

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_3 + var_551_8 and arg_548_1.time_ < var_551_3 + var_551_8 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
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

		arg_548_1:InitPlayNodeList()
	end,
	Play426071133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 426071133
		arg_552_1.duration_ = 9

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play426071134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if arg_552_1.bgs_.ST47 == nil then
				local var_555_0 = Object.Instantiate(arg_552_1.paintGo_)

				var_555_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_555_0.name = "ST47"
				var_555_0.transform.parent = arg_552_1.stage_.transform
				var_555_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_552_1.bgs_.ST47 = var_555_0
			end

			if 2 < arg_552_1.time_ and arg_552_1.time_ <= 2 + arg_555_0 then
				local var_555_1 = arg_552_1.bgs_.ST47

				arg_552_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_555_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_555_2 = var_555_1:GetComponent("SpriteRenderer")

				if var_555_2 and var_555_2.sprite then
					local var_555_3 = 2 * (var_555_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_555_1.transform.localScale = Vector3.New(var_555_3 / var_555_2.sprite.bounds.size.y < var_555_3 * manager.ui.mainCameraCom_.aspect / var_555_2.sprite.bounds.size.x and var_555_3 * manager.ui.mainCameraCom_.aspect / var_555_2.sprite.bounds.size.x or var_555_3 / var_555_2.sprite.bounds.size.y, var_555_3 / var_555_2.sprite.bounds.size.y < var_555_3 * manager.ui.mainCameraCom_.aspect / var_555_2.sprite.bounds.size.x and var_555_3 * manager.ui.mainCameraCom_.aspect / var_555_2.sprite.bounds.size.x or var_555_3 / var_555_2.sprite.bounds.size.y, 0)
				end

				for iter_555_0, iter_555_1 in pairs(arg_552_1.bgs_) do
					if iter_555_0 ~= "ST47" then
						iter_555_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_555_4 = 4

			if 4 < arg_552_1.time_ and arg_552_1.time_ <= var_555_4 + arg_555_0 then
				arg_552_1.allBtn_.enabled = false
			end

			if arg_552_1.time_ >= var_555_4 + 0.3 and arg_552_1.time_ < var_555_4 + 0.3 + arg_555_0 then
				arg_552_1.allBtn_.enabled = true
			end

			local var_555_5 = 0

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_5 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_6 = 2

			if var_555_5 <= arg_552_1.time_ and arg_552_1.time_ < var_555_5 + var_555_6 then
				local var_555_7 = Color.New(0, 0, 0)

				var_555_7.a = Mathf.Lerp(0, 1, (arg_552_1.time_ - var_555_5) / var_555_6)
				arg_552_1.mask_.color = var_555_7
			end

			if arg_552_1.time_ >= var_555_5 + var_555_6 and arg_552_1.time_ < var_555_5 + var_555_6 + arg_555_0 then
				local var_555_8 = Color.New(0, 0, 0)

				var_555_8.a = 1
				arg_552_1.mask_.color = var_555_8
			end

			local var_555_9 = 2

			if 2 < arg_552_1.time_ and arg_552_1.time_ <= var_555_9 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_10 = 2

			if var_555_9 <= arg_552_1.time_ and arg_552_1.time_ < var_555_9 + var_555_10 then
				local var_555_11 = Color.New(0, 0, 0)

				var_555_11.a = Mathf.Lerp(1, 0, (arg_552_1.time_ - var_555_9) / var_555_10)
				arg_552_1.mask_.color = var_555_11
			end

			if arg_552_1.time_ >= var_555_9 + var_555_10 and arg_552_1.time_ < var_555_9 + var_555_10 + arg_555_0 then
				local var_555_12 = Color.New(0, 0, 0)

				arg_552_1.mask_.enabled = false
				var_555_12.a = 0
				arg_552_1.mask_.color = var_555_12
			end

			if 3.66666666666667 < arg_552_1.time_ and arg_552_1.time_ <= 3.66666666666667 + arg_555_0 then
				arg_552_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 4.03333333333333 < arg_552_1.time_ and arg_552_1.time_ <= 4.03333333333333 + arg_555_0 then
				arg_552_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_552_1.frameCnt_ <= 1 then
				arg_552_1.dialog_:SetActive(false)
			end

			local var_555_15 = 4
			local var_555_16 = 0.35

			if 4 < arg_552_1.time_ and arg_552_1.time_ <= var_555_15 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0

				arg_552_1.dialog_:SetActive(true)

				arg_552_1.dialogCg_.alpha = 0

				local var_555_17 = LeanTween.value(arg_552_1.dialog_, 0, 1, 0.3)

				var_555_17:setOnUpdate(LuaHelper.FloatAction(function(arg_556_0)
					arg_552_1.dialogCg_.alpha = arg_556_0
				end))
				var_555_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_552_1.dialog_)
					var_555_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_552_1.duration_ = arg_552_1.duration_ + 0.3

				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_18 = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(426071133).content)

				arg_552_1.text_.text = var_555_18

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_20 = 14 <= 0 and var_555_16 or var_555_16 * (utf8.len(var_555_18) / 14)

				if (14 <= 0 and var_555_16 or var_555_16 * (utf8.len(var_555_18) / 14)) > 0 and var_555_16 < var_555_20 then
					arg_552_1.talkMaxDuration = var_555_20
					var_555_15 = var_555_15 + 0.3

					if var_555_20 + var_555_15 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_20 + var_555_15
					end
				end

				arg_552_1.text_.text = var_555_18
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_21 = var_555_15 + 0.3
			local var_555_22 = math.max(var_555_16, arg_552_1.talkMaxDuration)

			if var_555_15 + 0.3 <= arg_552_1.time_ and arg_552_1.time_ < var_555_21 + var_555_22 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_21) / var_555_22

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_21 + var_555_22 and arg_552_1.time_ < var_555_21 + var_555_22 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play426071134 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 426071134
		arg_558_1.duration_ = 3.07

		local var_558_0 = {
			zh = 2.566,
			ja = 3.066
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play426071135(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if arg_558_1.actors_["1012ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1012ui_story"))) then
				local var_561_0 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_558_1.stage_.transform)

				var_561_0.name = "1012ui_story"
				var_561_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_558_1.actors_["1012ui_story"] = var_561_0

				local var_561_1 = var_561_0:GetComponentInChildren(typeof(CharacterEffect))

				var_561_1.enabled = true

				local var_561_2 = GameObjectTools.GetOrAddComponent(var_561_0, typeof(DynamicBoneHelper))

				if var_561_2 then
					var_561_2:EnableDynamicBone(false)
				end

				arg_558_1:ShowWeapon(var_561_1.transform, false)

				arg_558_1.var_["1012ui_story" .. "Animator"] = var_561_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_558_1.var_["1012ui_story" .. "Animator"].applyRootMotion = true
				arg_558_1.var_["1012ui_story" .. "LipSync"] = var_561_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_561_3 = arg_558_1.actors_["1012ui_story"].transform

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.var_.moveOldPos1012ui_story = var_561_3.localPosition
			end

			local var_561_4 = 0.001

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 then
				var_561_3.localPosition = Vector3.Lerp(arg_558_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_558_1.time_ - 0) / var_561_4)
				var_561_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_3.position).x, (manager.ui.mainCamera.transform.position - var_561_3.position).y, (manager.ui.mainCamera.transform.position - var_561_3.position).z)
				var_561_3.localEulerAngles.z = 0
				var_561_3.localEulerAngles.x = 0
				var_561_3.localEulerAngles = var_561_3.localEulerAngles
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 then
				var_561_3.localPosition = Vector3.New(0, -1.05, -6.24)
				var_561_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_561_3.position).x, (manager.ui.mainCamera.transform.position - var_561_3.position).y, (manager.ui.mainCamera.transform.position - var_561_3.position).z)
				var_561_3.localEulerAngles.z = 0
				var_561_3.localEulerAngles.x = 0
				var_561_3.localEulerAngles = var_561_3.localEulerAngles
			end

			local var_561_5 = arg_558_1.actors_["1012ui_story"]

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(var_561_5) and arg_558_1.var_.characterEffect1012ui_story == nil then
				arg_558_1.var_.characterEffect1012ui_story = var_561_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_6 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_6 and not isNil(var_561_5) then
				if arg_558_1.var_.characterEffect1012ui_story and not isNil(var_561_5) then
					arg_558_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_558_1.time_ >= 0 + var_561_6 and arg_558_1.time_ < 0 + var_561_6 + arg_561_0 and not isNil(var_561_5) and arg_558_1.var_.characterEffect1012ui_story then
				arg_558_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_561_8 = 0
			local var_561_9 = 0.3

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_8 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_10 = arg_558_1:GetWordFromCfg(426071134)
				local var_561_11 = arg_558_1:FormatText(var_561_10.content)

				arg_558_1.text_.text = var_561_11

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_13 = 12 <= 0 and var_561_9 or var_561_9 * (utf8.len(var_561_11) / 12)

				if (12 <= 0 and var_561_9 or var_561_9 * (utf8.len(var_561_11) / 12)) > 0 and var_561_9 < var_561_13 then
					arg_558_1.talkMaxDuration = var_561_13

					if var_561_13 + var_561_8 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_13 + var_561_8
					end
				end

				arg_558_1.text_.text = var_561_11
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071134", "story_v_out_426071.awb") ~= 0 then
					local var_561_14 = manager.audio:GetVoiceLength("story_v_out_426071", "426071134", "story_v_out_426071.awb") / 1000

					if var_561_14 + var_561_8 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_14 + var_561_8
					end

					if var_561_10.prefab_name ~= "" and arg_558_1.actors_[var_561_10.prefab_name] ~= nil then
						local var_561_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_10.prefab_name].transform, "story_v_out_426071", "426071134", "story_v_out_426071.awb")

						arg_558_1:RecordAudio("426071134", var_561_15)
						arg_558_1:RecordAudio("426071134", var_561_15)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_426071", "426071134", "story_v_out_426071.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_426071", "426071134", "story_v_out_426071.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_16 = math.max(var_561_9, arg_558_1.talkMaxDuration)

			if var_561_8 <= arg_558_1.time_ and arg_558_1.time_ < var_561_8 + var_561_16 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_8) / var_561_16

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_8 + var_561_16 and arg_558_1.time_ < var_561_8 + var_561_16 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_558_1:InitPlayNodeList()
	end,
	Play426071135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 426071135
		arg_562_1.duration_ = 6.97

		local var_562_0 = {
			zh = 6.966,
			ja = 5.833
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play426071136(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_565_0 = 0
			local var_565_1 = 0.925

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_2 = arg_562_1:GetWordFromCfg(426071135)
				local var_565_3 = arg_562_1:FormatText(var_565_2.content)

				arg_562_1.text_.text = var_565_3

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_5 = 37 <= 0 and var_565_1 or var_565_1 * (utf8.len(var_565_3) / 37)

				if (37 <= 0 and var_565_1 or var_565_1 * (utf8.len(var_565_3) / 37)) > 0 and var_565_1 < var_565_5 then
					arg_562_1.talkMaxDuration = var_565_5

					if var_565_5 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_5 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_3
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071135", "story_v_out_426071.awb") ~= 0 then
					local var_565_6 = manager.audio:GetVoiceLength("story_v_out_426071", "426071135", "story_v_out_426071.awb") / 1000

					if var_565_6 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_6 + var_565_0
					end

					if var_565_2.prefab_name ~= "" and arg_562_1.actors_[var_565_2.prefab_name] ~= nil then
						local var_565_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_2.prefab_name].transform, "story_v_out_426071", "426071135", "story_v_out_426071.awb")

						arg_562_1:RecordAudio("426071135", var_565_7)
						arg_562_1:RecordAudio("426071135", var_565_7)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_426071", "426071135", "story_v_out_426071.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_426071", "426071135", "story_v_out_426071.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_8 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_8 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_8

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_8 and arg_562_1.time_ < var_565_0 + var_565_8 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play426071136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 426071136
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play426071137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(arg_566_1.actors_["1012ui_story"]) and arg_566_1.var_.characterEffect1012ui_story == nil then
				arg_566_1.var_.characterEffect1012ui_story = arg_566_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_0 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 and not isNil(arg_566_1.actors_["1012ui_story"]) then
				if arg_566_1.var_.characterEffect1012ui_story and not isNil(arg_566_1.actors_["1012ui_story"]) then
					arg_566_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_566_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_566_1.time_ - 0) / var_569_0)
				end
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 and not isNil(arg_566_1.actors_["1012ui_story"]) and arg_566_1.var_.characterEffect1012ui_story then
				arg_566_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_566_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_569_1 = 0
			local var_569_2 = 0.625

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, true)
				arg_566_1.iconController_:SetSelectedState("hero")

				arg_566_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_566_1.callingController_:SetSelectedState("normal")

				arg_566_1.keyicon_.color = Color.New(1, 1, 1)
				arg_566_1.icon_.color = Color.New(1, 1, 1)

				local var_569_3 = arg_566_1:FormatText(arg_566_1:GetWordFromCfg(426071136).content)

				arg_566_1.text_.text = var_569_3

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 25 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_3) / 25)

				if (25 <= 0 and var_569_2 or var_569_2 * (utf8.len(var_569_3) / 25)) > 0 and var_569_2 < var_569_5 then
					arg_566_1.talkMaxDuration = var_569_5

					if var_569_5 + var_569_1 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_5 + var_569_1
					end
				end

				arg_566_1.text_.text = var_569_3
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_6 = math.max(var_569_2, arg_566_1.talkMaxDuration)

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_6 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_1) / var_569_6

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_1 + var_569_6 and arg_566_1.time_ < var_569_1 + var_569_6 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play426071137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 426071137
		arg_570_1.duration_ = 18.9

		local var_570_0 = {
			zh = 10.533,
			ja = 18.9
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play426071138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1012ui_story"]) and arg_570_1.var_.characterEffect1012ui_story == nil then
				arg_570_1.var_.characterEffect1012ui_story = arg_570_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1012ui_story"]) then
				if arg_570_1.var_.characterEffect1012ui_story and not isNil(arg_570_1.actors_["1012ui_story"]) then
					arg_570_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1012ui_story"]) and arg_570_1.var_.characterEffect1012ui_story then
				arg_570_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 then
				arg_570_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_573_2 = 0
			local var_573_3 = 1.375

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_2 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_4 = arg_570_1:GetWordFromCfg(426071137)
				local var_573_5 = arg_570_1:FormatText(var_573_4.content)

				arg_570_1.text_.text = var_573_5

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_7 = 55 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 55)

				if (55 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 55)) > 0 and var_573_3 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_2
					end
				end

				arg_570_1.text_.text = var_573_5
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071137", "story_v_out_426071.awb") ~= 0 then
					local var_573_8 = manager.audio:GetVoiceLength("story_v_out_426071", "426071137", "story_v_out_426071.awb") / 1000

					if var_573_8 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_8 + var_573_2
					end

					if var_573_4.prefab_name ~= "" and arg_570_1.actors_[var_573_4.prefab_name] ~= nil then
						local var_573_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_4.prefab_name].transform, "story_v_out_426071", "426071137", "story_v_out_426071.awb")

						arg_570_1:RecordAudio("426071137", var_573_9)
						arg_570_1:RecordAudio("426071137", var_573_9)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_426071", "426071137", "story_v_out_426071.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_426071", "426071137", "story_v_out_426071.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_10 = math.max(var_573_3, arg_570_1.talkMaxDuration)

			if var_573_2 <= arg_570_1.time_ and arg_570_1.time_ < var_573_2 + var_573_10 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_2) / var_573_10

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_2 + var_573_10 and arg_570_1.time_ < var_573_2 + var_573_10 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play426071138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 426071138
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play426071139(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 and not isNil(arg_574_1.actors_["1012ui_story"]) and arg_574_1.var_.characterEffect1012ui_story == nil then
				arg_574_1.var_.characterEffect1012ui_story = arg_574_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_0 = 0.200000002980232

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_0 and not isNil(arg_574_1.actors_["1012ui_story"]) then
				if arg_574_1.var_.characterEffect1012ui_story and not isNil(arg_574_1.actors_["1012ui_story"]) then
					arg_574_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_574_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_574_1.time_ - 0) / var_577_0)
				end
			end

			if arg_574_1.time_ >= 0 + var_577_0 and arg_574_1.time_ < 0 + var_577_0 + arg_577_0 and not isNil(arg_574_1.actors_["1012ui_story"]) and arg_574_1.var_.characterEffect1012ui_story then
				arg_574_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_574_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_577_1 = 0
			local var_577_2 = 1.525

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_3 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(426071138).content)

				arg_574_1.text_.text = var_577_3

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_5 = 61 <= 0 and var_577_2 or var_577_2 * (utf8.len(var_577_3) / 61)

				if (61 <= 0 and var_577_2 or var_577_2 * (utf8.len(var_577_3) / 61)) > 0 and var_577_2 < var_577_5 then
					arg_574_1.talkMaxDuration = var_577_5

					if var_577_5 + var_577_1 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_5 + var_577_1
					end
				end

				arg_574_1.text_.text = var_577_3
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_6 = math.max(var_577_2, arg_574_1.talkMaxDuration)

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_6 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_1) / var_577_6

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_1 + var_577_6 and arg_574_1.time_ < var_577_1 + var_577_6 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play426071139 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 426071139
		arg_578_1.duration_ = 3.07

		local var_578_0 = {
			zh = 3.066,
			ja = 2.666
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play426071140(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos1012ui_story = arg_578_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_581_0 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 then
				arg_578_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_578_1.time_ - 0) / var_581_0)
				arg_578_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1012ui_story"].transform.position).z)
				arg_578_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1012ui_story"].transform.localEulerAngles = arg_578_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 then
				arg_578_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_578_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1012ui_story"].transform.position).z)
				arg_578_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1012ui_story"].transform.localEulerAngles = arg_578_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_581_1 = arg_578_1.actors_["1012ui_story"]

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect1012ui_story == nil then
				arg_578_1.var_.characterEffect1012ui_story = var_581_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_2 and not isNil(var_581_1) then
				if arg_578_1.var_.characterEffect1012ui_story and not isNil(var_581_1) then
					arg_578_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= 0 + var_581_2 and arg_578_1.time_ < 0 + var_581_2 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect1012ui_story then
				arg_578_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_581_4 = 0
			local var_581_5 = 0.25

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_4 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_6 = arg_578_1:GetWordFromCfg(426071139)
				local var_581_7 = arg_578_1:FormatText(var_581_6.content)

				arg_578_1.text_.text = var_581_7

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_9 = 10 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 10)

				if (10 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 10)) > 0 and var_581_5 < var_581_9 then
					arg_578_1.talkMaxDuration = var_581_9

					if var_581_9 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_9 + var_581_4
					end
				end

				arg_578_1.text_.text = var_581_7
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071139", "story_v_out_426071.awb") ~= 0 then
					local var_581_10 = manager.audio:GetVoiceLength("story_v_out_426071", "426071139", "story_v_out_426071.awb") / 1000

					if var_581_10 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_10 + var_581_4
					end

					if var_581_6.prefab_name ~= "" and arg_578_1.actors_[var_581_6.prefab_name] ~= nil then
						local var_581_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_6.prefab_name].transform, "story_v_out_426071", "426071139", "story_v_out_426071.awb")

						arg_578_1:RecordAudio("426071139", var_581_11)
						arg_578_1:RecordAudio("426071139", var_581_11)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_426071", "426071139", "story_v_out_426071.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_426071", "426071139", "story_v_out_426071.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_12 = math.max(var_581_5, arg_578_1.talkMaxDuration)

			if var_581_4 <= arg_578_1.time_ and arg_578_1.time_ < var_581_4 + var_581_12 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_4) / var_581_12

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_4 + var_581_12 and arg_578_1.time_ < var_581_4 + var_581_12 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play426071140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 426071140
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play426071141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(arg_582_1.actors_["1012ui_story"]) and arg_582_1.var_.characterEffect1012ui_story == nil then
				arg_582_1.var_.characterEffect1012ui_story = arg_582_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_0 = 0.200000002980232

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 and not isNil(arg_582_1.actors_["1012ui_story"]) then
				if arg_582_1.var_.characterEffect1012ui_story and not isNil(arg_582_1.actors_["1012ui_story"]) then
					arg_582_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_582_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_582_1.time_ - 0) / var_585_0)
				end
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 and not isNil(arg_582_1.actors_["1012ui_story"]) and arg_582_1.var_.characterEffect1012ui_story then
				arg_582_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_582_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_585_1 = 0
			local var_585_2 = 0.55

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_3 = arg_582_1:FormatText(arg_582_1:GetWordFromCfg(426071140).content)

				arg_582_1.text_.text = var_585_3

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_5 = 22 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 22)

				if (22 <= 0 and var_585_2 or var_585_2 * (utf8.len(var_585_3) / 22)) > 0 and var_585_2 < var_585_5 then
					arg_582_1.talkMaxDuration = var_585_5

					if var_585_5 + var_585_1 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_5 + var_585_1
					end
				end

				arg_582_1.text_.text = var_585_3
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_6 = math.max(var_585_2, arg_582_1.talkMaxDuration)

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_6 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_1) / var_585_6

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_1 + var_585_6 and arg_582_1.time_ < var_585_1 + var_585_6 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play426071141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 426071141
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play426071142(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = 0.7

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, true)
				arg_586_1.iconController_:SetSelectedState("hero")

				arg_586_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_586_1.callingController_:SetSelectedState("normal")

				arg_586_1.keyicon_.color = Color.New(1, 1, 1)
				arg_586_1.icon_.color = Color.New(1, 1, 1)

				local var_589_1 = arg_586_1:FormatText(arg_586_1:GetWordFromCfg(426071141).content)

				arg_586_1.text_.text = var_589_1

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_3 = 28 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_1) / 28)

				if (28 <= 0 and var_589_0 or var_589_0 * (utf8.len(var_589_1) / 28)) > 0 and var_589_0 < var_589_3 then
					arg_586_1.talkMaxDuration = var_589_3

					if var_589_3 + 0 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_3 + 0
					end
				end

				arg_586_1.text_.text = var_589_1
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_4 = math.max(var_589_0, arg_586_1.talkMaxDuration)

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_4 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - 0) / var_589_4

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= 0 + var_589_4 and arg_586_1.time_ < 0 + var_589_4 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play426071142 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 426071142
		arg_590_1.duration_ = 9

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play426071143(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if 2 < arg_590_1.time_ and arg_590_1.time_ <= 2 + arg_593_0 then
				local var_593_0 = arg_590_1.bgs_.ST37

				arg_590_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_593_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_593_1 = var_593_0:GetComponent("SpriteRenderer")

				if var_593_1 and var_593_1.sprite then
					local var_593_2 = 2 * (var_593_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_593_0.transform.localScale = Vector3.New(var_593_2 / var_593_1.sprite.bounds.size.y < var_593_2 * manager.ui.mainCameraCom_.aspect / var_593_1.sprite.bounds.size.x and var_593_2 * manager.ui.mainCameraCom_.aspect / var_593_1.sprite.bounds.size.x or var_593_2 / var_593_1.sprite.bounds.size.y, var_593_2 / var_593_1.sprite.bounds.size.y < var_593_2 * manager.ui.mainCameraCom_.aspect / var_593_1.sprite.bounds.size.x and var_593_2 * manager.ui.mainCameraCom_.aspect / var_593_1.sprite.bounds.size.x or var_593_2 / var_593_1.sprite.bounds.size.y, 0)
				end

				for iter_593_0, iter_593_1 in pairs(arg_590_1.bgs_) do
					if iter_593_0 ~= "ST37" then
						iter_593_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_593_3 = 4

			if 4 < arg_590_1.time_ and arg_590_1.time_ <= var_593_3 + arg_593_0 then
				arg_590_1.allBtn_.enabled = false
			end

			if arg_590_1.time_ >= var_593_3 + 0.3 and arg_590_1.time_ < var_593_3 + 0.3 + arg_593_0 then
				arg_590_1.allBtn_.enabled = true
			end

			local var_593_4 = 0

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_4 + arg_593_0 then
				arg_590_1.mask_.enabled = true
				arg_590_1.mask_.raycastTarget = true

				arg_590_1:SetGaussion(false)
			end

			local var_593_5 = 2

			if var_593_4 <= arg_590_1.time_ and arg_590_1.time_ < var_593_4 + var_593_5 then
				local var_593_6 = Color.New(0, 0, 0)

				var_593_6.a = Mathf.Lerp(0, 1, (arg_590_1.time_ - var_593_4) / var_593_5)
				arg_590_1.mask_.color = var_593_6
			end

			if arg_590_1.time_ >= var_593_4 + var_593_5 and arg_590_1.time_ < var_593_4 + var_593_5 + arg_593_0 then
				local var_593_7 = Color.New(0, 0, 0)

				var_593_7.a = 1
				arg_590_1.mask_.color = var_593_7
			end

			local var_593_8 = 2

			if 2 < arg_590_1.time_ and arg_590_1.time_ <= var_593_8 + arg_593_0 then
				arg_590_1.mask_.enabled = true
				arg_590_1.mask_.raycastTarget = true

				arg_590_1:SetGaussion(false)
			end

			local var_593_9 = 2

			if var_593_8 <= arg_590_1.time_ and arg_590_1.time_ < var_593_8 + var_593_9 then
				local var_593_10 = Color.New(0, 0, 0)

				var_593_10.a = Mathf.Lerp(1, 0, (arg_590_1.time_ - var_593_8) / var_593_9)
				arg_590_1.mask_.color = var_593_10
			end

			if arg_590_1.time_ >= var_593_8 + var_593_9 and arg_590_1.time_ < var_593_8 + var_593_9 + arg_593_0 then
				local var_593_11 = Color.New(0, 0, 0)

				arg_590_1.mask_.enabled = false
				var_593_11.a = 0
				arg_590_1.mask_.color = var_593_11
			end

			local var_593_12 = arg_590_1.actors_["1012ui_story"].transform

			if 1.9 < arg_590_1.time_ and arg_590_1.time_ <= 1.9 + arg_593_0 then
				arg_590_1.var_.moveOldPos1012ui_story = var_593_12.localPosition
			end

			local var_593_13 = 0.001

			if 1.9 <= arg_590_1.time_ and arg_590_1.time_ < 1.9 + var_593_13 then
				var_593_12.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_590_1.time_ - 1.9) / var_593_13)
				var_593_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_593_12.position).x, (manager.ui.mainCamera.transform.position - var_593_12.position).y, (manager.ui.mainCamera.transform.position - var_593_12.position).z)
				var_593_12.localEulerAngles.z = 0
				var_593_12.localEulerAngles.x = 0
				var_593_12.localEulerAngles = var_593_12.localEulerAngles
			end

			if arg_590_1.time_ >= 1.9 + var_593_13 and arg_590_1.time_ < 1.9 + var_593_13 + arg_593_0 then
				var_593_12.localPosition = Vector3.New(0, 100, 0)
				var_593_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_593_12.position).x, (manager.ui.mainCamera.transform.position - var_593_12.position).y, (manager.ui.mainCamera.transform.position - var_593_12.position).z)
				var_593_12.localEulerAngles.z = 0
				var_593_12.localEulerAngles.x = 0
				var_593_12.localEulerAngles = var_593_12.localEulerAngles
			end

			if 1.93400000184774 < arg_590_1.time_ and arg_590_1.time_ <= 1.93400000184774 + arg_593_0 then
				arg_590_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 2.4 < arg_590_1.time_ and arg_590_1.time_ <= 2.4 + arg_593_0 then
				arg_590_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_590_1.frameCnt_ <= 1 then
				arg_590_1.dialog_:SetActive(false)
			end

			local var_593_16 = 4
			local var_593_17 = 0.8

			if 4 < arg_590_1.time_ and arg_590_1.time_ <= var_593_16 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0

				arg_590_1.dialog_:SetActive(true)

				arg_590_1.dialogCg_.alpha = 0

				local var_593_18 = LeanTween.value(arg_590_1.dialog_, 0, 1, 0.3)

				var_593_18:setOnUpdate(LuaHelper.FloatAction(function(arg_594_0)
					arg_590_1.dialogCg_.alpha = arg_594_0
				end))
				var_593_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_590_1.dialog_)
					var_593_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_590_1.duration_ = arg_590_1.duration_ + 0.3

				SetActive(arg_590_1.leftNameGo_, false)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_19 = arg_590_1:FormatText(arg_590_1:GetWordFromCfg(426071142).content)

				arg_590_1.text_.text = var_593_19

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_21 = 32 <= 0 and var_593_17 or var_593_17 * (utf8.len(var_593_19) / 32)

				if (32 <= 0 and var_593_17 or var_593_17 * (utf8.len(var_593_19) / 32)) > 0 and var_593_17 < var_593_21 then
					arg_590_1.talkMaxDuration = var_593_21
					var_593_16 = var_593_16 + 0.3

					if var_593_21 + var_593_16 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_21 + var_593_16
					end
				end

				arg_590_1.text_.text = var_593_19
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_22 = var_593_16 + 0.3
			local var_593_23 = math.max(var_593_17, arg_590_1.talkMaxDuration)

			if var_593_16 + 0.3 <= arg_590_1.time_ and arg_590_1.time_ < var_593_22 + var_593_23 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_22) / var_593_23

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_22 + var_593_23 and arg_590_1.time_ < var_593_22 + var_593_23 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_590_1:InitPlayNodeList()
	end,
	Play426071143 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 426071143
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play426071144(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 1.3

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, false)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_596_1.iconTrs_.gameObject, false)
				arg_596_1.callingController_:SetSelectedState("normal")

				local var_599_1 = arg_596_1:FormatText(arg_596_1:GetWordFromCfg(426071143).content)

				arg_596_1.text_.text = var_599_1

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_3 = 52 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_1) / 52)

				if (52 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_1) / 52)) > 0 and var_599_0 < var_599_3 then
					arg_596_1.talkMaxDuration = var_599_3

					if var_599_3 + 0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_3 + 0
					end
				end

				arg_596_1.text_.text = var_599_1
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_4 = math.max(var_599_0, arg_596_1.talkMaxDuration)

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_4 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - 0) / var_599_4

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= 0 + var_599_4 and arg_596_1.time_ < 0 + var_599_4 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play426071144 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 426071144
		arg_600_1.duration_ = 6.93

		local var_600_0 = {
			zh = 6.333,
			ja = 6.933
		}
		local var_600_1 = manager.audio:GetLocalizationFlag()

		if var_600_0[var_600_1] ~= nil then
			arg_600_1.duration_ = var_600_0[var_600_1]
		end

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play426071145(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0.95

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				arg_600_1.leftNameTxt_.text = arg_600_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_1 = arg_600_1:GetWordFromCfg(426071144)
				local var_603_2 = arg_600_1:FormatText(var_603_1.content)

				arg_600_1.text_.text = var_603_2

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_4 = 38 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_2) / 38)

				if (38 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_2) / 38)) > 0 and var_603_0 < var_603_4 then
					arg_600_1.talkMaxDuration = var_603_4

					if var_603_4 + 0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_4 + 0
					end
				end

				arg_600_1.text_.text = var_603_2
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071144", "story_v_out_426071.awb") ~= 0 then
					local var_603_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071144", "story_v_out_426071.awb") / 1000

					if var_603_5 + 0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_5 + 0
					end

					if var_603_1.prefab_name ~= "" and arg_600_1.actors_[var_603_1.prefab_name] ~= nil then
						local var_603_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_1.prefab_name].transform, "story_v_out_426071", "426071144", "story_v_out_426071.awb")

						arg_600_1:RecordAudio("426071144", var_603_6)
						arg_600_1:RecordAudio("426071144", var_603_6)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_out_426071", "426071144", "story_v_out_426071.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_out_426071", "426071144", "story_v_out_426071.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_7 = math.max(var_603_0, arg_600_1.talkMaxDuration)

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_7 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - 0) / var_603_7

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= 0 + var_603_7 and arg_600_1.time_ < 0 + var_603_7 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play426071145 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 426071145
		arg_604_1.duration_ = 10.57

		local var_604_0 = {
			zh = 7.633,
			ja = 10.566
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play426071146(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 1.05

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_1 = arg_604_1:GetWordFromCfg(426071145)
				local var_607_2 = arg_604_1:FormatText(var_607_1.content)

				arg_604_1.text_.text = var_607_2

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_4 = 42 <= 0 and var_607_0 or var_607_0 * (utf8.len(var_607_2) / 42)

				if (42 <= 0 and var_607_0 or var_607_0 * (utf8.len(var_607_2) / 42)) > 0 and var_607_0 < var_607_4 then
					arg_604_1.talkMaxDuration = var_607_4

					if var_607_4 + 0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_4 + 0
					end
				end

				arg_604_1.text_.text = var_607_2
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071145", "story_v_out_426071.awb") ~= 0 then
					local var_607_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071145", "story_v_out_426071.awb") / 1000

					if var_607_5 + 0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_5 + 0
					end

					if var_607_1.prefab_name ~= "" and arg_604_1.actors_[var_607_1.prefab_name] ~= nil then
						local var_607_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_1.prefab_name].transform, "story_v_out_426071", "426071145", "story_v_out_426071.awb")

						arg_604_1:RecordAudio("426071145", var_607_6)
						arg_604_1:RecordAudio("426071145", var_607_6)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_426071", "426071145", "story_v_out_426071.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_426071", "426071145", "story_v_out_426071.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_7 = math.max(var_607_0, arg_604_1.talkMaxDuration)

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_7 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - 0) / var_607_7

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= 0 + var_607_7 and arg_604_1.time_ < 0 + var_607_7 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play426071146 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 426071146
		arg_608_1.duration_ = 1.1

		local var_608_0 = {
			zh = 0.999999999999,
			ja = 1.1
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play426071147(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = 0.075

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				arg_608_1.leftNameTxt_.text = arg_608_1:FormatText(StoryNameCfg[1491].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_1 = arg_608_1:GetWordFromCfg(426071146)
				local var_611_2 = arg_608_1:FormatText(var_611_1.content)

				arg_608_1.text_.text = var_611_2

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_4 = 3 <= 0 and var_611_0 or var_611_0 * (utf8.len(var_611_2) / 3)

				if (3 <= 0 and var_611_0 or var_611_0 * (utf8.len(var_611_2) / 3)) > 0 and var_611_0 < var_611_4 then
					arg_608_1.talkMaxDuration = var_611_4

					if var_611_4 + 0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_4 + 0
					end
				end

				arg_608_1.text_.text = var_611_2
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071146", "story_v_out_426071.awb") ~= 0 then
					local var_611_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071146", "story_v_out_426071.awb") / 1000

					if var_611_5 + 0 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_5 + 0
					end

					if var_611_1.prefab_name ~= "" and arg_608_1.actors_[var_611_1.prefab_name] ~= nil then
						local var_611_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_1.prefab_name].transform, "story_v_out_426071", "426071146", "story_v_out_426071.awb")

						arg_608_1:RecordAudio("426071146", var_611_6)
						arg_608_1:RecordAudio("426071146", var_611_6)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_out_426071", "426071146", "story_v_out_426071.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_out_426071", "426071146", "story_v_out_426071.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_7 = math.max(var_611_0, arg_608_1.talkMaxDuration)

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_7 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - 0) / var_611_7

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= 0 + var_611_7 and arg_608_1.time_ < 0 + var_611_7 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play426071147 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 426071147
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play426071148(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0.775

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, false)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_1 = arg_612_1:FormatText(arg_612_1:GetWordFromCfg(426071147).content)

				arg_612_1.text_.text = var_615_1

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_3 = 31 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 31)

				if (31 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 31)) > 0 and var_615_0 < var_615_3 then
					arg_612_1.talkMaxDuration = var_615_3

					if var_615_3 + 0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_3 + 0
					end
				end

				arg_612_1.text_.text = var_615_1
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_4 = math.max(var_615_0, arg_612_1.talkMaxDuration)

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_4 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - 0) / var_615_4

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= 0 + var_615_4 and arg_612_1.time_ < 0 + var_615_4 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play426071148 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 426071148
		arg_616_1.duration_ = 5.73

		local var_616_0 = {
			zh = 4.833,
			ja = 5.733
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play426071149(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0.725

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				arg_616_1.leftNameTxt_.text = arg_616_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, true)
				arg_616_1.iconController_:SetSelectedState("hero")

				arg_616_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_616_1.callingController_:SetSelectedState("normal")

				arg_616_1.keyicon_.color = Color.New(1, 1, 1)
				arg_616_1.icon_.color = Color.New(1, 1, 1)

				local var_619_1 = arg_616_1:GetWordFromCfg(426071148)
				local var_619_2 = arg_616_1:FormatText(var_619_1.content)

				arg_616_1.text_.text = var_619_2

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_4 = 29 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_2) / 29)

				if (29 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_2) / 29)) > 0 and var_619_0 < var_619_4 then
					arg_616_1.talkMaxDuration = var_619_4

					if var_619_4 + 0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_4 + 0
					end
				end

				arg_616_1.text_.text = var_619_2
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071148", "story_v_out_426071.awb") ~= 0 then
					local var_619_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071148", "story_v_out_426071.awb") / 1000

					if var_619_5 + 0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_5 + 0
					end

					if var_619_1.prefab_name ~= "" and arg_616_1.actors_[var_619_1.prefab_name] ~= nil then
						local var_619_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_1.prefab_name].transform, "story_v_out_426071", "426071148", "story_v_out_426071.awb")

						arg_616_1:RecordAudio("426071148", var_619_6)
						arg_616_1:RecordAudio("426071148", var_619_6)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_426071", "426071148", "story_v_out_426071.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_426071", "426071148", "story_v_out_426071.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_7 = math.max(var_619_0, arg_616_1.talkMaxDuration)

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_7 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - 0) / var_619_7

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= 0 + var_619_7 and arg_616_1.time_ < 0 + var_619_7 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play426071149 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 426071149
		arg_620_1.duration_ = 9.3

		local var_620_0 = {
			zh = 6,
			ja = 9.3
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play426071150(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0.55

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[1490].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, true)
				arg_620_1.iconController_:SetSelectedState("hero")

				arg_620_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10069")

				arg_620_1.callingController_:SetSelectedState("normal")

				arg_620_1.keyicon_.color = Color.New(1, 1, 1)
				arg_620_1.icon_.color = Color.New(1, 1, 1)

				local var_623_1 = arg_620_1:GetWordFromCfg(426071149)
				local var_623_2 = arg_620_1:FormatText(var_623_1.content)

				arg_620_1.text_.text = var_623_2

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_4 = 22 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_2) / 22)

				if (22 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_2) / 22)) > 0 and var_623_0 < var_623_4 then
					arg_620_1.talkMaxDuration = var_623_4

					if var_623_4 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_4 + 0
					end
				end

				arg_620_1.text_.text = var_623_2
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071149", "story_v_out_426071.awb") ~= 0 then
					local var_623_5 = manager.audio:GetVoiceLength("story_v_out_426071", "426071149", "story_v_out_426071.awb") / 1000

					if var_623_5 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_5 + 0
					end

					if var_623_1.prefab_name ~= "" and arg_620_1.actors_[var_623_1.prefab_name] ~= nil then
						local var_623_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_1.prefab_name].transform, "story_v_out_426071", "426071149", "story_v_out_426071.awb")

						arg_620_1:RecordAudio("426071149", var_623_6)
						arg_620_1:RecordAudio("426071149", var_623_6)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_426071", "426071149", "story_v_out_426071.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_426071", "426071149", "story_v_out_426071.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_7 = math.max(var_623_0, arg_620_1.talkMaxDuration)

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_7 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - 0) / var_623_7

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= 0 + var_623_7 and arg_620_1.time_ < 0 + var_623_7 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play426071150 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 426071150
		arg_624_1.duration_ = 1.37

		local var_624_0 = {
			zh = 0.999999999999,
			ja = 1.366
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play426071151(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_627_0 = 0.3

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_0 then
				local var_627_1, var_627_2 = math.modf((arg_624_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_627_2 * 0.13, var_627_2 * 0.13, var_627_2 * 0.13) + arg_624_1.var_.shakeOldPos
			end

			if arg_624_1.time_ >= 0 + var_627_0 and arg_624_1.time_ < 0 + var_627_0 + arg_627_0 then
				manager.ui.mainCamera.transform.localPosition = arg_624_1.var_.shakeOldPos
			end

			local var_627_3 = 0

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_3 + arg_627_0 then
				arg_624_1.allBtn_.enabled = false
			end

			if arg_624_1.time_ >= var_627_3 + 0.3 and arg_624_1.time_ < var_627_3 + 0.3 + arg_627_0 then
				arg_624_1.allBtn_.enabled = true
			end

			local var_627_4 = 0
			local var_627_5 = 0.1

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_4 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[1492].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_6 = arg_624_1:GetWordFromCfg(426071150)
				local var_627_7 = arg_624_1:FormatText(var_627_6.content)

				arg_624_1.text_.text = var_627_7

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_9 = 4 <= 0 and var_627_5 or var_627_5 * (utf8.len(var_627_7) / 4)

				if (4 <= 0 and var_627_5 or var_627_5 * (utf8.len(var_627_7) / 4)) > 0 and var_627_5 < var_627_9 then
					arg_624_1.talkMaxDuration = var_627_9

					if var_627_9 + var_627_4 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_9 + var_627_4
					end
				end

				arg_624_1.text_.text = var_627_7
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426071", "426071150", "story_v_out_426071.awb") ~= 0 then
					local var_627_10 = manager.audio:GetVoiceLength("story_v_out_426071", "426071150", "story_v_out_426071.awb") / 1000

					if var_627_10 + var_627_4 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_10 + var_627_4
					end

					if var_627_6.prefab_name ~= "" and arg_624_1.actors_[var_627_6.prefab_name] ~= nil then
						local var_627_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_6.prefab_name].transform, "story_v_out_426071", "426071150", "story_v_out_426071.awb")

						arg_624_1:RecordAudio("426071150", var_627_11)
						arg_624_1:RecordAudio("426071150", var_627_11)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_426071", "426071150", "story_v_out_426071.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_426071", "426071150", "story_v_out_426071.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_12 = math.max(var_627_5, arg_624_1.talkMaxDuration)

			if var_627_4 <= arg_624_1.time_ and arg_624_1.time_ < var_627_4 + var_627_12 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_4) / var_627_12

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_4 + var_627_12 and arg_624_1.time_ < var_627_4 + var_627_12 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play426071151 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 426071151
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
			arg_628_1.auto_ = false
		end

		function arg_628_1.playNext_(arg_630_0)
			arg_628_1.onStoryFinished_()
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = 1.15

			if 0 < arg_628_1.time_ and arg_628_1.time_ <= 0 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, false)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_1 = arg_628_1:FormatText(arg_628_1:GetWordFromCfg(426071151).content)

				arg_628_1.text_.text = var_631_1

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_3 = 46 <= 0 and var_631_0 or var_631_0 * (utf8.len(var_631_1) / 46)

				if (46 <= 0 and var_631_0 or var_631_0 * (utf8.len(var_631_1) / 46)) > 0 and var_631_0 < var_631_3 then
					arg_628_1.talkMaxDuration = var_631_3

					if var_631_3 + 0 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_3 + 0
					end
				end

				arg_628_1.text_.text = var_631_1
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_4 = math.max(var_631_0, arg_628_1.talkMaxDuration)

			if 0 <= arg_628_1.time_ and arg_628_1.time_ < 0 + var_631_4 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - 0) / var_631_4

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= 0 + var_631_4 and arg_628_1.time_ < 0 + var_631_4 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007a",
		"TextureConfig/Background/ST2012a",
		"TextureConfig/Background/ST2007",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST47"
	},
	voices = {
		"story_v_out_426071.awb"
	}
}
