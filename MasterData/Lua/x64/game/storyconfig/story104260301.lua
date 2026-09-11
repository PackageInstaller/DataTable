return {
	Play426031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426031001
		arg_1_1.duration_ = 14.1

		local var_1_0 = {
			zh = 8.90000000298023,
			ja = 14.1000000029802
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
				arg_1_0:Play426031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J03f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03f")
				var_4_0.name = "J03f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J03f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J03f

				arg_1_1.bgs_.J03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J03f" then
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

			local var_4_9 = "1012ui_story"

			if arg_1_1.actors_["1012ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1012ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1012ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1012ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.05, -6.24)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1012ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1012ui_story == nil then
				arg_1_1.var_.characterEffect1012ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1012ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1012ui_story then
				arg_1_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2.00000000298023
			local var_4_26 = 0.95

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(426031001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 38 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 38)

				if (38 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 38)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031001", "story_v_out_426031.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_426031", "426031001", "story_v_out_426031.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_426031", "426031001", "story_v_out_426031.awb")

						arg_1_1:RecordAudio("426031001", var_4_33)
						arg_1_1:RecordAudio("426031001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_426031", "426031001", "story_v_out_426031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_426031", "426031001", "story_v_out_426031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play426031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426031002
		arg_9_1.duration_ = 5.47

		local var_9_0 = {
			zh = 5.466,
			ja = 5.266
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
				arg_9_0:Play426031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1012ui_story = arg_9_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1012ui_story"].transform.position).z)
				arg_9_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1012ui_story"].transform.localEulerAngles = arg_9_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_9_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1012ui_story"].transform.position).z)
				arg_9_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1012ui_story"].transform.localEulerAngles = arg_9_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_12_1 = 0
			local var_12_2 = 0.725

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:GetWordFromCfg(426031002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 29 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 29)

				if (29 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 29)) > 0 and var_12_2 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031002", "story_v_out_426031.awb") ~= 0 then
					local var_12_7 = manager.audio:GetVoiceLength("story_v_out_426031", "426031002", "story_v_out_426031.awb") / 1000

					if var_12_7 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_1
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_426031", "426031002", "story_v_out_426031.awb")

						arg_9_1:RecordAudio("426031002", var_12_8)
						arg_9_1:RecordAudio("426031002", var_12_8)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_426031", "426031002", "story_v_out_426031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_426031", "426031002", "story_v_out_426031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_9 and arg_9_1.time_ < var_12_1 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play426031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426031003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play426031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1012ui_story = arg_13_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1012ui_story"].transform.position).z)
				arg_13_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1012ui_story"].transform.localEulerAngles = arg_13_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1012ui_story"].transform.position).z)
				arg_13_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1012ui_story"].transform.localEulerAngles = arg_13_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1012ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1012ui_story == nil then
				arg_13_1.var_.characterEffect1012ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1012ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1012ui_story then
				arg_13_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_16_3 = 0
			local var_16_4 = 0.75

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(426031003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 30 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 30)

				if (30 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 30)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play426031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426031004
		arg_17_1.duration_ = 5.3

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 5.3
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
				arg_17_0:Play426031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1012ui_story = arg_17_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1012ui_story"].transform.position).z)
				arg_17_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1012ui_story"].transform.localEulerAngles = arg_17_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_17_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1012ui_story"].transform.position).z)
				arg_17_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1012ui_story"].transform.localEulerAngles = arg_17_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1012ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1012ui_story == nil then
				arg_17_1.var_.characterEffect1012ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1012ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1012ui_story then
				arg_17_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_20_4 = 0
			local var_20_5 = 0.175

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(426031004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 7 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 7)

				if (7 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 7)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031004", "story_v_out_426031.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031004", "story_v_out_426031.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_426031", "426031004", "story_v_out_426031.awb")

						arg_17_1:RecordAudio("426031004", var_20_11)
						arg_17_1:RecordAudio("426031004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_426031", "426031004", "story_v_out_426031.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_426031", "426031004", "story_v_out_426031.awb")
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
				actorName = "1012ui_story",
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
	Play426031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play426031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1012ui_story"]) and arg_21_1.var_.characterEffect1012ui_story == nil then
				arg_21_1.var_.characterEffect1012ui_story = arg_21_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1012ui_story"]) then
				if arg_21_1.var_.characterEffect1012ui_story and not isNil(arg_21_1.actors_["1012ui_story"]) then
					arg_21_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1012ui_story"]) and arg_21_1.var_.characterEffect1012ui_story then
				arg_21_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(426031005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 3 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 3)

				if (3 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 3)) > 0 and var_24_2 < var_24_5 then
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play426031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 426031006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play426031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1012ui_story = arg_25_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1012ui_story"].transform.position).z)
				arg_25_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1012ui_story"].transform.localEulerAngles = arg_25_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1012ui_story"].transform.position).z)
				arg_25_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1012ui_story"].transform.localEulerAngles = arg_25_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 1.375

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(426031006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 55 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 55)

				if (55 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 55)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play426031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 426031007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play426031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1012ui_story = arg_29_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1012ui_story"].transform.position).z)
				arg_29_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1012ui_story"].transform.localEulerAngles = arg_29_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_29_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1012ui_story"].transform.position).z)
				arg_29_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1012ui_story"].transform.localEulerAngles = arg_29_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1012ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1012ui_story == nil then
				arg_29_1.var_.characterEffect1012ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1012ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1012ui_story then
				arg_29_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(426031007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 10 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 10)

				if (10 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 10)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031007", "story_v_out_426031.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031007", "story_v_out_426031.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_426031", "426031007", "story_v_out_426031.awb")

						arg_29_1:RecordAudio("426031007", var_32_11)
						arg_29_1:RecordAudio("426031007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_426031", "426031007", "story_v_out_426031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_426031", "426031007", "story_v_out_426031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play426031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 426031008
		arg_33_1.duration_ = 6.2

		local var_33_0 = {
			zh = 3.866,
			ja = 6.2
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
				arg_33_0:Play426031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1012ui_story"]) and arg_33_1.var_.characterEffect1012ui_story == nil then
				arg_33_1.var_.characterEffect1012ui_story = arg_33_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1012ui_story"]) then
				if arg_33_1.var_.characterEffect1012ui_story and not isNil(arg_33_1.actors_["1012ui_story"]) then
					arg_33_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1012ui_story"]) and arg_33_1.var_.characterEffect1012ui_story then
				arg_33_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1110].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10090")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(426031008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 19 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 19)

				if (19 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 19)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031008", "story_v_out_426031.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_426031", "426031008", "story_v_out_426031.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_426031", "426031008", "story_v_out_426031.awb")

						arg_33_1:RecordAudio("426031008", var_36_8)
						arg_33_1:RecordAudio("426031008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_426031", "426031008", "story_v_out_426031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_426031", "426031008", "story_v_out_426031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play426031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 426031009
		arg_37_1.duration_ = 8.83

		local var_37_0 = {
			zh = 4.233,
			ja = 8.833
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
				arg_37_0:Play426031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1012ui_story = arg_37_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1012ui_story"].transform.position).z)
				arg_37_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1012ui_story"].transform.localEulerAngles = arg_37_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_37_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1012ui_story"].transform.position).z)
				arg_37_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1012ui_story"].transform.localEulerAngles = arg_37_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1012ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1012ui_story == nil then
				arg_37_1.var_.characterEffect1012ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1012ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1012ui_story then
				arg_37_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 0.5

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(426031009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 20 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 20)

				if (20 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 20)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031009", "story_v_out_426031.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031009", "story_v_out_426031.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_426031", "426031009", "story_v_out_426031.awb")

						arg_37_1:RecordAudio("426031009", var_40_11)
						arg_37_1:RecordAudio("426031009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_426031", "426031009", "story_v_out_426031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_426031", "426031009", "story_v_out_426031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play426031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 426031010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play426031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1012ui_story"]) and arg_41_1.var_.characterEffect1012ui_story == nil then
				arg_41_1.var_.characterEffect1012ui_story = arg_41_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1012ui_story"]) then
				if arg_41_1.var_.characterEffect1012ui_story and not isNil(arg_41_1.actors_["1012ui_story"]) then
					arg_41_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1012ui_story"]) and arg_41_1.var_.characterEffect1012ui_story then
				arg_41_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.55

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(426031010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 22 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 22)

				if (22 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 22)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play426031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 426031011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play426031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1012ui_story = arg_45_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1012ui_story"].transform.position).z)
				arg_45_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1012ui_story"].transform.localEulerAngles = arg_45_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1012ui_story"].transform.position).z)
				arg_45_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1012ui_story"].transform.localEulerAngles = arg_45_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_48_1 = 0
			local var_48_2 = 1.025

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

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(426031011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 41 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 41)

				if (41 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 41)) > 0 and var_48_2 < var_48_5 then
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play426031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 426031012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play426031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.4

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

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(426031012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 16 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 16)

				if (16 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 16)) > 0 and var_52_0 < var_52_3 then
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
	Play426031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 426031013
		arg_53_1.duration_ = 8.43

		local var_53_0 = {
			zh = 5.9,
			ja = 8.433
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play426031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1012ui_story = arg_53_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1012ui_story"].transform.position).z)
				arg_53_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1012ui_story"].transform.localEulerAngles = arg_53_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_53_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1012ui_story"].transform.position).z)
				arg_53_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1012ui_story"].transform.localEulerAngles = arg_53_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1012ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1012ui_story == nil then
				arg_53_1.var_.characterEffect1012ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1012ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1012ui_story then
				arg_53_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(426031013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 33 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 33)

				if (33 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 33)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031013", "story_v_out_426031.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031013", "story_v_out_426031.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_426031", "426031013", "story_v_out_426031.awb")

						arg_53_1:RecordAudio("426031013", var_56_11)
						arg_53_1:RecordAudio("426031013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_426031", "426031013", "story_v_out_426031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_426031", "426031013", "story_v_out_426031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play426031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 426031014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play426031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1012ui_story"]) and arg_57_1.var_.characterEffect1012ui_story == nil then
				arg_57_1.var_.characterEffect1012ui_story = arg_57_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1012ui_story"]) then
				if arg_57_1.var_.characterEffect1012ui_story and not isNil(arg_57_1.actors_["1012ui_story"]) then
					arg_57_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1012ui_story"]) and arg_57_1.var_.characterEffect1012ui_story then
				arg_57_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.65

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

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(426031014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 26 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 26)

				if (26 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 26)) > 0 and var_60_2 < var_60_5 then
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
	Play426031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 426031015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play426031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1012ui_story = arg_61_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1012ui_story"].transform.position).z)
				arg_61_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1012ui_story"].transform.localEulerAngles = arg_61_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1012ui_story"].transform.position).z)
				arg_61_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1012ui_story"].transform.localEulerAngles = arg_61_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0.034000001847744 < arg_61_1.time_ and arg_61_1.time_ <= 0.034000001847744 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_plastic", "")
			end

			local var_64_2 = 0
			local var_64_3 = 0.7

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(426031015).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 28 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 28)

				if (28 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 28)) > 0 and var_64_3 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_7 and arg_61_1.time_ < var_64_2 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play426031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 426031016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play426031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.175

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(426031016).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 7 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 7)

				if (7 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 7)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play426031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 426031017
		arg_69_1.duration_ = 9.13

		local var_69_0 = {
			zh = 6.1,
			ja = 9.133
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
				arg_69_0:Play426031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1012ui_story = arg_69_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1012ui_story"].transform.position).z)
				arg_69_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1012ui_story"].transform.localEulerAngles = arg_69_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_69_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1012ui_story"].transform.position).z)
				arg_69_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1012ui_story"].transform.localEulerAngles = arg_69_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1012ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1012ui_story == nil then
				arg_69_1.var_.characterEffect1012ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1012ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1012ui_story then
				arg_69_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_72_4 = 0
			local var_72_5 = 0.725

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(426031017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 29 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 29)

				if (29 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 29)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031017", "story_v_out_426031.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031017", "story_v_out_426031.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_426031", "426031017", "story_v_out_426031.awb")

						arg_69_1:RecordAudio("426031017", var_72_11)
						arg_69_1:RecordAudio("426031017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_426031", "426031017", "story_v_out_426031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_426031", "426031017", "story_v_out_426031.awb")
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

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play426031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 426031018
		arg_73_1.duration_ = 11.3

		local var_73_0 = {
			zh = 9.033,
			ja = 11.3
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
				arg_73_0:Play426031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1012ui_story = arg_73_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1012ui_story"].transform.position).z)
				arg_73_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1012ui_story"].transform.localEulerAngles = arg_73_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_73_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1012ui_story"].transform.position).z)
				arg_73_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1012ui_story"].transform.localEulerAngles = arg_73_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_76_1 = 0
			local var_76_2 = 1.05

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:GetWordFromCfg(426031018)
				local var_76_4 = arg_73_1:FormatText(var_76_3.content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 42 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 42)

				if (42 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_4) / 42)) > 0 and var_76_2 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031018", "story_v_out_426031.awb") ~= 0 then
					local var_76_7 = manager.audio:GetVoiceLength("story_v_out_426031", "426031018", "story_v_out_426031.awb") / 1000

					if var_76_7 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_1
					end

					if var_76_3.prefab_name ~= "" and arg_73_1.actors_[var_76_3.prefab_name] ~= nil then
						local var_76_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_3.prefab_name].transform, "story_v_out_426031", "426031018", "story_v_out_426031.awb")

						arg_73_1:RecordAudio("426031018", var_76_8)
						arg_73_1:RecordAudio("426031018", var_76_8)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_426031", "426031018", "story_v_out_426031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_426031", "426031018", "story_v_out_426031.awb")
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

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play426031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 426031019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play426031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1012ui_story"]) and arg_77_1.var_.characterEffect1012ui_story == nil then
				arg_77_1.var_.characterEffect1012ui_story = arg_77_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1012ui_story"]) then
				if arg_77_1.var_.characterEffect1012ui_story and not isNil(arg_77_1.actors_["1012ui_story"]) then
					arg_77_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1012ui_story"]) and arg_77_1.var_.characterEffect1012ui_story then
				arg_77_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.3

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(426031019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 12 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 12)

				if (12 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 12)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play426031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 426031020
		arg_81_1.duration_ = 6.4

		local var_81_0 = {
			zh = 5.566,
			ja = 6.4
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
				arg_81_0:Play426031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1012ui_story"]) and arg_81_1.var_.characterEffect1012ui_story == nil then
				arg_81_1.var_.characterEffect1012ui_story = arg_81_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1012ui_story"]) then
				if arg_81_1.var_.characterEffect1012ui_story and not isNil(arg_81_1.actors_["1012ui_story"]) then
					arg_81_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1012ui_story"]) and arg_81_1.var_.characterEffect1012ui_story then
				arg_81_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_84_2 = 0
			local var_84_3 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(426031020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 24 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 24)

				if (24 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 24)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031020", "story_v_out_426031.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_426031", "426031020", "story_v_out_426031.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_426031", "426031020", "story_v_out_426031.awb")

						arg_81_1:RecordAudio("426031020", var_84_9)
						arg_81_1:RecordAudio("426031020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_426031", "426031020", "story_v_out_426031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_426031", "426031020", "story_v_out_426031.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play426031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 426031021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play426031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1012ui_story"]) and arg_85_1.var_.characterEffect1012ui_story == nil then
				arg_85_1.var_.characterEffect1012ui_story = arg_85_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1012ui_story"]) then
				if arg_85_1.var_.characterEffect1012ui_story and not isNil(arg_85_1.actors_["1012ui_story"]) then
					arg_85_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1012ui_story"]) and arg_85_1.var_.characterEffect1012ui_story then
				arg_85_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.125

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(426031021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 5 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 5)

				if (5 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 5)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play426031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 426031022
		arg_89_1.duration_ = 5.2

		local var_89_0 = {
			zh = 4.066,
			ja = 5.2
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play426031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1012ui_story = arg_89_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1012ui_story"].transform.position).z)
				arg_89_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1012ui_story"].transform.localEulerAngles = arg_89_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_89_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1012ui_story"].transform.position).z)
				arg_89_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1012ui_story"].transform.localEulerAngles = arg_89_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1012ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1012ui_story == nil then
				arg_89_1.var_.characterEffect1012ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1012ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1012ui_story then
				arg_89_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.4

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(426031022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 16 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 16)

				if (16 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 16)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031022", "story_v_out_426031.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031022", "story_v_out_426031.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_426031", "426031022", "story_v_out_426031.awb")

						arg_89_1:RecordAudio("426031022", var_92_11)
						arg_89_1:RecordAudio("426031022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_426031", "426031022", "story_v_out_426031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_426031", "426031022", "story_v_out_426031.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play426031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 426031023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play426031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1012ui_story = arg_93_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1012ui_story"].transform.position).z)
				arg_93_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1012ui_story"].transform.localEulerAngles = arg_93_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1012ui_story"].transform.position).z)
				arg_93_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1012ui_story"].transform.localEulerAngles = arg_93_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1012ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1012ui_story == nil then
				arg_93_1.var_.characterEffect1012ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1012ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_2)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1012ui_story then
				arg_93_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_96_3 = 0
			local var_96_4 = 0.875

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(426031023).content)

				arg_93_1.text_.text = var_96_5

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 35 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 35)

				if (35 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_5) / 35)) > 0 and var_96_4 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_5
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_8 and arg_93_1.time_ < var_96_3 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play426031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 426031024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play426031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.85

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(426031024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 34 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 34)

				if (34 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 34)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play426031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 426031025
		arg_101_1.duration_ = 3.23

		local var_101_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_101_0:Play426031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1012ui_story = arg_101_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1012ui_story"].transform.position).z)
				arg_101_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1012ui_story"].transform.localEulerAngles = arg_101_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_101_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1012ui_story"].transform.position).z)
				arg_101_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1012ui_story"].transform.localEulerAngles = arg_101_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1012ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1012ui_story == nil then
				arg_101_1.var_.characterEffect1012ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1012ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1012ui_story then
				arg_101_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_104_4 = 0
			local var_104_5 = 0.2

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(426031025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 8 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 8)

				if (8 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 8)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031025", "story_v_out_426031.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031025", "story_v_out_426031.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_426031", "426031025", "story_v_out_426031.awb")

						arg_101_1:RecordAudio("426031025", var_104_11)
						arg_101_1:RecordAudio("426031025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_426031", "426031025", "story_v_out_426031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_426031", "426031025", "story_v_out_426031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play426031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 426031026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play426031027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1012ui_story"]) and arg_105_1.var_.characterEffect1012ui_story == nil then
				arg_105_1.var_.characterEffect1012ui_story = arg_105_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1012ui_story"]) then
				if arg_105_1.var_.characterEffect1012ui_story and not isNil(arg_105_1.actors_["1012ui_story"]) then
					arg_105_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1012ui_story"]) and arg_105_1.var_.characterEffect1012ui_story then
				arg_105_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(426031026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 19 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 19)

				if (19 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 19)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play426031027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 426031027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play426031028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1012ui_story = arg_109_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1012ui_story"].transform.position).z)
				arg_109_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1012ui_story"].transform.localEulerAngles = arg_109_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1012ui_story"].transform.position).z)
				arg_109_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1012ui_story"].transform.localEulerAngles = arg_109_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_112_1 = 0
			local var_112_2 = 0.95

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(426031027).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 38 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 38)

				if (38 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 38)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play426031028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 426031028
		arg_113_1.duration_ = 7.03

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play426031029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_9000

			if arg_113_1.bgs_.J03g == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03g")
				var_116_0.name = "J03g"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.J03g = var_116_0
			end

			if 0.866666666666667 < arg_113_1.time_ and arg_113_1.time_ <= 0.866666666666667 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.J03g

				arg_113_1.bgs_.J03g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "J03g" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 1.5

			if 1.5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_4 + 0.533333333333333 and arg_113_1.time_ < var_116_4 + 0.533333333333333 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				local var_116_5 = arg_113_1.var_.effectzhuanchangshanshang1

				if not arg_113_1.var_.effectzhuanchangshanshang1 then
					var_116_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_116_5.name = "zhuanchangshanshang1"
					arg_113_1.var_.effectzhuanchangshanshang1 = var_116_5
				else
					var_116_5.transform:SetParent(var_116_9000)
				end

				var_116_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_7 = 2.03333333333333
			local var_116_8 = 0.375

			if 2.03333333333333 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_9 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_9:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_10 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(426031028).content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_12 = 15 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 15)

				if (15 <= 0 and var_116_8 or var_116_8 * (utf8.len(var_116_10) / 15)) > 0 and var_116_8 < var_116_12 then
					arg_113_1.talkMaxDuration = var_116_12
					var_116_7 = var_116_7 + 0.3

					if var_116_12 + var_116_7 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_7
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = var_116_7 + 0.3
			local var_116_14 = math.max(var_116_8, arg_113_1.talkMaxDuration)

			if var_116_7 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_13 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_13) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_13 + var_116_14 and arg_113_1.time_ < var_116_13 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play426031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 426031029
		arg_119_1.duration_ = 4.17

		local var_119_0 = {
			zh = 4.166,
			ja = 3.666
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
				arg_119_0:Play426031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if arg_119_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_122_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_119_1.stage_.transform)

				var_122_0.name = "1054ui_story"
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1054ui_story"] = var_122_0

				local var_122_1 = var_122_0:GetComponentInChildren(typeof(CharacterEffect))

				var_122_1.enabled = true

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_0, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end

				arg_119_1:ShowWeapon(var_122_1.transform, false)

				arg_119_1.var_["1054ui_story" .. "Animator"] = var_122_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_119_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_119_1.var_["1054ui_story" .. "LipSync"] = var_122_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_122_3 = arg_119_1.actors_["1054ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1054ui_story = var_122_3.localPosition

				local var_122_4 = GameObjectTools.GetOrAddComponent(var_122_3.gameObject, typeof(DynamicBoneHelper))

				if var_122_4 then
					var_122_4:EnableDynamicBone(false)
				end
			end

			local var_122_5 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_119_1.time_ - 0) / var_122_5)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles

				local var_122_6 = GameObjectTools.GetOrAddComponent(var_122_3.gameObject, typeof(DynamicBoneHelper))

				if var_122_6 then
					var_122_6:EnableDynamicBone(true)
				end
			end

			local var_122_7 = arg_119_1.actors_["1054ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.characterEffect1054ui_story == nil then
				arg_119_1.var_.characterEffect1054ui_story = var_122_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_8 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_8 and not isNil(var_122_7) then
				if arg_119_1.var_.characterEffect1054ui_story and not isNil(var_122_7) then
					arg_119_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_8 and arg_119_1.time_ < 0 + var_122_8 + arg_122_0 and not isNil(var_122_7) and arg_119_1.var_.characterEffect1054ui_story then
				arg_119_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			local var_122_10 = 0
			local var_122_11 = 0.325

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_12 = arg_119_1:GetWordFromCfg(426031029)
				local var_122_13 = arg_119_1:FormatText(var_122_12.content)

				arg_119_1.text_.text = var_122_13

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_15 = 13 <= 0 and var_122_11 or var_122_11 * (utf8.len(var_122_13) / 13)

				if (13 <= 0 and var_122_11 or var_122_11 * (utf8.len(var_122_13) / 13)) > 0 and var_122_11 < var_122_15 then
					arg_119_1.talkMaxDuration = var_122_15

					if var_122_15 + var_122_10 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_15 + var_122_10
					end
				end

				arg_119_1.text_.text = var_122_13
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031029", "story_v_out_426031.awb") ~= 0 then
					local var_122_16 = manager.audio:GetVoiceLength("story_v_out_426031", "426031029", "story_v_out_426031.awb") / 1000

					if var_122_16 + var_122_10 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_10
					end

					if var_122_12.prefab_name ~= "" and arg_119_1.actors_[var_122_12.prefab_name] ~= nil then
						local var_122_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_12.prefab_name].transform, "story_v_out_426031", "426031029", "story_v_out_426031.awb")

						arg_119_1:RecordAudio("426031029", var_122_17)
						arg_119_1:RecordAudio("426031029", var_122_17)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_426031", "426031029", "story_v_out_426031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_426031", "426031029", "story_v_out_426031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_18 = math.max(var_122_11, arg_119_1.talkMaxDuration)

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_18 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_10) / var_122_18

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_10 + var_122_18 and arg_119_1.time_ < var_122_10 + var_122_18 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play426031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 426031030
		arg_123_1.duration_ = 9.8

		local var_123_0 = {
			zh = 4.733,
			ja = 9.8
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
				arg_123_0:Play426031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_126_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_123_1.stage_.transform)

				var_126_0.name = "6148ui_story"
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["6148ui_story"] = var_126_0

				local var_126_1 = var_126_0:GetComponentInChildren(typeof(CharacterEffect))

				var_126_1.enabled = true

				local var_126_2 = GameObjectTools.GetOrAddComponent(var_126_0, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_1.transform, false)

				arg_123_1.var_["6148ui_story" .. "Animator"] = var_126_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_123_1.var_["6148ui_story" .. "LipSync"] = var_126_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_126_3 = arg_123_1.actors_["6148ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos6148ui_story = var_126_3.localPosition

				local var_126_4 = GameObjectTools.GetOrAddComponent(var_126_3.gameObject, typeof(DynamicBoneHelper))

				if var_126_4 then
					var_126_4:EnableDynamicBone(false)
				end
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_3.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_123_1.time_ - 0) / var_126_5)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles

				local var_126_6 = GameObjectTools.GetOrAddComponent(var_126_3.gameObject, typeof(DynamicBoneHelper))

				if var_126_6 then
					var_126_6:EnableDynamicBone(true)
				end
			end

			local var_126_7 = arg_123_1.actors_["6148ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.characterEffect6148ui_story == nil then
				arg_123_1.var_.characterEffect6148ui_story = var_126_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_8 and not isNil(var_126_7) then
				if arg_123_1.var_.characterEffect6148ui_story and not isNil(var_126_7) then
					arg_123_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_8 and arg_123_1.time_ < 0 + var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.characterEffect6148ui_story then
				arg_123_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_126_10 = arg_123_1.actors_["1054ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_10) and arg_123_1.var_.characterEffect1054ui_story == nil then
				arg_123_1.var_.characterEffect1054ui_story = var_126_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_11 and not isNil(var_126_10) then
				if arg_123_1.var_.characterEffect1054ui_story and not isNil(var_126_10) then
					arg_123_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_11)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_11 and arg_123_1.time_ < 0 + var_126_11 + arg_126_0 and not isNil(var_126_10) and arg_123_1.var_.characterEffect1054ui_story then
				arg_123_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_126_12 = 0
			local var_126_13 = 0.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
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

				local var_126_14 = arg_123_1:GetWordFromCfg(426031030)
				local var_126_15 = arg_123_1:FormatText(var_126_14.content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 24 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 24)

				if (24 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 24)) > 0 and var_126_13 < var_126_17 then
					arg_123_1.talkMaxDuration = var_126_17

					if var_126_17 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031030", "story_v_out_426031.awb") ~= 0 then
					local var_126_18 = manager.audio:GetVoiceLength("story_v_out_426031", "426031030", "story_v_out_426031.awb") / 1000

					if var_126_18 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_12
					end

					if var_126_14.prefab_name ~= "" and arg_123_1.actors_[var_126_14.prefab_name] ~= nil then
						local var_126_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_14.prefab_name].transform, "story_v_out_426031", "426031030", "story_v_out_426031.awb")

						arg_123_1:RecordAudio("426031030", var_126_19)
						arg_123_1:RecordAudio("426031030", var_126_19)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_426031", "426031030", "story_v_out_426031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_426031", "426031030", "story_v_out_426031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_20 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_20 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_12) / var_126_20

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_12 + var_126_20 and arg_123_1.time_ < var_126_12 + var_126_20 + arg_126_0 then
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
	Play426031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 426031031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play426031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos6148ui_story = arg_127_1.actors_["6148ui_story"].transform.localPosition

				local var_130_0 = GameObjectTools.GetOrAddComponent(arg_127_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_130_0 then
					var_130_0:EnableDynamicBone(false)
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_1)
				arg_127_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).z)
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles = arg_127_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["6148ui_story"].transform.position).z)
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["6148ui_story"].transform.localEulerAngles = arg_127_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_130_2 = GameObjectTools.GetOrAddComponent(arg_127_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(true)
				end
			end

			local var_130_3 = arg_127_1.actors_["1054ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1054ui_story = var_130_3.localPosition

				local var_130_4 = GameObjectTools.GetOrAddComponent(var_130_3.gameObject, typeof(DynamicBoneHelper))

				if var_130_4 then
					var_130_4:EnableDynamicBone(false)
				end
			end

			local var_130_5 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 then
				var_130_3.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_5)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 then
				var_130_3.localPosition = Vector3.New(0, 100, 0)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles

				local var_130_6 = GameObjectTools.GetOrAddComponent(var_130_3.gameObject, typeof(DynamicBoneHelper))

				if var_130_6 then
					var_130_6:EnableDynamicBone(true)
				end
			end

			local var_130_7 = arg_127_1.actors_["6148ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.characterEffect6148ui_story == nil then
				arg_127_1.var_.characterEffect6148ui_story = var_130_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_8 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_8 and not isNil(var_130_7) then
				if arg_127_1.var_.characterEffect6148ui_story and not isNil(var_130_7) then
					arg_127_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_127_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_8)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_8 and arg_127_1.time_ < 0 + var_130_8 + arg_130_0 and not isNil(var_130_7) and arg_127_1.var_.characterEffect6148ui_story then
				arg_127_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_127_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_130_9 = 0
			local var_130_10 = 0.725

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_11 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(426031031).content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 29 <= 0 and var_130_10 or var_130_10 * (utf8.len(var_130_11) / 29)

				if (29 <= 0 and var_130_10 or var_130_10 * (utf8.len(var_130_11) / 29)) > 0 and var_130_10 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_9 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_9
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_10, arg_127_1.talkMaxDuration)

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_9) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_9 + var_130_14 and arg_127_1.time_ < var_130_9 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play426031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 426031032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play426031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.4

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(426031032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 16)

				if (16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 16)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play426031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 426031033
		arg_135_1.duration_ = 3.43

		local var_135_0 = {
			zh = 3.433,
			ja = 3.333
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
				arg_135_0:Play426031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1054ui_story = arg_135_1.actors_["1054ui_story"].transform.localPosition

				local var_138_0 = GameObjectTools.GetOrAddComponent(arg_135_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_138_0 then
					var_138_0:EnableDynamicBone(false)
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_135_1.time_ - 0) / var_138_1)
				arg_135_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1054ui_story"].transform.position).z)
				arg_135_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1054ui_story"].transform.localEulerAngles = arg_135_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_135_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1054ui_story"].transform.position).z)
				arg_135_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1054ui_story"].transform.localEulerAngles = arg_135_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_138_2 = GameObjectTools.GetOrAddComponent(arg_135_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_138_2 then
					var_138_2:EnableDynamicBone(true)
				end
			end

			local var_138_3 = arg_135_1.actors_["1054ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_3) and arg_135_1.var_.characterEffect1054ui_story == nil then
				arg_135_1.var_.characterEffect1054ui_story = var_138_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_4 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 and not isNil(var_138_3) then
				if arg_135_1.var_.characterEffect1054ui_story and not isNil(var_138_3) then
					arg_135_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 and not isNil(var_138_3) and arg_135_1.var_.characterEffect1054ui_story then
				arg_135_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_138_6 = 0
			local var_138_7 = 0.2

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:GetWordFromCfg(426031033)
				local var_138_9 = arg_135_1:FormatText(var_138_8.content)

				arg_135_1.text_.text = var_138_9

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 8 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 8)

				if (8 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_9) / 8)) > 0 and var_138_7 < var_138_11 then
					arg_135_1.talkMaxDuration = var_138_11

					if var_138_11 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_9
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031033", "story_v_out_426031.awb") ~= 0 then
					local var_138_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031033", "story_v_out_426031.awb") / 1000

					if var_138_12 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_12 + var_138_6
					end

					if var_138_8.prefab_name ~= "" and arg_135_1.actors_[var_138_8.prefab_name] ~= nil then
						local var_138_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_8.prefab_name].transform, "story_v_out_426031", "426031033", "story_v_out_426031.awb")

						arg_135_1:RecordAudio("426031033", var_138_13)
						arg_135_1:RecordAudio("426031033", var_138_13)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_426031", "426031033", "story_v_out_426031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_426031", "426031033", "story_v_out_426031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_14 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_14 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_14

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_14 and arg_135_1.time_ < var_138_6 + var_138_14 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play426031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 426031034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play426031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1054ui_story"]) and arg_139_1.var_.characterEffect1054ui_story == nil then
				arg_139_1.var_.characterEffect1054ui_story = arg_139_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1054ui_story"]) then
				if arg_139_1.var_.characterEffect1054ui_story and not isNil(arg_139_1.actors_["1054ui_story"]) then
					arg_139_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1054ui_story"]) and arg_139_1.var_.characterEffect1054ui_story then
				arg_139_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_142_1 = 0
			local var_142_2 = 0.725

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

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(426031034).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 29 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 29)

				if (29 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 29)) > 0 and var_142_2 < var_142_5 then
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
	Play426031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 426031035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play426031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.7

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(426031035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 28 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 28)

				if (28 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 28)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play426031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 426031036
		arg_147_1.duration_ = 4.97

		local var_147_0 = {
			zh = 4.966,
			ja = 4.4
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play426031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos6148ui_story = arg_147_1.actors_["6148ui_story"].transform.localPosition

				local var_150_0 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_0 then
					var_150_0:EnableDynamicBone(false)
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_147_1.time_ - 0) / var_150_1)
				arg_147_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).z)
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles = arg_147_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_147_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["6148ui_story"].transform.position).z)
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["6148ui_story"].transform.localEulerAngles = arg_147_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_150_2 = GameObjectTools.GetOrAddComponent(arg_147_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_150_2 then
					var_150_2:EnableDynamicBone(true)
				end
			end

			local var_150_3 = arg_147_1.actors_["1054ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1054ui_story = var_150_3.localPosition

				local var_150_4 = GameObjectTools.GetOrAddComponent(var_150_3.gameObject, typeof(DynamicBoneHelper))

				if var_150_4 then
					var_150_4:EnableDynamicBone(false)
				end
			end

			local var_150_5 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 then
				var_150_3.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_147_1.time_ - 0) / var_150_5)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 then
				var_150_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_150_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_3.position).x, (manager.ui.mainCamera.transform.position - var_150_3.position).y, (manager.ui.mainCamera.transform.position - var_150_3.position).z)
				var_150_3.localEulerAngles.z = 0
				var_150_3.localEulerAngles.x = 0
				var_150_3.localEulerAngles = var_150_3.localEulerAngles

				local var_150_6 = GameObjectTools.GetOrAddComponent(var_150_3.gameObject, typeof(DynamicBoneHelper))

				if var_150_6 then
					var_150_6:EnableDynamicBone(true)
				end
			end

			local var_150_7 = arg_147_1.actors_["6148ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.characterEffect6148ui_story == nil then
				arg_147_1.var_.characterEffect6148ui_story = var_150_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_8 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_8 and not isNil(var_150_7) then
				if arg_147_1.var_.characterEffect6148ui_story and not isNil(var_150_7) then
					arg_147_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_8 and arg_147_1.time_ < 0 + var_150_8 + arg_150_0 and not isNil(var_150_7) and arg_147_1.var_.characterEffect6148ui_story then
				arg_147_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_150_10 = 0
			local var_150_11 = 0.5

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_12 = arg_147_1:GetWordFromCfg(426031036)
				local var_150_13 = arg_147_1:FormatText(var_150_12.content)

				arg_147_1.text_.text = var_150_13

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_15 = 20 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 20)

				if (20 <= 0 and var_150_11 or var_150_11 * (utf8.len(var_150_13) / 20)) > 0 and var_150_11 < var_150_15 then
					arg_147_1.talkMaxDuration = var_150_15

					if var_150_15 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_15 + var_150_10
					end
				end

				arg_147_1.text_.text = var_150_13
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031036", "story_v_out_426031.awb") ~= 0 then
					local var_150_16 = manager.audio:GetVoiceLength("story_v_out_426031", "426031036", "story_v_out_426031.awb") / 1000

					if var_150_16 + var_150_10 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_10
					end

					if var_150_12.prefab_name ~= "" and arg_147_1.actors_[var_150_12.prefab_name] ~= nil then
						local var_150_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_12.prefab_name].transform, "story_v_out_426031", "426031036", "story_v_out_426031.awb")

						arg_147_1:RecordAudio("426031036", var_150_17)
						arg_147_1:RecordAudio("426031036", var_150_17)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_426031", "426031036", "story_v_out_426031.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_426031", "426031036", "story_v_out_426031.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_18 = math.max(var_150_11, arg_147_1.talkMaxDuration)

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_18 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_10) / var_150_18

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_10 + var_150_18 and arg_147_1.time_ < var_150_10 + var_150_18 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play426031037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426031037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426031038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) and arg_151_1.var_.characterEffect6148ui_story == nil then
				arg_151_1.var_.characterEffect6148ui_story = arg_151_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) then
				if arg_151_1.var_.characterEffect6148ui_story and not isNil(arg_151_1.actors_["6148ui_story"]) then
					arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_151_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["6148ui_story"]) and arg_151_1.var_.characterEffect6148ui_story then
				arg_151_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_151_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(426031037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 24 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 24)

				if (24 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 24)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play426031038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426031038
		arg_155_1.duration_ = 8.6

		local var_155_0 = {
			zh = 8.6,
			ja = 5.733
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
				arg_155_0:Play426031039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1054ui_story = arg_155_1.actors_["1054ui_story"].transform.localPosition

				local var_158_0 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_0 then
					var_158_0:EnableDynamicBone(false)
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_155_1.time_ - 0) / var_158_1)
				arg_155_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).z)
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles = arg_155_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_155_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1054ui_story"].transform.position).z)
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1054ui_story"].transform.localEulerAngles = arg_155_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_158_2 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(true)
				end
			end

			local var_158_3 = arg_155_1.actors_["1054ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect1054ui_story == nil then
				arg_155_1.var_.characterEffect1054ui_story = var_158_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_3) then
				if arg_155_1.var_.characterEffect1054ui_story and not isNil(var_158_3) then
					arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect1054ui_story then
				arg_155_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.85

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_8 = arg_155_1:GetWordFromCfg(426031038)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 34 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 34)

				if (34 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 34)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031038", "story_v_out_426031.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031038", "story_v_out_426031.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_426031", "426031038", "story_v_out_426031.awb")

						arg_155_1:RecordAudio("426031038", var_158_13)
						arg_155_1:RecordAudio("426031038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_426031", "426031038", "story_v_out_426031.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_426031", "426031038", "story_v_out_426031.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_14 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_14 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_14

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_14 and arg_155_1.time_ < var_158_6 + var_158_14 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play426031039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426031039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426031040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos6148ui_story = arg_159_1.actors_["6148ui_story"].transform.localPosition

				local var_162_0 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_0 then
					var_162_0:EnableDynamicBone(false)
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_1)
				arg_159_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["6148ui_story"].transform.position).z)
				arg_159_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["6148ui_story"].transform.localEulerAngles = arg_159_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["6148ui_story"].transform.position).z)
				arg_159_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["6148ui_story"].transform.localEulerAngles = arg_159_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_162_2 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(true)
				end
			end

			local var_162_3 = arg_159_1.actors_["1054ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1054ui_story = var_162_3.localPosition

				local var_162_4 = GameObjectTools.GetOrAddComponent(var_162_3.gameObject, typeof(DynamicBoneHelper))

				if var_162_4 then
					var_162_4:EnableDynamicBone(false)
				end
			end

			local var_162_5 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 then
				var_162_3.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_5)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 then
				var_162_3.localPosition = Vector3.New(0, 100, 0)
				var_162_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_3.position).x, (manager.ui.mainCamera.transform.position - var_162_3.position).y, (manager.ui.mainCamera.transform.position - var_162_3.position).z)
				var_162_3.localEulerAngles.z = 0
				var_162_3.localEulerAngles.x = 0
				var_162_3.localEulerAngles = var_162_3.localEulerAngles

				local var_162_6 = GameObjectTools.GetOrAddComponent(var_162_3.gameObject, typeof(DynamicBoneHelper))

				if var_162_6 then
					var_162_6:EnableDynamicBone(true)
				end
			end

			local var_162_7 = arg_159_1.actors_["1054ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.characterEffect1054ui_story == nil then
				arg_159_1.var_.characterEffect1054ui_story = var_162_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_8 and not isNil(var_162_7) then
				if arg_159_1.var_.characterEffect1054ui_story and not isNil(var_162_7) then
					arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_8)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_8 and arg_159_1.time_ < 0 + var_162_8 + arg_162_0 and not isNil(var_162_7) and arg_159_1.var_.characterEffect1054ui_story then
				arg_159_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_162_9 = 0
			local var_162_10 = 1.125

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_9 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_11 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(426031039).content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 45 <= 0 and var_162_10 or var_162_10 * (utf8.len(var_162_11) / 45)

				if (45 <= 0 and var_162_10 or var_162_10 * (utf8.len(var_162_11) / 45)) > 0 and var_162_10 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_9 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_9
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_10, arg_159_1.talkMaxDuration)

			if var_162_9 <= arg_159_1.time_ and arg_159_1.time_ < var_162_9 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_9) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_9 + var_162_14 and arg_159_1.time_ < var_162_9 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play426031040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426031040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play426031041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.875

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(426031040).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 35 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 35)

				if (35 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 35)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play426031041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426031041
		arg_167_1.duration_ = 4.67

		local var_167_0 = {
			zh = 4.666,
			ja = 2.9
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
				arg_167_0:Play426031042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos6148ui_story = arg_167_1.actors_["6148ui_story"].transform.localPosition

				local var_170_0 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_0 then
					var_170_0:EnableDynamicBone(false)
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_167_1.time_ - 0) / var_170_1)
				arg_167_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["6148ui_story"].transform.position).z)
				arg_167_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["6148ui_story"].transform.localEulerAngles = arg_167_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_167_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["6148ui_story"].transform.position).z)
				arg_167_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["6148ui_story"].transform.localEulerAngles = arg_167_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_170_2 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(true)
				end
			end

			local var_170_3 = arg_167_1.actors_["6148ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect6148ui_story == nil then
				arg_167_1.var_.characterEffect6148ui_story = var_170_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_4 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 and not isNil(var_170_3) then
				if arg_167_1.var_.characterEffect6148ui_story and not isNil(var_170_3) then
					arg_167_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect6148ui_story then
				arg_167_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			local var_170_6 = 0
			local var_170_7 = 0.325

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
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

				local var_170_8 = arg_167_1:GetWordFromCfg(426031041)
				local var_170_9 = arg_167_1:FormatText(var_170_8.content)

				arg_167_1.text_.text = var_170_9

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 13 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 13)

				if (13 <= 0 and var_170_7 or var_170_7 * (utf8.len(var_170_9) / 13)) > 0 and var_170_7 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_9
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031041", "story_v_out_426031.awb") ~= 0 then
					local var_170_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031041", "story_v_out_426031.awb") / 1000

					if var_170_12 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_6
					end

					if var_170_8.prefab_name ~= "" and arg_167_1.actors_[var_170_8.prefab_name] ~= nil then
						local var_170_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_8.prefab_name].transform, "story_v_out_426031", "426031041", "story_v_out_426031.awb")

						arg_167_1:RecordAudio("426031041", var_170_13)
						arg_167_1:RecordAudio("426031041", var_170_13)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_426031", "426031041", "story_v_out_426031.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_426031", "426031041", "story_v_out_426031.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_14 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_14 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_14

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_14 and arg_167_1.time_ < var_170_6 + var_170_14 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play426031042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426031042
		arg_171_1.duration_ = 5.73

		local var_171_0 = {
			zh = 4.133,
			ja = 5.733
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426031043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1054ui_story = arg_171_1.actors_["1054ui_story"].transform.localPosition

				local var_174_0 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_0 then
					var_174_0:EnableDynamicBone(false)
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_171_1.time_ - 0) / var_174_1)
				arg_171_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).z)
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles = arg_171_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_171_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1054ui_story"].transform.position).z)
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1054ui_story"].transform.localEulerAngles = arg_171_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_174_2 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(true)
				end
			end

			local var_174_3 = arg_171_1.actors_["1054ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1054ui_story == nil then
				arg_171_1.var_.characterEffect1054ui_story = var_174_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_4 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 and not isNil(var_174_3) then
				if arg_171_1.var_.characterEffect1054ui_story and not isNil(var_174_3) then
					arg_171_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect1054ui_story then
				arg_171_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_174_6 = arg_171_1.actors_["6148ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect6148ui_story == nil then
				arg_171_1.var_.characterEffect6148ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_7 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 and not isNil(var_174_6) then
				if arg_171_1.var_.characterEffect6148ui_story and not isNil(var_174_6) then
					arg_171_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_171_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_7)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect6148ui_story then
				arg_171_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_171_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			local var_174_8 = 0
			local var_174_9 = 0.35

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(426031042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 14 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 14)

				if (14 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 14)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031042", "story_v_out_426031.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_426031", "426031042", "story_v_out_426031.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_426031", "426031042", "story_v_out_426031.awb")

						arg_171_1:RecordAudio("426031042", var_174_15)
						arg_171_1:RecordAudio("426031042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_426031", "426031042", "story_v_out_426031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_426031", "426031042", "story_v_out_426031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play426031043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 426031043
		arg_175_1.duration_ = 2

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play426031044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1012ui_story = arg_175_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1012ui_story, Vector3.New(-0.7, -1.05, -6.24), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1012ui_story"].transform.position).z)
				arg_175_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1012ui_story"].transform.localEulerAngles = arg_175_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.24)
				arg_175_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1012ui_story"].transform.position).z)
				arg_175_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1012ui_story"].transform.localEulerAngles = arg_175_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["6148ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos6148ui_story = var_178_1.localPosition

				local var_178_2 = GameObjectTools.GetOrAddComponent(var_178_1.gameObject, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(false)
				end
			end

			local var_178_3 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 then
				var_178_1.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_3)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 then
				var_178_1.localPosition = Vector3.New(0, 100, 0)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles

				local var_178_4 = GameObjectTools.GetOrAddComponent(var_178_1.gameObject, typeof(DynamicBoneHelper))

				if var_178_4 then
					var_178_4:EnableDynamicBone(true)
				end
			end

			local var_178_5 = arg_175_1.actors_["1012ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1012ui_story == nil then
				arg_175_1.var_.characterEffect1012ui_story = var_178_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.characterEffect1012ui_story and not isNil(var_178_5) then
					arg_175_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1012ui_story then
				arg_175_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_178_8 = arg_175_1.actors_["1054ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.characterEffect1054ui_story == nil then
				arg_175_1.var_.characterEffect1054ui_story = var_178_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_9 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_9 and not isNil(var_178_8) then
				if arg_175_1.var_.characterEffect1054ui_story and not isNil(var_178_8) then
					arg_175_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_9)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_9 and arg_175_1.time_ < 0 + var_178_9 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.characterEffect1054ui_story then
				arg_175_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_178_10 = 0
			local var_178_11 = 0.1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_12 = arg_175_1:GetWordFromCfg(426031043)
				local var_178_13 = arg_175_1:FormatText(var_178_12.content)

				arg_175_1.text_.text = var_178_13

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 4 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 4)

				if (4 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 4)) > 0 and var_178_11 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_10
					end
				end

				arg_175_1.text_.text = var_178_13
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031043", "story_v_out_426031.awb") ~= 0 then
					local var_178_16 = manager.audio:GetVoiceLength("story_v_out_426031", "426031043", "story_v_out_426031.awb") / 1000

					if var_178_16 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_16 + var_178_10
					end

					if var_178_12.prefab_name ~= "" and arg_175_1.actors_[var_178_12.prefab_name] ~= nil then
						local var_178_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_12.prefab_name].transform, "story_v_out_426031", "426031043", "story_v_out_426031.awb")

						arg_175_1:RecordAudio("426031043", var_178_17)
						arg_175_1:RecordAudio("426031043", var_178_17)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_426031", "426031043", "story_v_out_426031.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_426031", "426031043", "story_v_out_426031.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_18 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_18 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_10) / var_178_18

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_10 + var_178_18 and arg_175_1.time_ < var_178_10 + var_178_18 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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

		arg_175_1:InitPlayNodeList()
	end,
	Play426031044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 426031044
		arg_179_1.duration_ = 2

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play426031045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1054ui_story = arg_179_1.actors_["1054ui_story"].transform.localPosition

				local var_182_0 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_0 then
					var_182_0:EnableDynamicBone(false)
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_179_1.time_ - 0) / var_182_1)
				arg_179_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).z)
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles = arg_179_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_179_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1054ui_story"].transform.position).z)
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1054ui_story"].transform.localEulerAngles = arg_179_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_182_2 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(true)
				end
			end

			local var_182_3 = arg_179_1.actors_["1054ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1054ui_story == nil then
				arg_179_1.var_.characterEffect1054ui_story = var_182_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_4 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 and not isNil(var_182_3) then
				if arg_179_1.var_.characterEffect1054ui_story and not isNil(var_182_3) then
					arg_179_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect1054ui_story then
				arg_179_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_182_6 = arg_179_1.actors_["1012ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1012ui_story == nil then
				arg_179_1.var_.characterEffect1012ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_7 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 and not isNil(var_182_6) then
				if arg_179_1.var_.characterEffect1012ui_story and not isNil(var_182_6) then
					arg_179_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_7)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect1012ui_story then
				arg_179_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			local var_182_8 = 0
			local var_182_9 = 0.05

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(426031044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 2 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 2)

				if (2 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 2)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031044", "story_v_out_426031.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_426031", "426031044", "story_v_out_426031.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_426031", "426031044", "story_v_out_426031.awb")

						arg_179_1:RecordAudio("426031044", var_182_15)
						arg_179_1:RecordAudio("426031044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_426031", "426031044", "story_v_out_426031.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_426031", "426031044", "story_v_out_426031.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_16 and arg_179_1.time_ < var_182_8 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play426031045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 426031045
		arg_183_1.duration_ = 3.5

		local var_183_0 = {
			zh = 2.6,
			ja = 3.5
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
				arg_183_0:Play426031046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1012ui_story = arg_183_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1012ui_story, Vector3.New(-0.7, -1.05, -6.24), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1012ui_story"].transform.position).z)
				arg_183_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1012ui_story"].transform.localEulerAngles = arg_183_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.24)
				arg_183_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1012ui_story"].transform.position).z)
				arg_183_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1012ui_story"].transform.localEulerAngles = arg_183_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1012ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1012ui_story == nil then
				arg_183_1.var_.characterEffect1012ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1012ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1012ui_story then
				arg_183_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_186_4 = arg_183_1.actors_["1054ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1054ui_story == nil then
				arg_183_1.var_.characterEffect1054ui_story = var_186_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_5 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_5 and not isNil(var_186_4) then
				if arg_183_1.var_.characterEffect1054ui_story and not isNil(var_186_4) then
					arg_183_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_5)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_5 and arg_183_1.time_ < 0 + var_186_5 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1054ui_story then
				arg_183_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_186_6 = 0
			local var_186_7 = 0.3

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(426031045)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 12 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 12)

				if (12 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 12)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031045", "story_v_out_426031.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031045", "story_v_out_426031.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_out_426031", "426031045", "story_v_out_426031.awb")

						arg_183_1:RecordAudio("426031045", var_186_13)
						arg_183_1:RecordAudio("426031045", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_426031", "426031045", "story_v_out_426031.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_426031", "426031045", "story_v_out_426031.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play426031046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 426031046
		arg_187_1.duration_ = 2.9

		local var_187_0 = {
			zh = 2.7,
			ja = 2.9
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
				arg_187_0:Play426031047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1012ui_story = arg_187_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1012ui_story, Vector3.New(-0.7, -1.05, -6.24), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1012ui_story"].transform.position).z)
				arg_187_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1012ui_story"].transform.localEulerAngles = arg_187_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.24)
				arg_187_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1012ui_story"].transform.position).z)
				arg_187_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1012ui_story"].transform.localEulerAngles = arg_187_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_2")
			end

			local var_190_1 = 0
			local var_190_2 = 0.225

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(426031046)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_6 = 9 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_4) / 9)

				if (9 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_4) / 9)) > 0 and var_190_2 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031046", "story_v_out_426031.awb") ~= 0 then
					local var_190_7 = manager.audio:GetVoiceLength("story_v_out_426031", "426031046", "story_v_out_426031.awb") / 1000

					if var_190_7 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_1
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_426031", "426031046", "story_v_out_426031.awb")

						arg_187_1:RecordAudio("426031046", var_190_8)
						arg_187_1:RecordAudio("426031046", var_190_8)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_426031", "426031046", "story_v_out_426031.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_426031", "426031046", "story_v_out_426031.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_9 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_9 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_9

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_9 and arg_187_1.time_ < var_190_1 + var_190_9 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play426031047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 426031047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play426031048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1012ui_story = arg_191_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).z)
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles = arg_191_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).z)
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles = arg_191_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1054ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1054ui_story = var_194_1.localPosition

				local var_194_2 = GameObjectTools.GetOrAddComponent(var_194_1.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(false)
				end
			end

			local var_194_3 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 then
				var_194_1.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_3)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 then
				var_194_1.localPosition = Vector3.New(0, 100, 0)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles

				local var_194_4 = GameObjectTools.GetOrAddComponent(var_194_1.gameObject, typeof(DynamicBoneHelper))

				if var_194_4 then
					var_194_4:EnableDynamicBone(true)
				end
			end

			local var_194_5 = arg_191_1.actors_["1012ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect1012ui_story == nil then
				arg_191_1.var_.characterEffect1012ui_story = var_194_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_6 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_6 and not isNil(var_194_5) then
				if arg_191_1.var_.characterEffect1012ui_story and not isNil(var_194_5) then
					arg_191_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_6)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_6 and arg_191_1.time_ < 0 + var_194_6 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect1012ui_story then
				arg_191_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_194_7 = 0
			local var_194_8 = 0.975

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_9 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(426031047).content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 39 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_9) / 39)

				if (39 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_9) / 39)) > 0 and var_194_8 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_7
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_7) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_7 + var_194_12 and arg_191_1.time_ < var_194_7 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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

		arg_191_1:InitPlayNodeList()
	end,
	Play426031048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426031048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play426031049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.175

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

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(426031048).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 47 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 47)

				if (47 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 47)) > 0 and var_198_0 < var_198_3 then
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
	Play426031049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426031049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play426031050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.975

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(426031049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 39 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 39)

				if (39 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 39)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play426031050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426031050
		arg_203_1.duration_ = 4.33

		local var_203_0 = {
			zh = 3.9,
			ja = 4.333
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
				arg_203_0:Play426031051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos6148ui_story = arg_203_1.actors_["6148ui_story"].transform.localPosition

				local var_206_0 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_0 then
					var_206_0:EnableDynamicBone(false)
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_203_1.time_ - 0) / var_206_1)
				arg_203_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["6148ui_story"].transform.position).z)
				arg_203_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["6148ui_story"].transform.localEulerAngles = arg_203_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_203_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["6148ui_story"].transform.position).z)
				arg_203_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["6148ui_story"].transform.localEulerAngles = arg_203_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_206_2 = GameObjectTools.GetOrAddComponent(arg_203_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_206_2 then
					var_206_2:EnableDynamicBone(true)
				end
			end

			local var_206_3 = arg_203_1.actors_["6148ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect6148ui_story == nil then
				arg_203_1.var_.characterEffect6148ui_story = var_206_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_4 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 and not isNil(var_206_3) then
				if arg_203_1.var_.characterEffect6148ui_story and not isNil(var_206_3) then
					arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect6148ui_story then
				arg_203_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_206_6 = 0
			local var_206_7 = 0.25

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
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

				local var_206_8 = arg_203_1:GetWordFromCfg(426031050)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 10 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 10)

				if (10 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 10)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031050", "story_v_out_426031.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031050", "story_v_out_426031.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_426031", "426031050", "story_v_out_426031.awb")

						arg_203_1:RecordAudio("426031050", var_206_13)
						arg_203_1:RecordAudio("426031050", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426031", "426031050", "story_v_out_426031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426031", "426031050", "story_v_out_426031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play426031051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426031051
		arg_207_1.duration_ = 6.83

		local var_207_0 = {
			zh = 5.233,
			ja = 6.833
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play426031052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1012ui_story = arg_207_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1012ui_story, Vector3.New(0.7, -1.05, -6.24), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1012ui_story"].transform.position).z)
				arg_207_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1012ui_story"].transform.localEulerAngles = arg_207_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.24)
				arg_207_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1012ui_story"].transform.position).z)
				arg_207_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1012ui_story"].transform.localEulerAngles = arg_207_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1012ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1012ui_story == nil then
				arg_207_1.var_.characterEffect1012ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1012ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1012ui_story then
				arg_207_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["6148ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect6148ui_story == nil then
				arg_207_1.var_.characterEffect6148ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_5 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 and not isNil(var_210_4) then
				if arg_207_1.var_.characterEffect6148ui_story and not isNil(var_210_4) then
					arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_207_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_5)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect6148ui_story then
				arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_207_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_210_6 = 0
			local var_210_7 = 0.55

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(426031051)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 22 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 22)

				if (22 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 22)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031051", "story_v_out_426031.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031051", "story_v_out_426031.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_426031", "426031051", "story_v_out_426031.awb")

						arg_207_1:RecordAudio("426031051", var_210_13)
						arg_207_1:RecordAudio("426031051", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_426031", "426031051", "story_v_out_426031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_426031", "426031051", "story_v_out_426031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play426031052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426031052
		arg_211_1.duration_ = 10.53

		local var_211_0 = {
			zh = 8.4,
			ja = 10.533
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
				arg_211_0:Play426031053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.2

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:GetWordFromCfg(426031052)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 48 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 48)

				if (48 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 48)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031052", "story_v_out_426031.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_426031", "426031052", "story_v_out_426031.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_426031", "426031052", "story_v_out_426031.awb")

						arg_211_1:RecordAudio("426031052", var_214_6)
						arg_211_1:RecordAudio("426031052", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_426031", "426031052", "story_v_out_426031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_426031", "426031052", "story_v_out_426031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play426031053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426031053
		arg_215_1.duration_ = 2.1

		local var_215_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_215_0:Play426031054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos6148ui_story = arg_215_1.actors_["6148ui_story"].transform.localPosition

				local var_218_0 = GameObjectTools.GetOrAddComponent(arg_215_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_218_0 then
					var_218_0:EnableDynamicBone(false)
				end
			end

			local var_218_1 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				arg_215_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_215_1.time_ - 0) / var_218_1)
				arg_215_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["6148ui_story"].transform.position).z)
				arg_215_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["6148ui_story"].transform.localEulerAngles = arg_215_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_215_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["6148ui_story"].transform.position).z)
				arg_215_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["6148ui_story"].transform.localEulerAngles = arg_215_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_218_2 = GameObjectTools.GetOrAddComponent(arg_215_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_218_2 then
					var_218_2:EnableDynamicBone(true)
				end
			end

			local var_218_3 = arg_215_1.actors_["6148ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_3) and arg_215_1.var_.characterEffect6148ui_story == nil then
				arg_215_1.var_.characterEffect6148ui_story = var_218_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_4 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 and not isNil(var_218_3) then
				if arg_215_1.var_.characterEffect6148ui_story and not isNil(var_218_3) then
					arg_215_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 and not isNil(var_218_3) and arg_215_1.var_.characterEffect6148ui_story then
				arg_215_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_218_6 = arg_215_1.actors_["1012ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect1012ui_story == nil then
				arg_215_1.var_.characterEffect1012ui_story = var_218_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_7 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 and not isNil(var_218_6) then
				if arg_215_1.var_.characterEffect1012ui_story and not isNil(var_218_6) then
					arg_215_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_7)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 and not isNil(var_218_6) and arg_215_1.var_.characterEffect1012ui_story then
				arg_215_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_218_8 = 0
			local var_218_9 = 0.15

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
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

				local var_218_10 = arg_215_1:GetWordFromCfg(426031053)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 6 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 6)

				if (6 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 6)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031053", "story_v_out_426031.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_426031", "426031053", "story_v_out_426031.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_426031", "426031053", "story_v_out_426031.awb")

						arg_215_1:RecordAudio("426031053", var_218_15)
						arg_215_1:RecordAudio("426031053", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_426031", "426031053", "story_v_out_426031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_426031", "426031053", "story_v_out_426031.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_9, arg_215_1.talkMaxDuration)

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_8) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_8 + var_218_16 and arg_215_1.time_ < var_218_8 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play426031054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426031054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426031055(arg_219_1)
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
			local var_222_2 = 0.3

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

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(426031054).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 12 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 12)

				if (12 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 12)) > 0 and var_222_2 < var_222_5 then
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
	Play426031055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 426031055
		arg_223_1.duration_ = 8.47

		local var_223_0 = {
			zh = 5.266,
			ja = 8.466
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
				arg_223_0:Play426031056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1012ui_story = arg_223_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1012ui_story, Vector3.New(0.7, -1.05, -6.24), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1012ui_story"].transform.position).z)
				arg_223_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1012ui_story"].transform.localEulerAngles = arg_223_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.24)
				arg_223_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1012ui_story"].transform.position).z)
				arg_223_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1012ui_story"].transform.localEulerAngles = arg_223_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1012ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1012ui_story == nil then
				arg_223_1.var_.characterEffect1012ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1012ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1012ui_story then
				arg_223_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_226_4 = 0
			local var_226_5 = 0.7

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(426031055)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 28 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 28)

				if (28 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 28)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031055", "story_v_out_426031.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031055", "story_v_out_426031.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_426031", "426031055", "story_v_out_426031.awb")

						arg_223_1:RecordAudio("426031055", var_226_11)
						arg_223_1:RecordAudio("426031055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_426031", "426031055", "story_v_out_426031.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_426031", "426031055", "story_v_out_426031.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play426031056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 426031056
		arg_227_1.duration_ = 8.77

		local var_227_0 = {
			zh = 5.066,
			ja = 8.766
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
				arg_227_0:Play426031057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			local var_230_0 = 0
			local var_230_1 = 0.725

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(426031056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 29 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 29)

				if (29 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 29)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031056", "story_v_out_426031.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_out_426031", "426031056", "story_v_out_426031.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_out_426031", "426031056", "story_v_out_426031.awb")

						arg_227_1:RecordAudio("426031056", var_230_7)
						arg_227_1:RecordAudio("426031056", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_426031", "426031056", "story_v_out_426031.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_426031", "426031056", "story_v_out_426031.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_8 and arg_227_1.time_ < var_230_0 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play426031057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 426031057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play426031058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1012ui_story"]) and arg_231_1.var_.characterEffect1012ui_story == nil then
				arg_231_1.var_.characterEffect1012ui_story = arg_231_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1012ui_story"]) then
				if arg_231_1.var_.characterEffect1012ui_story and not isNil(arg_231_1.actors_["1012ui_story"]) then
					arg_231_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1012ui_story"]) and arg_231_1.var_.characterEffect1012ui_story then
				arg_231_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.425

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(426031057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 17 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 17)

				if (17 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 17)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play426031058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 426031058
		arg_235_1.duration_ = 2

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play426031059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1054ui_story = arg_235_1.actors_["1054ui_story"].transform.localPosition

				local var_238_0 = GameObjectTools.GetOrAddComponent(arg_235_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_238_0 then
					var_238_0:EnableDynamicBone(false)
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_235_1.time_ - 0) / var_238_1)
				arg_235_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1054ui_story"].transform.position).z)
				arg_235_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1054ui_story"].transform.localEulerAngles = arg_235_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_235_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1054ui_story"].transform.position).z)
				arg_235_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1054ui_story"].transform.localEulerAngles = arg_235_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_238_2 = GameObjectTools.GetOrAddComponent(arg_235_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(true)
				end
			end

			local var_238_3 = arg_235_1.actors_["1012ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1012ui_story = var_238_3.localPosition
			end

			local var_238_4 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				var_238_3.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_4)
				var_238_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_3.position).x, (manager.ui.mainCamera.transform.position - var_238_3.position).y, (manager.ui.mainCamera.transform.position - var_238_3.position).z)
				var_238_3.localEulerAngles.z = 0
				var_238_3.localEulerAngles.x = 0
				var_238_3.localEulerAngles = var_238_3.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				var_238_3.localPosition = Vector3.New(0, 100, 0)
				var_238_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_3.position).x, (manager.ui.mainCamera.transform.position - var_238_3.position).y, (manager.ui.mainCamera.transform.position - var_238_3.position).z)
				var_238_3.localEulerAngles.z = 0
				var_238_3.localEulerAngles.x = 0
				var_238_3.localEulerAngles = var_238_3.localEulerAngles
			end

			local var_238_5 = arg_235_1.actors_["1054ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1054ui_story == nil then
				arg_235_1.var_.characterEffect1054ui_story = var_238_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_6 and not isNil(var_238_5) then
				if arg_235_1.var_.characterEffect1054ui_story and not isNil(var_238_5) then
					arg_235_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_6 and arg_235_1.time_ < 0 + var_238_6 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1054ui_story then
				arg_235_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_238_8 = 0
			local var_238_9 = 0.15

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_10 = arg_235_1:GetWordFromCfg(426031058)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 6 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 6)

				if (6 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 6)) > 0 and var_238_9 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031058", "story_v_out_426031.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_426031", "426031058", "story_v_out_426031.awb") / 1000

					if var_238_14 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_8
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_426031", "426031058", "story_v_out_426031.awb")

						arg_235_1:RecordAudio("426031058", var_238_15)
						arg_235_1:RecordAudio("426031058", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_426031", "426031058", "story_v_out_426031.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_426031", "426031058", "story_v_out_426031.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play426031059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 426031059
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play426031060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1054ui_story = arg_239_1.actors_["1054ui_story"].transform.localPosition

				local var_242_0 = GameObjectTools.GetOrAddComponent(arg_239_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_242_0 then
					var_242_0:EnableDynamicBone(false)
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 0) / var_242_1)
				arg_239_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1054ui_story"].transform.position).z)
				arg_239_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1054ui_story"].transform.localEulerAngles = arg_239_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1054ui_story"].transform.position).z)
				arg_239_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1054ui_story"].transform.localEulerAngles = arg_239_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_242_2 = GameObjectTools.GetOrAddComponent(arg_239_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_242_2 then
					var_242_2:EnableDynamicBone(true)
				end
			end

			local var_242_3 = arg_239_1.actors_["1054ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_3) and arg_239_1.var_.characterEffect1054ui_story == nil then
				arg_239_1.var_.characterEffect1054ui_story = var_242_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_4 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 and not isNil(var_242_3) then
				if arg_239_1.var_.characterEffect1054ui_story and not isNil(var_242_3) then
					arg_239_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_4)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 and not isNil(var_242_3) and arg_239_1.var_.characterEffect1054ui_story then
				arg_239_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_242_5 = arg_239_1.actors_["6148ui_story"].transform

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos6148ui_story = var_242_5.localPosition

				local var_242_6 = GameObjectTools.GetOrAddComponent(var_242_5.gameObject, typeof(DynamicBoneHelper))

				if var_242_6 then
					var_242_6:EnableDynamicBone(false)
				end
			end

			local var_242_7 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				var_242_5.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_239_1.time_ - 0) / var_242_7)
				var_242_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_5.position).x, (manager.ui.mainCamera.transform.position - var_242_5.position).y, (manager.ui.mainCamera.transform.position - var_242_5.position).z)
				var_242_5.localEulerAngles.z = 0
				var_242_5.localEulerAngles.x = 0
				var_242_5.localEulerAngles = var_242_5.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				var_242_5.localPosition = Vector3.New(0, 100, 0)
				var_242_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_242_5.position).x, (manager.ui.mainCamera.transform.position - var_242_5.position).y, (manager.ui.mainCamera.transform.position - var_242_5.position).z)
				var_242_5.localEulerAngles.z = 0
				var_242_5.localEulerAngles.x = 0
				var_242_5.localEulerAngles = var_242_5.localEulerAngles

				local var_242_8 = GameObjectTools.GetOrAddComponent(var_242_5.gameObject, typeof(DynamicBoneHelper))

				if var_242_8 then
					var_242_8:EnableDynamicBone(true)
				end
			end

			local var_242_9 = 0
			local var_242_10 = 0.8

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_9 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_11 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(426031059).content)

				arg_239_1.text_.text = var_242_11

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_13 = 32 <= 0 and var_242_10 or var_242_10 * (utf8.len(var_242_11) / 32)

				if (32 <= 0 and var_242_10 or var_242_10 * (utf8.len(var_242_11) / 32)) > 0 and var_242_10 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_9 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_9
					end
				end

				arg_239_1.text_.text = var_242_11
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_10, arg_239_1.talkMaxDuration)

			if var_242_9 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_9) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_9 + var_242_14 and arg_239_1.time_ < var_242_9 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play426031060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 426031060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play426031061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.2

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(426031060).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 8 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 8)

				if (8 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 8)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play426031061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 426031061
		arg_247_1.duration_ = 2

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play426031062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1012ui_story = arg_247_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1012ui_story"].transform.position).z)
				arg_247_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1012ui_story"].transform.localEulerAngles = arg_247_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_247_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1012ui_story"].transform.position).z)
				arg_247_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1012ui_story"].transform.localEulerAngles = arg_247_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1012ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1012ui_story == nil then
				arg_247_1.var_.characterEffect1012ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1012ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1012ui_story then
				arg_247_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_250_4 = 0
			local var_250_5 = 0.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:GetWordFromCfg(426031061)
				local var_250_7 = arg_247_1:FormatText(var_250_6.content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 4 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 4)

				if (4 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_7) / 4)) > 0 and var_250_5 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031061", "story_v_out_426031.awb") ~= 0 then
					local var_250_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031061", "story_v_out_426031.awb") / 1000

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end

					if var_250_6.prefab_name ~= "" and arg_247_1.actors_[var_250_6.prefab_name] ~= nil then
						local var_250_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_6.prefab_name].transform, "story_v_out_426031", "426031061", "story_v_out_426031.awb")

						arg_247_1:RecordAudio("426031061", var_250_11)
						arg_247_1:RecordAudio("426031061", var_250_11)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_426031", "426031061", "story_v_out_426031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_426031", "426031061", "story_v_out_426031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_12 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_12 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_12

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_12 and arg_247_1.time_ < var_250_4 + var_250_12 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
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

		arg_247_1:InitPlayNodeList()
	end,
	Play426031062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 426031062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play426031063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1012ui_story"]) and arg_251_1.var_.characterEffect1012ui_story == nil then
				arg_251_1.var_.characterEffect1012ui_story = arg_251_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1012ui_story"]) then
				if arg_251_1.var_.characterEffect1012ui_story and not isNil(arg_251_1.actors_["1012ui_story"]) then
					arg_251_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1012ui_story"]) and arg_251_1.var_.characterEffect1012ui_story then
				arg_251_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.25

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(426031062).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 10 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 10)

				if (10 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 10)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play426031063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 426031063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play426031064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.8

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(426031063).content)

				arg_255_1.text_.text = var_258_1

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_3 = 32 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 32)

				if (32 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 32)) > 0 and var_258_0 < var_258_3 then
					arg_255_1.talkMaxDuration = var_258_3

					if var_258_3 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_3 + 0
					end
				end

				arg_255_1.text_.text = var_258_1
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_4 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_4

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play426031064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 426031064
		arg_259_1.duration_ = 7.83

		local var_259_0 = {
			zh = 4.266,
			ja = 7.833
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play426031065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1012ui_story = arg_259_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1012ui_story"].transform.position).z)
				arg_259_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1012ui_story"].transform.localEulerAngles = arg_259_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_259_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["1012ui_story"].transform.position).z)
				arg_259_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["1012ui_story"].transform.localEulerAngles = arg_259_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["1012ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1012ui_story == nil then
				arg_259_1.var_.characterEffect1012ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect1012ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect1012ui_story then
				arg_259_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_262_4 = 0
			local var_262_5 = 0.425

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(426031064)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 17 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 17)

				if (17 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 17)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031064", "story_v_out_426031.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031064", "story_v_out_426031.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_out_426031", "426031064", "story_v_out_426031.awb")

						arg_259_1:RecordAudio("426031064", var_262_11)
						arg_259_1:RecordAudio("426031064", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_426031", "426031064", "story_v_out_426031.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_426031", "426031064", "story_v_out_426031.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play426031065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 426031065
		arg_263_1.duration_ = 3.13

		local var_263_0 = {
			zh = 3.133,
			ja = 2.166
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play426031066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1054ui_story = arg_263_1.actors_["1054ui_story"].transform.localPosition

				local var_266_0 = GameObjectTools.GetOrAddComponent(arg_263_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_266_0 then
					var_266_0:EnableDynamicBone(false)
				end
			end

			local var_266_1 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_263_1.time_ - 0) / var_266_1)
				arg_263_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).z)
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles = arg_263_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_263_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).z)
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles = arg_263_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_266_2 = GameObjectTools.GetOrAddComponent(arg_263_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_266_2 then
					var_266_2:EnableDynamicBone(true)
				end
			end

			local var_266_3 = arg_263_1.actors_["1012ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1012ui_story = var_266_3.localPosition
			end

			local var_266_4 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				var_266_3.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_4)
				var_266_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_3.position).x, (manager.ui.mainCamera.transform.position - var_266_3.position).y, (manager.ui.mainCamera.transform.position - var_266_3.position).z)
				var_266_3.localEulerAngles.z = 0
				var_266_3.localEulerAngles.x = 0
				var_266_3.localEulerAngles = var_266_3.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				var_266_3.localPosition = Vector3.New(0, 100, 0)
				var_266_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_3.position).x, (manager.ui.mainCamera.transform.position - var_266_3.position).y, (manager.ui.mainCamera.transform.position - var_266_3.position).z)
				var_266_3.localEulerAngles.z = 0
				var_266_3.localEulerAngles.x = 0
				var_266_3.localEulerAngles = var_266_3.localEulerAngles
			end

			local var_266_5 = arg_263_1.actors_["1054ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1054ui_story == nil then
				arg_263_1.var_.characterEffect1054ui_story = var_266_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_6 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_6 and not isNil(var_266_5) then
				if arg_263_1.var_.characterEffect1054ui_story and not isNil(var_266_5) then
					arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_6 and arg_263_1.time_ < 0 + var_266_6 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1054ui_story then
				arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_266_8 = arg_263_1.actors_["1012ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.characterEffect1012ui_story == nil then
				arg_263_1.var_.characterEffect1012ui_story = var_266_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_9 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_9 and not isNil(var_266_8) then
				if arg_263_1.var_.characterEffect1012ui_story and not isNil(var_266_8) then
					arg_263_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_9)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_9 and arg_263_1.time_ < 0 + var_266_9 + arg_266_0 and not isNil(var_266_8) and arg_263_1.var_.characterEffect1012ui_story then
				arg_263_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_266_10 = 0
			local var_266_11 = 0.175

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_12 = arg_263_1:GetWordFromCfg(426031065)
				local var_266_13 = arg_263_1:FormatText(var_266_12.content)

				arg_263_1.text_.text = var_266_13

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_15 = 7 <= 0 and var_266_11 or var_266_11 * (utf8.len(var_266_13) / 7)

				if (7 <= 0 and var_266_11 or var_266_11 * (utf8.len(var_266_13) / 7)) > 0 and var_266_11 < var_266_15 then
					arg_263_1.talkMaxDuration = var_266_15

					if var_266_15 + var_266_10 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_15 + var_266_10
					end
				end

				arg_263_1.text_.text = var_266_13
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031065", "story_v_out_426031.awb") ~= 0 then
					local var_266_16 = manager.audio:GetVoiceLength("story_v_out_426031", "426031065", "story_v_out_426031.awb") / 1000

					if var_266_16 + var_266_10 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_16 + var_266_10
					end

					if var_266_12.prefab_name ~= "" and arg_263_1.actors_[var_266_12.prefab_name] ~= nil then
						local var_266_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_12.prefab_name].transform, "story_v_out_426031", "426031065", "story_v_out_426031.awb")

						arg_263_1:RecordAudio("426031065", var_266_17)
						arg_263_1:RecordAudio("426031065", var_266_17)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_426031", "426031065", "story_v_out_426031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_426031", "426031065", "story_v_out_426031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_18 = math.max(var_266_11, arg_263_1.talkMaxDuration)

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_18 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_10) / var_266_18

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_10 + var_266_18 and arg_263_1.time_ < var_266_10 + var_266_18 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play426031066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 426031066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play426031067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1054ui_story = arg_267_1.actors_["1054ui_story"].transform.localPosition

				local var_270_0 = GameObjectTools.GetOrAddComponent(arg_267_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_270_0 then
					var_270_0:EnableDynamicBone(false)
				end
			end

			local var_270_1 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 then
				arg_267_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_267_1.time_ - 0) / var_270_1)
				arg_267_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1054ui_story"].transform.position).z)
				arg_267_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1054ui_story"].transform.localEulerAngles = arg_267_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 then
				arg_267_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1054ui_story"].transform.position).z)
				arg_267_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1054ui_story"].transform.localEulerAngles = arg_267_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_270_2 = GameObjectTools.GetOrAddComponent(arg_267_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_270_2 then
					var_270_2:EnableDynamicBone(true)
				end
			end

			local var_270_3 = arg_267_1.actors_["1054ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_3) and arg_267_1.var_.characterEffect1054ui_story == nil then
				arg_267_1.var_.characterEffect1054ui_story = var_270_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_4 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 and not isNil(var_270_3) then
				if arg_267_1.var_.characterEffect1054ui_story and not isNil(var_270_3) then
					arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_4)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 and not isNil(var_270_3) and arg_267_1.var_.characterEffect1054ui_story then
				arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_270_5 = 0
			local var_270_6 = 1.1

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(426031066).content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 44 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 44)

				if (44 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 44)) > 0 and var_270_6 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_10 and arg_267_1.time_ < var_270_5 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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

		arg_267_1:InitPlayNodeList()
	end,
	Play426031067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 426031067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play426031068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.475

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(426031067).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 19 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 19)

				if (19 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 19)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play426031068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 426031068
		arg_275_1.duration_ = 9.1

		local var_275_0 = {
			zh = 6.166,
			ja = 9.1
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play426031069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1012ui_story = arg_275_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1012ui_story"].transform.position).z)
				arg_275_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1012ui_story"].transform.localEulerAngles = arg_275_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_275_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1012ui_story"].transform.position).z)
				arg_275_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1012ui_story"].transform.localEulerAngles = arg_275_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1012ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1012ui_story == nil then
				arg_275_1.var_.characterEffect1012ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1012ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1012ui_story then
				arg_275_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			local var_278_4 = 0
			local var_278_5 = 0.7

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(426031068)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 28 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 28)

				if (28 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 28)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031068", "story_v_out_426031.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031068", "story_v_out_426031.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_out_426031", "426031068", "story_v_out_426031.awb")

						arg_275_1:RecordAudio("426031068", var_278_11)
						arg_275_1:RecordAudio("426031068", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_426031", "426031068", "story_v_out_426031.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_426031", "426031068", "story_v_out_426031.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
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

		arg_275_1:InitPlayNodeList()
	end,
	Play426031069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 426031069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play426031070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1012ui_story"]) and arg_279_1.var_.characterEffect1012ui_story == nil then
				arg_279_1.var_.characterEffect1012ui_story = arg_279_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1012ui_story"]) then
				if arg_279_1.var_.characterEffect1012ui_story and not isNil(arg_279_1.actors_["1012ui_story"]) then
					arg_279_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1012ui_story"]) and arg_279_1.var_.characterEffect1012ui_story then
				arg_279_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.775

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(426031069).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 31 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 31)

				if (31 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 31)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play426031070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 426031070
		arg_283_1.duration_ = 4.87

		local var_283_0 = {
			zh = 3.2,
			ja = 4.866
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play426031071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1012ui_story = arg_283_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1012ui_story"].transform.position).z)
				arg_283_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1012ui_story"].transform.localEulerAngles = arg_283_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_283_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1012ui_story"].transform.position).z)
				arg_283_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1012ui_story"].transform.localEulerAngles = arg_283_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1012ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1012ui_story == nil then
				arg_283_1.var_.characterEffect1012ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1012ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1012ui_story then
				arg_283_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_286_4 = 0
			local var_286_5 = 0.325

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_6 = arg_283_1:GetWordFromCfg(426031070)
				local var_286_7 = arg_283_1:FormatText(var_286_6.content)

				arg_283_1.text_.text = var_286_7

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_9 = 13 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 13)

				if (13 <= 0 and var_286_5 or var_286_5 * (utf8.len(var_286_7) / 13)) > 0 and var_286_5 < var_286_9 then
					arg_283_1.talkMaxDuration = var_286_9

					if var_286_9 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_9 + var_286_4
					end
				end

				arg_283_1.text_.text = var_286_7
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031070", "story_v_out_426031.awb") ~= 0 then
					local var_286_10 = manager.audio:GetVoiceLength("story_v_out_426031", "426031070", "story_v_out_426031.awb") / 1000

					if var_286_10 + var_286_4 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_4
					end

					if var_286_6.prefab_name ~= "" and arg_283_1.actors_[var_286_6.prefab_name] ~= nil then
						local var_286_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_6.prefab_name].transform, "story_v_out_426031", "426031070", "story_v_out_426031.awb")

						arg_283_1:RecordAudio("426031070", var_286_11)
						arg_283_1:RecordAudio("426031070", var_286_11)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_426031", "426031070", "story_v_out_426031.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_426031", "426031070", "story_v_out_426031.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_12 = math.max(var_286_5, arg_283_1.talkMaxDuration)

			if var_286_4 <= arg_283_1.time_ and arg_283_1.time_ < var_286_4 + var_286_12 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_4) / var_286_12

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_4 + var_286_12 and arg_283_1.time_ < var_286_4 + var_286_12 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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

		arg_283_1:InitPlayNodeList()
	end,
	Play426031071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 426031071
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play426031072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1012ui_story"]) and arg_287_1.var_.characterEffect1012ui_story == nil then
				arg_287_1.var_.characterEffect1012ui_story = arg_287_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1012ui_story"]) then
				if arg_287_1.var_.characterEffect1012ui_story and not isNil(arg_287_1.actors_["1012ui_story"]) then
					arg_287_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1012ui_story"]) and arg_287_1.var_.characterEffect1012ui_story then
				arg_287_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_290_1 = 0
			local var_290_2 = 0.425

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(426031071).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 17 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 17)

				if (17 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 17)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play426031072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 426031072
		arg_291_1.duration_ = 5.77

		local var_291_0 = {
			zh = 4.2,
			ja = 5.766
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play426031073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1012ui_story"]) and arg_291_1.var_.characterEffect1012ui_story == nil then
				arg_291_1.var_.characterEffect1012ui_story = arg_291_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1012ui_story"]) then
				if arg_291_1.var_.characterEffect1012ui_story and not isNil(arg_291_1.actors_["1012ui_story"]) then
					arg_291_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1012ui_story"]) and arg_291_1.var_.characterEffect1012ui_story then
				arg_291_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_294_2 = 0
			local var_294_3 = 0.375

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_4 = arg_291_1:GetWordFromCfg(426031072)
				local var_294_5 = arg_291_1:FormatText(var_294_4.content)

				arg_291_1.text_.text = var_294_5

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_7 = 15 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 15)

				if (15 <= 0 and var_294_3 or var_294_3 * (utf8.len(var_294_5) / 15)) > 0 and var_294_3 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_2
					end
				end

				arg_291_1.text_.text = var_294_5
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031072", "story_v_out_426031.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_426031", "426031072", "story_v_out_426031.awb") / 1000

					if var_294_8 + var_294_2 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_2
					end

					if var_294_4.prefab_name ~= "" and arg_291_1.actors_[var_294_4.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_4.prefab_name].transform, "story_v_out_426031", "426031072", "story_v_out_426031.awb")

						arg_291_1:RecordAudio("426031072", var_294_9)
						arg_291_1:RecordAudio("426031072", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_426031", "426031072", "story_v_out_426031.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_426031", "426031072", "story_v_out_426031.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_3, arg_291_1.talkMaxDuration)

			if var_294_2 <= arg_291_1.time_ and arg_291_1.time_ < var_294_2 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_2) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_2 + var_294_10 and arg_291_1.time_ < var_294_2 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play426031073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 426031073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play426031074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1012ui_story = arg_295_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1012ui_story"].transform.position).z)
				arg_295_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1012ui_story"].transform.localEulerAngles = arg_295_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1012ui_story"].transform.position).z)
				arg_295_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1012ui_story"].transform.localEulerAngles = arg_295_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1012ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1012ui_story == nil then
				arg_295_1.var_.characterEffect1012ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1012ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_2)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1012ui_story then
				arg_295_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_298_3 = 0
			local var_298_4 = 0.7

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_3 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_5 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(426031073).content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 28 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 28)

				if (28 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 28)) > 0 and var_298_4 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_3 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_3
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_4, arg_295_1.talkMaxDuration)

			if var_298_3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_3 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_3) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_3 + var_298_8 and arg_295_1.time_ < var_298_3 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play426031074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 426031074
		arg_299_1.duration_ = 7.47

		local var_299_0 = {
			zh = 7.466,
			ja = 6.866
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play426031075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos6148ui_story = arg_299_1.actors_["6148ui_story"].transform.localPosition

				local var_302_0 = GameObjectTools.GetOrAddComponent(arg_299_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_302_0 then
					var_302_0:EnableDynamicBone(false)
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_299_1.time_ - 0) / var_302_1)
				arg_299_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).z)
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles = arg_299_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_299_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).z)
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles = arg_299_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_302_2 = GameObjectTools.GetOrAddComponent(arg_299_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_302_2 then
					var_302_2:EnableDynamicBone(true)
				end
			end

			local var_302_3 = arg_299_1.actors_["6148ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_3) and arg_299_1.var_.characterEffect6148ui_story == nil then
				arg_299_1.var_.characterEffect6148ui_story = var_302_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_4 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 and not isNil(var_302_3) then
				if arg_299_1.var_.characterEffect6148ui_story and not isNil(var_302_3) then
					arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 and not isNil(var_302_3) and arg_299_1.var_.characterEffect6148ui_story then
				arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_302_6 = 0
			local var_302_7 = 0.575

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_8 = arg_299_1:GetWordFromCfg(426031074)
				local var_302_9 = arg_299_1:FormatText(var_302_8.content)

				arg_299_1.text_.text = var_302_9

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_11 = 23 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 23)

				if (23 <= 0 and var_302_7 or var_302_7 * (utf8.len(var_302_9) / 23)) > 0 and var_302_7 < var_302_11 then
					arg_299_1.talkMaxDuration = var_302_11

					if var_302_11 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_9
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031074", "story_v_out_426031.awb") ~= 0 then
					local var_302_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031074", "story_v_out_426031.awb") / 1000

					if var_302_12 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_6
					end

					if var_302_8.prefab_name ~= "" and arg_299_1.actors_[var_302_8.prefab_name] ~= nil then
						local var_302_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_8.prefab_name].transform, "story_v_out_426031", "426031074", "story_v_out_426031.awb")

						arg_299_1:RecordAudio("426031074", var_302_13)
						arg_299_1:RecordAudio("426031074", var_302_13)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_426031", "426031074", "story_v_out_426031.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_426031", "426031074", "story_v_out_426031.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_14 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_14 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_14

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_14 and arg_299_1.time_ < var_302_6 + var_302_14 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play426031075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 426031075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play426031076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["6148ui_story"]) and arg_303_1.var_.characterEffect6148ui_story == nil then
				arg_303_1.var_.characterEffect6148ui_story = arg_303_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["6148ui_story"]) then
				if arg_303_1.var_.characterEffect6148ui_story and not isNil(arg_303_1.actors_["6148ui_story"]) then
					arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_303_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["6148ui_story"]) and arg_303_1.var_.characterEffect6148ui_story then
				arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_303_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.875

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(426031075).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 35 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 35)

				if (35 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 35)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play426031076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 426031076
		arg_307_1.duration_ = 4.43

		local var_307_0 = {
			zh = 4.433,
			ja = 2.4
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play426031077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos6148ui_story = arg_307_1.actors_["6148ui_story"].transform.localPosition

				local var_310_0 = GameObjectTools.GetOrAddComponent(arg_307_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_310_0 then
					var_310_0:EnableDynamicBone(false)
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_307_1.time_ - 0) / var_310_1)
				arg_307_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6148ui_story"].transform.position).z)
				arg_307_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["6148ui_story"].transform.localEulerAngles = arg_307_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_307_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["6148ui_story"].transform.position).z)
				arg_307_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["6148ui_story"].transform.localEulerAngles = arg_307_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_310_2 = GameObjectTools.GetOrAddComponent(arg_307_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_310_2 then
					var_310_2:EnableDynamicBone(true)
				end
			end

			local var_310_3 = arg_307_1.actors_["6148ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_3) and arg_307_1.var_.characterEffect6148ui_story == nil then
				arg_307_1.var_.characterEffect6148ui_story = var_310_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_4 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 and not isNil(var_310_3) then
				if arg_307_1.var_.characterEffect6148ui_story and not isNil(var_310_3) then
					arg_307_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 and not isNil(var_310_3) and arg_307_1.var_.characterEffect6148ui_story then
				arg_307_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			local var_310_6 = 0
			local var_310_7 = 0.475

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_6 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_8 = arg_307_1:GetWordFromCfg(426031076)
				local var_310_9 = arg_307_1:FormatText(var_310_8.content)

				arg_307_1.text_.text = var_310_9

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_11 = 19 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 19)

				if (19 <= 0 and var_310_7 or var_310_7 * (utf8.len(var_310_9) / 19)) > 0 and var_310_7 < var_310_11 then
					arg_307_1.talkMaxDuration = var_310_11

					if var_310_11 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_6
					end
				end

				arg_307_1.text_.text = var_310_9
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031076", "story_v_out_426031.awb") ~= 0 then
					local var_310_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031076", "story_v_out_426031.awb") / 1000

					if var_310_12 + var_310_6 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_12 + var_310_6
					end

					if var_310_8.prefab_name ~= "" and arg_307_1.actors_[var_310_8.prefab_name] ~= nil then
						local var_310_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_8.prefab_name].transform, "story_v_out_426031", "426031076", "story_v_out_426031.awb")

						arg_307_1:RecordAudio("426031076", var_310_13)
						arg_307_1:RecordAudio("426031076", var_310_13)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_426031", "426031076", "story_v_out_426031.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_426031", "426031076", "story_v_out_426031.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_14 = math.max(var_310_7, arg_307_1.talkMaxDuration)

			if var_310_6 <= arg_307_1.time_ and arg_307_1.time_ < var_310_6 + var_310_14 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_6) / var_310_14

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_6 + var_310_14 and arg_307_1.time_ < var_310_6 + var_310_14 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
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

		arg_307_1:InitPlayNodeList()
	end,
	Play426031077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 426031077
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play426031078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["6148ui_story"]) and arg_311_1.var_.characterEffect6148ui_story == nil then
				arg_311_1.var_.characterEffect6148ui_story = arg_311_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["6148ui_story"]) then
				if arg_311_1.var_.characterEffect6148ui_story and not isNil(arg_311_1.actors_["6148ui_story"]) then
					arg_311_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_311_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["6148ui_story"]) and arg_311_1.var_.characterEffect6148ui_story then
				arg_311_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_311_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.725

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(426031077).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 29 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 29)

				if (29 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 29)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play426031078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 426031078
		arg_315_1.duration_ = 2

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play426031079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos6148ui_story = arg_315_1.actors_["6148ui_story"].transform.localPosition

				local var_318_0 = GameObjectTools.GetOrAddComponent(arg_315_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_318_0 then
					var_318_0:EnableDynamicBone(false)
				end
			end

			local var_318_1 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 then
				arg_315_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_315_1.time_ - 0) / var_318_1)
				arg_315_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6148ui_story"].transform.position).z)
				arg_315_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["6148ui_story"].transform.localEulerAngles = arg_315_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 then
				arg_315_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_315_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["6148ui_story"].transform.position).z)
				arg_315_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["6148ui_story"].transform.localEulerAngles = arg_315_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_318_2 = GameObjectTools.GetOrAddComponent(arg_315_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_318_2 then
					var_318_2:EnableDynamicBone(true)
				end
			end

			local var_318_3 = arg_315_1.actors_["1054ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1054ui_story = var_318_3.localPosition

				local var_318_4 = GameObjectTools.GetOrAddComponent(var_318_3.gameObject, typeof(DynamicBoneHelper))

				if var_318_4 then
					var_318_4:EnableDynamicBone(false)
				end
			end

			local var_318_5 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_5 then
				var_318_3.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_315_1.time_ - 0) / var_318_5)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_5 and arg_315_1.time_ < 0 + var_318_5 + arg_318_0 then
				var_318_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_318_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_3.position).x, (manager.ui.mainCamera.transform.position - var_318_3.position).y, (manager.ui.mainCamera.transform.position - var_318_3.position).z)
				var_318_3.localEulerAngles.z = 0
				var_318_3.localEulerAngles.x = 0
				var_318_3.localEulerAngles = var_318_3.localEulerAngles

				local var_318_6 = GameObjectTools.GetOrAddComponent(var_318_3.gameObject, typeof(DynamicBoneHelper))

				if var_318_6 then
					var_318_6:EnableDynamicBone(true)
				end
			end

			local var_318_7 = arg_315_1.actors_["1054ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.characterEffect1054ui_story == nil then
				arg_315_1.var_.characterEffect1054ui_story = var_318_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_8 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_8 and not isNil(var_318_7) then
				if arg_315_1.var_.characterEffect1054ui_story and not isNil(var_318_7) then
					arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_8 and arg_315_1.time_ < 0 + var_318_8 + arg_318_0 and not isNil(var_318_7) and arg_315_1.var_.characterEffect1054ui_story then
				arg_315_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_318_10 = 0
			local var_318_11 = 0.1

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_12 = arg_315_1:GetWordFromCfg(426031078)
				local var_318_13 = arg_315_1:FormatText(var_318_12.content)

				arg_315_1.text_.text = var_318_13

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_15 = 4 <= 0 and var_318_11 or var_318_11 * (utf8.len(var_318_13) / 4)

				if (4 <= 0 and var_318_11 or var_318_11 * (utf8.len(var_318_13) / 4)) > 0 and var_318_11 < var_318_15 then
					arg_315_1.talkMaxDuration = var_318_15

					if var_318_15 + var_318_10 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_15 + var_318_10
					end
				end

				arg_315_1.text_.text = var_318_13
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031078", "story_v_out_426031.awb") ~= 0 then
					local var_318_16 = manager.audio:GetVoiceLength("story_v_out_426031", "426031078", "story_v_out_426031.awb") / 1000

					if var_318_16 + var_318_10 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_16 + var_318_10
					end

					if var_318_12.prefab_name ~= "" and arg_315_1.actors_[var_318_12.prefab_name] ~= nil then
						local var_318_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_12.prefab_name].transform, "story_v_out_426031", "426031078", "story_v_out_426031.awb")

						arg_315_1:RecordAudio("426031078", var_318_17)
						arg_315_1:RecordAudio("426031078", var_318_17)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_426031", "426031078", "story_v_out_426031.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_426031", "426031078", "story_v_out_426031.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_18 = math.max(var_318_11, arg_315_1.talkMaxDuration)

			if var_318_10 <= arg_315_1.time_ and arg_315_1.time_ < var_318_10 + var_318_18 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_10) / var_318_18

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_10 + var_318_18 and arg_315_1.time_ < var_318_10 + var_318_18 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play426031079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 426031079
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play426031080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1054ui_story"]) and arg_319_1.var_.characterEffect1054ui_story == nil then
				arg_319_1.var_.characterEffect1054ui_story = arg_319_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1054ui_story"]) then
				if arg_319_1.var_.characterEffect1054ui_story and not isNil(arg_319_1.actors_["1054ui_story"]) then
					arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1054ui_story"]) and arg_319_1.var_.characterEffect1054ui_story then
				arg_319_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.2

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(426031079).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 8 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 8)

				if (8 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 8)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play426031080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 426031080
		arg_323_1.duration_ = 7.63

		local var_323_0 = {
			zh = 6.133,
			ja = 7.633
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play426031081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1054ui_story = arg_323_1.actors_["1054ui_story"].transform.localPosition

				local var_326_0 = GameObjectTools.GetOrAddComponent(arg_323_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_326_0 then
					var_326_0:EnableDynamicBone(false)
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_323_1.time_ - 0) / var_326_1)
				arg_323_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1054ui_story"].transform.position).z)
				arg_323_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1054ui_story"].transform.localEulerAngles = arg_323_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_323_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1054ui_story"].transform.position).z)
				arg_323_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1054ui_story"].transform.localEulerAngles = arg_323_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_326_2 = GameObjectTools.GetOrAddComponent(arg_323_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(true)
				end
			end

			local var_326_3 = arg_323_1.actors_["1054ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_3) and arg_323_1.var_.characterEffect1054ui_story == nil then
				arg_323_1.var_.characterEffect1054ui_story = var_326_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_4 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 and not isNil(var_326_3) then
				if arg_323_1.var_.characterEffect1054ui_story and not isNil(var_326_3) then
					arg_323_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 and not isNil(var_326_3) and arg_323_1.var_.characterEffect1054ui_story then
				arg_323_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_326_6 = 0
			local var_326_7 = 0.55

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(426031080)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 22 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 22)

				if (22 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 22)) > 0 and var_326_7 < var_326_11 then
					arg_323_1.talkMaxDuration = var_326_11

					if var_326_11 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031080", "story_v_out_426031.awb") ~= 0 then
					local var_326_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031080", "story_v_out_426031.awb") / 1000

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end

					if var_326_8.prefab_name ~= "" and arg_323_1.actors_[var_326_8.prefab_name] ~= nil then
						local var_326_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_8.prefab_name].transform, "story_v_out_426031", "426031080", "story_v_out_426031.awb")

						arg_323_1:RecordAudio("426031080", var_326_13)
						arg_323_1:RecordAudio("426031080", var_326_13)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_426031", "426031080", "story_v_out_426031.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_426031", "426031080", "story_v_out_426031.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_14 and arg_323_1.time_ < var_326_6 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play426031081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 426031081
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play426031082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1054ui_story = arg_327_1.actors_["1054ui_story"].transform.localPosition

				local var_330_0 = GameObjectTools.GetOrAddComponent(arg_327_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_330_0 then
					var_330_0:EnableDynamicBone(false)
				end
			end

			local var_330_1 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_1 then
				arg_327_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_1)
				arg_327_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1054ui_story"].transform.position).z)
				arg_327_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1054ui_story"].transform.localEulerAngles = arg_327_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_1 and arg_327_1.time_ < 0 + var_330_1 + arg_330_0 then
				arg_327_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["1054ui_story"].transform.position).z)
				arg_327_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["1054ui_story"].transform.localEulerAngles = arg_327_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_330_2 = GameObjectTools.GetOrAddComponent(arg_327_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_330_2 then
					var_330_2:EnableDynamicBone(true)
				end
			end

			local var_330_3 = arg_327_1.actors_["6148ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos6148ui_story = var_330_3.localPosition

				local var_330_4 = GameObjectTools.GetOrAddComponent(var_330_3.gameObject, typeof(DynamicBoneHelper))

				if var_330_4 then
					var_330_4:EnableDynamicBone(false)
				end
			end

			local var_330_5 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_5 then
				var_330_3.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_5)
				var_330_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_3.position).x, (manager.ui.mainCamera.transform.position - var_330_3.position).y, (manager.ui.mainCamera.transform.position - var_330_3.position).z)
				var_330_3.localEulerAngles.z = 0
				var_330_3.localEulerAngles.x = 0
				var_330_3.localEulerAngles = var_330_3.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_5 and arg_327_1.time_ < 0 + var_330_5 + arg_330_0 then
				var_330_3.localPosition = Vector3.New(0, 100, 0)
				var_330_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_3.position).x, (manager.ui.mainCamera.transform.position - var_330_3.position).y, (manager.ui.mainCamera.transform.position - var_330_3.position).z)
				var_330_3.localEulerAngles.z = 0
				var_330_3.localEulerAngles.x = 0
				var_330_3.localEulerAngles = var_330_3.localEulerAngles

				local var_330_6 = GameObjectTools.GetOrAddComponent(var_330_3.gameObject, typeof(DynamicBoneHelper))

				if var_330_6 then
					var_330_6:EnableDynamicBone(true)
				end
			end

			local var_330_7 = arg_327_1.actors_["1054ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.characterEffect1054ui_story == nil then
				arg_327_1.var_.characterEffect1054ui_story = var_330_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_8 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_8 and not isNil(var_330_7) then
				if arg_327_1.var_.characterEffect1054ui_story and not isNil(var_330_7) then
					arg_327_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_8)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_8 and arg_327_1.time_ < 0 + var_330_8 + arg_330_0 and not isNil(var_330_7) and arg_327_1.var_.characterEffect1054ui_story then
				arg_327_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_330_9 = 0
			local var_330_10 = 0.875

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_11 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(426031081).content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 35 <= 0 and var_330_10 or var_330_10 * (utf8.len(var_330_11) / 35)

				if (35 <= 0 and var_330_10 or var_330_10 * (utf8.len(var_330_11) / 35)) > 0 and var_330_10 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_9 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_9
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_14 = math.max(var_330_10, arg_327_1.talkMaxDuration)

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_14 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_9) / var_330_14

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_9 + var_330_14 and arg_327_1.time_ < var_330_9 + var_330_14 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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

		arg_327_1:InitPlayNodeList()
	end,
	Play426031082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 426031082
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play426031083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.55

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(426031082).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 22 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 22)

				if (22 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 22)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play426031083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 426031083
		arg_335_1.duration_ = 7

		local var_335_0 = {
			zh = 6.6,
			ja = 7
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play426031084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos6148ui_story = arg_335_1.actors_["6148ui_story"].transform.localPosition

				local var_338_0 = GameObjectTools.GetOrAddComponent(arg_335_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_338_0 then
					var_338_0:EnableDynamicBone(false)
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_335_1.time_ - 0) / var_338_1)
				arg_335_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["6148ui_story"].transform.position).z)
				arg_335_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["6148ui_story"].transform.localEulerAngles = arg_335_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_335_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["6148ui_story"].transform.position).z)
				arg_335_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["6148ui_story"].transform.localEulerAngles = arg_335_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_338_2 = GameObjectTools.GetOrAddComponent(arg_335_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_338_2 then
					var_338_2:EnableDynamicBone(true)
				end
			end

			local var_338_3 = arg_335_1.actors_["6148ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect6148ui_story == nil then
				arg_335_1.var_.characterEffect6148ui_story = var_338_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_4 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 and not isNil(var_338_3) then
				if arg_335_1.var_.characterEffect6148ui_story and not isNil(var_338_3) then
					arg_335_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect6148ui_story then
				arg_335_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_338_6 = 0
			local var_338_7 = 0.85

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_8 = arg_335_1:GetWordFromCfg(426031083)
				local var_338_9 = arg_335_1:FormatText(var_338_8.content)

				arg_335_1.text_.text = var_338_9

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_11 = 34 <= 0 and var_338_7 or var_338_7 * (utf8.len(var_338_9) / 34)

				if (34 <= 0 and var_338_7 or var_338_7 * (utf8.len(var_338_9) / 34)) > 0 and var_338_7 < var_338_11 then
					arg_335_1.talkMaxDuration = var_338_11

					if var_338_11 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_11 + var_338_6
					end
				end

				arg_335_1.text_.text = var_338_9
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031083", "story_v_out_426031.awb") ~= 0 then
					local var_338_12 = manager.audio:GetVoiceLength("story_v_out_426031", "426031083", "story_v_out_426031.awb") / 1000

					if var_338_12 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_6
					end

					if var_338_8.prefab_name ~= "" and arg_335_1.actors_[var_338_8.prefab_name] ~= nil then
						local var_338_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_8.prefab_name].transform, "story_v_out_426031", "426031083", "story_v_out_426031.awb")

						arg_335_1:RecordAudio("426031083", var_338_13)
						arg_335_1:RecordAudio("426031083", var_338_13)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_426031", "426031083", "story_v_out_426031.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_426031", "426031083", "story_v_out_426031.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_14 = math.max(var_338_7, arg_335_1.talkMaxDuration)

			if var_338_6 <= arg_335_1.time_ and arg_335_1.time_ < var_338_6 + var_338_14 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_6) / var_338_14

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_6 + var_338_14 and arg_335_1.time_ < var_338_6 + var_338_14 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play426031084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426031084
		arg_339_1.duration_ = 9.17

		local var_339_0 = {
			zh = 5.1,
			ja = 9.166
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play426031085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos6148ui_story = arg_339_1.actors_["6148ui_story"].transform.localPosition

				local var_342_0 = GameObjectTools.GetOrAddComponent(arg_339_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_342_0 then
					var_342_0:EnableDynamicBone(false)
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_339_1.time_ - 0) / var_342_1)
				arg_339_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["6148ui_story"].transform.position).z)
				arg_339_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["6148ui_story"].transform.localEulerAngles = arg_339_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_339_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["6148ui_story"].transform.position).z)
				arg_339_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["6148ui_story"].transform.localEulerAngles = arg_339_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_342_2 = GameObjectTools.GetOrAddComponent(arg_339_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_342_2 then
					var_342_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_342_3 = 0
			local var_342_4 = 0.575

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_3 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_5 = arg_339_1:GetWordFromCfg(426031084)
				local var_342_6 = arg_339_1:FormatText(var_342_5.content)

				arg_339_1.text_.text = var_342_6

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_8 = 23 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_6) / 23)

				if (23 <= 0 and var_342_4 or var_342_4 * (utf8.len(var_342_6) / 23)) > 0 and var_342_4 < var_342_8 then
					arg_339_1.talkMaxDuration = var_342_8

					if var_342_8 + var_342_3 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_3
					end
				end

				arg_339_1.text_.text = var_342_6
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426031", "426031084", "story_v_out_426031.awb") ~= 0 then
					local var_342_9 = manager.audio:GetVoiceLength("story_v_out_426031", "426031084", "story_v_out_426031.awb") / 1000

					if var_342_9 + var_342_3 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_3
					end

					if var_342_5.prefab_name ~= "" and arg_339_1.actors_[var_342_5.prefab_name] ~= nil then
						local var_342_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_5.prefab_name].transform, "story_v_out_426031", "426031084", "story_v_out_426031.awb")

						arg_339_1:RecordAudio("426031084", var_342_10)
						arg_339_1:RecordAudio("426031084", var_342_10)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_426031", "426031084", "story_v_out_426031.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_426031", "426031084", "story_v_out_426031.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_11 = math.max(var_342_4, arg_339_1.talkMaxDuration)

			if var_342_3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_3 + var_342_11 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_3) / var_342_11

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_3 + var_342_11 and arg_339_1.time_ < var_342_3 + var_342_11 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play426031085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426031085
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
			arg_343_1.auto_ = false
		end

		function arg_343_1.playNext_(arg_345_0)
			arg_343_1.onStoryFinished_()
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["6148ui_story"]) and arg_343_1.var_.characterEffect6148ui_story == nil then
				arg_343_1.var_.characterEffect6148ui_story = arg_343_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["6148ui_story"]) then
				if arg_343_1.var_.characterEffect6148ui_story and not isNil(arg_343_1.actors_["6148ui_story"]) then
					arg_343_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_343_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["6148ui_story"]) and arg_343_1.var_.characterEffect6148ui_story then
				arg_343_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_343_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0.433333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 0.433333333333333 + arg_346_0 then
				arg_343_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_footsteps", "")
			end

			local var_346_2 = arg_343_1.actors_["6148ui_story"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos6148ui_story = var_346_2.localPosition

				local var_346_3 = GameObjectTools.GetOrAddComponent(var_346_2.gameObject, typeof(DynamicBoneHelper))

				if var_346_3 then
					var_346_3:EnableDynamicBone(false)
				end
			end

			local var_346_4 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				var_346_2.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0) / var_346_4)
				var_346_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_2.position).x, (manager.ui.mainCamera.transform.position - var_346_2.position).y, (manager.ui.mainCamera.transform.position - var_346_2.position).z)
				var_346_2.localEulerAngles.z = 0
				var_346_2.localEulerAngles.x = 0
				var_346_2.localEulerAngles = var_346_2.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				var_346_2.localPosition = Vector3.New(0, 100, 0)
				var_346_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_2.position).x, (manager.ui.mainCamera.transform.position - var_346_2.position).y, (manager.ui.mainCamera.transform.position - var_346_2.position).z)
				var_346_2.localEulerAngles.z = 0
				var_346_2.localEulerAngles.x = 0
				var_346_2.localEulerAngles = var_346_2.localEulerAngles

				local var_346_5 = GameObjectTools.GetOrAddComponent(var_346_2.gameObject, typeof(DynamicBoneHelper))

				if var_346_5 then
					var_346_5:EnableDynamicBone(true)
				end
			end

			local var_346_6 = 0
			local var_346_7 = 1.05

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_8 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(426031085).content)

				arg_343_1.text_.text = var_346_8

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 42 <= 0 and var_346_7 or var_346_7 * (utf8.len(var_346_8) / 42)

				if (42 <= 0 and var_346_7 or var_346_7 * (utf8.len(var_346_8) / 42)) > 0 and var_346_7 < var_346_10 then
					arg_343_1.talkMaxDuration = var_346_10

					if var_346_10 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_6
					end
				end

				arg_343_1.text_.text = var_346_8
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_11 = math.max(var_346_7, arg_343_1.talkMaxDuration)

			if var_346_6 <= arg_343_1.time_ and arg_343_1.time_ < var_346_6 + var_346_11 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_6) / var_346_11

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_6 + var_346_11 and arg_343_1.time_ < var_346_6 + var_346_11 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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

		arg_343_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J03f",
		"TextureConfig/Background/J03g"
	},
	voices = {
		"story_v_out_426031.awb"
	}
}
