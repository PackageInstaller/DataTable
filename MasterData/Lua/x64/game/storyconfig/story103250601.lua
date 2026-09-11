return {
	Play325061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325061001
		arg_1_1.duration_ = 6.73

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_0_story_xuheng_quiet", "bgm_activity_5_0_story_xuheng_quiet")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 1.73333333333333
			local var_4_14 = 1.225

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325061001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 49 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 49)

				if (49 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 49)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325061002
		arg_8_1.duration_ = 7.83

		local var_8_0 = {
			zh = 7.733,
			ja = 7.833
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
				arg_8_0:Play325061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1077ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1077ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1077ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1077ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1077ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1077ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1077ui_story = var_11_3.localPosition

				local var_11_4 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_4 then
					var_11_4:EnableDynamicBone(false)
				end
			end

			local var_11_5 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_5 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_8_1.time_ - 0) / var_11_5)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_5 and arg_8_1.time_ < 0 + var_11_5 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles

				local var_11_6 = GameObjectTools.GetOrAddComponent(var_11_3.gameObject, typeof(DynamicBoneHelper))

				if var_11_6 then
					var_11_6:EnableDynamicBone(true)
				end
			end

			local var_11_7 = arg_8_1.actors_["1077ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1077ui_story == nil then
				arg_8_1.var_.characterEffect1077ui_story = var_11_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_8 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_8 and not isNil(var_11_7) then
				if arg_8_1.var_.characterEffect1077ui_story and not isNil(var_11_7) then
					arg_8_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_8 and arg_8_1.time_ < 0 + var_11_8 + arg_11_0 and not isNil(var_11_7) and arg_8_1.var_.characterEffect1077ui_story then
				arg_8_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_11_10 = 0
			local var_11_11 = 0.825

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(325061002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 33 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 33)

				if (33 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 33)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061002", "story_v_out_325061.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061002", "story_v_out_325061.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_325061", "325061002", "story_v_out_325061.awb")

						arg_8_1:RecordAudio("325061002", var_11_17)
						arg_8_1:RecordAudio("325061002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_325061", "325061002", "story_v_out_325061.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_325061", "325061002", "story_v_out_325061.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_18 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_18 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_18

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_18 and arg_8_1.time_ < var_11_10 + var_11_18 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play325061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325061003
		arg_12_1.duration_ = 11.2

		local var_12_0 = {
			zh = 9.8,
			ja = 11.2
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
				arg_12_0:Play325061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.075

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:GetWordFromCfg(325061003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 43 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 43)

				if (43 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 43)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061003", "story_v_out_325061.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061003", "story_v_out_325061.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_325061", "325061003", "story_v_out_325061.awb")

						arg_12_1:RecordAudio("325061003", var_15_6)
						arg_12_1:RecordAudio("325061003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325061", "325061003", "story_v_out_325061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325061", "325061003", "story_v_out_325061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1077ui_story = arg_16_1.actors_["1077ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).z)
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles = arg_16_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1077ui_story"].transform.position).z)
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1077ui_story"].transform.localEulerAngles = arg_16_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["1077ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1077ui_story == nil then
				arg_16_1.var_.characterEffect1077ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1077ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_4)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1077ui_story then
				arg_16_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_16_1.time_ and arg_16_1.time_ <= 0.1 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_151", "se_story_151_footstep02", "")
			end

			local var_19_6 = 0
			local var_19_7 = 1.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(325061004).content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_10 = 54 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_8) / 54)

				if (54 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_8) / 54)) > 0 and var_19_7 < var_19_10 then
					arg_16_1.talkMaxDuration = var_19_10

					if var_19_10 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_10 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_11 and arg_16_1.time_ < var_19_6 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325061005
		arg_20_1.duration_ = 3.13

		local var_20_0 = {
			zh = 3.133,
			ja = 3.1
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
				arg_20_0:Play325061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1077ui_story = arg_20_1.actors_["1077ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).z)
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles = arg_20_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_20_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1077ui_story"].transform.position).z)
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1077ui_story"].transform.localEulerAngles = arg_20_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = arg_20_1.actors_["1077ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1077ui_story == nil then
				arg_20_1.var_.characterEffect1077ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect1077ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1077ui_story then
				arg_20_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_23_6 = 0
			local var_23_7 = 0.275

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(325061005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 11 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 11)

				if (11 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 11)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061005", "story_v_out_325061.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_325061", "325061005", "story_v_out_325061.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_325061", "325061005", "story_v_out_325061.awb")

						arg_20_1:RecordAudio("325061005", var_23_13)
						arg_20_1:RecordAudio("325061005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325061", "325061005", "story_v_out_325061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325061", "325061005", "story_v_out_325061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325061006
		arg_24_1.duration_ = 5.4

		local var_24_0 = {
			zh = 2.5,
			ja = 5.4
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
				arg_24_0:Play325061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1077ui_story = arg_24_1.actors_["1077ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).z)
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles = arg_24_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				arg_24_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1077ui_story"].transform.position).z)
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1077ui_story"].transform.localEulerAngles = arg_24_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = "1073ui_story"

			if arg_24_1.actors_["1073ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1073ui_story"))) then
				local var_27_4 = Object.Instantiate(Asset.Load("Char/" .. "1073ui_story"), arg_24_1.stage_.transform)

				var_27_4.name = var_27_3
				var_27_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_[var_27_3] = var_27_4

				local var_27_5 = var_27_4:GetComponentInChildren(typeof(CharacterEffect))

				var_27_5.enabled = true

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_4, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_5.transform, false)

				arg_24_1.var_[var_27_3 .. "Animator"] = var_27_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_[var_27_3 .. "Animator"].applyRootMotion = true
				arg_24_1.var_[var_27_3 .. "LipSync"] = var_27_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_7 = arg_24_1.actors_["1073ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1073ui_story = var_27_7.localPosition
			end

			local var_27_8 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 then
				var_27_7.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1073ui_story, Vector3.New(0.7, -0.74, -6.3), (arg_24_1.time_ - 0) / var_27_8)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 then
				var_27_7.localPosition = Vector3.New(0.7, -0.74, -6.3)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			local var_27_9 = arg_24_1.actors_["1073ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1073ui_story == nil then
				arg_24_1.var_.characterEffect1073ui_story = var_27_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_10 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_10 and not isNil(var_27_9) then
				if arg_24_1.var_.characterEffect1073ui_story and not isNil(var_27_9) then
					arg_24_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_10 and arg_24_1.time_ < 0 + var_27_10 + arg_27_0 and not isNil(var_27_9) and arg_24_1.var_.characterEffect1073ui_story then
				arg_24_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			local var_27_12 = arg_24_1.actors_["1077ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.characterEffect1077ui_story == nil then
				arg_24_1.var_.characterEffect1077ui_story = var_27_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_13 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_13 and not isNil(var_27_12) then
				if arg_24_1.var_.characterEffect1077ui_story and not isNil(var_27_12) then
					arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_13)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_13 and arg_24_1.time_ < 0 + var_27_13 + arg_27_0 and not isNil(var_27_12) and arg_24_1.var_.characterEffect1077ui_story then
				arg_24_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action7_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_14 = 0
			local var_27_15 = 0.2

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(325061006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 8 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 8)

				if (8 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 8)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061006", "story_v_out_325061.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_325061", "325061006", "story_v_out_325061.awb") / 1000

					if var_27_20 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_14
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_325061", "325061006", "story_v_out_325061.awb")

						arg_24_1:RecordAudio("325061006", var_27_21)
						arg_24_1:RecordAudio("325061006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325061", "325061006", "story_v_out_325061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325061", "325061006", "story_v_out_325061.awb")
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1073ui_story",
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
	Play325061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325061007
		arg_28_1.duration_ = 7.53

		local var_28_0 = {
			zh = 7.033,
			ja = 7.533
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
				arg_28_0:Play325061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1077ui_story"]) and arg_28_1.var_.characterEffect1077ui_story == nil then
				arg_28_1.var_.characterEffect1077ui_story = arg_28_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1077ui_story"]) then
				if arg_28_1.var_.characterEffect1077ui_story and not isNil(arg_28_1.actors_["1077ui_story"]) then
					arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1077ui_story"]) and arg_28_1.var_.characterEffect1077ui_story then
				arg_28_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1073ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1073ui_story == nil then
				arg_28_1.var_.characterEffect1073ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1073ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1073ui_story then
				arg_28_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			local var_31_4 = 0
			local var_31_5 = 0.75

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(325061007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 30 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 30)

				if (30 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 30)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061007", "story_v_out_325061.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061007", "story_v_out_325061.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_325061", "325061007", "story_v_out_325061.awb")

						arg_28_1:RecordAudio("325061007", var_31_11)
						arg_28_1:RecordAudio("325061007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325061", "325061007", "story_v_out_325061.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325061", "325061007", "story_v_out_325061.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325061008
		arg_32_1.duration_ = 2

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1073ui_story"]) and arg_32_1.var_.characterEffect1073ui_story == nil then
				arg_32_1.var_.characterEffect1073ui_story = arg_32_1.actors_["1073ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1073ui_story"]) then
				if arg_32_1.var_.characterEffect1073ui_story and not isNil(arg_32_1.actors_["1073ui_story"]) then
					arg_32_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1073ui_story"]) and arg_32_1.var_.characterEffect1073ui_story then
				arg_32_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1077ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1077ui_story == nil then
				arg_32_1.var_.characterEffect1077ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1077ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1077ui_story then
				arg_32_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action7_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileB_weixiao", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 0.05

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(325061008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 2 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 2)

				if (2 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 2)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061008", "story_v_out_325061.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061008", "story_v_out_325061.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_325061", "325061008", "story_v_out_325061.awb")

						arg_32_1:RecordAudio("325061008", var_35_11)
						arg_32_1:RecordAudio("325061008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325061", "325061008", "story_v_out_325061.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325061", "325061008", "story_v_out_325061.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325061009
		arg_36_1.duration_ = 2.27

		local var_36_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_36_0:Play325061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1077ui_story"]) and arg_36_1.var_.characterEffect1077ui_story == nil then
				arg_36_1.var_.characterEffect1077ui_story = arg_36_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1077ui_story"]) then
				if arg_36_1.var_.characterEffect1077ui_story and not isNil(arg_36_1.actors_["1077ui_story"]) then
					arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1077ui_story"]) and arg_36_1.var_.characterEffect1077ui_story then
				arg_36_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1073ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1073ui_story == nil then
				arg_36_1.var_.characterEffect1073ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1073ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1073ui_story then
				arg_36_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_4 = 0
			local var_39_5 = 0.175

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(325061009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 7 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 7)

				if (7 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 7)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061009", "story_v_out_325061.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061009", "story_v_out_325061.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_325061", "325061009", "story_v_out_325061.awb")

						arg_36_1:RecordAudio("325061009", var_39_11)
						arg_36_1:RecordAudio("325061009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325061", "325061009", "story_v_out_325061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325061", "325061009", "story_v_out_325061.awb")
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
	Play325061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325061010
		arg_40_1.duration_ = 6.17

		local var_40_0 = {
			zh = 5.966,
			ja = 6.166
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
				arg_40_0:Play325061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1073ui_story"]) and arg_40_1.var_.characterEffect1073ui_story == nil then
				arg_40_1.var_.characterEffect1073ui_story = arg_40_1.actors_["1073ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1073ui_story"]) then
				if arg_40_1.var_.characterEffect1073ui_story and not isNil(arg_40_1.actors_["1073ui_story"]) then
					arg_40_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1073ui_story"]) and arg_40_1.var_.characterEffect1073ui_story then
				arg_40_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1077ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1077ui_story == nil then
				arg_40_1.var_.characterEffect1077ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1077ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1077ui_story then
				arg_40_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action5_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileB_weixiao", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 0.7

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(325061010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 28 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 28)

				if (28 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 28)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061010", "story_v_out_325061.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061010", "story_v_out_325061.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_325061", "325061010", "story_v_out_325061.awb")

						arg_40_1:RecordAudio("325061010", var_43_11)
						arg_40_1:RecordAudio("325061010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325061", "325061010", "story_v_out_325061.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325061", "325061010", "story_v_out_325061.awb")
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

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325061011
		arg_44_1.duration_ = 3.53

		local var_44_0 = {
			zh = 2.566,
			ja = 3.533
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
				arg_44_0:Play325061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) and arg_44_1.var_.characterEffect1077ui_story == nil then
				arg_44_1.var_.characterEffect1077ui_story = arg_44_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) then
				if arg_44_1.var_.characterEffect1077ui_story and not isNil(arg_44_1.actors_["1077ui_story"]) then
					arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1077ui_story"]) and arg_44_1.var_.characterEffect1077ui_story then
				arg_44_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1073ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1073ui_story == nil then
				arg_44_1.var_.characterEffect1073ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1073ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1073ui_story then
				arg_44_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			local var_47_4 = 0
			local var_47_5 = 0.175

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(325061011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 7 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 7)

				if (7 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 7)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061011", "story_v_out_325061.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061011", "story_v_out_325061.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_325061", "325061011", "story_v_out_325061.awb")

						arg_44_1:RecordAudio("325061011", var_47_11)
						arg_44_1:RecordAudio("325061011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325061", "325061011", "story_v_out_325061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325061", "325061011", "story_v_out_325061.awb")
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
	Play325061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325061012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1077ui_story = arg_48_1.actors_["1077ui_story"].transform.localPosition

				local var_51_0 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_0 then
					var_51_0:EnableDynamicBone(false)
				end
			end

			local var_51_1 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_1 then
				arg_48_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_1)
				arg_48_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).z)
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles = arg_48_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_1 and arg_48_1.time_ < 0 + var_51_1 + arg_51_0 then
				arg_48_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1077ui_story"].transform.position).z)
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1077ui_story"].transform.localEulerAngles = arg_48_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_51_2 = GameObjectTools.GetOrAddComponent(arg_48_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(true)
				end
			end

			local var_51_3 = arg_48_1.actors_["1073ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1073ui_story = var_51_3.localPosition
			end

			local var_51_4 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				var_51_3.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1073ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_4)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				var_51_3.localPosition = Vector3.New(0, 100, 0)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			local var_51_5 = arg_48_1.actors_["1077ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1077ui_story == nil then
				arg_48_1.var_.characterEffect1077ui_story = var_51_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_6 and not isNil(var_51_5) then
				if arg_48_1.var_.characterEffect1077ui_story and not isNil(var_51_5) then
					arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_6)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_6 and arg_48_1.time_ < 0 + var_51_6 + arg_51_0 and not isNil(var_51_5) and arg_48_1.var_.characterEffect1077ui_story then
				arg_48_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_48_1.time_ and arg_48_1.time_ <= 0.1 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_footstep", "")
			end

			local var_51_8 = 0
			local var_51_9 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(325061012).content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_12 = 23 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_10) / 23)

				if (23 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_10) / 23)) > 0 and var_51_9 < var_51_12 then
					arg_48_1.talkMaxDuration = var_51_12

					if var_51_12 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_12 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_13 and arg_48_1.time_ < var_51_8 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1073ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play325061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325061013
		arg_52_1.duration_ = 6.9

		local var_52_0 = {
			zh = 6.9,
			ja = 6.7
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
				arg_52_0:Play325061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1073ui_story = arg_52_1.actors_["1073ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1073ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1073ui_story, Vector3.New(0, -0.74, -6.3), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1073ui_story"].transform.position).z)
				arg_52_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1073ui_story"].transform.localEulerAngles = arg_52_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1073ui_story"].transform.localPosition = Vector3.New(0, -0.74, -6.3)
				arg_52_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1073ui_story"].transform.position).z)
				arg_52_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1073ui_story"].transform.localEulerAngles = arg_52_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1073ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1073ui_story == nil then
				arg_52_1.var_.characterEffect1073ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1073ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1073ui_story then
				arg_52_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action5_2")
			end

			local var_55_4 = 0
			local var_55_5 = 0.6

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(325061013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 24 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 24)

				if (24 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 24)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061013", "story_v_out_325061.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061013", "story_v_out_325061.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_325061", "325061013", "story_v_out_325061.awb")

						arg_52_1:RecordAudio("325061013", var_55_11)
						arg_52_1:RecordAudio("325061013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325061", "325061013", "story_v_out_325061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325061", "325061013", "story_v_out_325061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play325061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325061014
		arg_56_1.duration_ = 10.03

		local var_56_0 = {
			zh = 6.3,
			ja = 10.033
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
				arg_56_0:Play325061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.875

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:GetWordFromCfg(325061014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 35 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 35)

				if (35 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 35)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061014", "story_v_out_325061.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061014", "story_v_out_325061.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_325061", "325061014", "story_v_out_325061.awb")

						arg_56_1:RecordAudio("325061014", var_59_6)
						arg_56_1:RecordAudio("325061014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325061", "325061014", "story_v_out_325061.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325061", "325061014", "story_v_out_325061.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325061015
		arg_60_1.duration_ = 3.17

		local var_60_0 = {
			zh = 2.1,
			ja = 3.166
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
				arg_60_0:Play325061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1073ui_story = arg_60_1.actors_["1073ui_story"].transform.localPosition
			end

			local var_63_0 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				arg_60_1.actors_["1073ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1073ui_story, Vector3.New(-0.7, -0.74, -6.3), (arg_60_1.time_ - 0) / var_63_0)
				arg_60_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1073ui_story"].transform.position).z)
				arg_60_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1073ui_story"].transform.localEulerAngles = arg_60_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				arg_60_1.actors_["1073ui_story"].transform.localPosition = Vector3.New(-0.7, -0.74, -6.3)
				arg_60_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1073ui_story"].transform.position).z)
				arg_60_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1073ui_story"].transform.localEulerAngles = arg_60_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			local var_63_1 = arg_60_1.actors_["1077ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1077ui_story = var_63_1.localPosition

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_1.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end
			end

			local var_63_3 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 then
				var_63_1.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_60_1.time_ - 0) / var_63_3)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 then
				var_63_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_63_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_1.position).x, (manager.ui.mainCamera.transform.position - var_63_1.position).y, (manager.ui.mainCamera.transform.position - var_63_1.position).z)
				var_63_1.localEulerAngles.z = 0
				var_63_1.localEulerAngles.x = 0
				var_63_1.localEulerAngles = var_63_1.localEulerAngles

				local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_1.gameObject, typeof(DynamicBoneHelper))

				if var_63_4 then
					var_63_4:EnableDynamicBone(true)
				end
			end

			local var_63_5 = arg_60_1.actors_["1077ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1077ui_story == nil then
				arg_60_1.var_.characterEffect1077ui_story = var_63_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_6 and not isNil(var_63_5) then
				if arg_60_1.var_.characterEffect1077ui_story and not isNil(var_63_5) then
					arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_6 and arg_60_1.time_ < 0 + var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1077ui_story then
				arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_63_8 = arg_60_1.actors_["1073ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.characterEffect1073ui_story == nil then
				arg_60_1.var_.characterEffect1073ui_story = var_63_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_9 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_9 and not isNil(var_63_8) then
				if arg_60_1.var_.characterEffect1073ui_story and not isNil(var_63_8) then
					arg_60_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_9)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_9 and arg_60_1.time_ < 0 + var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.characterEffect1073ui_story then
				arg_60_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			local var_63_10 = 0
			local var_63_11 = 0.25

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_12 = arg_60_1:GetWordFromCfg(325061015)
				local var_63_13 = arg_60_1:FormatText(var_63_12.content)

				arg_60_1.text_.text = var_63_13

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 10 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 10)

				if (10 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 10)) > 0 and var_63_11 < var_63_15 then
					arg_60_1.talkMaxDuration = var_63_15

					if var_63_15 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_15 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_13
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061015", "story_v_out_325061.awb") ~= 0 then
					local var_63_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061015", "story_v_out_325061.awb") / 1000

					if var_63_16 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_16 + var_63_10
					end

					if var_63_12.prefab_name ~= "" and arg_60_1.actors_[var_63_12.prefab_name] ~= nil then
						local var_63_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_12.prefab_name].transform, "story_v_out_325061", "325061015", "story_v_out_325061.awb")

						arg_60_1:RecordAudio("325061015", var_63_17)
						arg_60_1:RecordAudio("325061015", var_63_17)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325061", "325061015", "story_v_out_325061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325061", "325061015", "story_v_out_325061.awb")
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
				actorName = "1073ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play325061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325061016
		arg_64_1.duration_ = 13.23

		local var_64_0 = {
			zh = 9.966,
			ja = 13.233
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
				arg_64_0:Play325061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1073ui_story"]) and arg_64_1.var_.characterEffect1073ui_story == nil then
				arg_64_1.var_.characterEffect1073ui_story = arg_64_1.actors_["1073ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1073ui_story"]) then
				if arg_64_1.var_.characterEffect1073ui_story and not isNil(arg_64_1.actors_["1073ui_story"]) then
					arg_64_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1073ui_story"]) and arg_64_1.var_.characterEffect1073ui_story then
				arg_64_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1077ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1077ui_story == nil then
				arg_64_1.var_.characterEffect1077ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1077ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1077ui_story then
				arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_67_4 = 0
			local var_67_5 = 1.2

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(325061016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 48 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 48)

				if (48 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 48)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061016", "story_v_out_325061.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061016", "story_v_out_325061.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_325061", "325061016", "story_v_out_325061.awb")

						arg_64_1:RecordAudio("325061016", var_67_11)
						arg_64_1:RecordAudio("325061016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325061", "325061016", "story_v_out_325061.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325061", "325061016", "story_v_out_325061.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play325061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325061017
		arg_68_1.duration_ = 3.6

		local var_68_0 = {
			zh = 2.933,
			ja = 3.6
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
				arg_68_0:Play325061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) and arg_68_1.var_.characterEffect1077ui_story == nil then
				arg_68_1.var_.characterEffect1077ui_story = arg_68_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) then
				if arg_68_1.var_.characterEffect1077ui_story and not isNil(arg_68_1.actors_["1077ui_story"]) then
					arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1077ui_story"]) and arg_68_1.var_.characterEffect1077ui_story then
				arg_68_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1073ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1073ui_story == nil then
				arg_68_1.var_.characterEffect1073ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect1073ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1073ui_story then
				arg_68_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			local var_71_4 = 0
			local var_71_5 = 0.375

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(325061017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 15 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 15)

				if (15 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 15)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061017", "story_v_out_325061.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061017", "story_v_out_325061.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_325061", "325061017", "story_v_out_325061.awb")

						arg_68_1:RecordAudio("325061017", var_71_11)
						arg_68_1:RecordAudio("325061017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325061", "325061017", "story_v_out_325061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325061", "325061017", "story_v_out_325061.awb")
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

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325061018
		arg_72_1.duration_ = 7.5

		local var_72_0 = {
			zh = 3.433,
			ja = 7.5
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
				arg_72_0:Play325061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1073ui_story"]) and arg_72_1.var_.characterEffect1073ui_story == nil then
				arg_72_1.var_.characterEffect1073ui_story = arg_72_1.actors_["1073ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1073ui_story"]) then
				if arg_72_1.var_.characterEffect1073ui_story and not isNil(arg_72_1.actors_["1073ui_story"]) then
					arg_72_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1073ui_story"]) and arg_72_1.var_.characterEffect1073ui_story then
				arg_72_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["1077ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect1077ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1077ui_story then
				arg_72_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action2_1")
			end

			local var_75_4 = 0
			local var_75_5 = 0.375

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(325061018)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 15 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 15)

				if (15 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 15)) > 0 and var_75_5 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061018", "story_v_out_325061.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061018", "story_v_out_325061.awb") / 1000

					if var_75_10 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_4
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_325061", "325061018", "story_v_out_325061.awb")

						arg_72_1:RecordAudio("325061018", var_75_11)
						arg_72_1:RecordAudio("325061018", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325061", "325061018", "story_v_out_325061.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325061", "325061018", "story_v_out_325061.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_12 and arg_72_1.time_ < var_75_4 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play325061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325061019
		arg_76_1.duration_ = 12.8

		local var_76_0 = {
			zh = 9.633,
			ja = 12.8
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
				arg_76_0:Play325061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.2

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(325061019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 48 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 48)

				if (48 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 48)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061019", "story_v_out_325061.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061019", "story_v_out_325061.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_325061", "325061019", "story_v_out_325061.awb")

						arg_76_1:RecordAudio("325061019", var_79_6)
						arg_76_1:RecordAudio("325061019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325061", "325061019", "story_v_out_325061.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325061", "325061019", "story_v_out_325061.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325061020
		arg_80_1.duration_ = 3.5

		local var_80_0 = {
			zh = 3.433,
			ja = 3.5
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
				arg_80_0:Play325061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action2_2")
			end

			local var_83_0 = 0
			local var_83_1 = 0.5

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_2 = arg_80_1:GetWordFromCfg(325061020)
				local var_83_3 = arg_80_1:FormatText(var_83_2.content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 20 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 20)

				if (20 <= 0 and var_83_1 or var_83_1 * (utf8.len(var_83_3) / 20)) > 0 and var_83_1 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061020", "story_v_out_325061.awb") ~= 0 then
					local var_83_6 = manager.audio:GetVoiceLength("story_v_out_325061", "325061020", "story_v_out_325061.awb") / 1000

					if var_83_6 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_0
					end

					if var_83_2.prefab_name ~= "" and arg_80_1.actors_[var_83_2.prefab_name] ~= nil then
						local var_83_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_2.prefab_name].transform, "story_v_out_325061", "325061020", "story_v_out_325061.awb")

						arg_80_1:RecordAudio("325061020", var_83_7)
						arg_80_1:RecordAudio("325061020", var_83_7)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325061", "325061020", "story_v_out_325061.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325061", "325061020", "story_v_out_325061.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_8 and arg_80_1.time_ < var_83_0 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play325061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325061021
		arg_84_1.duration_ = 7.9

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325061022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if arg_84_1.bgs_.ST41 == nil then
				local var_87_0 = Object.Instantiate(arg_84_1.paintGo_)

				var_87_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST41")
				var_87_0.name = "ST41"
				var_87_0.transform.parent = arg_84_1.stage_.transform
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.bgs_.ST41 = var_87_0
			end

			if 1.43333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 1.43333333333333 + arg_87_0 then
				local var_87_1 = arg_84_1.bgs_.ST41

				arg_84_1.bgs_.ST41.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_87_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_2 = var_87_1:GetComponent("SpriteRenderer")

				if var_87_2 and var_87_2.sprite then
					local var_87_3 = 2 * (var_87_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_87_1.transform.localScale = Vector3.New(var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "ST41" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_4 = 1.43333333333333

			if 1.43333333333333 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			if arg_84_1.time_ >= var_87_4 + 0.3 and arg_84_1.time_ < var_87_4 + 0.3 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			local var_87_5 = 0

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_6 = 1.43333333333333

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 then
				local var_87_7 = Color.New(0, 0, 0)

				var_87_7.a = Mathf.Lerp(0, 1, (arg_84_1.time_ - var_87_5) / var_87_6)
				arg_84_1.mask_.color = var_87_7
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 then
				local var_87_8 = Color.New(0, 0, 0)

				var_87_8.a = 1
				arg_84_1.mask_.color = var_87_8
			end

			local var_87_9 = 1.43333333333333

			if 1.43333333333333 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_10 = 2

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 then
				local var_87_11 = Color.New(0, 0, 0)

				var_87_11.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - var_87_9) / var_87_10)
				arg_84_1.mask_.color = var_87_11
			end

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 then
				local var_87_12 = Color.New(0, 0, 0)

				arg_84_1.mask_.enabled = false
				var_87_12.a = 0
				arg_84_1.mask_.color = var_87_12
			end

			local var_87_13 = arg_84_1.actors_["1073ui_story"].transform

			if 1.43333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 1.43333333333333 + arg_87_0 then
				arg_84_1.var_.moveOldPos1073ui_story = var_87_13.localPosition
			end

			local var_87_14 = 0.001

			if 1.43333333333333 <= arg_84_1.time_ and arg_84_1.time_ < 1.43333333333333 + var_87_14 then
				var_87_13.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1073ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 1.43333333333333) / var_87_14)
				var_87_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_13.position).x, (manager.ui.mainCamera.transform.position - var_87_13.position).y, (manager.ui.mainCamera.transform.position - var_87_13.position).z)
				var_87_13.localEulerAngles.z = 0
				var_87_13.localEulerAngles.x = 0
				var_87_13.localEulerAngles = var_87_13.localEulerAngles
			end

			if arg_84_1.time_ >= 1.43333333333333 + var_87_14 and arg_84_1.time_ < 1.43333333333333 + var_87_14 + arg_87_0 then
				var_87_13.localPosition = Vector3.New(0, 100, 0)
				var_87_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_13.position).x, (manager.ui.mainCamera.transform.position - var_87_13.position).y, (manager.ui.mainCamera.transform.position - var_87_13.position).z)
				var_87_13.localEulerAngles.z = 0
				var_87_13.localEulerAngles.x = 0
				var_87_13.localEulerAngles = var_87_13.localEulerAngles
			end

			local var_87_15 = arg_84_1.actors_["1077ui_story"].transform

			if 1.43333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 1.43333333333333 + arg_87_0 then
				arg_84_1.var_.moveOldPos1077ui_story = var_87_15.localPosition

				local var_87_16 = GameObjectTools.GetOrAddComponent(var_87_15.gameObject, typeof(DynamicBoneHelper))

				if var_87_16 then
					var_87_16:EnableDynamicBone(false)
				end
			end

			local var_87_17 = 0.001

			if 1.43333333333333 <= arg_84_1.time_ and arg_84_1.time_ < 1.43333333333333 + var_87_17 then
				var_87_15.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 1.43333333333333) / var_87_17)
				var_87_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_15.position).x, (manager.ui.mainCamera.transform.position - var_87_15.position).y, (manager.ui.mainCamera.transform.position - var_87_15.position).z)
				var_87_15.localEulerAngles.z = 0
				var_87_15.localEulerAngles.x = 0
				var_87_15.localEulerAngles = var_87_15.localEulerAngles
			end

			if arg_84_1.time_ >= 1.43333333333333 + var_87_17 and arg_84_1.time_ < 1.43333333333333 + var_87_17 + arg_87_0 then
				var_87_15.localPosition = Vector3.New(0, 100, 0)
				var_87_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_15.position).x, (manager.ui.mainCamera.transform.position - var_87_15.position).y, (manager.ui.mainCamera.transform.position - var_87_15.position).z)
				var_87_15.localEulerAngles.z = 0
				var_87_15.localEulerAngles.x = 0
				var_87_15.localEulerAngles = var_87_15.localEulerAngles

				local var_87_18 = GameObjectTools.GetOrAddComponent(var_87_15.gameObject, typeof(DynamicBoneHelper))

				if var_87_18 then
					var_87_18:EnableDynamicBone(true)
				end
			end

			local var_87_19 = arg_84_1.actors_["1073ui_story"]

			if 1.43333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 1.43333333333333 + arg_87_0 and not isNil(var_87_19) and arg_84_1.var_.characterEffect1073ui_story == nil then
				arg_84_1.var_.characterEffect1073ui_story = var_87_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_20 = 0.200000002980232

			if 1.43333333333333 <= arg_84_1.time_ and arg_84_1.time_ < 1.43333333333333 + var_87_20 and not isNil(var_87_19) then
				if arg_84_1.var_.characterEffect1073ui_story and not isNil(var_87_19) then
					arg_84_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 1.43333333333333) / var_87_20)
				end
			end

			if arg_84_1.time_ >= 1.43333333333333 + var_87_20 and arg_84_1.time_ < 1.43333333333333 + var_87_20 + arg_87_0 and not isNil(var_87_19) and arg_84_1.var_.characterEffect1073ui_story then
				arg_84_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_84_1.time_ and arg_84_1.time_ <= 0.1 + arg_87_0 then
				arg_84_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 1.7 < arg_84_1.time_ and arg_84_1.time_ <= 1.7 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			if 1.2 < arg_84_1.time_ and arg_84_1.time_ <= 1.2 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_3", "")
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_24 = 2.9
			local var_87_25 = 0.8

			if 2.9 < arg_84_1.time_ and arg_84_1.time_ <= var_87_24 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_26 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_26:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_27 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(325061021).content)

				arg_84_1.text_.text = var_87_27

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_29 = 32 <= 0 and var_87_25 or var_87_25 * (utf8.len(var_87_27) / 32)

				if (32 <= 0 and var_87_25 or var_87_25 * (utf8.len(var_87_27) / 32)) > 0 and var_87_25 < var_87_29 then
					arg_84_1.talkMaxDuration = var_87_29
					var_87_24 = var_87_24 + 0.3

					if var_87_29 + var_87_24 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_29 + var_87_24
					end
				end

				arg_84_1.text_.text = var_87_27
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_30 = var_87_24 + 0.3
			local var_87_31 = math.max(var_87_25, arg_84_1.talkMaxDuration)

			if var_87_24 + 0.3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_30 + var_87_31 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_30) / var_87_31

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_30 + var_87_31 and arg_84_1.time_ < var_87_30 + var_87_31 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play325061022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325061022
		arg_90_1.duration_ = 4.77

		local var_90_0 = {
			zh = 3.566,
			ja = 4.766
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
				arg_90_0:Play325061023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if arg_90_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_93_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_90_1.stage_.transform)

				var_93_0.name = "1061ui_story"
				var_93_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.actors_["1061ui_story"] = var_93_0

				local var_93_1 = var_93_0:GetComponentInChildren(typeof(CharacterEffect))

				var_93_1.enabled = true

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_0, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end

				arg_90_1:ShowWeapon(var_93_1.transform, false)

				arg_90_1.var_["1061ui_story" .. "Animator"] = var_93_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_90_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_90_1.var_["1061ui_story" .. "LipSync"] = var_93_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_93_3 = arg_90_1.actors_["1061ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1061ui_story = var_93_3.localPosition
			end

			local var_93_4 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_3.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_90_1.time_ - 0) / var_93_4)
				var_93_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_3.position).x, (manager.ui.mainCamera.transform.position - var_93_3.position).y, (manager.ui.mainCamera.transform.position - var_93_3.position).z)
				var_93_3.localEulerAngles.z = 0
				var_93_3.localEulerAngles.x = 0
				var_93_3.localEulerAngles = var_93_3.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_93_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_3.position).x, (manager.ui.mainCamera.transform.position - var_93_3.position).y, (manager.ui.mainCamera.transform.position - var_93_3.position).z)
				var_93_3.localEulerAngles.z = 0
				var_93_3.localEulerAngles.x = 0
				var_93_3.localEulerAngles = var_93_3.localEulerAngles
			end

			local var_93_5 = arg_90_1.actors_["1061ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1061ui_story == nil then
				arg_90_1.var_.characterEffect1061ui_story = var_93_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_6 and not isNil(var_93_5) then
				if arg_90_1.var_.characterEffect1061ui_story and not isNil(var_93_5) then
					arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_6 and arg_90_1.time_ < 0 + var_93_6 + arg_93_0 and not isNil(var_93_5) and arg_90_1.var_.characterEffect1061ui_story then
				arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_8 = 0
			local var_93_9 = 0.325

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(325061022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 13 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 13)

				if (13 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 13)) > 0 and var_93_9 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061022", "story_v_out_325061.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061022", "story_v_out_325061.awb") / 1000

					if var_93_14 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_8
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_325061", "325061022", "story_v_out_325061.awb")

						arg_90_1:RecordAudio("325061022", var_93_15)
						arg_90_1:RecordAudio("325061022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_325061", "325061022", "story_v_out_325061.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_325061", "325061022", "story_v_out_325061.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play325061023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325061023
		arg_94_1.duration_ = 9.77

		local var_94_0 = {
			zh = 5.8,
			ja = 9.766
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
				arg_94_0:Play325061024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1061ui_story = arg_94_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_97_0 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 then
				arg_94_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_94_1.time_ - 0) / var_97_0)
				arg_94_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).z)
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles = arg_94_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 then
				arg_94_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_94_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).z)
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles = arg_94_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_97_1 = arg_94_1.actors_["1073ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1073ui_story = var_97_1.localPosition
			end

			local var_97_2 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 then
				var_97_1.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1073ui_story, Vector3.New(0.7, -0.74, -6.3), (arg_94_1.time_ - 0) / var_97_2)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 then
				var_97_1.localPosition = Vector3.New(0.7, -0.74, -6.3)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles
			end

			local var_97_3 = arg_94_1.actors_["1073ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1073ui_story == nil then
				arg_94_1.var_.characterEffect1073ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect1073ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1073ui_story then
				arg_94_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			local var_97_6 = arg_94_1.actors_["1061ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1061ui_story == nil then
				arg_94_1.var_.characterEffect1061ui_story = var_97_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_7 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 and not isNil(var_97_6) then
				if arg_94_1.var_.characterEffect1061ui_story and not isNil(var_97_6) then
					arg_94_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_7)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect1061ui_story then
				arg_94_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action6_1")
			end

			local var_97_8 = 0
			local var_97_9 = 0.575

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_10 = arg_94_1:GetWordFromCfg(325061023)
				local var_97_11 = arg_94_1:FormatText(var_97_10.content)

				arg_94_1.text_.text = var_97_11

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 23 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 23)

				if (23 <= 0 and var_97_9 or var_97_9 * (utf8.len(var_97_11) / 23)) > 0 and var_97_9 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_11
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061023", "story_v_out_325061.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061023", "story_v_out_325061.awb") / 1000

					if var_97_14 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_8
					end

					if var_97_10.prefab_name ~= "" and arg_94_1.actors_[var_97_10.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_10.prefab_name].transform, "story_v_out_325061", "325061023", "story_v_out_325061.awb")

						arg_94_1:RecordAudio("325061023", var_97_15)
						arg_94_1:RecordAudio("325061023", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325061", "325061023", "story_v_out_325061.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325061", "325061023", "story_v_out_325061.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1073ui_story",
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
	Play325061024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325061024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325061025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1073ui_story = arg_98_1.actors_["1073ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["1073ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1073ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1073ui_story"].transform.position).z)
				arg_98_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1073ui_story"].transform.localEulerAngles = arg_98_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["1073ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1073ui_story"].transform.position).z)
				arg_98_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1073ui_story"].transform.localEulerAngles = arg_98_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			local var_101_1 = arg_98_1.actors_["1061ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1061ui_story = var_101_1.localPosition
			end

			local var_101_2 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 then
				var_101_1.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_2)
				var_101_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_1.position).x, (manager.ui.mainCamera.transform.position - var_101_1.position).y, (manager.ui.mainCamera.transform.position - var_101_1.position).z)
				var_101_1.localEulerAngles.z = 0
				var_101_1.localEulerAngles.x = 0
				var_101_1.localEulerAngles = var_101_1.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 then
				var_101_1.localPosition = Vector3.New(0, 100, 0)
				var_101_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_1.position).x, (manager.ui.mainCamera.transform.position - var_101_1.position).y, (manager.ui.mainCamera.transform.position - var_101_1.position).z)
				var_101_1.localEulerAngles.z = 0
				var_101_1.localEulerAngles.x = 0
				var_101_1.localEulerAngles = var_101_1.localEulerAngles
			end

			local var_101_3 = arg_98_1.actors_["1073ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect1073ui_story == nil then
				arg_98_1.var_.characterEffect1073ui_story = var_101_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_4 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 and not isNil(var_101_3) then
				if arg_98_1.var_.characterEffect1073ui_story and not isNil(var_101_3) then
					arg_98_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_4)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect1073ui_story then
				arg_98_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_98_1.time_ and arg_98_1.time_ <= 0.2 + arg_101_0 then
				arg_98_1:AudioAction("play", "effect", "se_story_141", "se_story_141_door", "")
			end

			local var_101_6 = 0
			local var_101_7 = 0.475

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(325061024).content)

				arg_98_1.text_.text = var_101_8

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 19 <= 0 and var_101_7 or var_101_7 * (utf8.len(var_101_8) / 19)

				if (19 <= 0 and var_101_7 or var_101_7 * (utf8.len(var_101_8) / 19)) > 0 and var_101_7 < var_101_10 then
					arg_98_1.talkMaxDuration = var_101_10

					if var_101_10 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_8
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_11 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_11 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_11

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_11 and arg_98_1.time_ < var_101_6 + var_101_11 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325061025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325061025
		arg_102_1.duration_ = 5.17

		local var_102_0 = {
			zh = 5.166,
			ja = 4.233
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
				arg_102_0:Play325061026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1061ui_story = arg_102_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).z)
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles = arg_102_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_102_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).z)
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles = arg_102_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1061ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1061ui_story then
				arg_102_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_105_4 = 0
			local var_105_5 = 0.7

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(325061025)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 25 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 25)

				if (25 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 25)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061025", "story_v_out_325061.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061025", "story_v_out_325061.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_325061", "325061025", "story_v_out_325061.awb")

						arg_102_1:RecordAudio("325061025", var_105_11)
						arg_102_1:RecordAudio("325061025", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325061", "325061025", "story_v_out_325061.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325061", "325061025", "story_v_out_325061.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325061026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325061026
		arg_106_1.duration_ = 3.77

		local var_106_0 = {
			zh = 2.533,
			ja = 3.766
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
				arg_106_0:Play325061027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1061ui_story = arg_106_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).z)
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles = arg_106_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_106_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).z)
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles = arg_106_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1073ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1073ui_story = var_109_1.localPosition
			end

			local var_109_2 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 then
				var_109_1.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1073ui_story, Vector3.New(0.7, -0.74, -6.3), (arg_106_1.time_ - 0) / var_109_2)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 then
				var_109_1.localPosition = Vector3.New(0.7, -0.74, -6.3)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			local var_109_3 = arg_106_1.actors_["1073ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1073ui_story == nil then
				arg_106_1.var_.characterEffect1073ui_story = var_109_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_4 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 and not isNil(var_109_3) then
				if arg_106_1.var_.characterEffect1073ui_story and not isNil(var_109_3) then
					arg_106_1.var_.characterEffect1073ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect1073ui_story then
				arg_106_1.var_.characterEffect1073ui_story.fillFlat = false
			end

			local var_109_6 = arg_106_1.actors_["1061ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = var_109_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_7 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 and not isNil(var_109_6) then
				if arg_106_1.var_.characterEffect1061ui_story and not isNil(var_109_6) then
					arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_7)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 and not isNil(var_109_6) and arg_106_1.var_.characterEffect1061ui_story then
				arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/story1073/story1073action/1073action6_2")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1073ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_8 = 0
			local var_109_9 = 0.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:GetWordFromCfg(325061026)
				local var_109_11 = arg_106_1:FormatText(var_109_10.content)

				arg_106_1.text_.text = var_109_11

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 12 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 12)

				if (12 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 12)) > 0 and var_109_9 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_11
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061026", "story_v_out_325061.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061026", "story_v_out_325061.awb") / 1000

					if var_109_14 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_8
					end

					if var_109_10.prefab_name ~= "" and arg_106_1.actors_[var_109_10.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_10.prefab_name].transform, "story_v_out_325061", "325061026", "story_v_out_325061.awb")

						arg_106_1:RecordAudio("325061026", var_109_15)
						arg_106_1:RecordAudio("325061026", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325061", "325061026", "story_v_out_325061.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325061", "325061026", "story_v_out_325061.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_16 and arg_106_1.time_ < var_109_8 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1073ui_story",
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
	Play325061027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325061027
		arg_110_1.duration_ = 10.3

		local var_110_0 = {
			zh = 9.866,
			ja = 10.3
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
				arg_110_0:Play325061028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1073ui_story = arg_110_1.actors_["1073ui_story"].transform.localPosition
			end

			local var_113_0 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 then
				arg_110_1.actors_["1073ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1073ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_0)
				arg_110_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1073ui_story"].transform.position).z)
				arg_110_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1073ui_story"].transform.localEulerAngles = arg_110_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 then
				arg_110_1.actors_["1073ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_["1073ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["1073ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1073ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["1073ui_story"].transform.position).z)
				arg_110_1.actors_["1073ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["1073ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["1073ui_story"].transform.localEulerAngles = arg_110_1.actors_["1073ui_story"].transform.localEulerAngles
			end

			local var_113_1 = arg_110_1.actors_["1077ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1077ui_story = var_113_1.localPosition

				local var_113_2 = GameObjectTools.GetOrAddComponent(var_113_1.gameObject, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(false)
				end
			end

			local var_113_3 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 then
				var_113_1.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_110_1.time_ - 0) / var_113_3)
				var_113_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_1.position).x, (manager.ui.mainCamera.transform.position - var_113_1.position).y, (manager.ui.mainCamera.transform.position - var_113_1.position).z)
				var_113_1.localEulerAngles.z = 0
				var_113_1.localEulerAngles.x = 0
				var_113_1.localEulerAngles = var_113_1.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 then
				var_113_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_113_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_1.position).x, (manager.ui.mainCamera.transform.position - var_113_1.position).y, (manager.ui.mainCamera.transform.position - var_113_1.position).z)
				var_113_1.localEulerAngles.z = 0
				var_113_1.localEulerAngles.x = 0
				var_113_1.localEulerAngles = var_113_1.localEulerAngles

				local var_113_4 = GameObjectTools.GetOrAddComponent(var_113_1.gameObject, typeof(DynamicBoneHelper))

				if var_113_4 then
					var_113_4:EnableDynamicBone(true)
				end
			end

			local var_113_5 = arg_110_1.actors_["1077ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect1077ui_story == nil then
				arg_110_1.var_.characterEffect1077ui_story = var_113_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_6 and not isNil(var_113_5) then
				if arg_110_1.var_.characterEffect1077ui_story and not isNil(var_113_5) then
					arg_110_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_6 and arg_110_1.time_ < 0 + var_113_6 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect1077ui_story then
				arg_110_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_113_8 = arg_110_1.actors_["1073ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.characterEffect1073ui_story == nil then
				arg_110_1.var_.characterEffect1073ui_story = var_113_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_9 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_9 and not isNil(var_113_8) then
				if arg_110_1.var_.characterEffect1073ui_story and not isNil(var_113_8) then
					arg_110_1.var_.characterEffect1073ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1073ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_9)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_9 and arg_110_1.time_ < 0 + var_113_9 + arg_113_0 and not isNil(var_113_8) and arg_110_1.var_.characterEffect1073ui_story then
				arg_110_1.var_.characterEffect1073ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1073ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_113_10 = 0
			local var_113_11 = 1.025

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_12 = arg_110_1:GetWordFromCfg(325061027)
				local var_113_13 = arg_110_1:FormatText(var_113_12.content)

				arg_110_1.text_.text = var_113_13

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_15 = 41 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 41)

				if (41 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 41)) > 0 and var_113_11 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_10
					end
				end

				arg_110_1.text_.text = var_113_13
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061027", "story_v_out_325061.awb") ~= 0 then
					local var_113_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061027", "story_v_out_325061.awb") / 1000

					if var_113_16 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_16 + var_113_10
					end

					if var_113_12.prefab_name ~= "" and arg_110_1.actors_[var_113_12.prefab_name] ~= nil then
						local var_113_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_12.prefab_name].transform, "story_v_out_325061", "325061027", "story_v_out_325061.awb")

						arg_110_1:RecordAudio("325061027", var_113_17)
						arg_110_1:RecordAudio("325061027", var_113_17)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325061", "325061027", "story_v_out_325061.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325061", "325061027", "story_v_out_325061.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_18 = math.max(var_113_11, arg_110_1.talkMaxDuration)

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_10) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_10 + var_113_18 and arg_110_1.time_ < var_113_10 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1073ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play325061028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325061028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325061029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1077ui_story = arg_114_1.actors_["1077ui_story"].transform.localPosition

				local var_117_0 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_0 then
					var_117_0:EnableDynamicBone(false)
				end
			end

			local var_117_1 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_1 then
				arg_114_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_1)
				arg_114_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1077ui_story"].transform.position).z)
				arg_114_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1077ui_story"].transform.localEulerAngles = arg_114_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_1 and arg_114_1.time_ < 0 + var_117_1 + arg_117_0 then
				arg_114_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1077ui_story"].transform.position).z)
				arg_114_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1077ui_story"].transform.localEulerAngles = arg_114_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_117_2 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(true)
				end
			end

			local var_117_3 = arg_114_1.actors_["1061ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1061ui_story = var_117_3.localPosition
			end

			local var_117_4 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				var_117_3.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_4)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_3.localPosition = Vector3.New(0, 100, 0)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			local var_117_5 = arg_114_1.actors_["1077ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1077ui_story == nil then
				arg_114_1.var_.characterEffect1077ui_story = var_117_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 and not isNil(var_117_5) then
				if arg_114_1.var_.characterEffect1077ui_story and not isNil(var_117_5) then
					arg_114_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_6)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1077ui_story then
				arg_114_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_117_7 = 0
			local var_117_8 = 1.025

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

				local var_117_9 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(325061028).content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_11 = 41 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 41)

				if (41 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 41)) > 0 and var_117_8 < var_117_11 then
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

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play325061029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325061029
		arg_118_1.duration_ = 8.53

		local var_118_0 = {
			zh = 5.9,
			ja = 8.533
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325061030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if arg_118_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_121_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_118_1.stage_.transform)

				var_121_0.name = "1075ui_story"
				var_121_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_["1075ui_story"] = var_121_0

				local var_121_1 = var_121_0:GetComponentInChildren(typeof(CharacterEffect))

				var_121_1.enabled = true

				local var_121_2 = GameObjectTools.GetOrAddComponent(var_121_0, typeof(DynamicBoneHelper))

				if var_121_2 then
					var_121_2:EnableDynamicBone(false)
				end

				arg_118_1:ShowWeapon(var_121_1.transform, false)

				arg_118_1.var_["1075ui_story" .. "Animator"] = var_121_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_118_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_118_1.var_["1075ui_story" .. "LipSync"] = var_121_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_121_3 = arg_118_1.actors_["1075ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1075ui_story = var_121_3.localPosition
			end

			local var_121_4 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				var_121_3.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_118_1.time_ - 0) / var_121_4)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				var_121_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			local var_121_5 = arg_118_1.actors_["1075ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect1075ui_story == nil then
				arg_118_1.var_.characterEffect1075ui_story = var_121_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_6 and not isNil(var_121_5) then
				if arg_118_1.var_.characterEffect1075ui_story and not isNil(var_121_5) then
					arg_118_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_6 and arg_118_1.time_ < 0 + var_121_6 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect1075ui_story then
				arg_118_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_121_8 = 0
			local var_121_9 = 0.6

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_10 = arg_118_1:GetWordFromCfg(325061029)
				local var_121_11 = arg_118_1:FormatText(var_121_10.content)

				arg_118_1.text_.text = var_121_11

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 24 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 24)

				if (24 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 24)) > 0 and var_121_9 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_11
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061029", "story_v_out_325061.awb") ~= 0 then
					local var_121_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061029", "story_v_out_325061.awb") / 1000

					if var_121_14 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_8
					end

					if var_121_10.prefab_name ~= "" and arg_118_1.actors_[var_121_10.prefab_name] ~= nil then
						local var_121_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_10.prefab_name].transform, "story_v_out_325061", "325061029", "story_v_out_325061.awb")

						arg_118_1:RecordAudio("325061029", var_121_15)
						arg_118_1:RecordAudio("325061029", var_121_15)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325061", "325061029", "story_v_out_325061.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325061", "325061029", "story_v_out_325061.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_16 and arg_118_1.time_ < var_121_8 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play325061030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325061030
		arg_122_1.duration_ = 6.63

		local var_122_0 = {
			zh = 6.433,
			ja = 6.633
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325061031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1075ui_story = arg_122_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1075ui_story"].transform.position).z)
				arg_122_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1075ui_story"].transform.localEulerAngles = arg_122_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_122_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1075ui_story"].transform.position).z)
				arg_122_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1075ui_story"].transform.localEulerAngles = arg_122_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["1061ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1061ui_story = var_125_1.localPosition
			end

			local var_125_2 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 then
				var_125_1.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_122_1.time_ - 0) / var_125_2)
				var_125_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_1.position).x, (manager.ui.mainCamera.transform.position - var_125_1.position).y, (manager.ui.mainCamera.transform.position - var_125_1.position).z)
				var_125_1.localEulerAngles.z = 0
				var_125_1.localEulerAngles.x = 0
				var_125_1.localEulerAngles = var_125_1.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 then
				var_125_1.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_125_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_1.position).x, (manager.ui.mainCamera.transform.position - var_125_1.position).y, (manager.ui.mainCamera.transform.position - var_125_1.position).z)
				var_125_1.localEulerAngles.z = 0
				var_125_1.localEulerAngles.x = 0
				var_125_1.localEulerAngles = var_125_1.localEulerAngles
			end

			local var_125_3 = arg_122_1.actors_["1061ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect1061ui_story == nil then
				arg_122_1.var_.characterEffect1061ui_story = var_125_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_4 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 and not isNil(var_125_3) then
				if arg_122_1.var_.characterEffect1061ui_story and not isNil(var_125_3) then
					arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect1061ui_story then
				arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_125_6 = arg_122_1.actors_["1075ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1075ui_story == nil then
				arg_122_1.var_.characterEffect1075ui_story = var_125_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_7 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 and not isNil(var_125_6) then
				if arg_122_1.var_.characterEffect1075ui_story and not isNil(var_125_6) then
					arg_122_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_7)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1075ui_story then
				arg_122_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_125_8 = 0
			local var_125_9 = 0.575

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:GetWordFromCfg(325061030)
				local var_125_11 = arg_122_1:FormatText(var_125_10.content)

				arg_122_1.text_.text = var_125_11

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 23 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 23)

				if (23 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 23)) > 0 and var_125_9 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_11
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061030", "story_v_out_325061.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061030", "story_v_out_325061.awb") / 1000

					if var_125_14 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_8
					end

					if var_125_10.prefab_name ~= "" and arg_122_1.actors_[var_125_10.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_10.prefab_name].transform, "story_v_out_325061", "325061030", "story_v_out_325061.awb")

						arg_122_1:RecordAudio("325061030", var_125_15)
						arg_122_1:RecordAudio("325061030", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325061", "325061030", "story_v_out_325061.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325061", "325061030", "story_v_out_325061.awb")
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
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play325061031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325061031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325061032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1061ui_story = arg_126_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["1075ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1075ui_story = var_129_1.localPosition
			end

			local var_129_2 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 then
				var_129_1.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_2)
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

			local var_129_3 = arg_126_1.actors_["1061ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_4 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 and not isNil(var_129_3) then
				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_3) then
					arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_4)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 and not isNil(var_129_3) and arg_126_1.var_.characterEffect1061ui_story then
				arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_129_5 = 0
			local var_129_6 = 1.175

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_7 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(325061031).content)

				arg_126_1.text_.text = var_129_7

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_9 = 47 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_7) / 47)

				if (47 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_7) / 47)) > 0 and var_129_6 < var_129_9 then
					arg_126_1.talkMaxDuration = var_129_9

					if var_129_9 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_9 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_7
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_5) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_5 + var_129_10 and arg_126_1.time_ < var_129_5 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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

		arg_126_1:InitPlayNodeList()
	end,
	Play325061032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325061032
		arg_130_1.duration_ = 7.3

		local var_130_0 = {
			zh = 6.4,
			ja = 7.3
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
				arg_130_0:Play325061033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1075ui_story = arg_130_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1075ui_story"].transform.position).z)
				arg_130_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1075ui_story"].transform.localEulerAngles = arg_130_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_130_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1075ui_story"].transform.position).z)
				arg_130_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1075ui_story"].transform.localEulerAngles = arg_130_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1075ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1075ui_story == nil then
				arg_130_1.var_.characterEffect1075ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect1075ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1075ui_story then
				arg_130_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_133_4 = 0
			local var_133_5 = 0.8

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_6 = arg_130_1:GetWordFromCfg(325061032)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 32 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 32)

				if (32 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 32)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061032", "story_v_out_325061.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061032", "story_v_out_325061.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_out_325061", "325061032", "story_v_out_325061.awb")

						arg_130_1:RecordAudio("325061032", var_133_11)
						arg_130_1:RecordAudio("325061032", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_325061", "325061032", "story_v_out_325061.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_325061", "325061032", "story_v_out_325061.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play325061033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325061033
		arg_134_1.duration_ = 10.4

		local var_134_0 = {
			zh = 7.233,
			ja = 10.4
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
				arg_134_0:Play325061034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.825

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:GetWordFromCfg(325061033)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 33 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 33)

				if (33 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 33)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061033", "story_v_out_325061.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061033", "story_v_out_325061.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_325061", "325061033", "story_v_out_325061.awb")

						arg_134_1:RecordAudio("325061033", var_137_6)
						arg_134_1:RecordAudio("325061033", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325061", "325061033", "story_v_out_325061.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325061", "325061033", "story_v_out_325061.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325061034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325061034
		arg_138_1.duration_ = 4.9

		local var_138_0 = {
			zh = 2.5,
			ja = 4.9
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
				arg_138_0:Play325061035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1075ui_story = arg_138_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).z)
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles = arg_138_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_138_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).z)
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles = arg_138_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1077ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1077ui_story = var_141_1.localPosition

				local var_141_2 = GameObjectTools.GetOrAddComponent(var_141_1.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(false)
				end
			end

			local var_141_3 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 then
				var_141_1.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_138_1.time_ - 0) / var_141_3)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 then
				var_141_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_141_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_1.position).x, (manager.ui.mainCamera.transform.position - var_141_1.position).y, (manager.ui.mainCamera.transform.position - var_141_1.position).z)
				var_141_1.localEulerAngles.z = 0
				var_141_1.localEulerAngles.x = 0
				var_141_1.localEulerAngles = var_141_1.localEulerAngles

				local var_141_4 = GameObjectTools.GetOrAddComponent(var_141_1.gameObject, typeof(DynamicBoneHelper))

				if var_141_4 then
					var_141_4:EnableDynamicBone(true)
				end
			end

			local var_141_5 = arg_138_1.actors_["1077ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_5) and arg_138_1.var_.characterEffect1077ui_story == nil then
				arg_138_1.var_.characterEffect1077ui_story = var_141_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_6 and not isNil(var_141_5) then
				if arg_138_1.var_.characterEffect1077ui_story and not isNil(var_141_5) then
					arg_138_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_6 and arg_138_1.time_ < 0 + var_141_6 + arg_141_0 and not isNil(var_141_5) and arg_138_1.var_.characterEffect1077ui_story then
				arg_138_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_141_8 = arg_138_1.actors_["1075ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.characterEffect1075ui_story == nil then
				arg_138_1.var_.characterEffect1075ui_story = var_141_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_9 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_9 and not isNil(var_141_8) then
				if arg_138_1.var_.characterEffect1075ui_story and not isNil(var_141_8) then
					arg_138_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_9)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_9 and arg_138_1.time_ < 0 + var_141_9 + arg_141_0 and not isNil(var_141_8) and arg_138_1.var_.characterEffect1075ui_story then
				arg_138_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_2")
			end

			local var_141_10 = 0
			local var_141_11 = 0.35

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_12 = arg_138_1:GetWordFromCfg(325061034)
				local var_141_13 = arg_138_1:FormatText(var_141_12.content)

				arg_138_1.text_.text = var_141_13

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_15 = 14 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_13) / 14)

				if (14 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_13) / 14)) > 0 and var_141_11 < var_141_15 then
					arg_138_1.talkMaxDuration = var_141_15

					if var_141_15 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_15 + var_141_10
					end
				end

				arg_138_1.text_.text = var_141_13
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061034", "story_v_out_325061.awb") ~= 0 then
					local var_141_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061034", "story_v_out_325061.awb") / 1000

					if var_141_16 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_10
					end

					if var_141_12.prefab_name ~= "" and arg_138_1.actors_[var_141_12.prefab_name] ~= nil then
						local var_141_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_12.prefab_name].transform, "story_v_out_325061", "325061034", "story_v_out_325061.awb")

						arg_138_1:RecordAudio("325061034", var_141_17)
						arg_138_1:RecordAudio("325061034", var_141_17)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325061", "325061034", "story_v_out_325061.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325061", "325061034", "story_v_out_325061.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_18 = math.max(var_141_11, arg_138_1.talkMaxDuration)

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_18 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_10) / var_141_18

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_10 + var_141_18 and arg_138_1.time_ < var_141_10 + var_141_18 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play325061035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325061035
		arg_142_1.duration_ = 2.4

		local var_142_0 = {
			zh = 2.4,
			ja = 2.2
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325061036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1075ui_story"]) and arg_142_1.var_.characterEffect1075ui_story == nil then
				arg_142_1.var_.characterEffect1075ui_story = arg_142_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1075ui_story"]) then
				if arg_142_1.var_.characterEffect1075ui_story and not isNil(arg_142_1.actors_["1075ui_story"]) then
					arg_142_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1075ui_story"]) and arg_142_1.var_.characterEffect1075ui_story then
				arg_142_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_145_2 = arg_142_1.actors_["1077ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1077ui_story == nil then
				arg_142_1.var_.characterEffect1077ui_story = var_145_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_3 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.characterEffect1077ui_story and not isNil(var_145_2) then
					arg_142_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_3)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1077ui_story then
				arg_142_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_145_4 = 0
			local var_145_5 = 0.075

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(325061035)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 3 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 3)

				if (3 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 3)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061035", "story_v_out_325061.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061035", "story_v_out_325061.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_325061", "325061035", "story_v_out_325061.awb")

						arg_142_1:RecordAudio("325061035", var_145_11)
						arg_142_1:RecordAudio("325061035", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325061", "325061035", "story_v_out_325061.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325061", "325061035", "story_v_out_325061.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play325061036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325061036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325061037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1075ui_story"]) and arg_146_1.var_.characterEffect1075ui_story == nil then
				arg_146_1.var_.characterEffect1075ui_story = arg_146_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1075ui_story"]) then
				if arg_146_1.var_.characterEffect1075ui_story and not isNil(arg_146_1.actors_["1075ui_story"]) then
					arg_146_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_0)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1075ui_story"]) and arg_146_1.var_.characterEffect1075ui_story then
				arg_146_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_149_1 = 0
			local var_149_2 = 0.65

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(325061036).content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 26 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 26)

				if (26 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 26)) > 0 and var_149_2 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_6 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_6 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_6

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_6 and arg_146_1.time_ < var_149_1 + var_149_6 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play325061037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325061037
		arg_150_1.duration_ = 8.67

		local var_150_0 = {
			zh = 4.933,
			ja = 8.666
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
				arg_150_0:Play325061038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1075ui_story"]) and arg_150_1.var_.characterEffect1075ui_story == nil then
				arg_150_1.var_.characterEffect1075ui_story = arg_150_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1075ui_story"]) then
				if arg_150_1.var_.characterEffect1075ui_story and not isNil(arg_150_1.actors_["1075ui_story"]) then
					arg_150_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1075ui_story"]) and arg_150_1.var_.characterEffect1075ui_story then
				arg_150_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_153_2 = 0
			local var_153_3 = 0.55

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_2 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_4 = arg_150_1:GetWordFromCfg(325061037)
				local var_153_5 = arg_150_1:FormatText(var_153_4.content)

				arg_150_1.text_.text = var_153_5

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_7 = 22 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_5) / 22)

				if (22 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_5) / 22)) > 0 and var_153_3 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_2 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_2
					end
				end

				arg_150_1.text_.text = var_153_5
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061037", "story_v_out_325061.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_325061", "325061037", "story_v_out_325061.awb") / 1000

					if var_153_8 + var_153_2 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_2
					end

					if var_153_4.prefab_name ~= "" and arg_150_1.actors_[var_153_4.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_4.prefab_name].transform, "story_v_out_325061", "325061037", "story_v_out_325061.awb")

						arg_150_1:RecordAudio("325061037", var_153_9)
						arg_150_1:RecordAudio("325061037", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325061", "325061037", "story_v_out_325061.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325061", "325061037", "story_v_out_325061.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_3, arg_150_1.talkMaxDuration)

			if var_153_2 <= arg_150_1.time_ and arg_150_1.time_ < var_153_2 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_2) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_2 + var_153_10 and arg_150_1.time_ < var_153_2 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play325061038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325061038
		arg_154_1.duration_ = 13.17

		local var_154_0 = {
			zh = 8.4,
			ja = 13.166
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
				arg_154_0:Play325061039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1061ui_story"]) and arg_154_1.var_.characterEffect1061ui_story == nil then
				arg_154_1.var_.characterEffect1061ui_story = arg_154_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1061ui_story"]) then
				if arg_154_1.var_.characterEffect1061ui_story and not isNil(arg_154_1.actors_["1061ui_story"]) then
					arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1061ui_story"]) and arg_154_1.var_.characterEffect1061ui_story then
				arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_157_2 = arg_154_1.actors_["1075ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1075ui_story == nil then
				arg_154_1.var_.characterEffect1075ui_story = var_157_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_3 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.characterEffect1075ui_story and not isNil(var_157_2) then
					arg_154_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_3)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1075ui_story then
				arg_154_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_157_4 = arg_154_1.actors_["1061ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1061ui_story = var_157_4.localPosition
			end

			local var_157_5 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_5 then
				var_157_4.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_154_1.time_ - 0) / var_157_5)
				var_157_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_4.position).x, (manager.ui.mainCamera.transform.position - var_157_4.position).y, (manager.ui.mainCamera.transform.position - var_157_4.position).z)
				var_157_4.localEulerAngles.z = 0
				var_157_4.localEulerAngles.x = 0
				var_157_4.localEulerAngles = var_157_4.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_5 and arg_154_1.time_ < 0 + var_157_5 + arg_157_0 then
				var_157_4.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				var_157_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_4.position).x, (manager.ui.mainCamera.transform.position - var_157_4.position).y, (manager.ui.mainCamera.transform.position - var_157_4.position).z)
				var_157_4.localEulerAngles.z = 0
				var_157_4.localEulerAngles.x = 0
				var_157_4.localEulerAngles = var_157_4.localEulerAngles
			end

			local var_157_6 = arg_154_1.actors_["1075ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1075ui_story = var_157_6.localPosition
			end

			local var_157_7 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				var_157_6.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_7)
				var_157_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_6.position).x, (manager.ui.mainCamera.transform.position - var_157_6.position).y, (manager.ui.mainCamera.transform.position - var_157_6.position).z)
				var_157_6.localEulerAngles.z = 0
				var_157_6.localEulerAngles.x = 0
				var_157_6.localEulerAngles = var_157_6.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				var_157_6.localPosition = Vector3.New(0, 100, 0)
				var_157_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_6.position).x, (manager.ui.mainCamera.transform.position - var_157_6.position).y, (manager.ui.mainCamera.transform.position - var_157_6.position).z)
				var_157_6.localEulerAngles.z = 0
				var_157_6.localEulerAngles.x = 0
				var_157_6.localEulerAngles = var_157_6.localEulerAngles
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_157_8 = 0
			local var_157_9 = 0.825

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_8 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_10 = arg_154_1:GetWordFromCfg(325061038)
				local var_157_11 = arg_154_1:FormatText(var_157_10.content)

				arg_154_1.text_.text = var_157_11

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_13 = 33 <= 0 and var_157_9 or var_157_9 * (utf8.len(var_157_11) / 33)

				if (33 <= 0 and var_157_9 or var_157_9 * (utf8.len(var_157_11) / 33)) > 0 and var_157_9 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_8 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_8
					end
				end

				arg_154_1.text_.text = var_157_11
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061038", "story_v_out_325061.awb") ~= 0 then
					local var_157_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061038", "story_v_out_325061.awb") / 1000

					if var_157_14 + var_157_8 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_8
					end

					if var_157_10.prefab_name ~= "" and arg_154_1.actors_[var_157_10.prefab_name] ~= nil then
						local var_157_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_10.prefab_name].transform, "story_v_out_325061", "325061038", "story_v_out_325061.awb")

						arg_154_1:RecordAudio("325061038", var_157_15)
						arg_154_1:RecordAudio("325061038", var_157_15)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325061", "325061038", "story_v_out_325061.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325061", "325061038", "story_v_out_325061.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_16 = math.max(var_157_9, arg_154_1.talkMaxDuration)

			if var_157_8 <= arg_154_1.time_ and arg_154_1.time_ < var_157_8 + var_157_16 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_8) / var_157_16

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_8 + var_157_16 and arg_154_1.time_ < var_157_8 + var_157_16 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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

		arg_154_1:InitPlayNodeList()
	end,
	Play325061039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325061039
		arg_158_1.duration_ = 9.33

		local var_158_0 = {
			zh = 7.666,
			ja = 9.333
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play325061040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1077ui_story"]) and arg_158_1.var_.characterEffect1077ui_story == nil then
				arg_158_1.var_.characterEffect1077ui_story = arg_158_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1077ui_story"]) then
				if arg_158_1.var_.characterEffect1077ui_story and not isNil(arg_158_1.actors_["1077ui_story"]) then
					arg_158_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1077ui_story"]) and arg_158_1.var_.characterEffect1077ui_story then
				arg_158_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_161_2 = arg_158_1.actors_["1061ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect1061ui_story == nil then
				arg_158_1.var_.characterEffect1061ui_story = var_161_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_3 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 and not isNil(var_161_2) then
				if arg_158_1.var_.characterEffect1061ui_story and not isNil(var_161_2) then
					arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_3)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect1061ui_story then
				arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_161_4 = 0
			local var_161_5 = 0.75

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_4 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_6 = arg_158_1:GetWordFromCfg(325061039)
				local var_161_7 = arg_158_1:FormatText(var_161_6.content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 30 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 30)

				if (30 <= 0 and var_161_5 or var_161_5 * (utf8.len(var_161_7) / 30)) > 0 and var_161_5 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_4
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061039", "story_v_out_325061.awb") ~= 0 then
					local var_161_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061039", "story_v_out_325061.awb") / 1000

					if var_161_10 + var_161_4 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_4
					end

					if var_161_6.prefab_name ~= "" and arg_158_1.actors_[var_161_6.prefab_name] ~= nil then
						local var_161_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_6.prefab_name].transform, "story_v_out_325061", "325061039", "story_v_out_325061.awb")

						arg_158_1:RecordAudio("325061039", var_161_11)
						arg_158_1:RecordAudio("325061039", var_161_11)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325061", "325061039", "story_v_out_325061.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325061", "325061039", "story_v_out_325061.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_12 = math.max(var_161_5, arg_158_1.talkMaxDuration)

			if var_161_4 <= arg_158_1.time_ and arg_158_1.time_ < var_161_4 + var_161_12 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_4) / var_161_12

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_4 + var_161_12 and arg_158_1.time_ < var_161_4 + var_161_12 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play325061040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325061040
		arg_162_1.duration_ = 11.47

		local var_162_0 = {
			zh = 5.266,
			ja = 11.466
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
				arg_162_0:Play325061041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1061ui_story"]) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = arg_162_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1061ui_story"]) then
				if arg_162_1.var_.characterEffect1061ui_story and not isNil(arg_162_1.actors_["1061ui_story"]) then
					arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1061ui_story"]) and arg_162_1.var_.characterEffect1061ui_story then
				arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_165_2 = arg_162_1.actors_["1077ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.characterEffect1077ui_story == nil then
				arg_162_1.var_.characterEffect1077ui_story = var_165_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_3 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_3 and not isNil(var_165_2) then
				if arg_162_1.var_.characterEffect1077ui_story and not isNil(var_165_2) then
					arg_162_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_3)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_3 and arg_162_1.time_ < 0 + var_165_3 + arg_165_0 and not isNil(var_165_2) and arg_162_1.var_.characterEffect1077ui_story then
				arg_162_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_165_4 = 0
			local var_165_5 = 0.7

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(325061040)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 28 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 28)

				if (28 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 28)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061040", "story_v_out_325061.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061040", "story_v_out_325061.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_out_325061", "325061040", "story_v_out_325061.awb")

						arg_162_1:RecordAudio("325061040", var_165_11)
						arg_162_1:RecordAudio("325061040", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_325061", "325061040", "story_v_out_325061.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_325061", "325061040", "story_v_out_325061.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play325061041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325061041
		arg_166_1.duration_ = 4.03

		local var_166_0 = {
			zh = 1.833,
			ja = 4.033
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325061042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1075ui_story"]) and arg_166_1.var_.characterEffect1075ui_story == nil then
				arg_166_1.var_.characterEffect1075ui_story = arg_166_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1075ui_story"]) then
				if arg_166_1.var_.characterEffect1075ui_story and not isNil(arg_166_1.actors_["1075ui_story"]) then
					arg_166_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1075ui_story"]) and arg_166_1.var_.characterEffect1075ui_story then
				arg_166_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_169_2 = arg_166_1.actors_["1061ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.characterEffect1061ui_story == nil then
				arg_166_1.var_.characterEffect1061ui_story = var_169_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_3 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.characterEffect1061ui_story and not isNil(var_169_2) then
					arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_3)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.characterEffect1061ui_story then
				arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_169_4 = 0
			local var_169_5 = 0.175

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(325061041)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 7 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 7)

				if (7 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 7)) > 0 and var_169_5 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061041", "story_v_out_325061.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061041", "story_v_out_325061.awb") / 1000

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end

					if var_169_6.prefab_name ~= "" and arg_166_1.actors_[var_169_6.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_6.prefab_name].transform, "story_v_out_325061", "325061041", "story_v_out_325061.awb")

						arg_166_1:RecordAudio("325061041", var_169_11)
						arg_166_1:RecordAudio("325061041", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_325061", "325061041", "story_v_out_325061.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_325061", "325061041", "story_v_out_325061.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_12 and arg_166_1.time_ < var_169_4 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play325061042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 325061042
		arg_170_1.duration_ = 9.7

		local var_170_0 = {
			zh = 7.2,
			ja = 9.7
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play325061043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1077ui_story"]) and arg_170_1.var_.characterEffect1077ui_story == nil then
				arg_170_1.var_.characterEffect1077ui_story = arg_170_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1077ui_story"]) then
				if arg_170_1.var_.characterEffect1077ui_story and not isNil(arg_170_1.actors_["1077ui_story"]) then
					arg_170_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1077ui_story"]) and arg_170_1.var_.characterEffect1077ui_story then
				arg_170_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_173_2 = arg_170_1.actors_["1075ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1075ui_story == nil then
				arg_170_1.var_.characterEffect1075ui_story = var_173_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_3 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 and not isNil(var_173_2) then
				if arg_170_1.var_.characterEffect1075ui_story and not isNil(var_173_2) then
					arg_170_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_3)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 and not isNil(var_173_2) and arg_170_1.var_.characterEffect1075ui_story then
				arg_170_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_173_4 = 0
			local var_173_5 = 0.675

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_6 = arg_170_1:GetWordFromCfg(325061042)
				local var_173_7 = arg_170_1:FormatText(var_173_6.content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 27 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 27)

				if (27 <= 0 and var_173_5 or var_173_5 * (utf8.len(var_173_7) / 27)) > 0 and var_173_5 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061042", "story_v_out_325061.awb") ~= 0 then
					local var_173_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061042", "story_v_out_325061.awb") / 1000

					if var_173_10 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_4
					end

					if var_173_6.prefab_name ~= "" and arg_170_1.actors_[var_173_6.prefab_name] ~= nil then
						local var_173_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_6.prefab_name].transform, "story_v_out_325061", "325061042", "story_v_out_325061.awb")

						arg_170_1:RecordAudio("325061042", var_173_11)
						arg_170_1:RecordAudio("325061042", var_173_11)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_325061", "325061042", "story_v_out_325061.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_325061", "325061042", "story_v_out_325061.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_12 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_12 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_12

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_12 and arg_170_1.time_ < var_173_4 + var_173_12 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play325061043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 325061043
		arg_174_1.duration_ = 9.47

		local var_174_0 = {
			zh = 6.633,
			ja = 9.466
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play325061044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1075ui_story"]) and arg_174_1.var_.characterEffect1075ui_story == nil then
				arg_174_1.var_.characterEffect1075ui_story = arg_174_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1075ui_story"]) then
				if arg_174_1.var_.characterEffect1075ui_story and not isNil(arg_174_1.actors_["1075ui_story"]) then
					arg_174_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1075ui_story"]) and arg_174_1.var_.characterEffect1075ui_story then
				arg_174_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_177_2 = arg_174_1.actors_["1077ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect1077ui_story == nil then
				arg_174_1.var_.characterEffect1077ui_story = var_177_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_3 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.characterEffect1077ui_story and not isNil(var_177_2) then
					arg_174_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_3)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.characterEffect1077ui_story then
				arg_174_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action424")
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_177_4 = arg_174_1.actors_["1061ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1061ui_story = var_177_4.localPosition
			end

			local var_177_5 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_5 then
				var_177_4.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_5)
				var_177_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_4.position).x, (manager.ui.mainCamera.transform.position - var_177_4.position).y, (manager.ui.mainCamera.transform.position - var_177_4.position).z)
				var_177_4.localEulerAngles.z = 0
				var_177_4.localEulerAngles.x = 0
				var_177_4.localEulerAngles = var_177_4.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_5 and arg_174_1.time_ < 0 + var_177_5 + arg_177_0 then
				var_177_4.localPosition = Vector3.New(0, 100, 0)
				var_177_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_4.position).x, (manager.ui.mainCamera.transform.position - var_177_4.position).y, (manager.ui.mainCamera.transform.position - var_177_4.position).z)
				var_177_4.localEulerAngles.z = 0
				var_177_4.localEulerAngles.x = 0
				var_177_4.localEulerAngles = var_177_4.localEulerAngles
			end

			local var_177_6 = arg_174_1.actors_["1075ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1075ui_story = var_177_6.localPosition
			end

			local var_177_7 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				var_177_6.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_174_1.time_ - 0) / var_177_7)
				var_177_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_6.position).x, (manager.ui.mainCamera.transform.position - var_177_6.position).y, (manager.ui.mainCamera.transform.position - var_177_6.position).z)
				var_177_6.localEulerAngles.z = 0
				var_177_6.localEulerAngles.x = 0
				var_177_6.localEulerAngles = var_177_6.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				var_177_6.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_177_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_6.position).x, (manager.ui.mainCamera.transform.position - var_177_6.position).y, (manager.ui.mainCamera.transform.position - var_177_6.position).z)
				var_177_6.localEulerAngles.z = 0
				var_177_6.localEulerAngles.x = 0
				var_177_6.localEulerAngles = var_177_6.localEulerAngles
			end

			local var_177_8 = 0
			local var_177_9 = 0.6

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_10 = arg_174_1:GetWordFromCfg(325061043)
				local var_177_11 = arg_174_1:FormatText(var_177_10.content)

				arg_174_1.text_.text = var_177_11

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_13 = 24 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 24)

				if (24 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_11) / 24)) > 0 and var_177_9 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_11
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061043", "story_v_out_325061.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061043", "story_v_out_325061.awb") / 1000

					if var_177_14 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_8
					end

					if var_177_10.prefab_name ~= "" and arg_174_1.actors_[var_177_10.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_10.prefab_name].transform, "story_v_out_325061", "325061043", "story_v_out_325061.awb")

						arg_174_1:RecordAudio("325061043", var_177_15)
						arg_174_1:RecordAudio("325061043", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_325061", "325061043", "story_v_out_325061.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_325061", "325061043", "story_v_out_325061.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_16 and arg_174_1.time_ < var_177_8 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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

		arg_174_1:InitPlayNodeList()
	end,
	Play325061044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 325061044
		arg_178_1.duration_ = 10.33

		local var_178_0 = {
			zh = 8.866,
			ja = 10.333
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play325061045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1077ui_story"]) and arg_178_1.var_.characterEffect1077ui_story == nil then
				arg_178_1.var_.characterEffect1077ui_story = arg_178_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1077ui_story"]) then
				if arg_178_1.var_.characterEffect1077ui_story and not isNil(arg_178_1.actors_["1077ui_story"]) then
					arg_178_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1077ui_story"]) and arg_178_1.var_.characterEffect1077ui_story then
				arg_178_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_181_2 = arg_178_1.actors_["1075ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.characterEffect1075ui_story == nil then
				arg_178_1.var_.characterEffect1075ui_story = var_181_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_3 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 and not isNil(var_181_2) then
				if arg_178_1.var_.characterEffect1075ui_story and not isNil(var_181_2) then
					arg_178_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_3)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.characterEffect1075ui_story then
				arg_178_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action5_2")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_181_4 = 0
			local var_181_5 = 0.925

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(325061044)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 37 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 37)

				if (37 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 37)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061044", "story_v_out_325061.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061044", "story_v_out_325061.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_out_325061", "325061044", "story_v_out_325061.awb")

						arg_178_1:RecordAudio("325061044", var_181_11)
						arg_178_1:RecordAudio("325061044", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_325061", "325061044", "story_v_out_325061.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_325061", "325061044", "story_v_out_325061.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play325061045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 325061045
		arg_182_1.duration_ = 8.67

		local var_182_0 = {
			zh = 8.666,
			ja = 7.6
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play325061046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.95

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(325061045)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 38 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 38)

				if (38 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 38)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061045", "story_v_out_325061.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061045", "story_v_out_325061.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_325061", "325061045", "story_v_out_325061.awb")

						arg_182_1:RecordAudio("325061045", var_185_6)
						arg_182_1:RecordAudio("325061045", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_325061", "325061045", "story_v_out_325061.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_325061", "325061045", "story_v_out_325061.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play325061046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 325061046
		arg_186_1.duration_ = 5.4

		local var_186_0 = {
			zh = 3.433,
			ja = 5.4
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play325061047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1075ui_story"]) and arg_186_1.var_.characterEffect1075ui_story == nil then
				arg_186_1.var_.characterEffect1075ui_story = arg_186_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_0 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1075ui_story"]) then
				if arg_186_1.var_.characterEffect1075ui_story and not isNil(arg_186_1.actors_["1075ui_story"]) then
					arg_186_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1075ui_story"]) and arg_186_1.var_.characterEffect1075ui_story then
				arg_186_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_189_2 = arg_186_1.actors_["1077ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.characterEffect1077ui_story == nil then
				arg_186_1.var_.characterEffect1077ui_story = var_189_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_3 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 and not isNil(var_189_2) then
				if arg_186_1.var_.characterEffect1077ui_story and not isNil(var_189_2) then
					arg_186_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_3)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.characterEffect1077ui_story then
				arg_186_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_189_4 = 0
			local var_189_5 = 0.4

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(325061046)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 16 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 16)

				if (16 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 16)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061046", "story_v_out_325061.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061046", "story_v_out_325061.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_out_325061", "325061046", "story_v_out_325061.awb")

						arg_186_1:RecordAudio("325061046", var_189_11)
						arg_186_1:RecordAudio("325061046", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_325061", "325061046", "story_v_out_325061.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_325061", "325061046", "story_v_out_325061.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play325061047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 325061047
		arg_190_1.duration_ = 11.37

		local var_190_0 = {
			zh = 8.4,
			ja = 11.366
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play325061048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_0 = 0
			local var_193_1 = 0.875

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(325061047)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 35 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 35)

				if (35 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 35)) > 0 and var_193_1 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061047", "story_v_out_325061.awb") ~= 0 then
					local var_193_6 = manager.audio:GetVoiceLength("story_v_out_325061", "325061047", "story_v_out_325061.awb") / 1000

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end

					if var_193_2.prefab_name ~= "" and arg_190_1.actors_[var_193_2.prefab_name] ~= nil then
						local var_193_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_2.prefab_name].transform, "story_v_out_325061", "325061047", "story_v_out_325061.awb")

						arg_190_1:RecordAudio("325061047", var_193_7)
						arg_190_1:RecordAudio("325061047", var_193_7)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_325061", "325061047", "story_v_out_325061.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_325061", "325061047", "story_v_out_325061.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play325061048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 325061048
		arg_194_1.duration_ = 4.4

		local var_194_0 = {
			zh = 2.9,
			ja = 4.4
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play325061049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1077ui_story"]) and arg_194_1.var_.characterEffect1077ui_story == nil then
				arg_194_1.var_.characterEffect1077ui_story = arg_194_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1077ui_story"]) then
				if arg_194_1.var_.characterEffect1077ui_story and not isNil(arg_194_1.actors_["1077ui_story"]) then
					arg_194_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1077ui_story"]) and arg_194_1.var_.characterEffect1077ui_story then
				arg_194_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_197_2 = arg_194_1.actors_["1075ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1075ui_story == nil then
				arg_194_1.var_.characterEffect1075ui_story = var_197_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_3 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.characterEffect1075ui_story and not isNil(var_197_2) then
					arg_194_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_3)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect1075ui_story then
				arg_194_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileB_weixiao", "EmotionTimelineAnimator")
			end

			local var_197_4 = 0
			local var_197_5 = 0.3

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_6 = arg_194_1:GetWordFromCfg(325061048)
				local var_197_7 = arg_194_1:FormatText(var_197_6.content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 12 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 12)

				if (12 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 12)) > 0 and var_197_5 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061048", "story_v_out_325061.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061048", "story_v_out_325061.awb") / 1000

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end

					if var_197_6.prefab_name ~= "" and arg_194_1.actors_[var_197_6.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_6.prefab_name].transform, "story_v_out_325061", "325061048", "story_v_out_325061.awb")

						arg_194_1:RecordAudio("325061048", var_197_11)
						arg_194_1:RecordAudio("325061048", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_325061", "325061048", "story_v_out_325061.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_325061", "325061048", "story_v_out_325061.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_12 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_12 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_4) / var_197_12

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_4 + var_197_12 and arg_194_1.time_ < var_197_4 + var_197_12 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play325061049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325061049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play325061050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1077ui_story = arg_198_1.actors_["1077ui_story"].transform.localPosition

				local var_201_0 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_0 then
					var_201_0:EnableDynamicBone(false)
				end
			end

			local var_201_1 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 then
				arg_198_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_1)
				arg_198_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1077ui_story"].transform.position).z)
				arg_198_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1077ui_story"].transform.localEulerAngles = arg_198_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 then
				arg_198_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1077ui_story"].transform.position).z)
				arg_198_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1077ui_story"].transform.localEulerAngles = arg_198_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_201_2 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_2 then
					var_201_2:EnableDynamicBone(true)
				end
			end

			local var_201_3 = arg_198_1.actors_["1075ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1075ui_story = var_201_3.localPosition
			end

			local var_201_4 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				var_201_3.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_4)
				var_201_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_3.position).x, (manager.ui.mainCamera.transform.position - var_201_3.position).y, (manager.ui.mainCamera.transform.position - var_201_3.position).z)
				var_201_3.localEulerAngles.z = 0
				var_201_3.localEulerAngles.x = 0
				var_201_3.localEulerAngles = var_201_3.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
				var_201_3.localPosition = Vector3.New(0, 100, 0)
				var_201_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_3.position).x, (manager.ui.mainCamera.transform.position - var_201_3.position).y, (manager.ui.mainCamera.transform.position - var_201_3.position).z)
				var_201_3.localEulerAngles.z = 0
				var_201_3.localEulerAngles.x = 0
				var_201_3.localEulerAngles = var_201_3.localEulerAngles
			end

			local var_201_5 = arg_198_1.actors_["1077ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_5) and arg_198_1.var_.characterEffect1077ui_story == nil then
				arg_198_1.var_.characterEffect1077ui_story = var_201_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_6 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_6 and not isNil(var_201_5) then
				if arg_198_1.var_.characterEffect1077ui_story and not isNil(var_201_5) then
					arg_198_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_6)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_6 and arg_198_1.time_ < 0 + var_201_6 + arg_201_0 and not isNil(var_201_5) and arg_198_1.var_.characterEffect1077ui_story then
				arg_198_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_198_1.time_ and arg_198_1.time_ <= 0.1 + arg_201_0 then
				arg_198_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hug", "")
			end

			local var_201_8 = 0
			local var_201_9 = 0.875

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(325061049).content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_12 = 35 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_10) / 35)

				if (35 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_10) / 35)) > 0 and var_201_9 < var_201_12 then
					arg_198_1.talkMaxDuration = var_201_12

					if var_201_12 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_12 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_13 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_13 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_13

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_13 and arg_198_1.time_ < var_201_8 + var_201_13 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_198_1:InitPlayNodeList()
	end,
	Play325061050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325061050
		arg_202_1.duration_ = 6.87

		local var_202_0 = {
			zh = 3.933,
			ja = 6.866
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325061051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1075ui_story = arg_202_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1075ui_story"].transform.position).z)
				arg_202_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1075ui_story"].transform.localEulerAngles = arg_202_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_202_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1075ui_story"].transform.position).z)
				arg_202_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1075ui_story"].transform.localEulerAngles = arg_202_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1075ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1075ui_story == nil then
				arg_202_1.var_.characterEffect1075ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1075ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1075ui_story then
				arg_202_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action6_1")
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_205_4 = 0
			local var_205_5 = 0.45

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(325061050)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 18 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 18)

				if (18 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 18)) > 0 and var_205_5 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061050", "story_v_out_325061.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061050", "story_v_out_325061.awb") / 1000

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_325061", "325061050", "story_v_out_325061.awb")

						arg_202_1:RecordAudio("325061050", var_205_11)
						arg_202_1:RecordAudio("325061050", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_325061", "325061050", "story_v_out_325061.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_325061", "325061050", "story_v_out_325061.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_12 and arg_202_1.time_ < var_205_4 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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

		arg_202_1:InitPlayNodeList()
	end,
	Play325061051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325061051
		arg_206_1.duration_ = 8.5

		local var_206_0 = {
			zh = 6.233,
			ja = 8.5
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325061052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.575

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:GetWordFromCfg(325061051)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 23 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 23)

				if (23 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 23)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061051", "story_v_out_325061.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061051", "story_v_out_325061.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_325061", "325061051", "story_v_out_325061.awb")

						arg_206_1:RecordAudio("325061051", var_209_6)
						arg_206_1:RecordAudio("325061051", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325061", "325061051", "story_v_out_325061.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325061", "325061051", "story_v_out_325061.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play325061052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325061052
		arg_210_1.duration_ = 2.73

		local var_210_0 = {
			zh = 2.6,
			ja = 2.733
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325061053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1075ui_story = arg_210_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1075ui_story"].transform.position).z)
				arg_210_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1075ui_story"].transform.localEulerAngles = arg_210_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_210_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1075ui_story"].transform.position).z)
				arg_210_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1075ui_story"].transform.localEulerAngles = arg_210_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1077ui_story"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1077ui_story = var_213_1.localPosition

				local var_213_2 = GameObjectTools.GetOrAddComponent(var_213_1.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(false)
				end
			end

			local var_213_3 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 then
				var_213_1.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_210_1.time_ - 0) / var_213_3)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 then
				var_213_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_213_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_213_1.position).x, (manager.ui.mainCamera.transform.position - var_213_1.position).y, (manager.ui.mainCamera.transform.position - var_213_1.position).z)
				var_213_1.localEulerAngles.z = 0
				var_213_1.localEulerAngles.x = 0
				var_213_1.localEulerAngles = var_213_1.localEulerAngles

				local var_213_4 = GameObjectTools.GetOrAddComponent(var_213_1.gameObject, typeof(DynamicBoneHelper))

				if var_213_4 then
					var_213_4:EnableDynamicBone(true)
				end
			end

			local var_213_5 = arg_210_1.actors_["1077ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_5) and arg_210_1.var_.characterEffect1077ui_story == nil then
				arg_210_1.var_.characterEffect1077ui_story = var_213_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_6 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_6 and not isNil(var_213_5) then
				if arg_210_1.var_.characterEffect1077ui_story and not isNil(var_213_5) then
					arg_210_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_6 and arg_210_1.time_ < 0 + var_213_6 + arg_213_0 and not isNil(var_213_5) and arg_210_1.var_.characterEffect1077ui_story then
				arg_210_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_213_8 = arg_210_1.actors_["1075ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.characterEffect1075ui_story == nil then
				arg_210_1.var_.characterEffect1075ui_story = var_213_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_9 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_9 and not isNil(var_213_8) then
				if arg_210_1.var_.characterEffect1075ui_story and not isNil(var_213_8) then
					arg_210_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_9)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_9 and arg_210_1.time_ < 0 + var_213_9 + arg_213_0 and not isNil(var_213_8) and arg_210_1.var_.characterEffect1075ui_story then
				arg_210_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_213_10 = 0
			local var_213_11 = 0.2

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_12 = arg_210_1:GetWordFromCfg(325061052)
				local var_213_13 = arg_210_1:FormatText(var_213_12.content)

				arg_210_1.text_.text = var_213_13

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_15 = 8 <= 0 and var_213_11 or var_213_11 * (utf8.len(var_213_13) / 8)

				if (8 <= 0 and var_213_11 or var_213_11 * (utf8.len(var_213_13) / 8)) > 0 and var_213_11 < var_213_15 then
					arg_210_1.talkMaxDuration = var_213_15

					if var_213_15 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_15 + var_213_10
					end
				end

				arg_210_1.text_.text = var_213_13
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061052", "story_v_out_325061.awb") ~= 0 then
					local var_213_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061052", "story_v_out_325061.awb") / 1000

					if var_213_16 + var_213_10 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_16 + var_213_10
					end

					if var_213_12.prefab_name ~= "" and arg_210_1.actors_[var_213_12.prefab_name] ~= nil then
						local var_213_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_12.prefab_name].transform, "story_v_out_325061", "325061052", "story_v_out_325061.awb")

						arg_210_1:RecordAudio("325061052", var_213_17)
						arg_210_1:RecordAudio("325061052", var_213_17)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_325061", "325061052", "story_v_out_325061.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_325061", "325061052", "story_v_out_325061.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_18 = math.max(var_213_11, arg_210_1.talkMaxDuration)

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_18 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_10) / var_213_18

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_10 + var_213_18 and arg_210_1.time_ < var_213_10 + var_213_18 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play325061053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325061053
		arg_214_1.duration_ = 19.17

		local var_214_0 = {
			zh = 9.833,
			ja = 19.166
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325061054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1075ui_story"]) and arg_214_1.var_.characterEffect1075ui_story == nil then
				arg_214_1.var_.characterEffect1075ui_story = arg_214_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1075ui_story"]) then
				if arg_214_1.var_.characterEffect1075ui_story and not isNil(arg_214_1.actors_["1075ui_story"]) then
					arg_214_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1075ui_story"]) and arg_214_1.var_.characterEffect1075ui_story then
				arg_214_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_217_2 = arg_214_1.actors_["1077ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1077ui_story == nil then
				arg_214_1.var_.characterEffect1077ui_story = var_217_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_3 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.characterEffect1077ui_story and not isNil(var_217_2) then
					arg_214_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_3)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1077ui_story then
				arg_214_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action6_2")
			end

			local var_217_4 = 0
			local var_217_5 = 0.95

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(325061053)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 38 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 38)

				if (38 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 38)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061053", "story_v_out_325061.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061053", "story_v_out_325061.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_out_325061", "325061053", "story_v_out_325061.awb")

						arg_214_1:RecordAudio("325061053", var_217_11)
						arg_214_1:RecordAudio("325061053", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325061", "325061053", "story_v_out_325061.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325061", "325061053", "story_v_out_325061.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play325061054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325061054
		arg_218_1.duration_ = 4.93

		local var_218_0 = {
			zh = 3.766,
			ja = 4.933
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325061055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1077ui_story"]) and arg_218_1.var_.characterEffect1077ui_story == nil then
				arg_218_1.var_.characterEffect1077ui_story = arg_218_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1077ui_story"]) then
				if arg_218_1.var_.characterEffect1077ui_story and not isNil(arg_218_1.actors_["1077ui_story"]) then
					arg_218_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1077ui_story"]) and arg_218_1.var_.characterEffect1077ui_story then
				arg_218_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_221_2 = arg_218_1.actors_["1075ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1075ui_story == nil then
				arg_218_1.var_.characterEffect1075ui_story = var_221_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_3 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.characterEffect1075ui_story and not isNil(var_221_2) then
					arg_218_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_3)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1075ui_story then
				arg_218_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_221_4 = 0
			local var_221_5 = 0.375

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(325061054)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 15 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 15)

				if (15 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 15)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061054", "story_v_out_325061.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061054", "story_v_out_325061.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_325061", "325061054", "story_v_out_325061.awb")

						arg_218_1:RecordAudio("325061054", var_221_11)
						arg_218_1:RecordAudio("325061054", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_325061", "325061054", "story_v_out_325061.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_325061", "325061054", "story_v_out_325061.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play325061055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325061055
		arg_222_1.duration_ = 10.73

		local var_222_0 = {
			zh = 8.933,
			ja = 10.733
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325061056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1075ui_story"]) and arg_222_1.var_.characterEffect1075ui_story == nil then
				arg_222_1.var_.characterEffect1075ui_story = arg_222_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1075ui_story"]) then
				if arg_222_1.var_.characterEffect1075ui_story and not isNil(arg_222_1.actors_["1075ui_story"]) then
					arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1075ui_story"]) and arg_222_1.var_.characterEffect1075ui_story then
				arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_225_2 = arg_222_1.actors_["1077ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1077ui_story == nil then
				arg_222_1.var_.characterEffect1077ui_story = var_225_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_3 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.characterEffect1077ui_story and not isNil(var_225_2) then
					arg_222_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_3)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect1077ui_story then
				arg_222_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_225_4 = 0
			local var_225_5 = 0.95

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(325061055)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 38 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 38)

				if (38 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 38)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061055", "story_v_out_325061.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061055", "story_v_out_325061.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_out_325061", "325061055", "story_v_out_325061.awb")

						arg_222_1:RecordAudio("325061055", var_225_11)
						arg_222_1:RecordAudio("325061055", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_325061", "325061055", "story_v_out_325061.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_325061", "325061055", "story_v_out_325061.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play325061056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325061056
		arg_226_1.duration_ = 10.83

		local var_226_0 = {
			zh = 8.133,
			ja = 10.833
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325061057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.9

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:GetWordFromCfg(325061056)
				local var_229_2 = arg_226_1:FormatText(var_229_1.content)

				arg_226_1.text_.text = var_229_2

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 36 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 36)

				if (36 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 36)) > 0 and var_229_0 < var_229_4 then
					arg_226_1.talkMaxDuration = var_229_4

					if var_229_4 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_4 + 0
					end
				end

				arg_226_1.text_.text = var_229_2
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061056", "story_v_out_325061.awb") ~= 0 then
					local var_229_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061056", "story_v_out_325061.awb") / 1000

					if var_229_5 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + 0
					end

					if var_229_1.prefab_name ~= "" and arg_226_1.actors_[var_229_1.prefab_name] ~= nil then
						local var_229_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_1.prefab_name].transform, "story_v_out_325061", "325061056", "story_v_out_325061.awb")

						arg_226_1:RecordAudio("325061056", var_229_6)
						arg_226_1:RecordAudio("325061056", var_229_6)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325061", "325061056", "story_v_out_325061.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325061", "325061056", "story_v_out_325061.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play325061057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325061057
		arg_230_1.duration_ = 11.87

		local var_230_0 = {
			zh = 9.366,
			ja = 11.866
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325061058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1077ui_story"]) and arg_230_1.var_.characterEffect1077ui_story == nil then
				arg_230_1.var_.characterEffect1077ui_story = arg_230_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1077ui_story"]) then
				if arg_230_1.var_.characterEffect1077ui_story and not isNil(arg_230_1.actors_["1077ui_story"]) then
					arg_230_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1077ui_story"]) and arg_230_1.var_.characterEffect1077ui_story then
				arg_230_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_233_2 = arg_230_1.actors_["1075ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.characterEffect1075ui_story == nil then
				arg_230_1.var_.characterEffect1075ui_story = var_233_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_3 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.characterEffect1075ui_story and not isNil(var_233_2) then
					arg_230_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_3)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.characterEffect1075ui_story then
				arg_230_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_233_4 = 0
			local var_233_5 = 1.125

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(325061057)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 45 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 45)

				if (45 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 45)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061057", "story_v_out_325061.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061057", "story_v_out_325061.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_out_325061", "325061057", "story_v_out_325061.awb")

						arg_230_1:RecordAudio("325061057", var_233_11)
						arg_230_1:RecordAudio("325061057", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_325061", "325061057", "story_v_out_325061.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_325061", "325061057", "story_v_out_325061.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_12 and arg_230_1.time_ < var_233_4 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play325061058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325061058
		arg_234_1.duration_ = 11.97

		local var_234_0 = {
			zh = 7.066,
			ja = 11.966
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325061059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_237_0 = 0
			local var_237_1 = 0.775

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_2 = arg_234_1:GetWordFromCfg(325061058)
				local var_237_3 = arg_234_1:FormatText(var_237_2.content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 31 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 31)

				if (31 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 31)) > 0 and var_237_1 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061058", "story_v_out_325061.awb") ~= 0 then
					local var_237_6 = manager.audio:GetVoiceLength("story_v_out_325061", "325061058", "story_v_out_325061.awb") / 1000

					if var_237_6 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_0
					end

					if var_237_2.prefab_name ~= "" and arg_234_1.actors_[var_237_2.prefab_name] ~= nil then
						local var_237_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_2.prefab_name].transform, "story_v_out_325061", "325061058", "story_v_out_325061.awb")

						arg_234_1:RecordAudio("325061058", var_237_7)
						arg_234_1:RecordAudio("325061058", var_237_7)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325061", "325061058", "story_v_out_325061.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325061", "325061058", "story_v_out_325061.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_8 and arg_234_1.time_ < var_237_0 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play325061059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325061059
		arg_238_1.duration_ = 7.6

		local var_238_0 = {
			zh = 6.333,
			ja = 7.6
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
				arg_238_0:Play325061060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0.675

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_1 = arg_238_1:GetWordFromCfg(325061059)
				local var_241_2 = arg_238_1:FormatText(var_241_1.content)

				arg_238_1.text_.text = var_241_2

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_4 = 27 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 27)

				if (27 <= 0 and var_241_0 or var_241_0 * (utf8.len(var_241_2) / 27)) > 0 and var_241_0 < var_241_4 then
					arg_238_1.talkMaxDuration = var_241_4

					if var_241_4 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_4 + 0
					end
				end

				arg_238_1.text_.text = var_241_2
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061059", "story_v_out_325061.awb") ~= 0 then
					local var_241_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061059", "story_v_out_325061.awb") / 1000

					if var_241_5 + 0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + 0
					end

					if var_241_1.prefab_name ~= "" and arg_238_1.actors_[var_241_1.prefab_name] ~= nil then
						local var_241_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_1.prefab_name].transform, "story_v_out_325061", "325061059", "story_v_out_325061.awb")

						arg_238_1:RecordAudio("325061059", var_241_6)
						arg_238_1:RecordAudio("325061059", var_241_6)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_325061", "325061059", "story_v_out_325061.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_325061", "325061059", "story_v_out_325061.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_0, arg_238_1.talkMaxDuration)

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - 0) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= 0 + var_241_7 and arg_238_1.time_ < 0 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play325061060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325061060
		arg_242_1.duration_ = 18.23

		local var_242_0 = {
			zh = 10.6,
			ja = 18.233
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325061061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1075ui_story"]) and arg_242_1.var_.characterEffect1075ui_story == nil then
				arg_242_1.var_.characterEffect1075ui_story = arg_242_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1075ui_story"]) then
				if arg_242_1.var_.characterEffect1075ui_story and not isNil(arg_242_1.actors_["1075ui_story"]) then
					arg_242_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1075ui_story"]) and arg_242_1.var_.characterEffect1075ui_story then
				arg_242_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_245_2 = arg_242_1.actors_["1077ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.characterEffect1077ui_story == nil then
				arg_242_1.var_.characterEffect1077ui_story = var_245_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_3 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.characterEffect1077ui_story and not isNil(var_245_2) then
					arg_242_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_3)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.characterEffect1077ui_story then
				arg_242_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_245_4 = 0
			local var_245_5 = 1.1

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(325061060)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 44 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 44)

				if (44 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 44)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061060", "story_v_out_325061.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061060", "story_v_out_325061.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_out_325061", "325061060", "story_v_out_325061.awb")

						arg_242_1:RecordAudio("325061060", var_245_11)
						arg_242_1:RecordAudio("325061060", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325061", "325061060", "story_v_out_325061.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325061", "325061060", "story_v_out_325061.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play325061061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325061061
		arg_246_1.duration_ = 4.1

		local var_246_0 = {
			zh = 3.066,
			ja = 4.1
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play325061062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1077ui_story"]) and arg_246_1.var_.characterEffect1077ui_story == nil then
				arg_246_1.var_.characterEffect1077ui_story = arg_246_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1077ui_story"]) then
				if arg_246_1.var_.characterEffect1077ui_story and not isNil(arg_246_1.actors_["1077ui_story"]) then
					arg_246_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1077ui_story"]) and arg_246_1.var_.characterEffect1077ui_story then
				arg_246_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_249_2 = arg_246_1.actors_["1075ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.characterEffect1075ui_story == nil then
				arg_246_1.var_.characterEffect1075ui_story = var_249_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_3 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.characterEffect1075ui_story and not isNil(var_249_2) then
					arg_246_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_3)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.characterEffect1075ui_story then
				arg_246_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_249_4 = 0
			local var_249_5 = 0.325

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_6 = arg_246_1:GetWordFromCfg(325061061)
				local var_249_7 = arg_246_1:FormatText(var_249_6.content)

				arg_246_1.text_.text = var_249_7

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_9 = 13 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 13)

				if (13 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 13)) > 0 and var_249_5 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_4
					end
				end

				arg_246_1.text_.text = var_249_7
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061061", "story_v_out_325061.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061061", "story_v_out_325061.awb") / 1000

					if var_249_10 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_4
					end

					if var_249_6.prefab_name ~= "" and arg_246_1.actors_[var_249_6.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_6.prefab_name].transform, "story_v_out_325061", "325061061", "story_v_out_325061.awb")

						arg_246_1:RecordAudio("325061061", var_249_11)
						arg_246_1:RecordAudio("325061061", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325061", "325061061", "story_v_out_325061.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325061", "325061061", "story_v_out_325061.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_5, arg_246_1.talkMaxDuration)

			if var_249_4 <= arg_246_1.time_ and arg_246_1.time_ < var_249_4 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_4) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_4 + var_249_12 and arg_246_1.time_ < var_249_4 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325061062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325061062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325061063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1077ui_story = arg_250_1.actors_["1077ui_story"].transform.localPosition

				local var_253_0 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_0 then
					var_253_0:EnableDynamicBone(false)
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_1)
				arg_250_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1077ui_story"].transform.position).z)
				arg_250_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1077ui_story"].transform.localEulerAngles = arg_250_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1077ui_story"].transform.position).z)
				arg_250_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1077ui_story"].transform.localEulerAngles = arg_250_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_253_2 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(true)
				end
			end

			local var_253_3 = arg_250_1.actors_["1075ui_story"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1075ui_story = var_253_3.localPosition
			end

			local var_253_4 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_3.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_4)
				var_253_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_3.position).x, (manager.ui.mainCamera.transform.position - var_253_3.position).y, (manager.ui.mainCamera.transform.position - var_253_3.position).z)
				var_253_3.localEulerAngles.z = 0
				var_253_3.localEulerAngles.x = 0
				var_253_3.localEulerAngles = var_253_3.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_3.localPosition = Vector3.New(0, 100, 0)
				var_253_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_3.position).x, (manager.ui.mainCamera.transform.position - var_253_3.position).y, (manager.ui.mainCamera.transform.position - var_253_3.position).z)
				var_253_3.localEulerAngles.z = 0
				var_253_3.localEulerAngles.x = 0
				var_253_3.localEulerAngles = var_253_3.localEulerAngles
			end

			local var_253_5 = arg_250_1.actors_["1077ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_5) and arg_250_1.var_.characterEffect1077ui_story == nil then
				arg_250_1.var_.characterEffect1077ui_story = var_253_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_6 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_6 and not isNil(var_253_5) then
				if arg_250_1.var_.characterEffect1077ui_story and not isNil(var_253_5) then
					arg_250_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_6)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_6 and arg_250_1.time_ < 0 + var_253_6 + arg_253_0 and not isNil(var_253_5) and arg_250_1.var_.characterEffect1077ui_story then
				arg_250_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_253_7 = 0
			local var_253_8 = 1.45

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(325061062).content)

				arg_250_1.text_.text = var_253_9

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 58 <= 0 and var_253_8 or var_253_8 * (utf8.len(var_253_9) / 58)

				if (58 <= 0 and var_253_8 or var_253_8 * (utf8.len(var_253_9) / 58)) > 0 and var_253_8 < var_253_11 then
					arg_250_1.talkMaxDuration = var_253_11

					if var_253_11 + var_253_7 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_11 + var_253_7
					end
				end

				arg_250_1.text_.text = var_253_9
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_8, arg_250_1.talkMaxDuration)

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_7) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_7 + var_253_12 and arg_250_1.time_ < var_253_7 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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

		arg_250_1:InitPlayNodeList()
	end,
	Play325061063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325061063
		arg_254_1.duration_ = 3.7

		local var_254_0 = {
			zh = 1.333,
			ja = 3.7
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325061064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1077ui_story = arg_254_1.actors_["1077ui_story"].transform.localPosition

				local var_257_0 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_0 then
					var_257_0:EnableDynamicBone(false)
				end
			end

			local var_257_1 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_1 then
				arg_254_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_254_1.time_ - 0) / var_257_1)
				arg_254_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1077ui_story"].transform.position).z)
				arg_254_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1077ui_story"].transform.localEulerAngles = arg_254_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_1 and arg_254_1.time_ < 0 + var_257_1 + arg_257_0 then
				arg_254_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_254_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1077ui_story"].transform.position).z)
				arg_254_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1077ui_story"].transform.localEulerAngles = arg_254_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_257_2 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_2 then
					var_257_2:EnableDynamicBone(true)
				end
			end

			local var_257_3 = arg_254_1.actors_["1077ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect1077ui_story == nil then
				arg_254_1.var_.characterEffect1077ui_story = var_257_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_4 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 and not isNil(var_257_3) then
				if arg_254_1.var_.characterEffect1077ui_story and not isNil(var_257_3) then
					arg_254_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect1077ui_story then
				arg_254_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_257_6 = 0
			local var_257_7 = 0.175

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_8 = arg_254_1:GetWordFromCfg(325061063)
				local var_257_9 = arg_254_1:FormatText(var_257_8.content)

				arg_254_1.text_.text = var_257_9

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 7 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 7)

				if (7 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 7)) > 0 and var_257_7 < var_257_11 then
					arg_254_1.talkMaxDuration = var_257_11

					if var_257_11 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_11 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_9
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061063", "story_v_out_325061.awb") ~= 0 then
					local var_257_12 = manager.audio:GetVoiceLength("story_v_out_325061", "325061063", "story_v_out_325061.awb") / 1000

					if var_257_12 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_6
					end

					if var_257_8.prefab_name ~= "" and arg_254_1.actors_[var_257_8.prefab_name] ~= nil then
						local var_257_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_8.prefab_name].transform, "story_v_out_325061", "325061063", "story_v_out_325061.awb")

						arg_254_1:RecordAudio("325061063", var_257_13)
						arg_254_1:RecordAudio("325061063", var_257_13)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_325061", "325061063", "story_v_out_325061.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_325061", "325061063", "story_v_out_325061.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play325061064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325061064
		arg_258_1.duration_ = 3.67

		local var_258_0 = {
			zh = 2.9,
			ja = 3.666
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325061065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1077ui_story = arg_258_1.actors_["1077ui_story"].transform.localPosition

				local var_261_0 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_0 then
					var_261_0:EnableDynamicBone(false)
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_258_1.time_ - 0) / var_261_1)
				arg_258_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).z)
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles = arg_258_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				arg_258_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1077ui_story"].transform.position).z)
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1077ui_story"].transform.localEulerAngles = arg_258_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_261_2 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(true)
				end
			end

			local var_261_3 = arg_258_1.actors_["1061ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1061ui_story = var_261_3.localPosition
			end

			local var_261_4 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				var_261_3.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_258_1.time_ - 0) / var_261_4)
				var_261_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_3.position).x, (manager.ui.mainCamera.transform.position - var_261_3.position).y, (manager.ui.mainCamera.transform.position - var_261_3.position).z)
				var_261_3.localEulerAngles.z = 0
				var_261_3.localEulerAngles.x = 0
				var_261_3.localEulerAngles = var_261_3.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				var_261_3.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_261_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_3.position).x, (manager.ui.mainCamera.transform.position - var_261_3.position).y, (manager.ui.mainCamera.transform.position - var_261_3.position).z)
				var_261_3.localEulerAngles.z = 0
				var_261_3.localEulerAngles.x = 0
				var_261_3.localEulerAngles = var_261_3.localEulerAngles
			end

			local var_261_5 = arg_258_1.actors_["1061ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.characterEffect1061ui_story == nil then
				arg_258_1.var_.characterEffect1061ui_story = var_261_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_6 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_6 and not isNil(var_261_5) then
				if arg_258_1.var_.characterEffect1061ui_story and not isNil(var_261_5) then
					arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_6 and arg_258_1.time_ < 0 + var_261_6 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.characterEffect1061ui_story then
				arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_261_8 = arg_258_1.actors_["1077ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.characterEffect1077ui_story == nil then
				arg_258_1.var_.characterEffect1077ui_story = var_261_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_9 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_9 and not isNil(var_261_8) then
				if arg_258_1.var_.characterEffect1077ui_story and not isNil(var_261_8) then
					arg_258_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_9)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_9 and arg_258_1.time_ < 0 + var_261_9 + arg_261_0 and not isNil(var_261_8) and arg_258_1.var_.characterEffect1077ui_story then
				arg_258_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_261_10 = 0
			local var_261_11 = 0.425

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_12 = arg_258_1:GetWordFromCfg(325061064)
				local var_261_13 = arg_258_1:FormatText(var_261_12.content)

				arg_258_1.text_.text = var_261_13

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_15 = 17 <= 0 and var_261_11 or var_261_11 * (utf8.len(var_261_13) / 17)

				if (17 <= 0 and var_261_11 or var_261_11 * (utf8.len(var_261_13) / 17)) > 0 and var_261_11 < var_261_15 then
					arg_258_1.talkMaxDuration = var_261_15

					if var_261_15 + var_261_10 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_15 + var_261_10
					end
				end

				arg_258_1.text_.text = var_261_13
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061064", "story_v_out_325061.awb") ~= 0 then
					local var_261_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061064", "story_v_out_325061.awb") / 1000

					if var_261_16 + var_261_10 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_16 + var_261_10
					end

					if var_261_12.prefab_name ~= "" and arg_258_1.actors_[var_261_12.prefab_name] ~= nil then
						local var_261_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_12.prefab_name].transform, "story_v_out_325061", "325061064", "story_v_out_325061.awb")

						arg_258_1:RecordAudio("325061064", var_261_17)
						arg_258_1:RecordAudio("325061064", var_261_17)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_325061", "325061064", "story_v_out_325061.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_325061", "325061064", "story_v_out_325061.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_18 = math.max(var_261_11, arg_258_1.talkMaxDuration)

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_18 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_10) / var_261_18

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_10 + var_261_18 and arg_258_1.time_ < var_261_10 + var_261_18 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play325061065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325061065
		arg_262_1.duration_ = 6.9

		local var_262_0 = {
			zh = 1.999999999999,
			ja = 6.9
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325061066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1077ui_story"]) and arg_262_1.var_.characterEffect1077ui_story == nil then
				arg_262_1.var_.characterEffect1077ui_story = arg_262_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1077ui_story"]) then
				if arg_262_1.var_.characterEffect1077ui_story and not isNil(arg_262_1.actors_["1077ui_story"]) then
					arg_262_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1077ui_story"]) and arg_262_1.var_.characterEffect1077ui_story then
				arg_262_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_265_2 = arg_262_1.actors_["1061ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect1061ui_story == nil then
				arg_262_1.var_.characterEffect1061ui_story = var_265_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_3 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.characterEffect1061ui_story and not isNil(var_265_2) then
					arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_3)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect1061ui_story then
				arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_265_4 = 0
			local var_265_5 = 0.2

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_6 = arg_262_1:GetWordFromCfg(325061065)
				local var_265_7 = arg_262_1:FormatText(var_265_6.content)

				arg_262_1.text_.text = var_265_7

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 8 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 8)

				if (8 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 8)) > 0 and var_265_5 < var_265_9 then
					arg_262_1.talkMaxDuration = var_265_9

					if var_265_9 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_4
					end
				end

				arg_262_1.text_.text = var_265_7
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061065", "story_v_out_325061.awb") ~= 0 then
					local var_265_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061065", "story_v_out_325061.awb") / 1000

					if var_265_10 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_4
					end

					if var_265_6.prefab_name ~= "" and arg_262_1.actors_[var_265_6.prefab_name] ~= nil then
						local var_265_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_6.prefab_name].transform, "story_v_out_325061", "325061065", "story_v_out_325061.awb")

						arg_262_1:RecordAudio("325061065", var_265_11)
						arg_262_1:RecordAudio("325061065", var_265_11)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_325061", "325061065", "story_v_out_325061.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_325061", "325061065", "story_v_out_325061.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_5, arg_262_1.talkMaxDuration)

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_4) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_4 + var_265_12 and arg_262_1.time_ < var_265_4 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play325061066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325061066
		arg_266_1.duration_ = 8.37

		local var_266_0 = {
			zh = 5.466,
			ja = 8.366
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325061067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1061ui_story"]) and arg_266_1.var_.characterEffect1061ui_story == nil then
				arg_266_1.var_.characterEffect1061ui_story = arg_266_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1061ui_story"]) then
				if arg_266_1.var_.characterEffect1061ui_story and not isNil(arg_266_1.actors_["1061ui_story"]) then
					arg_266_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1061ui_story"]) and arg_266_1.var_.characterEffect1061ui_story then
				arg_266_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_269_2 = arg_266_1.actors_["1077ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.characterEffect1077ui_story == nil then
				arg_266_1.var_.characterEffect1077ui_story = var_269_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_3 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 and not isNil(var_269_2) then
				if arg_266_1.var_.characterEffect1077ui_story and not isNil(var_269_2) then
					arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_3)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.characterEffect1077ui_story then
				arg_266_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_269_4 = 0
			local var_269_5 = 0.825

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(325061066)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 33 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 33)

				if (33 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 33)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061066", "story_v_out_325061.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061066", "story_v_out_325061.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_325061", "325061066", "story_v_out_325061.awb")

						arg_266_1:RecordAudio("325061066", var_269_11)
						arg_266_1:RecordAudio("325061066", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_325061", "325061066", "story_v_out_325061.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_325061", "325061066", "story_v_out_325061.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play325061067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325061067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325061068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1061ui_story = arg_270_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1061ui_story"].transform.position).z)
				arg_270_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1061ui_story"].transform.localEulerAngles = arg_270_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1061ui_story"].transform.position).z)
				arg_270_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1061ui_story"].transform.localEulerAngles = arg_270_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_273_1 = arg_270_1.actors_["1077ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1077ui_story = var_273_1.localPosition

				local var_273_2 = GameObjectTools.GetOrAddComponent(var_273_1.gameObject, typeof(DynamicBoneHelper))

				if var_273_2 then
					var_273_2:EnableDynamicBone(false)
				end
			end

			local var_273_3 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 then
				var_273_1.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_270_1.time_ - 0) / var_273_3)
				var_273_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_1.position).x, (manager.ui.mainCamera.transform.position - var_273_1.position).y, (manager.ui.mainCamera.transform.position - var_273_1.position).z)
				var_273_1.localEulerAngles.z = 0
				var_273_1.localEulerAngles.x = 0
				var_273_1.localEulerAngles = var_273_1.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 then
				var_273_1.localPosition = Vector3.New(0, 100, 0)
				var_273_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_1.position).x, (manager.ui.mainCamera.transform.position - var_273_1.position).y, (manager.ui.mainCamera.transform.position - var_273_1.position).z)
				var_273_1.localEulerAngles.z = 0
				var_273_1.localEulerAngles.x = 0
				var_273_1.localEulerAngles = var_273_1.localEulerAngles

				local var_273_4 = GameObjectTools.GetOrAddComponent(var_273_1.gameObject, typeof(DynamicBoneHelper))

				if var_273_4 then
					var_273_4:EnableDynamicBone(true)
				end
			end

			local var_273_5 = arg_270_1.actors_["1061ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1061ui_story == nil then
				arg_270_1.var_.characterEffect1061ui_story = var_273_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.characterEffect1061ui_story and not isNil(var_273_5) then
					arg_270_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_6)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_6 and arg_270_1.time_ < 0 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1061ui_story then
				arg_270_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_273_7 = 0
			local var_273_8 = 1.35

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_7 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_9 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(325061067).content)

				arg_270_1.text_.text = var_273_9

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 54 <= 0 and var_273_8 or var_273_8 * (utf8.len(var_273_9) / 54)

				if (54 <= 0 and var_273_8 or var_273_8 * (utf8.len(var_273_9) / 54)) > 0 and var_273_8 < var_273_11 then
					arg_270_1.talkMaxDuration = var_273_11

					if var_273_11 + var_273_7 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_11 + var_273_7
					end
				end

				arg_270_1.text_.text = var_273_9
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_8, arg_270_1.talkMaxDuration)

			if var_273_7 <= arg_270_1.time_ and arg_270_1.time_ < var_273_7 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_7) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_7 + var_273_12 and arg_270_1.time_ < var_273_7 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play325061068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 325061068
		arg_274_1.duration_ = 10.3

		local var_274_0 = {
			zh = 10.3,
			ja = 9.866
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play325061069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1077ui_story = arg_274_1.actors_["1077ui_story"].transform.localPosition

				local var_277_0 = GameObjectTools.GetOrAddComponent(arg_274_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_277_0 then
					var_277_0:EnableDynamicBone(false)
				end
			end

			local var_277_1 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 then
				arg_274_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_274_1.time_ - 0) / var_277_1)
				arg_274_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).z)
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles = arg_274_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 then
				arg_274_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_274_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1077ui_story"].transform.position).z)
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1077ui_story"].transform.localEulerAngles = arg_274_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_277_2 = GameObjectTools.GetOrAddComponent(arg_274_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(true)
				end
			end

			local var_277_3 = arg_274_1.actors_["1077ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect1077ui_story == nil then
				arg_274_1.var_.characterEffect1077ui_story = var_277_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_4 = 0.0166666666666667

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 and not isNil(var_277_3) then
				if arg_274_1.var_.characterEffect1077ui_story and not isNil(var_277_3) then
					arg_274_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 and not isNil(var_277_3) and arg_274_1.var_.characterEffect1077ui_story then
				arg_274_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileB_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			local var_277_6 = 0
			local var_277_7 = 1

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_8 = arg_274_1:GetWordFromCfg(325061068)
				local var_277_9 = arg_274_1:FormatText(var_277_8.content)

				arg_274_1.text_.text = var_277_9

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 40 <= 0 and var_277_7 or var_277_7 * (utf8.len(var_277_9) / 40)

				if (40 <= 0 and var_277_7 or var_277_7 * (utf8.len(var_277_9) / 40)) > 0 and var_277_7 < var_277_11 then
					arg_274_1.talkMaxDuration = var_277_11

					if var_277_11 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_9
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061068", "story_v_out_325061.awb") ~= 0 then
					local var_277_12 = manager.audio:GetVoiceLength("story_v_out_325061", "325061068", "story_v_out_325061.awb") / 1000

					if var_277_12 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_6
					end

					if var_277_8.prefab_name ~= "" and arg_274_1.actors_[var_277_8.prefab_name] ~= nil then
						local var_277_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_8.prefab_name].transform, "story_v_out_325061", "325061068", "story_v_out_325061.awb")

						arg_274_1:RecordAudio("325061068", var_277_13)
						arg_274_1:RecordAudio("325061068", var_277_13)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_325061", "325061068", "story_v_out_325061.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_325061", "325061068", "story_v_out_325061.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_14 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_14 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_14

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_14 and arg_274_1.time_ < var_277_6 + var_277_14 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play325061069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 325061069
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play325061070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1077ui_story"]) and arg_278_1.var_.characterEffect1077ui_story == nil then
				arg_278_1.var_.characterEffect1077ui_story = arg_278_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_0 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1077ui_story"]) then
				if arg_278_1.var_.characterEffect1077ui_story and not isNil(arg_278_1.actors_["1077ui_story"]) then
					arg_278_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_0)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1077ui_story"]) and arg_278_1.var_.characterEffect1077ui_story then
				arg_278_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_281_1 = arg_278_1.actors_["1077ui_story"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1077ui_story = var_281_1.localPosition

				local var_281_2 = GameObjectTools.GetOrAddComponent(var_281_1.gameObject, typeof(DynamicBoneHelper))

				if var_281_2 then
					var_281_2:EnableDynamicBone(false)
				end
			end

			local var_281_3 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 then
				var_281_1.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 0) / var_281_3)
				var_281_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_1.position).x, (manager.ui.mainCamera.transform.position - var_281_1.position).y, (manager.ui.mainCamera.transform.position - var_281_1.position).z)
				var_281_1.localEulerAngles.z = 0
				var_281_1.localEulerAngles.x = 0
				var_281_1.localEulerAngles = var_281_1.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 then
				var_281_1.localPosition = Vector3.New(0, 100, 0)
				var_281_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_1.position).x, (manager.ui.mainCamera.transform.position - var_281_1.position).y, (manager.ui.mainCamera.transform.position - var_281_1.position).z)
				var_281_1.localEulerAngles.z = 0
				var_281_1.localEulerAngles.x = 0
				var_281_1.localEulerAngles = var_281_1.localEulerAngles

				local var_281_4 = GameObjectTools.GetOrAddComponent(var_281_1.gameObject, typeof(DynamicBoneHelper))

				if var_281_4 then
					var_281_4:EnableDynamicBone(true)
				end
			end

			local var_281_5 = 0
			local var_281_6 = 1.225

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_7 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(325061069).content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 49 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 49)

				if (49 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 49)) > 0 and var_281_6 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_5
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_6, arg_278_1.talkMaxDuration)

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_5) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_5 + var_281_10 and arg_278_1.time_ < var_281_5 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play325061070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 325061070
		arg_282_1.duration_ = 8

		local var_282_0 = {
			zh = 5.533,
			ja = 8
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
				arg_282_0:Play325061071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1061ui_story = arg_282_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1061ui_story"].transform.position).z)
				arg_282_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1061ui_story"].transform.localEulerAngles = arg_282_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0.7, -1.18, -6.15)
				arg_282_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1061ui_story"].transform.position).z)
				arg_282_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1061ui_story"].transform.localEulerAngles = arg_282_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_285_1 = arg_282_1.actors_["1077ui_story"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1077ui_story = var_285_1.localPosition

				local var_285_2 = GameObjectTools.GetOrAddComponent(var_285_1.gameObject, typeof(DynamicBoneHelper))

				if var_285_2 then
					var_285_2:EnableDynamicBone(false)
				end
			end

			local var_285_3 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 then
				var_285_1.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_282_1.time_ - 0) / var_285_3)
				var_285_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_1.position).x, (manager.ui.mainCamera.transform.position - var_285_1.position).y, (manager.ui.mainCamera.transform.position - var_285_1.position).z)
				var_285_1.localEulerAngles.z = 0
				var_285_1.localEulerAngles.x = 0
				var_285_1.localEulerAngles = var_285_1.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 then
				var_285_1.localPosition = Vector3.New(0, 100, 0)
				var_285_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_285_1.position).x, (manager.ui.mainCamera.transform.position - var_285_1.position).y, (manager.ui.mainCamera.transform.position - var_285_1.position).z)
				var_285_1.localEulerAngles.z = 0
				var_285_1.localEulerAngles.x = 0
				var_285_1.localEulerAngles = var_285_1.localEulerAngles

				local var_285_4 = GameObjectTools.GetOrAddComponent(var_285_1.gameObject, typeof(DynamicBoneHelper))

				if var_285_4 then
					var_285_4:EnableDynamicBone(true)
				end
			end

			local var_285_5 = arg_282_1.actors_["1061ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.characterEffect1061ui_story == nil then
				arg_282_1.var_.characterEffect1061ui_story = var_285_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_6 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_6 and not isNil(var_285_5) then
				if arg_282_1.var_.characterEffect1061ui_story and not isNil(var_285_5) then
					arg_282_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_6 and arg_282_1.time_ < 0 + var_285_6 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.characterEffect1061ui_story then
				arg_282_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_285_8 = 0
			local var_285_9 = 0.725

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_10 = arg_282_1:GetWordFromCfg(325061070)
				local var_285_11 = arg_282_1:FormatText(var_285_10.content)

				arg_282_1.text_.text = var_285_11

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_13 = 29 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_11) / 29)

				if (29 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_11) / 29)) > 0 and var_285_9 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_11
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061070", "story_v_out_325061.awb") ~= 0 then
					local var_285_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061070", "story_v_out_325061.awb") / 1000

					if var_285_14 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_14 + var_285_8
					end

					if var_285_10.prefab_name ~= "" and arg_282_1.actors_[var_285_10.prefab_name] ~= nil then
						local var_285_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_10.prefab_name].transform, "story_v_out_325061", "325061070", "story_v_out_325061.awb")

						arg_282_1:RecordAudio("325061070", var_285_15)
						arg_282_1:RecordAudio("325061070", var_285_15)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_325061", "325061070", "story_v_out_325061.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_325061", "325061070", "story_v_out_325061.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_16 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_16 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_8) / var_285_16

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_8 + var_285_16 and arg_282_1.time_ < var_285_8 + var_285_16 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325061071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 325061071
		arg_286_1.duration_ = 2.47

		local var_286_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_286_0:Play325061072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1077ui_story"]) and arg_286_1.var_.characterEffect1077ui_story == nil then
				arg_286_1.var_.characterEffect1077ui_story = arg_286_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1077ui_story"]) then
				if arg_286_1.var_.characterEffect1077ui_story and not isNil(arg_286_1.actors_["1077ui_story"]) then
					arg_286_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1077ui_story"]) and arg_286_1.var_.characterEffect1077ui_story then
				arg_286_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_289_2 = arg_286_1.actors_["1061ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.characterEffect1061ui_story == nil then
				arg_286_1.var_.characterEffect1061ui_story = var_289_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_3 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_3 and not isNil(var_289_2) then
				if arg_286_1.var_.characterEffect1061ui_story and not isNil(var_289_2) then
					arg_286_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_3)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_3 and arg_286_1.time_ < 0 + var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.characterEffect1061ui_story then
				arg_286_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_289_4 = arg_286_1.actors_["1077ui_story"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1077ui_story = var_289_4.localPosition

				local var_289_5 = GameObjectTools.GetOrAddComponent(var_289_4.gameObject, typeof(DynamicBoneHelper))

				if var_289_5 then
					var_289_5:EnableDynamicBone(false)
				end
			end

			local var_289_6 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_6 then
				var_289_4.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_286_1.time_ - 0) / var_289_6)
				var_289_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_4.position).x, (manager.ui.mainCamera.transform.position - var_289_4.position).y, (manager.ui.mainCamera.transform.position - var_289_4.position).z)
				var_289_4.localEulerAngles.z = 0
				var_289_4.localEulerAngles.x = 0
				var_289_4.localEulerAngles = var_289_4.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_6 and arg_286_1.time_ < 0 + var_289_6 + arg_289_0 then
				var_289_4.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				var_289_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_4.position).x, (manager.ui.mainCamera.transform.position - var_289_4.position).y, (manager.ui.mainCamera.transform.position - var_289_4.position).z)
				var_289_4.localEulerAngles.z = 0
				var_289_4.localEulerAngles.x = 0
				var_289_4.localEulerAngles = var_289_4.localEulerAngles

				local var_289_7 = GameObjectTools.GetOrAddComponent(var_289_4.gameObject, typeof(DynamicBoneHelper))

				if var_289_7 then
					var_289_7:EnableDynamicBone(true)
				end
			end

			local var_289_8 = 0
			local var_289_9 = 0.125

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_10 = arg_286_1:GetWordFromCfg(325061071)
				local var_289_11 = arg_286_1:FormatText(var_289_10.content)

				arg_286_1.text_.text = var_289_11

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_13 = 5 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_11) / 5)

				if (5 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_11) / 5)) > 0 and var_289_9 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_8
					end
				end

				arg_286_1.text_.text = var_289_11
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061071", "story_v_out_325061.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_out_325061", "325061071", "story_v_out_325061.awb") / 1000

					if var_289_14 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_8
					end

					if var_289_10.prefab_name ~= "" and arg_286_1.actors_[var_289_10.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_10.prefab_name].transform, "story_v_out_325061", "325061071", "story_v_out_325061.awb")

						arg_286_1:RecordAudio("325061071", var_289_15)
						arg_286_1:RecordAudio("325061071", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_325061", "325061071", "story_v_out_325061.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_325061", "325061071", "story_v_out_325061.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_9, arg_286_1.talkMaxDuration)

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_8) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_8 + var_289_16 and arg_286_1.time_ < var_289_8 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325061072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 325061072
		arg_290_1.duration_ = 7.83

		local var_290_0 = {
			zh = 6.333,
			ja = 7.833
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play325061073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1061ui_story"]) and arg_290_1.var_.characterEffect1061ui_story == nil then
				arg_290_1.var_.characterEffect1061ui_story = arg_290_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1061ui_story"]) then
				if arg_290_1.var_.characterEffect1061ui_story and not isNil(arg_290_1.actors_["1061ui_story"]) then
					arg_290_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1061ui_story"]) and arg_290_1.var_.characterEffect1061ui_story then
				arg_290_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_293_2 = arg_290_1.actors_["1077ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.characterEffect1077ui_story == nil then
				arg_290_1.var_.characterEffect1077ui_story = var_293_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_3 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_3 and not isNil(var_293_2) then
				if arg_290_1.var_.characterEffect1077ui_story and not isNil(var_293_2) then
					arg_290_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_3)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_3 and arg_290_1.time_ < 0 + var_293_3 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.characterEffect1077ui_story then
				arg_290_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_293_4 = 0
			local var_293_5 = 0.675

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_6 = arg_290_1:GetWordFromCfg(325061072)
				local var_293_7 = arg_290_1:FormatText(var_293_6.content)

				arg_290_1.text_.text = var_293_7

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_9 = 27 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 27)

				if (27 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 27)) > 0 and var_293_5 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_4
					end
				end

				arg_290_1.text_.text = var_293_7
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061072", "story_v_out_325061.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061072", "story_v_out_325061.awb") / 1000

					if var_293_10 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_4
					end

					if var_293_6.prefab_name ~= "" and arg_290_1.actors_[var_293_6.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_6.prefab_name].transform, "story_v_out_325061", "325061072", "story_v_out_325061.awb")

						arg_290_1:RecordAudio("325061072", var_293_11)
						arg_290_1:RecordAudio("325061072", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_325061", "325061072", "story_v_out_325061.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_325061", "325061072", "story_v_out_325061.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_5, arg_290_1.talkMaxDuration)

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_4) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_4 + var_293_12 and arg_290_1.time_ < var_293_4 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play325061073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 325061073
		arg_294_1.duration_ = 15.23

		local var_294_0 = {
			zh = 8.6,
			ja = 15.233
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play325061074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 1.1

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:GetWordFromCfg(325061073)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 44 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 44)

				if (44 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 44)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061073", "story_v_out_325061.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061073", "story_v_out_325061.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_325061", "325061073", "story_v_out_325061.awb")

						arg_294_1:RecordAudio("325061073", var_297_6)
						arg_294_1:RecordAudio("325061073", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_325061", "325061073", "story_v_out_325061.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_325061", "325061073", "story_v_out_325061.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play325061074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 325061074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play325061075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1061ui_story = arg_298_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_301_0 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				arg_298_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1061ui_story"].transform.position).z)
				arg_298_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1061ui_story"].transform.localEulerAngles = arg_298_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				arg_298_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1061ui_story"].transform.position).z)
				arg_298_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1061ui_story"].transform.localEulerAngles = arg_298_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_301_1 = arg_298_1.actors_["1077ui_story"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1077ui_story = var_301_1.localPosition

				local var_301_2 = GameObjectTools.GetOrAddComponent(var_301_1.gameObject, typeof(DynamicBoneHelper))

				if var_301_2 then
					var_301_2:EnableDynamicBone(false)
				end
			end

			local var_301_3 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_3 then
				var_301_1.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 0) / var_301_3)
				var_301_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_1.position).x, (manager.ui.mainCamera.transform.position - var_301_1.position).y, (manager.ui.mainCamera.transform.position - var_301_1.position).z)
				var_301_1.localEulerAngles.z = 0
				var_301_1.localEulerAngles.x = 0
				var_301_1.localEulerAngles = var_301_1.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_3 and arg_298_1.time_ < 0 + var_301_3 + arg_301_0 then
				var_301_1.localPosition = Vector3.New(0, 100, 0)
				var_301_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_1.position).x, (manager.ui.mainCamera.transform.position - var_301_1.position).y, (manager.ui.mainCamera.transform.position - var_301_1.position).z)
				var_301_1.localEulerAngles.z = 0
				var_301_1.localEulerAngles.x = 0
				var_301_1.localEulerAngles = var_301_1.localEulerAngles

				local var_301_4 = GameObjectTools.GetOrAddComponent(var_301_1.gameObject, typeof(DynamicBoneHelper))

				if var_301_4 then
					var_301_4:EnableDynamicBone(true)
				end
			end

			local var_301_5 = arg_298_1.actors_["1061ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_5) and arg_298_1.var_.characterEffect1061ui_story == nil then
				arg_298_1.var_.characterEffect1061ui_story = var_301_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_6 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_6 and not isNil(var_301_5) then
				if arg_298_1.var_.characterEffect1061ui_story and not isNil(var_301_5) then
					arg_298_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_6)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_6 and arg_298_1.time_ < 0 + var_301_6 + arg_301_0 and not isNil(var_301_5) and arg_298_1.var_.characterEffect1061ui_story then
				arg_298_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_298_1.time_ and arg_298_1.time_ <= 0.1 + arg_301_0 then
				arg_298_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_301_8 = 0
			local var_301_9 = 0.625

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_10 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(325061074).content)

				arg_298_1.text_.text = var_301_10

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_12 = 25 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_10) / 25)

				if (25 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_10) / 25)) > 0 and var_301_9 < var_301_12 then
					arg_298_1.talkMaxDuration = var_301_12

					if var_301_12 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_12 + var_301_8
					end
				end

				arg_298_1.text_.text = var_301_10
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_13 = math.max(var_301_9, arg_298_1.talkMaxDuration)

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_13 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_8) / var_301_13

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_8 + var_301_13 and arg_298_1.time_ < var_301_8 + var_301_13 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play325061075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 325061075
		arg_302_1.duration_ = 10.97

		local var_302_0 = {
			zh = 8.166,
			ja = 10.966
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play325061076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1061ui_story = arg_302_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1061ui_story"].transform.position).z)
				arg_302_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1061ui_story"].transform.localEulerAngles = arg_302_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_302_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1061ui_story"].transform.position).z)
				arg_302_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1061ui_story"].transform.localEulerAngles = arg_302_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1061ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1061ui_story == nil then
				arg_302_1.var_.characterEffect1061ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1061ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1061ui_story then
				arg_302_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_4 = 0
			local var_305_5 = 1

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(325061075)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 40 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 40)

				if (40 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 40)) > 0 and var_305_5 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061075", "story_v_out_325061.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061075", "story_v_out_325061.awb") / 1000

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end

					if var_305_6.prefab_name ~= "" and arg_302_1.actors_[var_305_6.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_6.prefab_name].transform, "story_v_out_325061", "325061075", "story_v_out_325061.awb")

						arg_302_1:RecordAudio("325061075", var_305_11)
						arg_302_1:RecordAudio("325061075", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_325061", "325061075", "story_v_out_325061.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_325061", "325061075", "story_v_out_325061.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325061076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 325061076
		arg_306_1.duration_ = 4.87

		local var_306_0 = {
			zh = 3.9,
			ja = 4.866
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play325061077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1061ui_story = arg_306_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_309_0 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 then
				arg_306_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_306_1.time_ - 0) / var_309_0)
				arg_306_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1061ui_story"].transform.position).z)
				arg_306_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1061ui_story"].transform.localEulerAngles = arg_306_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 then
				arg_306_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0.7, -1.18, -6.15)
				arg_306_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1061ui_story"].transform.position).z)
				arg_306_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1061ui_story"].transform.localEulerAngles = arg_306_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_309_1 = arg_306_1.actors_["1077ui_story"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1077ui_story = var_309_1.localPosition

				local var_309_2 = GameObjectTools.GetOrAddComponent(var_309_1.gameObject, typeof(DynamicBoneHelper))

				if var_309_2 then
					var_309_2:EnableDynamicBone(false)
				end
			end

			local var_309_3 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 then
				var_309_1.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_306_1.time_ - 0) / var_309_3)
				var_309_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_1.position).x, (manager.ui.mainCamera.transform.position - var_309_1.position).y, (manager.ui.mainCamera.transform.position - var_309_1.position).z)
				var_309_1.localEulerAngles.z = 0
				var_309_1.localEulerAngles.x = 0
				var_309_1.localEulerAngles = var_309_1.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 then
				var_309_1.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				var_309_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_1.position).x, (manager.ui.mainCamera.transform.position - var_309_1.position).y, (manager.ui.mainCamera.transform.position - var_309_1.position).z)
				var_309_1.localEulerAngles.z = 0
				var_309_1.localEulerAngles.x = 0
				var_309_1.localEulerAngles = var_309_1.localEulerAngles

				local var_309_4 = GameObjectTools.GetOrAddComponent(var_309_1.gameObject, typeof(DynamicBoneHelper))

				if var_309_4 then
					var_309_4:EnableDynamicBone(true)
				end
			end

			local var_309_5 = arg_306_1.actors_["1077ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect1077ui_story == nil then
				arg_306_1.var_.characterEffect1077ui_story = var_309_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_6 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_6 and not isNil(var_309_5) then
				if arg_306_1.var_.characterEffect1077ui_story and not isNil(var_309_5) then
					arg_306_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_6 and arg_306_1.time_ < 0 + var_309_6 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect1077ui_story then
				arg_306_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_309_8 = arg_306_1.actors_["1061ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.characterEffect1061ui_story == nil then
				arg_306_1.var_.characterEffect1061ui_story = var_309_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_9 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_9 and not isNil(var_309_8) then
				if arg_306_1.var_.characterEffect1061ui_story and not isNil(var_309_8) then
					arg_306_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_9)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_9 and arg_306_1.time_ < 0 + var_309_9 + arg_309_0 and not isNil(var_309_8) and arg_306_1.var_.characterEffect1061ui_story then
				arg_306_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_309_10 = 0
			local var_309_11 = 0.225

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_12 = arg_306_1:GetWordFromCfg(325061076)
				local var_309_13 = arg_306_1:FormatText(var_309_12.content)

				arg_306_1.text_.text = var_309_13

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_15 = 9 <= 0 and var_309_11 or var_309_11 * (utf8.len(var_309_13) / 9)

				if (9 <= 0 and var_309_11 or var_309_11 * (utf8.len(var_309_13) / 9)) > 0 and var_309_11 < var_309_15 then
					arg_306_1.talkMaxDuration = var_309_15

					if var_309_15 + var_309_10 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_15 + var_309_10
					end
				end

				arg_306_1.text_.text = var_309_13
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061076", "story_v_out_325061.awb") ~= 0 then
					local var_309_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061076", "story_v_out_325061.awb") / 1000

					if var_309_16 + var_309_10 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_16 + var_309_10
					end

					if var_309_12.prefab_name ~= "" and arg_306_1.actors_[var_309_12.prefab_name] ~= nil then
						local var_309_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_12.prefab_name].transform, "story_v_out_325061", "325061076", "story_v_out_325061.awb")

						arg_306_1:RecordAudio("325061076", var_309_17)
						arg_306_1:RecordAudio("325061076", var_309_17)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_325061", "325061076", "story_v_out_325061.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_325061", "325061076", "story_v_out_325061.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_18 = math.max(var_309_11, arg_306_1.talkMaxDuration)

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_18 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_10) / var_309_18

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_10 + var_309_18 and arg_306_1.time_ < var_309_10 + var_309_18 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play325061077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 325061077
		arg_310_1.duration_ = 5.87

		local var_310_0 = {
			zh = 2.766,
			ja = 5.866
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play325061078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1061ui_story"]) and arg_310_1.var_.characterEffect1061ui_story == nil then
				arg_310_1.var_.characterEffect1061ui_story = arg_310_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1061ui_story"]) then
				if arg_310_1.var_.characterEffect1061ui_story and not isNil(arg_310_1.actors_["1061ui_story"]) then
					arg_310_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1061ui_story"]) and arg_310_1.var_.characterEffect1061ui_story then
				arg_310_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_313_2 = arg_310_1.actors_["1077ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect1077ui_story == nil then
				arg_310_1.var_.characterEffect1077ui_story = var_313_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_3 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.characterEffect1077ui_story and not isNil(var_313_2) then
					arg_310_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_3)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.characterEffect1077ui_story then
				arg_310_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_313_4 = 0
			local var_313_5 = 0.2

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_6 = arg_310_1:GetWordFromCfg(325061077)
				local var_313_7 = arg_310_1:FormatText(var_313_6.content)

				arg_310_1.text_.text = var_313_7

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 8 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 8)

				if (8 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 8)) > 0 and var_313_5 < var_313_9 then
					arg_310_1.talkMaxDuration = var_313_9

					if var_313_9 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_7
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061077", "story_v_out_325061.awb") ~= 0 then
					local var_313_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061077", "story_v_out_325061.awb") / 1000

					if var_313_10 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_4
					end

					if var_313_6.prefab_name ~= "" and arg_310_1.actors_[var_313_6.prefab_name] ~= nil then
						local var_313_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_6.prefab_name].transform, "story_v_out_325061", "325061077", "story_v_out_325061.awb")

						arg_310_1:RecordAudio("325061077", var_313_11)
						arg_310_1:RecordAudio("325061077", var_313_11)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_325061", "325061077", "story_v_out_325061.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_325061", "325061077", "story_v_out_325061.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_12 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_12 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_12

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_12 and arg_310_1.time_ < var_313_4 + var_313_12 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play325061078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 325061078
		arg_314_1.duration_ = 2.1

		local var_314_0 = {
			zh = 1.999999999999,
			ja = 2.1
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play325061079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1077ui_story"]) and arg_314_1.var_.characterEffect1077ui_story == nil then
				arg_314_1.var_.characterEffect1077ui_story = arg_314_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1077ui_story"]) then
				if arg_314_1.var_.characterEffect1077ui_story and not isNil(arg_314_1.actors_["1077ui_story"]) then
					arg_314_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1077ui_story"]) and arg_314_1.var_.characterEffect1077ui_story then
				arg_314_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_317_2 = arg_314_1.actors_["1061ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect1061ui_story == nil then
				arg_314_1.var_.characterEffect1061ui_story = var_317_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_3 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.characterEffect1061ui_story and not isNil(var_317_2) then
					arg_314_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_3)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect1061ui_story then
				arg_314_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_317_4 = 0

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.allBtn_.enabled = false
			end

			if arg_314_1.time_ >= var_317_4 + 1.26666666666667 and arg_314_1.time_ < var_317_4 + 1.26666666666667 + arg_317_0 then
				arg_314_1.allBtn_.enabled = true
			end

			local var_317_5 = 0
			local var_317_6 = 0.05

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:GetWordFromCfg(325061078)
				local var_317_8 = arg_314_1:FormatText(var_317_7.content)

				arg_314_1.text_.text = var_317_8

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_10 = 2 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 2)

				if (2 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 2)) > 0 and var_317_6 < var_317_10 then
					arg_314_1.talkMaxDuration = var_317_10

					if var_317_10 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_8
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061078", "story_v_out_325061.awb") ~= 0 then
					local var_317_11 = manager.audio:GetVoiceLength("story_v_out_325061", "325061078", "story_v_out_325061.awb") / 1000

					if var_317_11 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_11 + var_317_5
					end

					if var_317_7.prefab_name ~= "" and arg_314_1.actors_[var_317_7.prefab_name] ~= nil then
						local var_317_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_7.prefab_name].transform, "story_v_out_325061", "325061078", "story_v_out_325061.awb")

						arg_314_1:RecordAudio("325061078", var_317_12)
						arg_314_1:RecordAudio("325061078", var_317_12)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_325061", "325061078", "story_v_out_325061.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_325061", "325061078", "story_v_out_325061.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_13 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_13 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_13

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_13 and arg_314_1.time_ < var_317_5 + var_317_13 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play325061079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 325061079
		arg_318_1.duration_ = 14.33

		local var_318_0 = {
			zh = 6.833,
			ja = 14.333
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play325061080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1061ui_story"]) and arg_318_1.var_.characterEffect1061ui_story == nil then
				arg_318_1.var_.characterEffect1061ui_story = arg_318_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1061ui_story"]) then
				if arg_318_1.var_.characterEffect1061ui_story and not isNil(arg_318_1.actors_["1061ui_story"]) then
					arg_318_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1061ui_story"]) and arg_318_1.var_.characterEffect1061ui_story then
				arg_318_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_321_2 = arg_318_1.actors_["1077ui_story"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1077ui_story == nil then
				arg_318_1.var_.characterEffect1077ui_story = var_321_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_3 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.characterEffect1077ui_story and not isNil(var_321_2) then
					arg_318_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_318_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_3)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.characterEffect1077ui_story then
				arg_318_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_318_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_321_4 = 0
			local var_321_5 = 0.95

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_4 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_6 = arg_318_1:GetWordFromCfg(325061079)
				local var_321_7 = arg_318_1:FormatText(var_321_6.content)

				arg_318_1.text_.text = var_321_7

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_9 = 38 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 38)

				if (38 <= 0 and var_321_5 or var_321_5 * (utf8.len(var_321_7) / 38)) > 0 and var_321_5 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_4
					end
				end

				arg_318_1.text_.text = var_321_7
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061079", "story_v_out_325061.awb") ~= 0 then
					local var_321_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061079", "story_v_out_325061.awb") / 1000

					if var_321_10 + var_321_4 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_4
					end

					if var_321_6.prefab_name ~= "" and arg_318_1.actors_[var_321_6.prefab_name] ~= nil then
						local var_321_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_6.prefab_name].transform, "story_v_out_325061", "325061079", "story_v_out_325061.awb")

						arg_318_1:RecordAudio("325061079", var_321_11)
						arg_318_1:RecordAudio("325061079", var_321_11)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_325061", "325061079", "story_v_out_325061.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_325061", "325061079", "story_v_out_325061.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_12 = math.max(var_321_5, arg_318_1.talkMaxDuration)

			if var_321_4 <= arg_318_1.time_ and arg_318_1.time_ < var_321_4 + var_321_12 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_4) / var_321_12

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_4 + var_321_12 and arg_318_1.time_ < var_321_4 + var_321_12 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play325061080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 325061080
		arg_322_1.duration_ = 16.77

		local var_322_0 = {
			zh = 10,
			ja = 16.766
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play325061081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 1.225

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:GetWordFromCfg(325061080)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 49 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 49)

				if (49 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 49)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061080", "story_v_out_325061.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_325061", "325061080", "story_v_out_325061.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_325061", "325061080", "story_v_out_325061.awb")

						arg_322_1:RecordAudio("325061080", var_325_6)
						arg_322_1:RecordAudio("325061080", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_325061", "325061080", "story_v_out_325061.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_325061", "325061080", "story_v_out_325061.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play325061081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 325061081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play325061082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1061ui_story = arg_326_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_329_0 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 then
				arg_326_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 0) / var_329_0)
				arg_326_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1061ui_story"].transform.position).z)
				arg_326_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1061ui_story"].transform.localEulerAngles = arg_326_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 then
				arg_326_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_326_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_326_1.actors_["1061ui_story"].transform.position).z)
				arg_326_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_326_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_326_1.actors_["1061ui_story"].transform.localEulerAngles = arg_326_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_329_1 = arg_326_1.actors_["1077ui_story"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1077ui_story = var_329_1.localPosition

				local var_329_2 = GameObjectTools.GetOrAddComponent(var_329_1.gameObject, typeof(DynamicBoneHelper))

				if var_329_2 then
					var_329_2:EnableDynamicBone(false)
				end
			end

			local var_329_3 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_3 then
				var_329_1.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_326_1.time_ - 0) / var_329_3)
				var_329_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_1.position).x, (manager.ui.mainCamera.transform.position - var_329_1.position).y, (manager.ui.mainCamera.transform.position - var_329_1.position).z)
				var_329_1.localEulerAngles.z = 0
				var_329_1.localEulerAngles.x = 0
				var_329_1.localEulerAngles = var_329_1.localEulerAngles
			end

			if arg_326_1.time_ >= 0 + var_329_3 and arg_326_1.time_ < 0 + var_329_3 + arg_329_0 then
				var_329_1.localPosition = Vector3.New(0, 100, 0)
				var_329_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_329_1.position).x, (manager.ui.mainCamera.transform.position - var_329_1.position).y, (manager.ui.mainCamera.transform.position - var_329_1.position).z)
				var_329_1.localEulerAngles.z = 0
				var_329_1.localEulerAngles.x = 0
				var_329_1.localEulerAngles = var_329_1.localEulerAngles

				local var_329_4 = GameObjectTools.GetOrAddComponent(var_329_1.gameObject, typeof(DynamicBoneHelper))

				if var_329_4 then
					var_329_4:EnableDynamicBone(true)
				end
			end

			local var_329_5 = arg_326_1.actors_["1061ui_story"]

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(var_329_5) and arg_326_1.var_.characterEffect1061ui_story == nil then
				arg_326_1.var_.characterEffect1061ui_story = var_329_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_6 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_6 and not isNil(var_329_5) then
				if arg_326_1.var_.characterEffect1061ui_story and not isNil(var_329_5) then
					arg_326_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_6)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_6 and arg_326_1.time_ < 0 + var_329_6 + arg_329_0 and not isNil(var_329_5) and arg_326_1.var_.characterEffect1061ui_story then
				arg_326_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_326_1.time_ and arg_326_1.time_ <= 0.3 + arg_329_0 then
				arg_326_1:AudioAction("play", "effect", "se_story_140", "se_story_140_camera_ui02", "")
			end

			local var_329_8 = 0
			local var_329_9 = 1.15

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_8 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_10 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(325061081).content)

				arg_326_1.text_.text = var_329_10

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_12 = 46 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_10) / 46)

				if (46 <= 0 and var_329_9 or var_329_9 * (utf8.len(var_329_10) / 46)) > 0 and var_329_9 < var_329_12 then
					arg_326_1.talkMaxDuration = var_329_12

					if var_329_12 + var_329_8 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_12 + var_329_8
					end
				end

				arg_326_1.text_.text = var_329_10
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_13 = math.max(var_329_9, arg_326_1.talkMaxDuration)

			if var_329_8 <= arg_326_1.time_ and arg_326_1.time_ < var_329_8 + var_329_13 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_8) / var_329_13

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_8 + var_329_13 and arg_326_1.time_ < var_329_8 + var_329_13 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325061082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 325061082
		arg_330_1.duration_ = 8.5

		local var_330_0 = {
			zh = 7.8,
			ja = 8.5
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play325061083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1061ui_story = arg_330_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1061ui_story"].transform.position).z)
				arg_330_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1061ui_story"].transform.localEulerAngles = arg_330_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_330_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1061ui_story"].transform.position).z)
				arg_330_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1061ui_story"].transform.localEulerAngles = arg_330_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["1061ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1061ui_story == nil then
				arg_330_1.var_.characterEffect1061ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect1061ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1061ui_story then
				arg_330_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_333_4 = 0
			local var_333_5 = 0.75

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_6 = arg_330_1:GetWordFromCfg(325061082)
				local var_333_7 = arg_330_1:FormatText(var_333_6.content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 30 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 30)

				if (30 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 30)) > 0 and var_333_5 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9

					if var_333_9 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061082", "story_v_out_325061.awb") ~= 0 then
					local var_333_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061082", "story_v_out_325061.awb") / 1000

					if var_333_10 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_4
					end

					if var_333_6.prefab_name ~= "" and arg_330_1.actors_[var_333_6.prefab_name] ~= nil then
						local var_333_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_6.prefab_name].transform, "story_v_out_325061", "325061082", "story_v_out_325061.awb")

						arg_330_1:RecordAudio("325061082", var_333_11)
						arg_330_1:RecordAudio("325061082", var_333_11)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_325061", "325061082", "story_v_out_325061.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_325061", "325061082", "story_v_out_325061.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_12 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_12 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_4) / var_333_12

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_4 + var_333_12 and arg_330_1.time_ < var_333_4 + var_333_12 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play325061083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 325061083
		arg_334_1.duration_ = 5.43

		local var_334_0 = {
			zh = 3.8,
			ja = 5.433
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
				arg_334_0:Play325061084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1061ui_story = arg_334_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1061ui_story"].transform.position).z)
				arg_334_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1061ui_story"].transform.localEulerAngles = arg_334_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0.7, -1.18, -6.15)
				arg_334_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["1061ui_story"].transform.position).z)
				arg_334_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["1061ui_story"].transform.localEulerAngles = arg_334_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["1077ui_story"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1077ui_story = var_337_1.localPosition

				local var_337_2 = GameObjectTools.GetOrAddComponent(var_337_1.gameObject, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(false)
				end
			end

			local var_337_3 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_3 then
				var_337_1.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_334_1.time_ - 0) / var_337_3)
				var_337_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_1.position).x, (manager.ui.mainCamera.transform.position - var_337_1.position).y, (manager.ui.mainCamera.transform.position - var_337_1.position).z)
				var_337_1.localEulerAngles.z = 0
				var_337_1.localEulerAngles.x = 0
				var_337_1.localEulerAngles = var_337_1.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_3 and arg_334_1.time_ < 0 + var_337_3 + arg_337_0 then
				var_337_1.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				var_337_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_1.position).x, (manager.ui.mainCamera.transform.position - var_337_1.position).y, (manager.ui.mainCamera.transform.position - var_337_1.position).z)
				var_337_1.localEulerAngles.z = 0
				var_337_1.localEulerAngles.x = 0
				var_337_1.localEulerAngles = var_337_1.localEulerAngles

				local var_337_4 = GameObjectTools.GetOrAddComponent(var_337_1.gameObject, typeof(DynamicBoneHelper))

				if var_337_4 then
					var_337_4:EnableDynamicBone(true)
				end
			end

			local var_337_5 = arg_334_1.actors_["1077ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_5) and arg_334_1.var_.characterEffect1077ui_story == nil then
				arg_334_1.var_.characterEffect1077ui_story = var_337_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_6 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_6 and not isNil(var_337_5) then
				if arg_334_1.var_.characterEffect1077ui_story and not isNil(var_337_5) then
					arg_334_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_6 and arg_334_1.time_ < 0 + var_337_6 + arg_337_0 and not isNil(var_337_5) and arg_334_1.var_.characterEffect1077ui_story then
				arg_334_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_337_8 = arg_334_1.actors_["1061ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.characterEffect1061ui_story == nil then
				arg_334_1.var_.characterEffect1061ui_story = var_337_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_9 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_9 and not isNil(var_337_8) then
				if arg_334_1.var_.characterEffect1061ui_story and not isNil(var_337_8) then
					arg_334_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_9)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_9 and arg_334_1.time_ < 0 + var_337_9 + arg_337_0 and not isNil(var_337_8) and arg_334_1.var_.characterEffect1061ui_story then
				arg_334_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			local var_337_10 = 0
			local var_337_11 = 0.325

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_10 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_12 = arg_334_1:GetWordFromCfg(325061083)
				local var_337_13 = arg_334_1:FormatText(var_337_12.content)

				arg_334_1.text_.text = var_337_13

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_15 = 13 <= 0 and var_337_11 or var_337_11 * (utf8.len(var_337_13) / 13)

				if (13 <= 0 and var_337_11 or var_337_11 * (utf8.len(var_337_13) / 13)) > 0 and var_337_11 < var_337_15 then
					arg_334_1.talkMaxDuration = var_337_15

					if var_337_15 + var_337_10 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_15 + var_337_10
					end
				end

				arg_334_1.text_.text = var_337_13
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061083", "story_v_out_325061.awb") ~= 0 then
					local var_337_16 = manager.audio:GetVoiceLength("story_v_out_325061", "325061083", "story_v_out_325061.awb") / 1000

					if var_337_16 + var_337_10 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_16 + var_337_10
					end

					if var_337_12.prefab_name ~= "" and arg_334_1.actors_[var_337_12.prefab_name] ~= nil then
						local var_337_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_12.prefab_name].transform, "story_v_out_325061", "325061083", "story_v_out_325061.awb")

						arg_334_1:RecordAudio("325061083", var_337_17)
						arg_334_1:RecordAudio("325061083", var_337_17)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_325061", "325061083", "story_v_out_325061.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_325061", "325061083", "story_v_out_325061.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_18 = math.max(var_337_11, arg_334_1.talkMaxDuration)

			if var_337_10 <= arg_334_1.time_ and arg_334_1.time_ < var_337_10 + var_337_18 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_10) / var_337_18

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_10 + var_337_18 and arg_334_1.time_ < var_337_10 + var_337_18 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play325061084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 325061084
		arg_338_1.duration_ = 6.67

		local var_338_0 = {
			zh = 3.933,
			ja = 6.666
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play325061085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1061ui_story"]) and arg_338_1.var_.characterEffect1061ui_story == nil then
				arg_338_1.var_.characterEffect1061ui_story = arg_338_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1061ui_story"]) then
				if arg_338_1.var_.characterEffect1061ui_story and not isNil(arg_338_1.actors_["1061ui_story"]) then
					arg_338_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1061ui_story"]) and arg_338_1.var_.characterEffect1061ui_story then
				arg_338_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_341_2 = arg_338_1.actors_["1077ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_2) and arg_338_1.var_.characterEffect1077ui_story == nil then
				arg_338_1.var_.characterEffect1077ui_story = var_341_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_3 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_3 and not isNil(var_341_2) then
				if arg_338_1.var_.characterEffect1077ui_story and not isNil(var_341_2) then
					arg_338_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_338_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_3)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_3 and arg_338_1.time_ < 0 + var_341_3 + arg_341_0 and not isNil(var_341_2) and arg_338_1.var_.characterEffect1077ui_story then
				arg_338_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_338_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_341_4 = 0
			local var_341_5 = 0.525

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_6 = arg_338_1:GetWordFromCfg(325061084)
				local var_341_7 = arg_338_1:FormatText(var_341_6.content)

				arg_338_1.text_.text = var_341_7

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 21 <= 0 and var_341_5 or var_341_5 * (utf8.len(var_341_7) / 21)

				if (21 <= 0 and var_341_5 or var_341_5 * (utf8.len(var_341_7) / 21)) > 0 and var_341_5 < var_341_9 then
					arg_338_1.talkMaxDuration = var_341_9

					if var_341_9 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_7
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061084", "story_v_out_325061.awb") ~= 0 then
					local var_341_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061084", "story_v_out_325061.awb") / 1000

					if var_341_10 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_4
					end

					if var_341_6.prefab_name ~= "" and arg_338_1.actors_[var_341_6.prefab_name] ~= nil then
						local var_341_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_6.prefab_name].transform, "story_v_out_325061", "325061084", "story_v_out_325061.awb")

						arg_338_1:RecordAudio("325061084", var_341_11)
						arg_338_1:RecordAudio("325061084", var_341_11)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_325061", "325061084", "story_v_out_325061.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_325061", "325061084", "story_v_out_325061.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_12 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_12 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_12

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_12 and arg_338_1.time_ < var_341_4 + var_341_12 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play325061085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 325061085
		arg_342_1.duration_ = 3.6

		local var_342_0 = {
			zh = 1.999999999999,
			ja = 3.6
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play325061086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1077ui_story"]) and arg_342_1.var_.characterEffect1077ui_story == nil then
				arg_342_1.var_.characterEffect1077ui_story = arg_342_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1077ui_story"]) then
				if arg_342_1.var_.characterEffect1077ui_story and not isNil(arg_342_1.actors_["1077ui_story"]) then
					arg_342_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1077ui_story"]) and arg_342_1.var_.characterEffect1077ui_story then
				arg_342_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_345_2 = arg_342_1.actors_["1061ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.characterEffect1061ui_story == nil then
				arg_342_1.var_.characterEffect1061ui_story = var_345_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_3 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_3 and not isNil(var_345_2) then
				if arg_342_1.var_.characterEffect1061ui_story and not isNil(var_345_2) then
					arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_3)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_3 and arg_342_1.time_ < 0 + var_345_3 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.characterEffect1061ui_story then
				arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_2")
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_345_4 = 0
			local var_345_5 = 0.15

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_6 = arg_342_1:GetWordFromCfg(325061085)
				local var_345_7 = arg_342_1:FormatText(var_345_6.content)

				arg_342_1.text_.text = var_345_7

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_9 = 6 <= 0 and var_345_5 or var_345_5 * (utf8.len(var_345_7) / 6)

				if (6 <= 0 and var_345_5 or var_345_5 * (utf8.len(var_345_7) / 6)) > 0 and var_345_5 < var_345_9 then
					arg_342_1.talkMaxDuration = var_345_9

					if var_345_9 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_9 + var_345_4
					end
				end

				arg_342_1.text_.text = var_345_7
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061085", "story_v_out_325061.awb") ~= 0 then
					local var_345_10 = manager.audio:GetVoiceLength("story_v_out_325061", "325061085", "story_v_out_325061.awb") / 1000

					if var_345_10 + var_345_4 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_10 + var_345_4
					end

					if var_345_6.prefab_name ~= "" and arg_342_1.actors_[var_345_6.prefab_name] ~= nil then
						local var_345_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_6.prefab_name].transform, "story_v_out_325061", "325061085", "story_v_out_325061.awb")

						arg_342_1:RecordAudio("325061085", var_345_11)
						arg_342_1:RecordAudio("325061085", var_345_11)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_325061", "325061085", "story_v_out_325061.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_325061", "325061085", "story_v_out_325061.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_12 = math.max(var_345_5, arg_342_1.talkMaxDuration)

			if var_345_4 <= arg_342_1.time_ and arg_342_1.time_ < var_345_4 + var_345_12 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_4) / var_345_12

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_4 + var_345_12 and arg_342_1.time_ < var_345_4 + var_345_12 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play325061086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 325061086
		arg_346_1.duration_ = 10.6

		local var_346_0 = {
			zh = 9.6,
			ja = 10.6
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
			arg_346_1.auto_ = false
		end

		function arg_346_1.playNext_(arg_348_0)
			arg_346_1.onStoryFinished_()
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) and arg_346_1.var_.characterEffect1061ui_story == nil then
				arg_346_1.var_.characterEffect1061ui_story = arg_346_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) then
				if arg_346_1.var_.characterEffect1061ui_story and not isNil(arg_346_1.actors_["1061ui_story"]) then
					arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) and arg_346_1.var_.characterEffect1061ui_story then
				arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_349_2 = arg_346_1.actors_["1077ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.characterEffect1077ui_story == nil then
				arg_346_1.var_.characterEffect1077ui_story = var_349_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_3 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_3 and not isNil(var_349_2) then
				if arg_346_1.var_.characterEffect1077ui_story and not isNil(var_349_2) then
					arg_346_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_3)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_3 and arg_346_1.time_ < 0 + var_349_3 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.characterEffect1077ui_story then
				arg_346_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_349_5 = 0
			local var_349_6 = 1.025

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(325061086)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 41 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 41)

				if (41 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 41)) > 0 and var_349_6 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10

					if var_349_10 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_5
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325061", "325061086", "story_v_out_325061.awb") ~= 0 then
					local var_349_11 = manager.audio:GetVoiceLength("story_v_out_325061", "325061086", "story_v_out_325061.awb") / 1000

					if var_349_11 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_5
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_325061", "325061086", "story_v_out_325061.awb")

						arg_346_1:RecordAudio("325061086", var_349_12)
						arg_346_1:RecordAudio("325061086", var_349_12)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_325061", "325061086", "story_v_out_325061.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_325061", "325061086", "story_v_out_325061.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_6, arg_346_1.talkMaxDuration)

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_5) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_5 + var_349_13 and arg_346_1.time_ < var_349_5 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST41"
	},
	voices = {
		"story_v_out_325061.awb"
	}
}
