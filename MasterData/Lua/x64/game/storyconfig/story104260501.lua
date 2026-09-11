return {
	Play426051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 426051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play426051002(arg_1_1)
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

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.75

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

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(426051001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 30 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 30)

				if (30 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 30)) > 0 and var_4_17 < var_4_21 then
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
	Play426051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 426051002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play426051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.975

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(426051002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)

				if (39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 39)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play426051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 426051003
		arg_13_1.duration_ = 9.17

		local var_13_0 = {
			zh = 9.166,
			ja = 7.666
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
				arg_13_0:Play426051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "6148ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["6148ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["6148ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["6148ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["6148ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos6148ui_story = var_16_3.localPosition

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_13_1.time_ - 0) / var_16_5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.985, -6)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(true)
				end
			end

			local var_16_7 = arg_13_1.actors_["6148ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect6148ui_story == nil then
				arg_13_1.var_.characterEffect6148ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect6148ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect6148ui_story then
				arg_13_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_16_10 = 0
			local var_16_11 = 0.8

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(426051003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 32 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 32)

				if (32 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 32)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051003", "story_v_out_426051.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_426051", "426051003", "story_v_out_426051.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_426051", "426051003", "story_v_out_426051.awb")

						arg_13_1:RecordAudio("426051003", var_16_17)
						arg_13_1:RecordAudio("426051003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_426051", "426051003", "story_v_out_426051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_426051", "426051003", "story_v_out_426051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play426051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 426051004
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"

			SetActive(arg_17_1.choicesGo_, true)

			for iter_18_0, iter_18_1 in ipairs(arg_17_1.choices_) do
				SetActive(iter_18_1.go, iter_18_0 <= 2)
			end

			arg_17_1.choices_[1].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1603].name)
			arg_17_1.choices_[2].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1604].name)
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play426051005(arg_17_1)
			end

			if arg_19_0 == 2 then
				arg_17_0:Play426051005(arg_17_1)
			end

			arg_17_1:RecordChoiceLog(426051004, 1603, 1604)
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["6148ui_story"]) and arg_17_1.var_.characterEffect6148ui_story == nil then
				arg_17_1.var_.characterEffect6148ui_story = arg_17_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["6148ui_story"]) then
				if arg_17_1.var_.characterEffect6148ui_story and not isNil(arg_17_1.actors_["6148ui_story"]) then
					arg_17_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_17_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["6148ui_story"]) and arg_17_1.var_.characterEffect6148ui_story then
				arg_17_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_17_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_1 + 0.6 and arg_17_1.time_ < var_20_1 + 0.6 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play426051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 426051005
		arg_21_1.duration_ = 3.23

		local var_21_0 = {
			zh = 3.233,
			ja = 2.233
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play426051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos6148ui_story = arg_21_1.actors_["6148ui_story"].transform.localPosition

				local var_24_0 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_0 then
					var_24_0:EnableDynamicBone(false)
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_21_1.time_ - 0) / var_24_1)
				arg_21_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6148ui_story"].transform.position).z)
				arg_21_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["6148ui_story"].transform.localEulerAngles = arg_21_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_21_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["6148ui_story"].transform.position).z)
				arg_21_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["6148ui_story"].transform.localEulerAngles = arg_21_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_24_2 = GameObjectTools.GetOrAddComponent(arg_21_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(true)
				end
			end

			local var_24_3 = arg_21_1.actors_["6148ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect6148ui_story == nil then
				arg_21_1.var_.characterEffect6148ui_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect6148ui_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect6148ui_story then
				arg_21_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_24_6 = "6148ui_story"

			if arg_21_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_24_7 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_21_1.stage_.transform)

				var_24_7.name = var_24_6
				var_24_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_[var_24_6] = var_24_7

				local var_24_8 = var_24_7:GetComponentInChildren(typeof(CharacterEffect))

				var_24_8.enabled = true

				local var_24_9 = GameObjectTools.GetOrAddComponent(var_24_7, typeof(DynamicBoneHelper))

				if var_24_9 then
					var_24_9:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_8.transform, false)

				arg_21_1.var_[var_24_6 .. "Animator"] = var_24_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_[var_24_6 .. "Animator"].applyRootMotion = true
				arg_21_1.var_[var_24_6 .. "LipSync"] = var_24_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_24_10 = "6148ui_story"

			if arg_21_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_24_11 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_21_1.stage_.transform)

				var_24_11.name = var_24_10
				var_24_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_[var_24_10] = var_24_11

				local var_24_12 = var_24_11:GetComponentInChildren(typeof(CharacterEffect))

				var_24_12.enabled = true

				local var_24_13 = GameObjectTools.GetOrAddComponent(var_24_11, typeof(DynamicBoneHelper))

				if var_24_13 then
					var_24_13:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_12.transform, false)

				arg_21_1.var_[var_24_10 .. "Animator"] = var_24_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_[var_24_10 .. "Animator"].applyRootMotion = true
				arg_21_1.var_[var_24_10 .. "LipSync"] = var_24_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_24_14 = 0
			local var_24_15 = 0.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_16 = arg_21_1:GetWordFromCfg(426051005)
				local var_24_17 = arg_21_1:FormatText(var_24_16.content)

				arg_21_1.text_.text = var_24_17

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 10 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 10)

				if (10 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 10)) > 0 and var_24_15 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19

					if var_24_19 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_14
					end
				end

				arg_21_1.text_.text = var_24_17
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051005", "story_v_out_426051.awb") ~= 0 then
					local var_24_20 = manager.audio:GetVoiceLength("story_v_out_426051", "426051005", "story_v_out_426051.awb") / 1000

					if var_24_20 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_20 + var_24_14
					end

					if var_24_16.prefab_name ~= "" and arg_21_1.actors_[var_24_16.prefab_name] ~= nil then
						local var_24_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_16.prefab_name].transform, "story_v_out_426051", "426051005", "story_v_out_426051.awb")

						arg_21_1:RecordAudio("426051005", var_24_21)
						arg_21_1:RecordAudio("426051005", var_24_21)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_426051", "426051005", "story_v_out_426051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_426051", "426051005", "story_v_out_426051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_22 = math.max(var_24_15, arg_21_1.talkMaxDuration)

			if var_24_14 <= arg_21_1.time_ and arg_21_1.time_ < var_24_14 + var_24_22 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_14) / var_24_22

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_14 + var_24_22 and arg_21_1.time_ < var_24_14 + var_24_22 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play426051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 426051006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play426051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["6148ui_story"]) and arg_25_1.var_.characterEffect6148ui_story == nil then
				arg_25_1.var_.characterEffect6148ui_story = arg_25_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["6148ui_story"]) then
				if arg_25_1.var_.characterEffect6148ui_story and not isNil(arg_25_1.actors_["6148ui_story"]) then
					arg_25_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_25_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["6148ui_story"]) and arg_25_1.var_.characterEffect6148ui_story then
				arg_25_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_25_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.7

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(426051006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 28 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 28)

				if (28 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 28)) > 0 and var_28_2 < var_28_5 then
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

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play426051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 426051007
		arg_29_1.duration_ = 7.17

		local var_29_0 = {
			zh = 7.166,
			ja = 6.333
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
				arg_29_0:Play426051008(arg_29_1)
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
				arg_29_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_29_1.time_ - 0) / var_32_1)
				arg_29_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).z)
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles = arg_29_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_29_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).z)
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles = arg_29_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_32_2 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(true)
				end
			end

			local var_32_3 = arg_29_1.actors_["6148ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect6148ui_story == nil then
				arg_29_1.var_.characterEffect6148ui_story = var_32_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 and not isNil(var_32_3) then
				if arg_29_1.var_.characterEffect6148ui_story and not isNil(var_32_3) then
					arg_29_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect6148ui_story then
				arg_29_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_32_6 = 0
			local var_32_7 = 0.675

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(426051007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 27 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 27)

				if (27 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 27)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051007", "story_v_out_426051.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051007", "story_v_out_426051.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_426051", "426051007", "story_v_out_426051.awb")

						arg_29_1:RecordAudio("426051007", var_32_13)
						arg_29_1:RecordAudio("426051007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_426051", "426051007", "story_v_out_426051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_426051", "426051007", "story_v_out_426051.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
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
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play426051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 426051008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play426051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["6148ui_story"]) and arg_33_1.var_.characterEffect6148ui_story == nil then
				arg_33_1.var_.characterEffect6148ui_story = arg_33_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["6148ui_story"]) then
				if arg_33_1.var_.characterEffect6148ui_story and not isNil(arg_33_1.actors_["6148ui_story"]) then
					arg_33_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_33_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["6148ui_story"]) and arg_33_1.var_.characterEffect6148ui_story then
				arg_33_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_33_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.725

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
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

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(426051008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 29 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 29)

				if (29 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 29)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play426051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 426051009
		arg_37_1.duration_ = 7.1

		local var_37_0 = {
			zh = 7.1,
			ja = 6.266
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
				arg_37_0:Play426051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["6148ui_story"]) and arg_37_1.var_.characterEffect6148ui_story == nil then
				arg_37_1.var_.characterEffect6148ui_story = arg_37_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["6148ui_story"]) then
				if arg_37_1.var_.characterEffect6148ui_story and not isNil(arg_37_1.actors_["6148ui_story"]) then
					arg_37_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["6148ui_story"]) and arg_37_1.var_.characterEffect6148ui_story then
				arg_37_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			local var_40_2 = 0
			local var_40_3 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(426051009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 24 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 24)

				if (24 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 24)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051009", "story_v_out_426051.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_426051", "426051009", "story_v_out_426051.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_426051", "426051009", "story_v_out_426051.awb")

						arg_37_1:RecordAudio("426051009", var_40_9)
						arg_37_1:RecordAudio("426051009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_426051", "426051009", "story_v_out_426051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_426051", "426051009", "story_v_out_426051.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play426051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 426051010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play426051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["6148ui_story"]) and arg_41_1.var_.characterEffect6148ui_story == nil then
				arg_41_1.var_.characterEffect6148ui_story = arg_41_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["6148ui_story"]) then
				if arg_41_1.var_.characterEffect6148ui_story and not isNil(arg_41_1.actors_["6148ui_story"]) then
					arg_41_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_41_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["6148ui_story"]) and arg_41_1.var_.characterEffect6148ui_story then
				arg_41_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_41_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.65

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

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(426051010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 26 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 26)

				if (26 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 26)) > 0 and var_44_2 < var_44_5 then
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
	Play426051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 426051011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play426051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.75

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
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

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(426051011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 30)

				if (30 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 30)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play426051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 426051012
		arg_49_1.duration_ = 4.87

		local var_49_0 = {
			zh = 4.866,
			ja = 2.9
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
				arg_49_0:Play426051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos6148ui_story = arg_49_1.actors_["6148ui_story"].transform.localPosition

				local var_52_0 = GameObjectTools.GetOrAddComponent(arg_49_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_52_0 then
					var_52_0:EnableDynamicBone(false)
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_49_1.time_ - 0) / var_52_1)
				arg_49_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6148ui_story"].transform.position).z)
				arg_49_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["6148ui_story"].transform.localEulerAngles = arg_49_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_49_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["6148ui_story"].transform.position).z)
				arg_49_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["6148ui_story"].transform.localEulerAngles = arg_49_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_52_2 = GameObjectTools.GetOrAddComponent(arg_49_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(true)
				end
			end

			local var_52_3 = arg_49_1.actors_["6148ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect6148ui_story == nil then
				arg_49_1.var_.characterEffect6148ui_story = var_52_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_4 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 and not isNil(var_52_3) then
				if arg_49_1.var_.characterEffect6148ui_story and not isNil(var_52_3) then
					arg_49_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 and not isNil(var_52_3) and arg_49_1.var_.characterEffect6148ui_story then
				arg_49_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_6 = 0
			local var_52_7 = 0.55

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(426051012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 22 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 22)

				if (22 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 22)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051012", "story_v_out_426051.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051012", "story_v_out_426051.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_426051", "426051012", "story_v_out_426051.awb")

						arg_49_1:RecordAudio("426051012", var_52_13)
						arg_49_1:RecordAudio("426051012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_426051", "426051012", "story_v_out_426051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_426051", "426051012", "story_v_out_426051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play426051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 426051013
		arg_53_1.duration_ = 11.87

		local var_53_0 = {
			zh = 8.7,
			ja = 11.866
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
				arg_53_0:Play426051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_56_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_53_1.stage_.transform)

				var_56_0.name = "1054ui_story"
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1054ui_story"] = var_56_0

				local var_56_1 = var_56_0:GetComponentInChildren(typeof(CharacterEffect))

				var_56_1.enabled = true

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_1.transform, false)

				arg_53_1.var_["1054ui_story" .. "Animator"] = var_56_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_53_1.var_["1054ui_story" .. "LipSync"] = var_56_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_3 = arg_53_1.actors_["1054ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1054ui_story = var_56_3.localPosition

				local var_56_4 = GameObjectTools.GetOrAddComponent(var_56_3.gameObject, typeof(DynamicBoneHelper))

				if var_56_4 then
					var_56_4:EnableDynamicBone(false)
				end
			end

			local var_56_5 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_53_1.time_ - 0) / var_56_5)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles

				local var_56_6 = GameObjectTools.GetOrAddComponent(var_56_3.gameObject, typeof(DynamicBoneHelper))

				if var_56_6 then
					var_56_6:EnableDynamicBone(true)
				end
			end

			local var_56_7 = arg_53_1.actors_["6148ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos6148ui_story = var_56_7.localPosition

				local var_56_8 = GameObjectTools.GetOrAddComponent(var_56_7.gameObject, typeof(DynamicBoneHelper))

				if var_56_8 then
					var_56_8:EnableDynamicBone(false)
				end
			end

			local var_56_9 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 then
				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_53_1.time_ - 0) / var_56_9)
				var_56_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_7.position).x, (manager.ui.mainCamera.transform.position - var_56_7.position).y, (manager.ui.mainCamera.transform.position - var_56_7.position).z)
				var_56_7.localEulerAngles.z = 0
				var_56_7.localEulerAngles.x = 0
				var_56_7.localEulerAngles = var_56_7.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_56_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_7.position).x, (manager.ui.mainCamera.transform.position - var_56_7.position).y, (manager.ui.mainCamera.transform.position - var_56_7.position).z)
				var_56_7.localEulerAngles.z = 0
				var_56_7.localEulerAngles.x = 0
				var_56_7.localEulerAngles = var_56_7.localEulerAngles

				local var_56_10 = GameObjectTools.GetOrAddComponent(var_56_7.gameObject, typeof(DynamicBoneHelper))

				if var_56_10 then
					var_56_10:EnableDynamicBone(true)
				end
			end

			local var_56_11 = arg_53_1.actors_["1054ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect1054ui_story == nil then
				arg_53_1.var_.characterEffect1054ui_story = var_56_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_12 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_12 and not isNil(var_56_11) then
				if arg_53_1.var_.characterEffect1054ui_story and not isNil(var_56_11) then
					arg_53_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_12 and arg_53_1.time_ < 0 + var_56_12 + arg_56_0 and not isNil(var_56_11) and arg_53_1.var_.characterEffect1054ui_story then
				arg_53_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_56_14 = arg_53_1.actors_["6148ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect6148ui_story == nil then
				arg_53_1.var_.characterEffect6148ui_story = var_56_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_15 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_15 and not isNil(var_56_14) then
				if arg_53_1.var_.characterEffect6148ui_story and not isNil(var_56_14) then
					arg_53_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_53_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_15)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_15 and arg_53_1.time_ < 0 + var_56_15 + arg_56_0 and not isNil(var_56_14) and arg_53_1.var_.characterEffect6148ui_story then
				arg_53_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_53_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_56_16 = 0
			local var_56_17 = 0.9

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 then
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

				local var_56_18 = arg_53_1:GetWordFromCfg(426051013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_21 = 36 <= 0 and var_56_17 or var_56_17 * (utf8.len(var_56_19) / 36)

				if (36 <= 0 and var_56_17 or var_56_17 * (utf8.len(var_56_19) / 36)) > 0 and var_56_17 < var_56_21 then
					arg_53_1.talkMaxDuration = var_56_21

					if var_56_21 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_21 + var_56_16
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051013", "story_v_out_426051.awb") ~= 0 then
					local var_56_22 = manager.audio:GetVoiceLength("story_v_out_426051", "426051013", "story_v_out_426051.awb") / 1000

					if var_56_22 + var_56_16 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_16
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_out_426051", "426051013", "story_v_out_426051.awb")

						arg_53_1:RecordAudio("426051013", var_56_23)
						arg_53_1:RecordAudio("426051013", var_56_23)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_426051", "426051013", "story_v_out_426051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_426051", "426051013", "story_v_out_426051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_24 = math.max(var_56_17, arg_53_1.talkMaxDuration)

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_24 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_16) / var_56_24

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_16 + var_56_24 and arg_53_1.time_ < var_56_16 + var_56_24 + arg_56_0 then
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

		arg_53_1:InitPlayNodeList()
	end,
	Play426051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 426051014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play426051015(arg_57_1)
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
			local var_60_2 = 0.8

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

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(426051014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 32 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 32)

				if (32 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 32)) > 0 and var_60_2 < var_60_5 then
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
	Play426051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 426051015
		arg_61_1.duration_ = 8.03

		local var_61_0 = {
			zh = 6.566,
			ja = 8.033
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
				arg_61_0:Play426051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos6148ui_story = arg_61_1.actors_["6148ui_story"].transform.localPosition

				local var_64_0 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_0 then
					var_64_0:EnableDynamicBone(false)
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_61_1.time_ - 0) / var_64_1)
				arg_61_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["6148ui_story"].transform.position).z)
				arg_61_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["6148ui_story"].transform.localEulerAngles = arg_61_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_61_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["6148ui_story"].transform.position).z)
				arg_61_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["6148ui_story"].transform.localEulerAngles = arg_61_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_64_2 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(true)
				end
			end

			local var_64_3 = arg_61_1.actors_["6148ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect6148ui_story == nil then
				arg_61_1.var_.characterEffect6148ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect6148ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect6148ui_story then
				arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.725

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(426051015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 29 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 29)

				if (29 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 29)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051015", "story_v_out_426051.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051015", "story_v_out_426051.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_426051", "426051015", "story_v_out_426051.awb")

						arg_61_1:RecordAudio("426051015", var_64_13)
						arg_61_1:RecordAudio("426051015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_426051", "426051015", "story_v_out_426051.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_426051", "426051015", "story_v_out_426051.awb")
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
				actorName = "6148ui_story",
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
	Play426051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 426051016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play426051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["6148ui_story"]) and arg_65_1.var_.characterEffect6148ui_story == nil then
				arg_65_1.var_.characterEffect6148ui_story = arg_65_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["6148ui_story"]) then
				if arg_65_1.var_.characterEffect6148ui_story and not isNil(arg_65_1.actors_["6148ui_story"]) then
					arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_65_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["6148ui_story"]) and arg_65_1.var_.characterEffect6148ui_story then
				arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_65_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
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

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(426051016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 28 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 28)

				if (28 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 28)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play426051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 426051017
		arg_69_1.duration_ = 5.6

		local var_69_0 = {
			zh = 5.6,
			ja = 5.566
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
				arg_69_0:Play426051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos6148ui_story = arg_69_1.actors_["6148ui_story"].transform.localPosition

				local var_72_0 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_0 then
					var_72_0:EnableDynamicBone(false)
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_69_1.time_ - 0) / var_72_1)
				arg_69_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["6148ui_story"].transform.position).z)
				arg_69_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["6148ui_story"].transform.localEulerAngles = arg_69_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_69_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["6148ui_story"].transform.position).z)
				arg_69_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["6148ui_story"].transform.localEulerAngles = arg_69_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_72_2 = GameObjectTools.GetOrAddComponent(arg_69_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(true)
				end
			end

			local var_72_3 = arg_69_1.actors_["6148ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect6148ui_story == nil then
				arg_69_1.var_.characterEffect6148ui_story = var_72_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 and not isNil(var_72_3) then
				if arg_69_1.var_.characterEffect6148ui_story and not isNil(var_72_3) then
					arg_69_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect6148ui_story then
				arg_69_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			local var_72_6 = 0
			local var_72_7 = 0.4

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(426051017)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 16 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 16)

				if (16 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_9) / 16)) > 0 and var_72_7 < var_72_11 then
					arg_69_1.talkMaxDuration = var_72_11

					if var_72_11 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051017", "story_v_out_426051.awb") ~= 0 then
					local var_72_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051017", "story_v_out_426051.awb") / 1000

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end

					if var_72_8.prefab_name ~= "" and arg_69_1.actors_[var_72_8.prefab_name] ~= nil then
						local var_72_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_8.prefab_name].transform, "story_v_out_426051", "426051017", "story_v_out_426051.awb")

						arg_69_1:RecordAudio("426051017", var_72_13)
						arg_69_1:RecordAudio("426051017", var_72_13)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_426051", "426051017", "story_v_out_426051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_426051", "426051017", "story_v_out_426051.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play426051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 426051018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play426051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["6148ui_story"]) and arg_73_1.var_.characterEffect6148ui_story == nil then
				arg_73_1.var_.characterEffect6148ui_story = arg_73_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["6148ui_story"]) then
				if arg_73_1.var_.characterEffect6148ui_story and not isNil(arg_73_1.actors_["6148ui_story"]) then
					arg_73_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_73_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["6148ui_story"]) and arg_73_1.var_.characterEffect6148ui_story then
				arg_73_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_73_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.4

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(426051018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 16 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 16)

				if (16 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 16)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play426051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 426051019
		arg_77_1.duration_ = 2.33

		local var_77_0 = {
			zh = 2,
			ja = 2.333
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play426051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos6148ui_story = arg_77_1.actors_["6148ui_story"].transform.localPosition

				local var_80_0 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_0 then
					var_80_0:EnableDynamicBone(false)
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_77_1.time_ - 0) / var_80_1)
				arg_77_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["6148ui_story"].transform.position).z)
				arg_77_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["6148ui_story"].transform.localEulerAngles = arg_77_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_77_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["6148ui_story"].transform.position).z)
				arg_77_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["6148ui_story"].transform.localEulerAngles = arg_77_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_80_2 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(true)
				end
			end

			local var_80_3 = arg_77_1.actors_["6148ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect6148ui_story == nil then
				arg_77_1.var_.characterEffect6148ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect6148ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect6148ui_story then
				arg_77_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_80_6 = 0
			local var_80_7 = 0.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(426051019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 4 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 4)

				if (4 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 4)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051019", "story_v_out_426051.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051019", "story_v_out_426051.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_426051", "426051019", "story_v_out_426051.awb")

						arg_77_1:RecordAudio("426051019", var_80_13)
						arg_77_1:RecordAudio("426051019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_426051", "426051019", "story_v_out_426051.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_426051", "426051019", "story_v_out_426051.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play426051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 426051020
		arg_81_1.duration_ = 14.07

		local var_81_0 = {
			zh = 10.033,
			ja = 14.066
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
				arg_81_0:Play426051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1054ui_story"]) and arg_81_1.var_.characterEffect1054ui_story == nil then
				arg_81_1.var_.characterEffect1054ui_story = arg_81_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1054ui_story"]) then
				if arg_81_1.var_.characterEffect1054ui_story and not isNil(arg_81_1.actors_["1054ui_story"]) then
					arg_81_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1054ui_story"]) and arg_81_1.var_.characterEffect1054ui_story then
				arg_81_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["6148ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect6148ui_story == nil then
				arg_81_1.var_.characterEffect6148ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect6148ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_81_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect6148ui_story then
				arg_81_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_81_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_84_4 = 0
			local var_84_5 = 0.975

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(426051020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 39 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 39)

				if (39 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 39)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051020", "story_v_out_426051.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_426051", "426051020", "story_v_out_426051.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_426051", "426051020", "story_v_out_426051.awb")

						arg_81_1:RecordAudio("426051020", var_84_11)
						arg_81_1:RecordAudio("426051020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_426051", "426051020", "story_v_out_426051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_426051", "426051020", "story_v_out_426051.awb")
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

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play426051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 426051021
		arg_85_1.duration_ = 10.23

		local var_85_0 = {
			zh = 6.733,
			ja = 10.233
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
				arg_85_0:Play426051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos6148ui_story = arg_85_1.actors_["6148ui_story"].transform.localPosition

				local var_88_0 = GameObjectTools.GetOrAddComponent(arg_85_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_88_0 then
					var_88_0:EnableDynamicBone(false)
				end
			end

			local var_88_1 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 then
				arg_85_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_85_1.time_ - 0) / var_88_1)
				arg_85_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["6148ui_story"].transform.position).z)
				arg_85_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["6148ui_story"].transform.localEulerAngles = arg_85_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_85_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["6148ui_story"].transform.position).z)
				arg_85_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["6148ui_story"].transform.localEulerAngles = arg_85_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_88_2 = GameObjectTools.GetOrAddComponent(arg_85_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_88_2 then
					var_88_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_88_3 = 0
			local var_88_4 = 0.75

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(426051021)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 30 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 30)

				if (30 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_6) / 30)) > 0 and var_88_4 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051021", "story_v_out_426051.awb") ~= 0 then
					local var_88_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051021", "story_v_out_426051.awb") / 1000

					if var_88_9 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_3
					end

					if var_88_5.prefab_name ~= "" and arg_85_1.actors_[var_88_5.prefab_name] ~= nil then
						local var_88_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_5.prefab_name].transform, "story_v_out_426051", "426051021", "story_v_out_426051.awb")

						arg_85_1:RecordAudio("426051021", var_88_10)
						arg_85_1:RecordAudio("426051021", var_88_10)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_426051", "426051021", "story_v_out_426051.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_426051", "426051021", "story_v_out_426051.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_11 and arg_85_1.time_ < var_88_3 + var_88_11 + arg_88_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play426051022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 426051022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play426051023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1054ui_story"]) and arg_89_1.var_.characterEffect1054ui_story == nil then
				arg_89_1.var_.characterEffect1054ui_story = arg_89_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1054ui_story"]) then
				if arg_89_1.var_.characterEffect1054ui_story and not isNil(arg_89_1.actors_["1054ui_story"]) then
					arg_89_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1054ui_story"]) and arg_89_1.var_.characterEffect1054ui_story then
				arg_89_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.725

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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(426051022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 29 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 29)

				if (29 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 29)) > 0 and var_92_2 < var_92_5 then
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

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play426051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 426051023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play426051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.325

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

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(426051023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 13 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 13)

				if (13 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 13)) > 0 and var_96_0 < var_96_3 then
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
	Play426051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 426051024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play426051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(426051024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 40 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 40)

				if (40 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 40)) > 0 and var_100_0 < var_100_3 then
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
	Play426051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 426051025
		arg_101_1.duration_ = 11.43

		local var_101_0 = {
			zh = 9.2,
			ja = 11.433
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
				arg_101_0:Play426051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos6148ui_story = arg_101_1.actors_["6148ui_story"].transform.localPosition

				local var_104_0 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_0 then
					var_104_0:EnableDynamicBone(false)
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_101_1.time_ - 0) / var_104_1)
				arg_101_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6148ui_story"].transform.position).z)
				arg_101_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["6148ui_story"].transform.localEulerAngles = arg_101_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_101_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["6148ui_story"].transform.position).z)
				arg_101_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["6148ui_story"].transform.localEulerAngles = arg_101_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_104_2 = GameObjectTools.GetOrAddComponent(arg_101_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(true)
				end
			end

			local var_104_3 = arg_101_1.actors_["6148ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect6148ui_story == nil then
				arg_101_1.var_.characterEffect6148ui_story = var_104_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 and not isNil(var_104_3) then
				if arg_101_1.var_.characterEffect6148ui_story and not isNil(var_104_3) then
					arg_101_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect6148ui_story then
				arg_101_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_104_6 = 0
			local var_104_7 = 0.775

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(426051025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 31 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 31)

				if (31 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 31)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051025", "story_v_out_426051.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051025", "story_v_out_426051.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_426051", "426051025", "story_v_out_426051.awb")

						arg_101_1:RecordAudio("426051025", var_104_13)
						arg_101_1:RecordAudio("426051025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_426051", "426051025", "story_v_out_426051.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_426051", "426051025", "story_v_out_426051.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play426051026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 426051026
		arg_105_1.duration_ = 12.83

		local var_105_0 = {
			zh = 11.766,
			ja = 12.833
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
				arg_105_0:Play426051027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1054ui_story = arg_105_1.actors_["1054ui_story"].transform.localPosition

				local var_108_0 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_0 then
					var_108_0:EnableDynamicBone(false)
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_105_1.time_ - 0) / var_108_1)
				arg_105_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).z)
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles = arg_105_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_105_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).z)
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles = arg_105_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_108_2 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(true)
				end
			end

			local var_108_3 = arg_105_1.actors_["1054ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect1054ui_story == nil then
				arg_105_1.var_.characterEffect1054ui_story = var_108_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 and not isNil(var_108_3) then
				if arg_105_1.var_.characterEffect1054ui_story and not isNil(var_108_3) then
					arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect1054ui_story then
				arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_108_6 = arg_105_1.actors_["6148ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect6148ui_story == nil then
				arg_105_1.var_.characterEffect6148ui_story = var_108_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_7 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 and not isNil(var_108_6) then
				if arg_105_1.var_.characterEffect6148ui_story and not isNil(var_108_6) then
					arg_105_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_105_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_7)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 and not isNil(var_108_6) and arg_105_1.var_.characterEffect6148ui_story then
				arg_105_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_105_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_108_8 = 0
			local var_108_9 = 1.15

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:GetWordFromCfg(426051026)
				local var_108_11 = arg_105_1:FormatText(var_108_10.content)

				arg_105_1.text_.text = var_108_11

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_13 = 46 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 46)

				if (46 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_11) / 46)) > 0 and var_108_9 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_11
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051026", "story_v_out_426051.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_426051", "426051026", "story_v_out_426051.awb") / 1000

					if var_108_14 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_8
					end

					if var_108_10.prefab_name ~= "" and arg_105_1.actors_[var_108_10.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_10.prefab_name].transform, "story_v_out_426051", "426051026", "story_v_out_426051.awb")

						arg_105_1:RecordAudio("426051026", var_108_15)
						arg_105_1:RecordAudio("426051026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_426051", "426051026", "story_v_out_426051.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_426051", "426051026", "story_v_out_426051.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_16 and arg_105_1.time_ < var_108_8 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play426051027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 426051027
		arg_109_1.duration_ = 14.3

		local var_109_0 = {
			zh = 11.833,
			ja = 14.3
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
				arg_109_0:Play426051028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(426051027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 44 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 44)

				if (44 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 44)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051027", "story_v_out_426051.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051027", "story_v_out_426051.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_426051", "426051027", "story_v_out_426051.awb")

						arg_109_1:RecordAudio("426051027", var_112_6)
						arg_109_1:RecordAudio("426051027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_426051", "426051027", "story_v_out_426051.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_426051", "426051027", "story_v_out_426051.awb")
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
	Play426051028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 426051028
		arg_113_1.duration_ = 7.7

		local var_113_0 = {
			zh = 7.7,
			ja = 6.533
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
				arg_113_0:Play426051029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["6148ui_story"]) and arg_113_1.var_.characterEffect6148ui_story == nil then
				arg_113_1.var_.characterEffect6148ui_story = arg_113_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["6148ui_story"]) then
				if arg_113_1.var_.characterEffect6148ui_story and not isNil(arg_113_1.actors_["6148ui_story"]) then
					arg_113_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["6148ui_story"]) and arg_113_1.var_.characterEffect6148ui_story then
				arg_113_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["1054ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1054ui_story == nil then
				arg_113_1.var_.characterEffect1054ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect1054ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1054ui_story then
				arg_113_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			local var_116_4 = 0
			local var_116_5 = 0.725

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(426051028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 29 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 29)

				if (29 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 29)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051028", "story_v_out_426051.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_426051", "426051028", "story_v_out_426051.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_426051", "426051028", "story_v_out_426051.awb")

						arg_113_1:RecordAudio("426051028", var_116_11)
						arg_113_1:RecordAudio("426051028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_426051", "426051028", "story_v_out_426051.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_426051", "426051028", "story_v_out_426051.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play426051029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 426051029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play426051030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["6148ui_story"]) and arg_117_1.var_.characterEffect6148ui_story == nil then
				arg_117_1.var_.characterEffect6148ui_story = arg_117_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["6148ui_story"]) then
				if arg_117_1.var_.characterEffect6148ui_story and not isNil(arg_117_1.actors_["6148ui_story"]) then
					arg_117_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_117_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["6148ui_story"]) and arg_117_1.var_.characterEffect6148ui_story then
				arg_117_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_117_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.6

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(426051029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 24 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 24)

				if (24 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 24)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play426051030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 426051030
		arg_121_1.duration_ = 8.27

		local var_121_0 = {
			zh = 8.266,
			ja = 6.566
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
				arg_121_0:Play426051031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos6148ui_story = arg_121_1.actors_["6148ui_story"].transform.localPosition

				local var_124_0 = GameObjectTools.GetOrAddComponent(arg_121_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_124_0 then
					var_124_0:EnableDynamicBone(false)
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_121_1.time_ - 0) / var_124_1)
				arg_121_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).z)
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles = arg_121_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_121_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).z)
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles = arg_121_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_124_2 = GameObjectTools.GetOrAddComponent(arg_121_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_124_2 then
					var_124_2:EnableDynamicBone(true)
				end
			end

			local var_124_3 = arg_121_1.actors_["6148ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect6148ui_story == nil then
				arg_121_1.var_.characterEffect6148ui_story = var_124_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_4 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 and not isNil(var_124_3) then
				if arg_121_1.var_.characterEffect6148ui_story and not isNil(var_124_3) then
					arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect6148ui_story then
				arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action445")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_124_6 = 0
			local var_124_7 = 0.975

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(426051030)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 39 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 39)

				if (39 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 39)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051030", "story_v_out_426051.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051030", "story_v_out_426051.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_426051", "426051030", "story_v_out_426051.awb")

						arg_121_1:RecordAudio("426051030", var_124_13)
						arg_121_1:RecordAudio("426051030", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_426051", "426051030", "story_v_out_426051.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_426051", "426051030", "story_v_out_426051.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play426051031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 426051031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play426051032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["6148ui_story"]) and arg_125_1.var_.characterEffect6148ui_story == nil then
				arg_125_1.var_.characterEffect6148ui_story = arg_125_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["6148ui_story"]) then
				if arg_125_1.var_.characterEffect6148ui_story and not isNil(arg_125_1.actors_["6148ui_story"]) then
					arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_125_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["6148ui_story"]) and arg_125_1.var_.characterEffect6148ui_story then
				arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_125_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_128_1 = arg_125_1.actors_["6148ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos6148ui_story = var_128_1.localPosition

				local var_128_2 = GameObjectTools.GetOrAddComponent(var_128_1.gameObject, typeof(DynamicBoneHelper))

				if var_128_2 then
					var_128_2:EnableDynamicBone(false)
				end
			end

			local var_128_3 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 then
				var_128_1.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_3)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 then
				var_128_1.localPosition = Vector3.New(0, 100, 0)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles

				local var_128_4 = GameObjectTools.GetOrAddComponent(var_128_1.gameObject, typeof(DynamicBoneHelper))

				if var_128_4 then
					var_128_4:EnableDynamicBone(true)
				end
			end

			local var_128_5 = arg_125_1.actors_["1054ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1054ui_story = var_128_5.localPosition

				local var_128_6 = GameObjectTools.GetOrAddComponent(var_128_5.gameObject, typeof(DynamicBoneHelper))

				if var_128_6 then
					var_128_6:EnableDynamicBone(false)
				end
			end

			local var_128_7 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				var_128_5.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_7)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				var_128_5.localPosition = Vector3.New(0, 100, 0)
				var_128_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_5.position).x, (manager.ui.mainCamera.transform.position - var_128_5.position).y, (manager.ui.mainCamera.transform.position - var_128_5.position).z)
				var_128_5.localEulerAngles.z = 0
				var_128_5.localEulerAngles.x = 0
				var_128_5.localEulerAngles = var_128_5.localEulerAngles

				local var_128_8 = GameObjectTools.GetOrAddComponent(var_128_5.gameObject, typeof(DynamicBoneHelper))

				if var_128_8 then
					var_128_8:EnableDynamicBone(true)
				end
			end

			local var_128_9 = 0
			local var_128_10 = 1.05

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_11 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(426051031).content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 42 <= 0 and var_128_10 or var_128_10 * (utf8.len(var_128_11) / 42)

				if (42 <= 0 and var_128_10 or var_128_10 * (utf8.len(var_128_11) / 42)) > 0 and var_128_10 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_9
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_10, arg_125_1.talkMaxDuration)

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_9) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_9 + var_128_14 and arg_125_1.time_ < var_128_9 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
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

		arg_125_1:InitPlayNodeList()
	end,
	Play426051032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 426051032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play426051033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(426051032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 40 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 40)

				if (40 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 40)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play426051033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 426051033
		arg_133_1.duration_ = 12.47

		local var_133_0 = {
			zh = 10.533,
			ja = 12.466
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
				arg_133_0:Play426051034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1054ui_story = arg_133_1.actors_["1054ui_story"].transform.localPosition

				local var_136_0 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_0 then
					var_136_0:EnableDynamicBone(false)
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_133_1.time_ - 0) / var_136_1)
				arg_133_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).z)
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles = arg_133_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_133_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1054ui_story"].transform.position).z)
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1054ui_story"].transform.localEulerAngles = arg_133_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_136_2 = GameObjectTools.GetOrAddComponent(arg_133_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(true)
				end
			end

			local var_136_3 = arg_133_1.actors_["1054ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1054ui_story == nil then
				arg_133_1.var_.characterEffect1054ui_story = var_136_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 and not isNil(var_136_3) then
				if arg_133_1.var_.characterEffect1054ui_story and not isNil(var_136_3) then
					arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1054ui_story then
				arg_133_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_136_6 = 0
			local var_136_7 = 0.975

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(426051033)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 39 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 39)

				if (39 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 39)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051033", "story_v_out_426051.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051033", "story_v_out_426051.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_426051", "426051033", "story_v_out_426051.awb")

						arg_133_1:RecordAudio("426051033", var_136_13)
						arg_133_1:RecordAudio("426051033", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_426051", "426051033", "story_v_out_426051.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_426051", "426051033", "story_v_out_426051.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play426051034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 426051034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play426051035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos6148ui_story = arg_137_1.actors_["6148ui_story"].transform.localPosition

				local var_140_0 = GameObjectTools.GetOrAddComponent(arg_137_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_140_0 then
					var_140_0:EnableDynamicBone(false)
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_1)
				arg_137_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["6148ui_story"].transform.position).z)
				arg_137_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["6148ui_story"].transform.localEulerAngles = arg_137_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["6148ui_story"].transform.position).z)
				arg_137_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["6148ui_story"].transform.localEulerAngles = arg_137_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_140_2 = GameObjectTools.GetOrAddComponent(arg_137_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(true)
				end
			end

			local var_140_3 = arg_137_1.actors_["1054ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1054ui_story = var_140_3.localPosition

				local var_140_4 = GameObjectTools.GetOrAddComponent(var_140_3.gameObject, typeof(DynamicBoneHelper))

				if var_140_4 then
					var_140_4:EnableDynamicBone(false)
				end
			end

			local var_140_5 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 then
				var_140_3.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_5)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 then
				var_140_3.localPosition = Vector3.New(0, 100, 0)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles

				local var_140_6 = GameObjectTools.GetOrAddComponent(var_140_3.gameObject, typeof(DynamicBoneHelper))

				if var_140_6 then
					var_140_6:EnableDynamicBone(true)
				end
			end

			local var_140_7 = arg_137_1.actors_["1054ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect1054ui_story == nil then
				arg_137_1.var_.characterEffect1054ui_story = var_140_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_8 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_8 and not isNil(var_140_7) then
				if arg_137_1.var_.characterEffect1054ui_story and not isNil(var_140_7) then
					arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_8)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_8 and arg_137_1.time_ < 0 + var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect1054ui_story then
				arg_137_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_140_9 = 0
			local var_140_10 = 0.7

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_11 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(426051034).content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 28 <= 0 and var_140_10 or var_140_10 * (utf8.len(var_140_11) / 28)

				if (28 <= 0 and var_140_10 or var_140_10 * (utf8.len(var_140_11) / 28)) > 0 and var_140_10 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_9 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_9
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_10, arg_137_1.talkMaxDuration)

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_9) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_9 + var_140_14 and arg_137_1.time_ < var_140_9 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play426051035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 426051035
		arg_141_1.duration_ = 4.53

		local var_141_0 = {
			zh = 4.3,
			ja = 4.533
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
				arg_141_0:Play426051036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos6148ui_story = arg_141_1.actors_["6148ui_story"].transform.localPosition

				local var_144_0 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_0 then
					var_144_0:EnableDynamicBone(false)
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_141_1.time_ - 0) / var_144_1)
				arg_141_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["6148ui_story"].transform.position).z)
				arg_141_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["6148ui_story"].transform.localEulerAngles = arg_141_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_141_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["6148ui_story"].transform.position).z)
				arg_141_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["6148ui_story"].transform.localEulerAngles = arg_141_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_144_2 = GameObjectTools.GetOrAddComponent(arg_141_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(true)
				end
			end

			local var_144_3 = arg_141_1.actors_["6148ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect6148ui_story == nil then
				arg_141_1.var_.characterEffect6148ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect6148ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect6148ui_story then
				arg_141_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_6 = 0
			local var_144_7 = 0.475

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:GetWordFromCfg(426051035)
				local var_144_9 = arg_141_1:FormatText(var_144_8.content)

				arg_141_1.text_.text = var_144_9

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 19 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 19)

				if (19 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_9) / 19)) > 0 and var_144_7 < var_144_11 then
					arg_141_1.talkMaxDuration = var_144_11

					if var_144_11 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_9
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051035", "story_v_out_426051.awb") ~= 0 then
					local var_144_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051035", "story_v_out_426051.awb") / 1000

					if var_144_12 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_12 + var_144_6
					end

					if var_144_8.prefab_name ~= "" and arg_141_1.actors_[var_144_8.prefab_name] ~= nil then
						local var_144_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_8.prefab_name].transform, "story_v_out_426051", "426051035", "story_v_out_426051.awb")

						arg_141_1:RecordAudio("426051035", var_144_13)
						arg_141_1:RecordAudio("426051035", var_144_13)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_426051", "426051035", "story_v_out_426051.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_426051", "426051035", "story_v_out_426051.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play426051036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 426051036
		arg_145_1.duration_ = 11.73

		local var_145_0 = {
			zh = 10.1,
			ja = 11.733
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
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play426051037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				local var_148_0 = arg_145_1.bgs_.ST2007a

				arg_145_1.bgs_.ST2007a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_148_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_1 = var_148_0:GetComponent("SpriteRenderer")

				if var_148_1 and var_148_1.sprite then
					local var_148_2 = 2 * (var_148_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_148_0.transform.localScale = Vector3.New(var_148_2 / var_148_1.sprite.bounds.size.y < var_148_2 * manager.ui.mainCameraCom_.aspect / var_148_1.sprite.bounds.size.x and var_148_2 * manager.ui.mainCameraCom_.aspect / var_148_1.sprite.bounds.size.x or var_148_2 / var_148_1.sprite.bounds.size.y, var_148_2 / var_148_1.sprite.bounds.size.y < var_148_2 * manager.ui.mainCameraCom_.aspect / var_148_1.sprite.bounds.size.x and var_148_2 * manager.ui.mainCameraCom_.aspect / var_148_1.sprite.bounds.size.x or var_148_2 / var_148_1.sprite.bounds.size.y, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "ST2007a" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_148_3 = 4

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_3 + 0.3 and arg_145_1.time_ < var_148_3 + 0.3 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			local var_148_4 = 0

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_5 = 2

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_5 then
				local var_148_6 = Color.New(0, 0, 0)

				var_148_6.a = Mathf.Lerp(0, 1, (arg_145_1.time_ - var_148_4) / var_148_5)
				arg_145_1.mask_.color = var_148_6
			end

			if arg_145_1.time_ >= var_148_4 + var_148_5 and arg_145_1.time_ < var_148_4 + var_148_5 + arg_148_0 then
				local var_148_7 = Color.New(0, 0, 0)

				var_148_7.a = 1
				arg_145_1.mask_.color = var_148_7
			end

			local var_148_8 = 2

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.mask_.enabled = true
				arg_145_1.mask_.raycastTarget = true

				arg_145_1:SetGaussion(false)
			end

			local var_148_9 = 2

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 then
				local var_148_10 = Color.New(0, 0, 0)

				var_148_10.a = Mathf.Lerp(1, 0, (arg_145_1.time_ - var_148_8) / var_148_9)
				arg_145_1.mask_.color = var_148_10
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 then
				local var_148_11 = Color.New(0, 0, 0)

				arg_145_1.mask_.enabled = false
				var_148_11.a = 0
				arg_145_1.mask_.color = var_148_11
			end

			local var_148_12 = arg_145_1.actors_["6148ui_story"].transform

			if 3.8 < arg_145_1.time_ and arg_145_1.time_ <= 3.8 + arg_148_0 then
				arg_145_1.var_.moveOldPos6148ui_story = var_148_12.localPosition

				local var_148_13 = GameObjectTools.GetOrAddComponent(var_148_12.gameObject, typeof(DynamicBoneHelper))

				if var_148_13 then
					var_148_13:EnableDynamicBone(false)
				end
			end

			local var_148_14 = 0.001

			if 3.8 <= arg_145_1.time_ and arg_145_1.time_ < 3.8 + var_148_14 then
				var_148_12.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_145_1.time_ - 3.8) / var_148_14)
				var_148_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_12.position).x, (manager.ui.mainCamera.transform.position - var_148_12.position).y, (manager.ui.mainCamera.transform.position - var_148_12.position).z)
				var_148_12.localEulerAngles.z = 0
				var_148_12.localEulerAngles.x = 0
				var_148_12.localEulerAngles = var_148_12.localEulerAngles
			end

			if arg_145_1.time_ >= 3.8 + var_148_14 and arg_145_1.time_ < 3.8 + var_148_14 + arg_148_0 then
				var_148_12.localPosition = Vector3.New(0, -0.985, -6)
				var_148_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_12.position).x, (manager.ui.mainCamera.transform.position - var_148_12.position).y, (manager.ui.mainCamera.transform.position - var_148_12.position).z)
				var_148_12.localEulerAngles.z = 0
				var_148_12.localEulerAngles.x = 0
				var_148_12.localEulerAngles = var_148_12.localEulerAngles

				local var_148_15 = GameObjectTools.GetOrAddComponent(var_148_12.gameObject, typeof(DynamicBoneHelper))

				if var_148_15 then
					var_148_15:EnableDynamicBone(true)
				end
			end

			if 3.8 < arg_145_1.time_ and arg_145_1.time_ <= 3.8 + arg_148_0 then
				arg_145_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 3.8 < arg_145_1.time_ and arg_145_1.time_ <= 3.8 + arg_148_0 then
				arg_145_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_16 = arg_145_1.actors_["6148ui_story"].transform

			if 1.96599999815226 < arg_145_1.time_ and arg_145_1.time_ <= 1.96599999815226 + arg_148_0 then
				arg_145_1.var_.moveOldPos6148ui_story = var_148_16.localPosition

				local var_148_17 = GameObjectTools.GetOrAddComponent(var_148_16.gameObject, typeof(DynamicBoneHelper))

				if var_148_17 then
					var_148_17:EnableDynamicBone(false)
				end
			end

			local var_148_18 = 0.001

			if 1.96599999815226 <= arg_145_1.time_ and arg_145_1.time_ < 1.96599999815226 + var_148_18 then
				var_148_16.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 1.96599999815226) / var_148_18)
				var_148_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_16.position).x, (manager.ui.mainCamera.transform.position - var_148_16.position).y, (manager.ui.mainCamera.transform.position - var_148_16.position).z)
				var_148_16.localEulerAngles.z = 0
				var_148_16.localEulerAngles.x = 0
				var_148_16.localEulerAngles = var_148_16.localEulerAngles
			end

			if arg_145_1.time_ >= 1.96599999815226 + var_148_18 and arg_145_1.time_ < 1.96599999815226 + var_148_18 + arg_148_0 then
				var_148_16.localPosition = Vector3.New(0, 100, 0)
				var_148_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_16.position).x, (manager.ui.mainCamera.transform.position - var_148_16.position).y, (manager.ui.mainCamera.transform.position - var_148_16.position).z)
				var_148_16.localEulerAngles.z = 0
				var_148_16.localEulerAngles.x = 0
				var_148_16.localEulerAngles = var_148_16.localEulerAngles

				local var_148_19 = GameObjectTools.GetOrAddComponent(var_148_16.gameObject, typeof(DynamicBoneHelper))

				if var_148_19 then
					var_148_19:EnableDynamicBone(true)
				end
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_20 = 4
			local var_148_21 = 0.675

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_20 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_22 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_22:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_23 = arg_145_1:GetWordFromCfg(426051036)
				local var_148_24 = arg_145_1:FormatText(var_148_23.content)

				arg_145_1.text_.text = var_148_24

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_26 = 27 <= 0 and var_148_21 or var_148_21 * (utf8.len(var_148_24) / 27)

				if (27 <= 0 and var_148_21 or var_148_21 * (utf8.len(var_148_24) / 27)) > 0 and var_148_21 < var_148_26 then
					arg_145_1.talkMaxDuration = var_148_26
					var_148_20 = var_148_20 + 0.3

					if var_148_26 + var_148_20 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_26 + var_148_20
					end
				end

				arg_145_1.text_.text = var_148_24
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051036", "story_v_out_426051.awb") ~= 0 then
					local var_148_27 = manager.audio:GetVoiceLength("story_v_out_426051", "426051036", "story_v_out_426051.awb") / 1000

					if var_148_27 + var_148_20 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_27 + var_148_20
					end

					if var_148_23.prefab_name ~= "" and arg_145_1.actors_[var_148_23.prefab_name] ~= nil then
						local var_148_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_23.prefab_name].transform, "story_v_out_426051", "426051036", "story_v_out_426051.awb")

						arg_145_1:RecordAudio("426051036", var_148_28)
						arg_145_1:RecordAudio("426051036", var_148_28)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_426051", "426051036", "story_v_out_426051.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_426051", "426051036", "story_v_out_426051.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_29 = var_148_20 + 0.3
			local var_148_30 = math.max(var_148_21, arg_145_1.talkMaxDuration)

			if var_148_20 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_29 + var_148_30 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_29) / var_148_30

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_29 + var_148_30 and arg_145_1.time_ < var_148_29 + var_148_30 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_145_1:InitPlayNodeList()
	end,
	Play426051037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 426051037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play426051038(arg_151_1)
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
			local var_154_2 = 0.325

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

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(426051037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 13 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 13)

				if (13 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 13)) > 0 and var_154_2 < var_154_5 then
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
	Play426051038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 426051038
		arg_155_1.duration_ = 6.3

		local var_155_0 = {
			zh = 2.466,
			ja = 6.3
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
				arg_155_0:Play426051039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos6148ui_story = arg_155_1.actors_["6148ui_story"].transform.localPosition

				local var_158_0 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_0 then
					var_158_0:EnableDynamicBone(false)
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_155_1.time_ - 0) / var_158_1)
				arg_155_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["6148ui_story"].transform.position).z)
				arg_155_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["6148ui_story"].transform.localEulerAngles = arg_155_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_155_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["6148ui_story"].transform.position).z)
				arg_155_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["6148ui_story"].transform.localEulerAngles = arg_155_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_158_2 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(true)
				end
			end

			local var_158_3 = arg_155_1.actors_["6148ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect6148ui_story == nil then
				arg_155_1.var_.characterEffect6148ui_story = var_158_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_4 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 and not isNil(var_158_3) then
				if arg_155_1.var_.characterEffect6148ui_story and not isNil(var_158_3) then
					arg_155_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 and not isNil(var_158_3) and arg_155_1.var_.characterEffect6148ui_story then
				arg_155_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.275

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
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

				local var_158_8 = arg_155_1:GetWordFromCfg(426051038)
				local var_158_9 = arg_155_1:FormatText(var_158_8.content)

				arg_155_1.text_.text = var_158_9

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 11 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 11)

				if (11 <= 0 and var_158_7 or var_158_7 * (utf8.len(var_158_9) / 11)) > 0 and var_158_7 < var_158_11 then
					arg_155_1.talkMaxDuration = var_158_11

					if var_158_11 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_9
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051038", "story_v_out_426051.awb") ~= 0 then
					local var_158_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051038", "story_v_out_426051.awb") / 1000

					if var_158_12 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_12 + var_158_6
					end

					if var_158_8.prefab_name ~= "" and arg_155_1.actors_[var_158_8.prefab_name] ~= nil then
						local var_158_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_8.prefab_name].transform, "story_v_out_426051", "426051038", "story_v_out_426051.awb")

						arg_155_1:RecordAudio("426051038", var_158_13)
						arg_155_1:RecordAudio("426051038", var_158_13)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_426051", "426051038", "story_v_out_426051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_426051", "426051038", "story_v_out_426051.awb")
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
				actorName = "6148ui_story",
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
	Play426051039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 426051039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play426051040(arg_159_1)
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

			local var_162_3 = arg_159_1.actors_["6148ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect6148ui_story == nil then
				arg_159_1.var_.characterEffect6148ui_story = var_162_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_4 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 and not isNil(var_162_3) then
				if arg_159_1.var_.characterEffect6148ui_story and not isNil(var_162_3) then
					arg_159_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_159_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_4)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect6148ui_story then
				arg_159_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_159_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0.7 < arg_159_1.time_ and arg_159_1.time_ <= 0.7 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep02", "")
			end

			local var_162_6 = 0
			local var_162_7 = 1

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(426051039).content)

				arg_159_1.text_.text = var_162_8

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_10 = 40 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_8) / 40)

				if (40 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_8) / 40)) > 0 and var_162_7 < var_162_10 then
					arg_159_1.talkMaxDuration = var_162_10

					if var_162_10 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_8
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_11 and arg_159_1.time_ < var_162_6 + var_162_11 + arg_162_0 then
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
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play426051040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 426051040
		arg_163_1.duration_ = 6.9

		local var_163_0 = {
			zh = 6.8,
			ja = 6.9
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
				arg_163_0:Play426051041(arg_163_1)
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
				arg_163_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_163_1.time_ - 0) / var_166_1)
				arg_163_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["6148ui_story"].transform.position).z)
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["6148ui_story"].transform.localEulerAngles = arg_163_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
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
				arg_163_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_166_6 = 0
			local var_166_7 = 0.85

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

				local var_166_8 = arg_163_1:GetWordFromCfg(426051040)
				local var_166_9 = arg_163_1:FormatText(var_166_8.content)

				arg_163_1.text_.text = var_166_9

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 34 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 34)

				if (34 <= 0 and var_166_7 or var_166_7 * (utf8.len(var_166_9) / 34)) > 0 and var_166_7 < var_166_11 then
					arg_163_1.talkMaxDuration = var_166_11

					if var_166_11 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_11 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_9
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051040", "story_v_out_426051.awb") ~= 0 then
					local var_166_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051040", "story_v_out_426051.awb") / 1000

					if var_166_12 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_6
					end

					if var_166_8.prefab_name ~= "" and arg_163_1.actors_[var_166_8.prefab_name] ~= nil then
						local var_166_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_8.prefab_name].transform, "story_v_out_426051", "426051040", "story_v_out_426051.awb")

						arg_163_1:RecordAudio("426051040", var_166_13)
						arg_163_1:RecordAudio("426051040", var_166_13)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_426051", "426051040", "story_v_out_426051.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_426051", "426051040", "story_v_out_426051.awb")
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
	Play426051041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 426051041
		arg_167_1.duration_ = 3.23

		local var_167_0 = {
			zh = 1.999999999999,
			ja = 3.233
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
				arg_167_0:Play426051042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1054ui_story = arg_167_1.actors_["1054ui_story"].transform.localPosition

				local var_170_0 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_0 then
					var_170_0:EnableDynamicBone(false)
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_167_1.time_ - 0) / var_170_1)
				arg_167_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1054ui_story"].transform.position).z)
				arg_167_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1054ui_story"].transform.localEulerAngles = arg_167_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_167_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1054ui_story"].transform.position).z)
				arg_167_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1054ui_story"].transform.localEulerAngles = arg_167_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_170_2 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(true)
				end
			end

			local var_170_3 = arg_167_1.actors_["1054ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1054ui_story == nil then
				arg_167_1.var_.characterEffect1054ui_story = var_170_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_4 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 and not isNil(var_170_3) then
				if arg_167_1.var_.characterEffect1054ui_story and not isNil(var_170_3) then
					arg_167_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1054ui_story then
				arg_167_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_170_6 = arg_167_1.actors_["6148ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect6148ui_story == nil then
				arg_167_1.var_.characterEffect6148ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_7 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 and not isNil(var_170_6) then
				if arg_167_1.var_.characterEffect6148ui_story and not isNil(var_170_6) then
					arg_167_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_167_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_7)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect6148ui_story then
				arg_167_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_167_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_170_8 = 0
			local var_170_9 = 0.1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(426051041)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 4 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 4)

				if (4 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 4)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051041", "story_v_out_426051.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_426051", "426051041", "story_v_out_426051.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_426051", "426051041", "story_v_out_426051.awb")

						arg_167_1:RecordAudio("426051041", var_170_15)
						arg_167_1:RecordAudio("426051041", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_426051", "426051041", "story_v_out_426051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_426051", "426051041", "story_v_out_426051.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play426051042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 426051042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play426051043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos6148ui_story = arg_171_1.actors_["6148ui_story"].transform.localPosition

				local var_174_0 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_0 then
					var_174_0:EnableDynamicBone(false)
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_1)
				arg_171_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["6148ui_story"].transform.position).z)
				arg_171_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["6148ui_story"].transform.localEulerAngles = arg_171_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["6148ui_story"].transform.position).z)
				arg_171_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["6148ui_story"].transform.localEulerAngles = arg_171_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_174_2 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(true)
				end
			end

			local var_174_3 = arg_171_1.actors_["1054ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1054ui_story = var_174_3.localPosition

				local var_174_4 = GameObjectTools.GetOrAddComponent(var_174_3.gameObject, typeof(DynamicBoneHelper))

				if var_174_4 then
					var_174_4:EnableDynamicBone(false)
				end
			end

			local var_174_5 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_5)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, 100, 0)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles

				local var_174_6 = GameObjectTools.GetOrAddComponent(var_174_3.gameObject, typeof(DynamicBoneHelper))

				if var_174_6 then
					var_174_6:EnableDynamicBone(true)
				end
			end

			local var_174_7 = arg_171_1.actors_["1054ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.characterEffect1054ui_story == nil then
				arg_171_1.var_.characterEffect1054ui_story = var_174_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_8 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_8 and not isNil(var_174_7) then
				if arg_171_1.var_.characterEffect1054ui_story and not isNil(var_174_7) then
					arg_171_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_8)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_8 and arg_171_1.time_ < 0 + var_174_8 + arg_174_0 and not isNil(var_174_7) and arg_171_1.var_.characterEffect1054ui_story then
				arg_171_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_174_9 = 0
			local var_174_10 = 0.775

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_11 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(426051042).content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 31 <= 0 and var_174_10 or var_174_10 * (utf8.len(var_174_11) / 31)

				if (31 <= 0 and var_174_10 or var_174_10 * (utf8.len(var_174_11) / 31)) > 0 and var_174_10 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_9 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_9
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_10, arg_171_1.talkMaxDuration)

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_9) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_9 + var_174_14 and arg_171_1.time_ < var_174_9 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play426051043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 426051043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play426051044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.15

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(426051043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 6 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 6)

				if (6 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 6)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play426051044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 426051044
		arg_179_1.duration_ = 3.33

		local var_179_0 = {
			zh = 2.266,
			ja = 3.333
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play426051045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos6148ui_story = arg_179_1.actors_["6148ui_story"].transform.localPosition

				local var_182_0 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_0 then
					var_182_0:EnableDynamicBone(false)
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_179_1.time_ - 0) / var_182_1)
				arg_179_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["6148ui_story"].transform.position).z)
				arg_179_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["6148ui_story"].transform.localEulerAngles = arg_179_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_179_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["6148ui_story"].transform.position).z)
				arg_179_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["6148ui_story"].transform.localEulerAngles = arg_179_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_182_2 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(true)
				end
			end

			local var_182_3 = arg_179_1.actors_["6148ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect6148ui_story == nil then
				arg_179_1.var_.characterEffect6148ui_story = var_182_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_4 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 and not isNil(var_182_3) then
				if arg_179_1.var_.characterEffect6148ui_story and not isNil(var_182_3) then
					arg_179_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 and not isNil(var_182_3) and arg_179_1.var_.characterEffect6148ui_story then
				arg_179_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_182_6 = 0
			local var_182_7 = 0.5

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:GetWordFromCfg(426051044)
				local var_182_9 = arg_179_1:FormatText(var_182_8.content)

				arg_179_1.text_.text = var_182_9

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_11 = 20 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 20)

				if (20 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_9) / 20)) > 0 and var_182_7 < var_182_11 then
					arg_179_1.talkMaxDuration = var_182_11

					if var_182_11 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_9
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051044", "story_v_out_426051.awb") ~= 0 then
					local var_182_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051044", "story_v_out_426051.awb") / 1000

					if var_182_12 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_12 + var_182_6
					end

					if var_182_8.prefab_name ~= "" and arg_179_1.actors_[var_182_8.prefab_name] ~= nil then
						local var_182_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_8.prefab_name].transform, "story_v_out_426051", "426051044", "story_v_out_426051.awb")

						arg_179_1:RecordAudio("426051044", var_182_13)
						arg_179_1:RecordAudio("426051044", var_182_13)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_426051", "426051044", "story_v_out_426051.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_426051", "426051044", "story_v_out_426051.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_14 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_14 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_14

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_14 and arg_179_1.time_ < var_182_6 + var_182_14 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play426051045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 426051045
		arg_183_1.duration_ = 6.03

		local var_183_0 = {
			zh = 6.033,
			ja = 4.866
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
				arg_183_0:Play426051046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos6148ui_story = arg_183_1.actors_["6148ui_story"].transform.localPosition

				local var_186_0 = GameObjectTools.GetOrAddComponent(arg_183_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_186_0 then
					var_186_0:EnableDynamicBone(false)
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_183_1.time_ - 0) / var_186_1)
				arg_183_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).z)
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles = arg_183_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_183_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["6148ui_story"].transform.position).z)
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["6148ui_story"].transform.localEulerAngles = arg_183_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_186_2 = GameObjectTools.GetOrAddComponent(arg_183_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_186_3 = 0
			local var_186_4 = 0.75

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
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

				local var_186_5 = arg_183_1:GetWordFromCfg(426051045)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 30 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 30)

				if (30 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 30)) > 0 and var_186_4 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051045", "story_v_out_426051.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051045", "story_v_out_426051.awb") / 1000

					if var_186_9 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_3
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_out_426051", "426051045", "story_v_out_426051.awb")

						arg_183_1:RecordAudio("426051045", var_186_10)
						arg_183_1:RecordAudio("426051045", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_426051", "426051045", "story_v_out_426051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_426051", "426051045", "story_v_out_426051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_11 and arg_183_1.time_ < var_186_3 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play426051046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 426051046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play426051047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["6148ui_story"]) and arg_187_1.var_.characterEffect6148ui_story == nil then
				arg_187_1.var_.characterEffect6148ui_story = arg_187_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["6148ui_story"]) then
				if arg_187_1.var_.characterEffect6148ui_story and not isNil(arg_187_1.actors_["6148ui_story"]) then
					arg_187_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_187_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["6148ui_story"]) and arg_187_1.var_.characterEffect6148ui_story then
				arg_187_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_187_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.8

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(426051046).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 32 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 32)

				if (32 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 32)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play426051047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 426051047
		arg_191_1.duration_ = 5.57

		local var_191_0 = {
			zh = 5.566,
			ja = 5.1
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
				arg_191_0:Play426051048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos6148ui_story = arg_191_1.actors_["6148ui_story"].transform.localPosition

				local var_194_0 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_0 then
					var_194_0:EnableDynamicBone(false)
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_191_1.time_ - 0) / var_194_1)
				arg_191_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["6148ui_story"].transform.position).z)
				arg_191_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["6148ui_story"].transform.localEulerAngles = arg_191_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_191_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["6148ui_story"].transform.position).z)
				arg_191_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["6148ui_story"].transform.localEulerAngles = arg_191_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_194_2 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(true)
				end
			end

			local var_194_3 = arg_191_1.actors_["6148ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect6148ui_story == nil then
				arg_191_1.var_.characterEffect6148ui_story = var_194_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 and not isNil(var_194_3) then
				if arg_191_1.var_.characterEffect6148ui_story and not isNil(var_194_3) then
					arg_191_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect6148ui_story then
				arg_191_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_194_6 = 0
			local var_194_7 = 0.475

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(426051047)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 19 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 19)

				if (19 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 19)) > 0 and var_194_7 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051047", "story_v_out_426051.awb") ~= 0 then
					local var_194_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051047", "story_v_out_426051.awb") / 1000

					if var_194_12 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_6
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_426051", "426051047", "story_v_out_426051.awb")

						arg_191_1:RecordAudio("426051047", var_194_13)
						arg_191_1:RecordAudio("426051047", var_194_13)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_426051", "426051047", "story_v_out_426051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_426051", "426051047", "story_v_out_426051.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play426051048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 426051048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play426051049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["6148ui_story"]) and arg_195_1.var_.characterEffect6148ui_story == nil then
				arg_195_1.var_.characterEffect6148ui_story = arg_195_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["6148ui_story"]) then
				if arg_195_1.var_.characterEffect6148ui_story and not isNil(arg_195_1.actors_["6148ui_story"]) then
					arg_195_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_195_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["6148ui_story"]) and arg_195_1.var_.characterEffect6148ui_story then
				arg_195_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_195_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.15

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
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

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(426051048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 6 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 6)

				if (6 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 6)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play426051049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 426051049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play426051050(arg_199_1)
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
				arg_199_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_1)
				arg_199_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).z)
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles = arg_199_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["6148ui_story"].transform.position).z)
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["6148ui_story"].transform.localEulerAngles = arg_199_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_202_2 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(true)
				end
			end

			if 0.733333333333333 < arg_199_1.time_ and arg_199_1.time_ <= 0.733333333333333 + arg_202_0 then
				arg_199_1:AudioAction("play", "effect", "se_story_side_1084", "se_story_1084_electric", "")
			end

			local var_202_4 = 0
			local var_202_5 = 1.125

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(426051049).content)

				arg_199_1.text_.text = var_202_6

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_8 = 45 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 45)

				if (45 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 45)) > 0 and var_202_5 < var_202_8 then
					arg_199_1.talkMaxDuration = var_202_8

					if var_202_8 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_6
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_9 and arg_199_1.time_ < var_202_4 + var_202_9 + arg_202_0 then
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
	Play426051050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 426051050
		arg_203_1.duration_ = 3.3

		local var_203_0 = {
			zh = 3.3,
			ja = 1.999999999999
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
				arg_203_0:Play426051051(arg_203_1)
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
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_206_6 = 0
			local var_206_7 = 0.4

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

				local var_206_8 = arg_203_1:GetWordFromCfg(426051050)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 16 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 16)

				if (16 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 16)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051050", "story_v_out_426051.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051050", "story_v_out_426051.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_426051", "426051050", "story_v_out_426051.awb")

						arg_203_1:RecordAudio("426051050", var_206_13)
						arg_203_1:RecordAudio("426051050", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_426051", "426051050", "story_v_out_426051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_426051", "426051050", "story_v_out_426051.awb")
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
	Play426051051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 426051051
		arg_207_1.duration_ = 3.93

		local var_207_0 = {
			zh = 3.933,
			ja = 1.999999999999
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
				arg_207_0:Play426051052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1054ui_story = arg_207_1.actors_["1054ui_story"].transform.localPosition

				local var_210_0 = GameObjectTools.GetOrAddComponent(arg_207_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_210_0 then
					var_210_0:EnableDynamicBone(false)
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_207_1.time_ - 0) / var_210_1)
				arg_207_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1054ui_story"].transform.position).z)
				arg_207_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1054ui_story"].transform.localEulerAngles = arg_207_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_207_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1054ui_story"].transform.position).z)
				arg_207_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1054ui_story"].transform.localEulerAngles = arg_207_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_210_2 = GameObjectTools.GetOrAddComponent(arg_207_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_210_2 then
					var_210_2:EnableDynamicBone(true)
				end
			end

			local var_210_3 = arg_207_1.actors_["1054ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1054ui_story == nil then
				arg_207_1.var_.characterEffect1054ui_story = var_210_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_4 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 and not isNil(var_210_3) then
				if arg_207_1.var_.characterEffect1054ui_story and not isNil(var_210_3) then
					arg_207_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1054ui_story then
				arg_207_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_210_6 = arg_207_1.actors_["6148ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect6148ui_story == nil then
				arg_207_1.var_.characterEffect6148ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_7 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 and not isNil(var_210_6) then
				if arg_207_1.var_.characterEffect6148ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_207_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_7)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect6148ui_story then
				arg_207_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_207_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_210_8 = 0
			local var_210_9 = 0.4

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(426051051)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 16 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 16)

				if (16 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 16)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051051", "story_v_out_426051.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_426051", "426051051", "story_v_out_426051.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_426051", "426051051", "story_v_out_426051.awb")

						arg_207_1:RecordAudio("426051051", var_210_15)
						arg_207_1:RecordAudio("426051051", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_426051", "426051051", "story_v_out_426051.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_426051", "426051051", "story_v_out_426051.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play426051052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 426051052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play426051053(arg_211_1)
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
				arg_211_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_1)
				arg_211_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).z)
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles = arg_211_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["6148ui_story"].transform.position).z)
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["6148ui_story"].transform.localEulerAngles = arg_211_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_214_2 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(true)
				end
			end

			local var_214_3 = arg_211_1.actors_["1054ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1054ui_story == nil then
				arg_211_1.var_.characterEffect1054ui_story = var_214_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_4 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 and not isNil(var_214_3) then
				if arg_211_1.var_.characterEffect1054ui_story and not isNil(var_214_3) then
					arg_211_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_4)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1054ui_story then
				arg_211_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_214_5 = arg_211_1.actors_["1054ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1054ui_story = var_214_5.localPosition

				local var_214_6 = GameObjectTools.GetOrAddComponent(var_214_5.gameObject, typeof(DynamicBoneHelper))

				if var_214_6 then
					var_214_6:EnableDynamicBone(false)
				end
			end

			local var_214_7 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				var_214_5.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_7)
				var_214_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_5.position).x, (manager.ui.mainCamera.transform.position - var_214_5.position).y, (manager.ui.mainCamera.transform.position - var_214_5.position).z)
				var_214_5.localEulerAngles.z = 0
				var_214_5.localEulerAngles.x = 0
				var_214_5.localEulerAngles = var_214_5.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				var_214_5.localPosition = Vector3.New(0, 100, 0)
				var_214_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_5.position).x, (manager.ui.mainCamera.transform.position - var_214_5.position).y, (manager.ui.mainCamera.transform.position - var_214_5.position).z)
				var_214_5.localEulerAngles.z = 0
				var_214_5.localEulerAngles.x = 0
				var_214_5.localEulerAngles = var_214_5.localEulerAngles

				local var_214_8 = GameObjectTools.GetOrAddComponent(var_214_5.gameObject, typeof(DynamicBoneHelper))

				if var_214_8 then
					var_214_8:EnableDynamicBone(true)
				end
			end

			local var_214_9 = 0
			local var_214_10 = 0.825

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_9 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_11 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(426051052).content)

				arg_211_1.text_.text = var_214_11

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 33 <= 0 and var_214_10 or var_214_10 * (utf8.len(var_214_11) / 33)

				if (33 <= 0 and var_214_10 or var_214_10 * (utf8.len(var_214_11) / 33)) > 0 and var_214_10 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_9 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_9
					end
				end

				arg_211_1.text_.text = var_214_11
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_10, arg_211_1.talkMaxDuration)

			if var_214_9 <= arg_211_1.time_ and arg_211_1.time_ < var_214_9 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_9) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_9 + var_214_14 and arg_211_1.time_ < var_214_9 + var_214_14 + arg_214_0 then
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

		arg_211_1:InitPlayNodeList()
	end,
	Play426051053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 426051053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play426051054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.45

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(426051053).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 18 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 18)

				if (18 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 18)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play426051054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 426051054
		arg_219_1.duration_ = 9

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play426051055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 2 < arg_219_1.time_ and arg_219_1.time_ <= 2 + arg_222_0 then
				local var_222_0 = arg_219_1.bgs_.ST2007a

				arg_219_1.bgs_.ST2007a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_1 = var_222_0:GetComponent("SpriteRenderer")

				if var_222_1 and var_222_1.sprite then
					local var_222_2 = 2 * (var_222_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_0.transform.localScale = Vector3.New(var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, var_222_2 / var_222_1.sprite.bounds.size.y < var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x and var_222_2 * manager.ui.mainCameraCom_.aspect / var_222_1.sprite.bounds.size.x or var_222_2 / var_222_1.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "ST2007a" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_3 = 3.999999999999

			if 3.999999999999 < arg_219_1.time_ and arg_219_1.time_ <= var_222_3 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			if arg_219_1.time_ >= var_222_3 + 0.3 and arg_219_1.time_ < var_222_3 + 0.3 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_4 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_5 = 2

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_5 then
				local var_222_6 = Color.New(0, 0, 0)

				var_222_6.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_4) / var_222_5)
				arg_219_1.mask_.color = var_222_6
			end

			if arg_219_1.time_ >= var_222_4 + var_222_5 and arg_219_1.time_ < var_222_4 + var_222_5 + arg_222_0 then
				local var_222_7 = Color.New(0, 0, 0)

				var_222_7.a = 1
				arg_219_1.mask_.color = var_222_7
			end

			local var_222_8 = 2

			if 2 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_9 = 2

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_9 then
				local var_222_10 = Color.New(0, 0, 0)

				var_222_10.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_8) / var_222_9)
				arg_219_1.mask_.color = var_222_10
			end

			if arg_219_1.time_ >= var_222_8 + var_222_9 and arg_219_1.time_ < var_222_8 + var_222_9 + arg_222_0 then
				local var_222_11 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_11.a = 0
				arg_219_1.mask_.color = var_222_11
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_12 = 3.999999999999
			local var_222_13 = 1.375

			if 3.999999999999 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_14 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_14:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_15 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(426051054).content)

				arg_219_1.text_.text = var_222_15

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_17 = 55 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 55)

				if (55 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 55)) > 0 and var_222_13 < var_222_17 then
					arg_219_1.talkMaxDuration = var_222_17
					var_222_12 = var_222_12 + 0.3

					if var_222_17 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_17 + var_222_12
					end
				end

				arg_219_1.text_.text = var_222_15
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_18 = var_222_12 + 0.3
			local var_222_19 = math.max(var_222_13, arg_219_1.talkMaxDuration)

			if var_222_12 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_18 + var_222_19 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_18) / var_222_19

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_18 + var_222_19 and arg_219_1.time_ < var_222_18 + var_222_19 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play426051055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 426051055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play426051056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.2

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(426051055).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 8 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 8)

				if (8 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 8)) > 0 and var_228_0 < var_228_3 then
					arg_225_1.talkMaxDuration = var_228_3

					if var_228_3 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_3 + 0
					end
				end

				arg_225_1.text_.text = var_228_1
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_4 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_4

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play426051056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 426051056
		arg_229_1.duration_ = 6.4

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play426051057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_9000

			if 0.866666666666667 < arg_229_1.time_ and arg_229_1.time_ <= 0.866666666666667 + arg_232_0 then
				arg_229_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hug", "")
			end

			if 0.6 < arg_229_1.time_ and arg_229_1.time_ <= 0.6 + arg_232_0 then
				local var_232_1 = arg_229_1.var_.effectpuguolai1

				if not arg_229_1.var_.effectpuguolai1 then
					var_232_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_out"), manager.ui.mainCamera.transform)
					var_232_1.name = "puguolai1"
					arg_229_1.var_.effectpuguolai1 = var_232_1
				else
					var_232_1.transform:SetParent(var_232_9000)
				end

				var_232_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_232_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_232_3 = arg_229_1.bgs_.ST2007a.transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPosST2007a = var_232_3.localPosition
			end

			local var_232_4 = 1.6

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				var_232_3.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPosST2007a, Vector3.New(0, 1, 9.5), (arg_229_1.time_ - 0) / var_232_4)
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				var_232_3.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_232_5 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			if arg_229_1.time_ >= var_232_5 + 2.1 and arg_229_1.time_ < var_232_5 + 2.1 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_6 = 1.4
			local var_232_7 = 1.325

			if 1.4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_8 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_8:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_9 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(426051056).content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 53 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_9) / 53)

				if (53 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_9) / 53)) > 0 and var_232_7 < var_232_11 then
					arg_229_1.talkMaxDuration = var_232_11
					var_232_6 = var_232_6 + 0.3

					if var_232_11 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = var_232_6 + 0.3
			local var_232_13 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_12 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_12) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_12 + var_232_13 and arg_229_1.time_ < var_232_12 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST2007a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.6,
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

		arg_229_1:InitPlayNodeList()
	end,
	Play426051057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 426051057
		arg_235_1.duration_ = 2.2

		local var_235_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play426051058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos6148ui_story = arg_235_1.actors_["6148ui_story"].transform.localPosition

				local var_238_0 = GameObjectTools.GetOrAddComponent(arg_235_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_238_0 then
					var_238_0:EnableDynamicBone(false)
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_235_1.time_ - 0) / var_238_1)
				arg_235_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["6148ui_story"].transform.position).z)
				arg_235_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["6148ui_story"].transform.localEulerAngles = arg_235_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_235_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["6148ui_story"].transform.position).z)
				arg_235_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["6148ui_story"].transform.localEulerAngles = arg_235_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_238_2 = GameObjectTools.GetOrAddComponent(arg_235_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(true)
				end
			end

			local var_238_3 = arg_235_1.actors_["6148ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect6148ui_story == nil then
				arg_235_1.var_.characterEffect6148ui_story = var_238_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_4 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 and not isNil(var_238_3) then
				if arg_235_1.var_.characterEffect6148ui_story and not isNil(var_238_3) then
					arg_235_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 and not isNil(var_238_3) and arg_235_1.var_.characterEffect6148ui_story then
				arg_235_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_238_6 = 0
			local var_238_7 = 0.225

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_8 = arg_235_1:GetWordFromCfg(426051057)
				local var_238_9 = arg_235_1:FormatText(var_238_8.content)

				arg_235_1.text_.text = var_238_9

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 9 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 9)

				if (9 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 9)) > 0 and var_238_7 < var_238_11 then
					arg_235_1.talkMaxDuration = var_238_11

					if var_238_11 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_9
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051057", "story_v_out_426051.awb") ~= 0 then
					local var_238_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051057", "story_v_out_426051.awb") / 1000

					if var_238_12 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_6
					end

					if var_238_8.prefab_name ~= "" and arg_235_1.actors_[var_238_8.prefab_name] ~= nil then
						local var_238_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_8.prefab_name].transform, "story_v_out_426051", "426051057", "story_v_out_426051.awb")

						arg_235_1:RecordAudio("426051057", var_238_13)
						arg_235_1:RecordAudio("426051057", var_238_13)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_426051", "426051057", "story_v_out_426051.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_426051", "426051057", "story_v_out_426051.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
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

		arg_235_1:InitPlayNodeList()
	end,
	Play426051058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 426051058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play426051059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["6148ui_story"]) and arg_239_1.var_.characterEffect6148ui_story == nil then
				arg_239_1.var_.characterEffect6148ui_story = arg_239_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["6148ui_story"]) then
				if arg_239_1.var_.characterEffect6148ui_story and not isNil(arg_239_1.actors_["6148ui_story"]) then
					arg_239_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_239_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["6148ui_story"]) and arg_239_1.var_.characterEffect6148ui_story then
				arg_239_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_239_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.075

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(426051058).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 3 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 3)

				if (3 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 3)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play426051059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 426051059
		arg_243_1.duration_ = 2.07

		local var_243_0 = {
			zh = 2,
			ja = 2.066
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play426051060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1054ui_story = arg_243_1.actors_["1054ui_story"].transform.localPosition

				local var_246_0 = GameObjectTools.GetOrAddComponent(arg_243_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_246_0 then
					var_246_0:EnableDynamicBone(false)
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_243_1.time_ - 0) / var_246_1)
				arg_243_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1054ui_story"].transform.position).z)
				arg_243_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1054ui_story"].transform.localEulerAngles = arg_243_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_243_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1054ui_story"].transform.position).z)
				arg_243_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1054ui_story"].transform.localEulerAngles = arg_243_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_246_2 = GameObjectTools.GetOrAddComponent(arg_243_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_246_2 then
					var_246_2:EnableDynamicBone(true)
				end
			end

			local var_246_3 = arg_243_1.actors_["6148ui_story"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos6148ui_story = var_246_3.localPosition

				local var_246_4 = GameObjectTools.GetOrAddComponent(var_246_3.gameObject, typeof(DynamicBoneHelper))

				if var_246_4 then
					var_246_4:EnableDynamicBone(false)
				end
			end

			local var_246_5 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_5 then
				var_246_3.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_243_1.time_ - 0) / var_246_5)
				var_246_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_3.position).x, (manager.ui.mainCamera.transform.position - var_246_3.position).y, (manager.ui.mainCamera.transform.position - var_246_3.position).z)
				var_246_3.localEulerAngles.z = 0
				var_246_3.localEulerAngles.x = 0
				var_246_3.localEulerAngles = var_246_3.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_5 and arg_243_1.time_ < 0 + var_246_5 + arg_246_0 then
				var_246_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_246_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_3.position).x, (manager.ui.mainCamera.transform.position - var_246_3.position).y, (manager.ui.mainCamera.transform.position - var_246_3.position).z)
				var_246_3.localEulerAngles.z = 0
				var_246_3.localEulerAngles.x = 0
				var_246_3.localEulerAngles = var_246_3.localEulerAngles

				local var_246_6 = GameObjectTools.GetOrAddComponent(var_246_3.gameObject, typeof(DynamicBoneHelper))

				if var_246_6 then
					var_246_6:EnableDynamicBone(true)
				end
			end

			local var_246_7 = arg_243_1.actors_["1054ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1054ui_story == nil then
				arg_243_1.var_.characterEffect1054ui_story = var_246_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_8 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_8 and not isNil(var_246_7) then
				if arg_243_1.var_.characterEffect1054ui_story and not isNil(var_246_7) then
					arg_243_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_8 and arg_243_1.time_ < 0 + var_246_8 + arg_246_0 and not isNil(var_246_7) and arg_243_1.var_.characterEffect1054ui_story then
				arg_243_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_246_10 = 0
			local var_246_11 = 0.25

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_12 = arg_243_1:GetWordFromCfg(426051059)
				local var_246_13 = arg_243_1:FormatText(var_246_12.content)

				arg_243_1.text_.text = var_246_13

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_15 = 10 <= 0 and var_246_11 or var_246_11 * (utf8.len(var_246_13) / 10)

				if (10 <= 0 and var_246_11 or var_246_11 * (utf8.len(var_246_13) / 10)) > 0 and var_246_11 < var_246_15 then
					arg_243_1.talkMaxDuration = var_246_15

					if var_246_15 + var_246_10 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_15 + var_246_10
					end
				end

				arg_243_1.text_.text = var_246_13
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051059", "story_v_out_426051.awb") ~= 0 then
					local var_246_16 = manager.audio:GetVoiceLength("story_v_out_426051", "426051059", "story_v_out_426051.awb") / 1000

					if var_246_16 + var_246_10 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_16 + var_246_10
					end

					if var_246_12.prefab_name ~= "" and arg_243_1.actors_[var_246_12.prefab_name] ~= nil then
						local var_246_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_12.prefab_name].transform, "story_v_out_426051", "426051059", "story_v_out_426051.awb")

						arg_243_1:RecordAudio("426051059", var_246_17)
						arg_243_1:RecordAudio("426051059", var_246_17)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_426051", "426051059", "story_v_out_426051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_426051", "426051059", "story_v_out_426051.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_18 = math.max(var_246_11, arg_243_1.talkMaxDuration)

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_18 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_10) / var_246_18

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_10 + var_246_18 and arg_243_1.time_ < var_246_10 + var_246_18 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play426051060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 426051060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play426051061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1054ui_story"]) and arg_247_1.var_.characterEffect1054ui_story == nil then
				arg_247_1.var_.characterEffect1054ui_story = arg_247_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1054ui_story"]) then
				if arg_247_1.var_.characterEffect1054ui_story and not isNil(arg_247_1.actors_["1054ui_story"]) then
					arg_247_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1054ui_story"]) and arg_247_1.var_.characterEffect1054ui_story then
				arg_247_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.275

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(426051060).content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 11 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 11)

				if (11 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 11)) > 0 and var_250_2 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_6 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_6 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_6

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_6 and arg_247_1.time_ < var_250_1 + var_250_6 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play426051061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 426051061
		arg_251_1.duration_ = 2.1

		local var_251_0 = {
			zh = 1.999999999999,
			ja = 2.1
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play426051062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos6148ui_story = arg_251_1.actors_["6148ui_story"].transform.localPosition

				local var_254_0 = GameObjectTools.GetOrAddComponent(arg_251_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_254_0 then
					var_254_0:EnableDynamicBone(false)
				end
			end

			local var_254_1 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				arg_251_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_251_1.time_ - 0) / var_254_1)
				arg_251_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["6148ui_story"].transform.position).z)
				arg_251_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["6148ui_story"].transform.localEulerAngles = arg_251_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 then
				arg_251_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_251_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["6148ui_story"].transform.position).z)
				arg_251_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["6148ui_story"].transform.localEulerAngles = arg_251_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_254_2 = GameObjectTools.GetOrAddComponent(arg_251_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(true)
				end
			end

			local var_254_3 = arg_251_1.actors_["6148ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_3) and arg_251_1.var_.characterEffect6148ui_story == nil then
				arg_251_1.var_.characterEffect6148ui_story = var_254_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_4 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 and not isNil(var_254_3) then
				if arg_251_1.var_.characterEffect6148ui_story and not isNil(var_254_3) then
					arg_251_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 and not isNil(var_254_3) and arg_251_1.var_.characterEffect6148ui_story then
				arg_251_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action4_2")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_254_6 = 0
			local var_254_7 = 0.1

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:GetWordFromCfg(426051061)
				local var_254_9 = arg_251_1:FormatText(var_254_8.content)

				arg_251_1.text_.text = var_254_9

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 4 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 4)

				if (4 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 4)) > 0 and var_254_7 < var_254_11 then
					arg_251_1.talkMaxDuration = var_254_11

					if var_254_11 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_9
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051061", "story_v_out_426051.awb") ~= 0 then
					local var_254_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051061", "story_v_out_426051.awb") / 1000

					if var_254_12 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_6
					end

					if var_254_8.prefab_name ~= "" and arg_251_1.actors_[var_254_8.prefab_name] ~= nil then
						local var_254_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_8.prefab_name].transform, "story_v_out_426051", "426051061", "story_v_out_426051.awb")

						arg_251_1:RecordAudio("426051061", var_254_13)
						arg_251_1:RecordAudio("426051061", var_254_13)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_426051", "426051061", "story_v_out_426051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_426051", "426051061", "story_v_out_426051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play426051062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 426051062
		arg_255_1.duration_ = 2

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play426051063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1054ui_story = arg_255_1.actors_["1054ui_story"].transform.localPosition

				local var_258_0 = GameObjectTools.GetOrAddComponent(arg_255_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_258_0 then
					var_258_0:EnableDynamicBone(false)
				end
			end

			local var_258_1 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 then
				arg_255_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_255_1.time_ - 0) / var_258_1)
				arg_255_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1054ui_story"].transform.position).z)
				arg_255_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1054ui_story"].transform.localEulerAngles = arg_255_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 then
				arg_255_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_255_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1054ui_story"].transform.position).z)
				arg_255_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1054ui_story"].transform.localEulerAngles = arg_255_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_258_2 = GameObjectTools.GetOrAddComponent(arg_255_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_258_2 then
					var_258_2:EnableDynamicBone(true)
				end
			end

			local var_258_3 = arg_255_1.actors_["1054ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect1054ui_story == nil then
				arg_255_1.var_.characterEffect1054ui_story = var_258_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_4 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 and not isNil(var_258_3) then
				if arg_255_1.var_.characterEffect1054ui_story and not isNil(var_258_3) then
					arg_255_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 and not isNil(var_258_3) and arg_255_1.var_.characterEffect1054ui_story then
				arg_255_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_258_6 = arg_255_1.actors_["6148ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect6148ui_story == nil then
				arg_255_1.var_.characterEffect6148ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_7 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 and not isNil(var_258_6) then
				if arg_255_1.var_.characterEffect6148ui_story and not isNil(var_258_6) then
					arg_255_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_255_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_7)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 and not isNil(var_258_6) and arg_255_1.var_.characterEffect6148ui_story then
				arg_255_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_255_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_258_8 = 0
			local var_258_9 = 0.075

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:GetWordFromCfg(426051062)
				local var_258_11 = arg_255_1:FormatText(var_258_10.content)

				arg_255_1.text_.text = var_258_11

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 3 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 3)

				if (3 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 3)) > 0 and var_258_9 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_11
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051062", "story_v_out_426051.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_out_426051", "426051062", "story_v_out_426051.awb") / 1000

					if var_258_14 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_8
					end

					if var_258_10.prefab_name ~= "" and arg_255_1.actors_[var_258_10.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_10.prefab_name].transform, "story_v_out_426051", "426051062", "story_v_out_426051.awb")

						arg_255_1:RecordAudio("426051062", var_258_15)
						arg_255_1:RecordAudio("426051062", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_426051", "426051062", "story_v_out_426051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_426051", "426051062", "story_v_out_426051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play426051063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 426051063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play426051064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1054ui_story"]) and arg_259_1.var_.characterEffect1054ui_story == nil then
				arg_259_1.var_.characterEffect1054ui_story = arg_259_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1054ui_story"]) then
				if arg_259_1.var_.characterEffect1054ui_story and not isNil(arg_259_1.actors_["1054ui_story"]) then
					arg_259_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1054ui_story"]) and arg_259_1.var_.characterEffect1054ui_story then
				arg_259_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.4

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(426051063).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 16 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 16)

				if (16 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 16)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play426051064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 426051064
		arg_263_1.duration_ = 2

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play426051065(arg_263_1)
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
				arg_263_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_263_1.time_ - 0) / var_266_1)
				arg_263_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).z)
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles = arg_263_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_263_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1054ui_story"].transform.position).z)
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1054ui_story"].transform.localEulerAngles = arg_263_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_266_2 = GameObjectTools.GetOrAddComponent(arg_263_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_266_2 then
					var_266_2:EnableDynamicBone(true)
				end
			end

			local var_266_3 = arg_263_1.actors_["1054ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_3) and arg_263_1.var_.characterEffect1054ui_story == nil then
				arg_263_1.var_.characterEffect1054ui_story = var_266_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_4 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 and not isNil(var_266_3) then
				if arg_263_1.var_.characterEffect1054ui_story and not isNil(var_266_3) then
					arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 and not isNil(var_266_3) and arg_263_1.var_.characterEffect1054ui_story then
				arg_263_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_266_6 = 0
			local var_266_7 = 0.05

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
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

				local var_266_8 = arg_263_1:GetWordFromCfg(426051064)
				local var_266_9 = arg_263_1:FormatText(var_266_8.content)

				arg_263_1.text_.text = var_266_9

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 2 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 2)

				if (2 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 2)) > 0 and var_266_7 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_9
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051064", "story_v_out_426051.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051064", "story_v_out_426051.awb") / 1000

					if var_266_12 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_6
					end

					if var_266_8.prefab_name ~= "" and arg_263_1.actors_[var_266_8.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_8.prefab_name].transform, "story_v_out_426051", "426051064", "story_v_out_426051.awb")

						arg_263_1:RecordAudio("426051064", var_266_13)
						arg_263_1:RecordAudio("426051064", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_426051", "426051064", "story_v_out_426051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_426051", "426051064", "story_v_out_426051.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
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
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play426051065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 426051065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play426051066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1054ui_story"]) and arg_267_1.var_.characterEffect1054ui_story == nil then
				arg_267_1.var_.characterEffect1054ui_story = arg_267_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1054ui_story"]) then
				if arg_267_1.var_.characterEffect1054ui_story and not isNil(arg_267_1.actors_["1054ui_story"]) then
					arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1054ui_story"]) and arg_267_1.var_.characterEffect1054ui_story then
				arg_267_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.25

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(426051065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 10 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 10)

				if (10 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 10)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play426051066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 426051066
		arg_271_1.duration_ = 2

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play426051067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos6148ui_story = arg_271_1.actors_["6148ui_story"].transform.localPosition

				local var_274_0 = GameObjectTools.GetOrAddComponent(arg_271_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_274_0 then
					var_274_0:EnableDynamicBone(false)
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_271_1.time_ - 0) / var_274_1)
				arg_271_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).z)
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles = arg_271_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_271_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).z)
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles = arg_271_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_274_2 = GameObjectTools.GetOrAddComponent(arg_271_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(true)
				end
			end

			local var_274_3 = arg_271_1.actors_["6148ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect6148ui_story == nil then
				arg_271_1.var_.characterEffect6148ui_story = var_274_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_4 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 and not isNil(var_274_3) then
				if arg_271_1.var_.characterEffect6148ui_story and not isNil(var_274_3) then
					arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect6148ui_story then
				arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_274_6 = 0
			local var_274_7 = 0.125

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(426051066)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 5 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 5)

				if (5 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 5)) > 0 and var_274_7 < var_274_11 then
					arg_271_1.talkMaxDuration = var_274_11

					if var_274_11 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051066", "story_v_out_426051.awb") ~= 0 then
					local var_274_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051066", "story_v_out_426051.awb") / 1000

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end

					if var_274_8.prefab_name ~= "" and arg_271_1.actors_[var_274_8.prefab_name] ~= nil then
						local var_274_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_8.prefab_name].transform, "story_v_out_426051", "426051066", "story_v_out_426051.awb")

						arg_271_1:RecordAudio("426051066", var_274_13)
						arg_271_1:RecordAudio("426051066", var_274_13)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_426051", "426051066", "story_v_out_426051.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_426051", "426051066", "story_v_out_426051.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_14 and arg_271_1.time_ < var_274_6 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play426051067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 426051067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play426051068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["6148ui_story"]) and arg_275_1.var_.characterEffect6148ui_story == nil then
				arg_275_1.var_.characterEffect6148ui_story = arg_275_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["6148ui_story"]) then
				if arg_275_1.var_.characterEffect6148ui_story and not isNil(arg_275_1.actors_["6148ui_story"]) then
					arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_275_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["6148ui_story"]) and arg_275_1.var_.characterEffect6148ui_story then
				arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_275_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.275

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(426051067).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 11 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 11)

				if (11 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 11)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play426051068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 426051068
		arg_279_1.duration_ = 1

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"

			SetActive(arg_279_1.choicesGo_, true)

			for iter_280_0, iter_280_1 in ipairs(arg_279_1.choices_) do
				SetActive(iter_280_1.go, iter_280_0 <= 1)
			end

			arg_279_1.choices_[1].txt.text = arg_279_1:FormatText(StoryChoiceCfg[1605].name)
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play426051069(arg_279_1)
			end

			arg_279_1:RecordChoiceLog(426051068, 1605)
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			if arg_279_1.time_ >= 0 + 0.6 and arg_279_1.time_ < 0 + 0.6 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play426051069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 426051069
		arg_283_1.duration_ = 2.37

		local var_283_0 = {
			zh = 1.966,
			ja = 2.366
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
				arg_283_0:Play426051070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1054ui_story"]) and arg_283_1.var_.characterEffect1054ui_story == nil then
				arg_283_1.var_.characterEffect1054ui_story = arg_283_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1054ui_story"]) then
				if arg_283_1.var_.characterEffect1054ui_story and not isNil(arg_283_1.actors_["1054ui_story"]) then
					arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1054ui_story"]) and arg_283_1.var_.characterEffect1054ui_story then
				arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_286_2 = arg_283_1.actors_["6148ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect6148ui_story == nil then
				arg_283_1.var_.characterEffect6148ui_story = var_286_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_3 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.characterEffect6148ui_story and not isNil(var_286_2) then
					arg_283_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.characterEffect6148ui_story then
				arg_283_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_286_5 = 0
			local var_286_6 = 0.075

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_7 = arg_283_1:GetWordFromCfg(426051069)
				local var_286_8 = arg_283_1:FormatText(var_286_7.content)

				arg_283_1.text_.text = var_286_8

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_10 = 3 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 3)

				if (3 <= 0 and var_286_6 or var_286_6 * (utf8.len(var_286_8) / 3)) > 0 and var_286_6 < var_286_10 then
					arg_283_1.talkMaxDuration = var_286_10

					if var_286_10 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_10 + var_286_5
					end
				end

				arg_283_1.text_.text = var_286_8
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051069", "story_v_out_426051.awb") ~= 0 then
					local var_286_11 = manager.audio:GetVoiceLength("story_v_out_426051", "426051069", "story_v_out_426051.awb") / 1000

					if var_286_11 + var_286_5 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_5
					end

					if var_286_7.prefab_name ~= "" and arg_283_1.actors_[var_286_7.prefab_name] ~= nil then
						local var_286_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_7.prefab_name].transform, "story_v_out_426051", "426051069", "story_v_out_426051.awb")

						arg_283_1:RecordAudio("426051069", var_286_12)
						arg_283_1:RecordAudio("426051069", var_286_12)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_426051", "426051069", "story_v_out_426051.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_426051", "426051069", "story_v_out_426051.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_13 = math.max(var_286_6, arg_283_1.talkMaxDuration)

			if var_286_5 <= arg_283_1.time_ and arg_283_1.time_ < var_286_5 + var_286_13 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_5) / var_286_13

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_5 + var_286_13 and arg_283_1.time_ < var_286_5 + var_286_13 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play426051070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 426051070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play426051071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1054ui_story"]) and arg_287_1.var_.characterEffect1054ui_story == nil then
				arg_287_1.var_.characterEffect1054ui_story = arg_287_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1054ui_story"]) then
				if arg_287_1.var_.characterEffect1054ui_story and not isNil(arg_287_1.actors_["1054ui_story"]) then
					arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1054ui_story"]) and arg_287_1.var_.characterEffect1054ui_story then
				arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_290_1 = arg_287_1.actors_["6148ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect6148ui_story == nil then
				arg_287_1.var_.characterEffect6148ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect6148ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_287_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_2)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect6148ui_story then
				arg_287_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_287_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_290_3 = 0
			local var_290_4 = 0.9

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_3 + arg_290_0 then
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

				local var_290_5 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(426051070).content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 36 <= 0 and var_290_4 or var_290_4 * (utf8.len(var_290_5) / 36)

				if (36 <= 0 and var_290_4 or var_290_4 * (utf8.len(var_290_5) / 36)) > 0 and var_290_4 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_3 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_3
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_8 = math.max(var_290_4, arg_287_1.talkMaxDuration)

			if var_290_3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_3 + var_290_8 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_3) / var_290_8

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_3 + var_290_8 and arg_287_1.time_ < var_290_3 + var_290_8 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play426051071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 426051071
		arg_291_1.duration_ = 5.7

		local var_291_0 = {
			zh = 5.7,
			ja = 4.7
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
				arg_291_0:Play426051072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos6148ui_story = arg_291_1.actors_["6148ui_story"].transform.localPosition

				local var_294_0 = GameObjectTools.GetOrAddComponent(arg_291_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_294_0 then
					var_294_0:EnableDynamicBone(false)
				end
			end

			local var_294_1 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_1 then
				arg_291_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_291_1.time_ - 0) / var_294_1)
				arg_291_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["6148ui_story"].transform.position).z)
				arg_291_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["6148ui_story"].transform.localEulerAngles = arg_291_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_1 and arg_291_1.time_ < 0 + var_294_1 + arg_294_0 then
				arg_291_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_291_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["6148ui_story"].transform.position).z)
				arg_291_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["6148ui_story"].transform.localEulerAngles = arg_291_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_294_2 = GameObjectTools.GetOrAddComponent(arg_291_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_294_2 then
					var_294_2:EnableDynamicBone(true)
				end
			end

			local var_294_3 = arg_291_1.actors_["6148ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_3) and arg_291_1.var_.characterEffect6148ui_story == nil then
				arg_291_1.var_.characterEffect6148ui_story = var_294_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_4 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 and not isNil(var_294_3) then
				if arg_291_1.var_.characterEffect6148ui_story and not isNil(var_294_3) then
					arg_291_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 and not isNil(var_294_3) and arg_291_1.var_.characterEffect6148ui_story then
				arg_291_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_294_6 = 0
			local var_294_7 = 0.65

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_8 = arg_291_1:GetWordFromCfg(426051071)
				local var_294_9 = arg_291_1:FormatText(var_294_8.content)

				arg_291_1.text_.text = var_294_9

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 26 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 26)

				if (26 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 26)) > 0 and var_294_7 < var_294_11 then
					arg_291_1.talkMaxDuration = var_294_11

					if var_294_11 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_9
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051071", "story_v_out_426051.awb") ~= 0 then
					local var_294_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051071", "story_v_out_426051.awb") / 1000

					if var_294_12 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_6
					end

					if var_294_8.prefab_name ~= "" and arg_291_1.actors_[var_294_8.prefab_name] ~= nil then
						local var_294_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_8.prefab_name].transform, "story_v_out_426051", "426051071", "story_v_out_426051.awb")

						arg_291_1:RecordAudio("426051071", var_294_13)
						arg_291_1:RecordAudio("426051071", var_294_13)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_426051", "426051071", "story_v_out_426051.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_426051", "426051071", "story_v_out_426051.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_14 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_14 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_14

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_14 and arg_291_1.time_ < var_294_6 + var_294_14 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play426051072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 426051072
		arg_295_1.duration_ = 5.67

		local var_295_0 = {
			zh = 5.666,
			ja = 3.9
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play426051073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos6148ui_story = arg_295_1.actors_["6148ui_story"].transform.localPosition

				local var_298_0 = GameObjectTools.GetOrAddComponent(arg_295_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_298_0 then
					var_298_0:EnableDynamicBone(false)
				end
			end

			local var_298_1 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				arg_295_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_295_1.time_ - 0) / var_298_1)
				arg_295_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["6148ui_story"].transform.position).z)
				arg_295_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["6148ui_story"].transform.localEulerAngles = arg_295_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 then
				arg_295_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_295_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["6148ui_story"].transform.position).z)
				arg_295_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["6148ui_story"].transform.localEulerAngles = arg_295_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_298_2 = GameObjectTools.GetOrAddComponent(arg_295_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_298_2 then
					var_298_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_298_3 = 0
			local var_298_4 = 0.625

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_3 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_5 = arg_295_1:GetWordFromCfg(426051072)
				local var_298_6 = arg_295_1:FormatText(var_298_5.content)

				arg_295_1.text_.text = var_298_6

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_8 = 25 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_6) / 25)

				if (25 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_6) / 25)) > 0 and var_298_4 < var_298_8 then
					arg_295_1.talkMaxDuration = var_298_8

					if var_298_8 + var_298_3 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_3
					end
				end

				arg_295_1.text_.text = var_298_6
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051072", "story_v_out_426051.awb") ~= 0 then
					local var_298_9 = manager.audio:GetVoiceLength("story_v_out_426051", "426051072", "story_v_out_426051.awb") / 1000

					if var_298_9 + var_298_3 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_3
					end

					if var_298_5.prefab_name ~= "" and arg_295_1.actors_[var_298_5.prefab_name] ~= nil then
						local var_298_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_5.prefab_name].transform, "story_v_out_426051", "426051072", "story_v_out_426051.awb")

						arg_295_1:RecordAudio("426051072", var_298_10)
						arg_295_1:RecordAudio("426051072", var_298_10)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_426051", "426051072", "story_v_out_426051.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_426051", "426051072", "story_v_out_426051.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_11 = math.max(var_298_4, arg_295_1.talkMaxDuration)

			if var_298_3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_3 + var_298_11 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_3) / var_298_11

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_3 + var_298_11 and arg_295_1.time_ < var_298_3 + var_298_11 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play426051073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 426051073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play426051074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["6148ui_story"]) and arg_299_1.var_.characterEffect6148ui_story == nil then
				arg_299_1.var_.characterEffect6148ui_story = arg_299_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["6148ui_story"]) then
				if arg_299_1.var_.characterEffect6148ui_story and not isNil(arg_299_1.actors_["6148ui_story"]) then
					arg_299_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_299_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["6148ui_story"]) and arg_299_1.var_.characterEffect6148ui_story then
				arg_299_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_299_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.775

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(426051073).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 31 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 31)

				if (31 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 31)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play426051074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 426051074
		arg_303_1.duration_ = 2

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play426051075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1054ui_story = arg_303_1.actors_["1054ui_story"].transform.localPosition

				local var_306_0 = GameObjectTools.GetOrAddComponent(arg_303_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_306_0 then
					var_306_0:EnableDynamicBone(false)
				end
			end

			local var_306_1 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_1 then
				arg_303_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_303_1.time_ - 0) / var_306_1)
				arg_303_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1054ui_story"].transform.position).z)
				arg_303_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1054ui_story"].transform.localEulerAngles = arg_303_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_1 and arg_303_1.time_ < 0 + var_306_1 + arg_306_0 then
				arg_303_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_303_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1054ui_story"].transform.position).z)
				arg_303_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1054ui_story"].transform.localEulerAngles = arg_303_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_306_2 = GameObjectTools.GetOrAddComponent(arg_303_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_306_2 then
					var_306_2:EnableDynamicBone(true)
				end
			end

			local var_306_3 = arg_303_1.actors_["1054ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_3) and arg_303_1.var_.characterEffect1054ui_story == nil then
				arg_303_1.var_.characterEffect1054ui_story = var_306_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_4 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 and not isNil(var_306_3) then
				if arg_303_1.var_.characterEffect1054ui_story and not isNil(var_306_3) then
					arg_303_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 and not isNil(var_306_3) and arg_303_1.var_.characterEffect1054ui_story then
				arg_303_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_306_6 = 0
			local var_306_7 = 0.175

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_6 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_8 = arg_303_1:GetWordFromCfg(426051074)
				local var_306_9 = arg_303_1:FormatText(var_306_8.content)

				arg_303_1.text_.text = var_306_9

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_11 = 7 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 7)

				if (7 <= 0 and var_306_7 or var_306_7 * (utf8.len(var_306_9) / 7)) > 0 and var_306_7 < var_306_11 then
					arg_303_1.talkMaxDuration = var_306_11

					if var_306_11 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_11 + var_306_6
					end
				end

				arg_303_1.text_.text = var_306_9
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051074", "story_v_out_426051.awb") ~= 0 then
					local var_306_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051074", "story_v_out_426051.awb") / 1000

					if var_306_12 + var_306_6 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_12 + var_306_6
					end

					if var_306_8.prefab_name ~= "" and arg_303_1.actors_[var_306_8.prefab_name] ~= nil then
						local var_306_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_8.prefab_name].transform, "story_v_out_426051", "426051074", "story_v_out_426051.awb")

						arg_303_1:RecordAudio("426051074", var_306_13)
						arg_303_1:RecordAudio("426051074", var_306_13)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_426051", "426051074", "story_v_out_426051.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_426051", "426051074", "story_v_out_426051.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_14 = math.max(var_306_7, arg_303_1.talkMaxDuration)

			if var_306_6 <= arg_303_1.time_ and arg_303_1.time_ < var_306_6 + var_306_14 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_6) / var_306_14

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_6 + var_306_14 and arg_303_1.time_ < var_306_6 + var_306_14 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play426051075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 426051075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play426051076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1054ui_story"]) and arg_307_1.var_.characterEffect1054ui_story == nil then
				arg_307_1.var_.characterEffect1054ui_story = arg_307_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1054ui_story"]) then
				if arg_307_1.var_.characterEffect1054ui_story and not isNil(arg_307_1.actors_["1054ui_story"]) then
					arg_307_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1054ui_story"]) and arg_307_1.var_.characterEffect1054ui_story then
				arg_307_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.375

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(426051075).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 15 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 15)

				if (15 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 15)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play426051076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 426051076
		arg_311_1.duration_ = 2.2

		local var_311_0 = {
			zh = 2.066,
			ja = 2.2
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play426051077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1054ui_story"]) and arg_311_1.var_.characterEffect1054ui_story == nil then
				arg_311_1.var_.characterEffect1054ui_story = arg_311_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1054ui_story"]) then
				if arg_311_1.var_.characterEffect1054ui_story and not isNil(arg_311_1.actors_["1054ui_story"]) then
					arg_311_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1054ui_story"]) and arg_311_1.var_.characterEffect1054ui_story then
				arg_311_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_314_2 = arg_311_1.actors_["6148ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.characterEffect6148ui_story == nil then
				arg_311_1.var_.characterEffect6148ui_story = var_314_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_3 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.characterEffect6148ui_story and not isNil(var_314_2) then
					arg_311_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.characterEffect6148ui_story then
				arg_311_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_314_5 = 0
			local var_314_6 = 0.075

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(426051076)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 3 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 3)

				if (3 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 3)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051076", "story_v_out_426051.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_426051", "426051076", "story_v_out_426051.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_426051", "426051076", "story_v_out_426051.awb")

						arg_311_1:RecordAudio("426051076", var_314_12)
						arg_311_1:RecordAudio("426051076", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_426051", "426051076", "story_v_out_426051.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_426051", "426051076", "story_v_out_426051.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_13 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_13 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_13

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_13 and arg_311_1.time_ < var_314_5 + var_314_13 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play426051077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 426051077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play426051078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1054ui_story"]) and arg_315_1.var_.characterEffect1054ui_story == nil then
				arg_315_1.var_.characterEffect1054ui_story = arg_315_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1054ui_story"]) then
				if arg_315_1.var_.characterEffect1054ui_story and not isNil(arg_315_1.actors_["1054ui_story"]) then
					arg_315_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1054ui_story"]) and arg_315_1.var_.characterEffect1054ui_story then
				arg_315_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_318_1 = arg_315_1.actors_["6148ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect6148ui_story == nil then
				arg_315_1.var_.characterEffect6148ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect6148ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_315_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_2)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect6148ui_story then
				arg_315_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_315_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_318_3 = 0
			local var_318_4 = 0.15

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_5 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(426051077).content)

				arg_315_1.text_.text = var_318_5

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_7 = 6 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 6)

				if (6 <= 0 and var_318_4 or var_318_4 * (utf8.len(var_318_5) / 6)) > 0 and var_318_4 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_3 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_3
					end
				end

				arg_315_1.text_.text = var_318_5
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_8 = math.max(var_318_4, arg_315_1.talkMaxDuration)

			if var_318_3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_3 + var_318_8 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_3) / var_318_8

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_3 + var_318_8 and arg_315_1.time_ < var_318_3 + var_318_8 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play426051078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 426051078
		arg_319_1.duration_ = 7.1

		local var_319_0 = {
			zh = 4.666,
			ja = 7.1
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play426051079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1054ui_story = arg_319_1.actors_["1054ui_story"].transform.localPosition

				local var_322_0 = GameObjectTools.GetOrAddComponent(arg_319_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_322_0 then
					var_322_0:EnableDynamicBone(false)
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_319_1.time_ - 0) / var_322_1)
				arg_319_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1054ui_story"].transform.position).z)
				arg_319_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1054ui_story"].transform.localEulerAngles = arg_319_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_319_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["1054ui_story"].transform.position).z)
				arg_319_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["1054ui_story"].transform.localEulerAngles = arg_319_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_322_2 = GameObjectTools.GetOrAddComponent(arg_319_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_322_2 then
					var_322_2:EnableDynamicBone(true)
				end
			end

			local var_322_3 = arg_319_1.actors_["1054ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_3) and arg_319_1.var_.characterEffect1054ui_story == nil then
				arg_319_1.var_.characterEffect1054ui_story = var_322_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_4 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 and not isNil(var_322_3) then
				if arg_319_1.var_.characterEffect1054ui_story and not isNil(var_322_3) then
					arg_319_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 and not isNil(var_322_3) and arg_319_1.var_.characterEffect1054ui_story then
				arg_319_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_2")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_322_6 = 0
			local var_322_7 = 0.475

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_6 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_8 = arg_319_1:GetWordFromCfg(426051078)
				local var_322_9 = arg_319_1:FormatText(var_322_8.content)

				arg_319_1.text_.text = var_322_9

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_11 = 19 <= 0 and var_322_7 or var_322_7 * (utf8.len(var_322_9) / 19)

				if (19 <= 0 and var_322_7 or var_322_7 * (utf8.len(var_322_9) / 19)) > 0 and var_322_7 < var_322_11 then
					arg_319_1.talkMaxDuration = var_322_11

					if var_322_11 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_11 + var_322_6
					end
				end

				arg_319_1.text_.text = var_322_9
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051078", "story_v_out_426051.awb") ~= 0 then
					local var_322_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051078", "story_v_out_426051.awb") / 1000

					if var_322_12 + var_322_6 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_12 + var_322_6
					end

					if var_322_8.prefab_name ~= "" and arg_319_1.actors_[var_322_8.prefab_name] ~= nil then
						local var_322_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_8.prefab_name].transform, "story_v_out_426051", "426051078", "story_v_out_426051.awb")

						arg_319_1:RecordAudio("426051078", var_322_13)
						arg_319_1:RecordAudio("426051078", var_322_13)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_426051", "426051078", "story_v_out_426051.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_426051", "426051078", "story_v_out_426051.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_14 = math.max(var_322_7, arg_319_1.talkMaxDuration)

			if var_322_6 <= arg_319_1.time_ and arg_319_1.time_ < var_322_6 + var_322_14 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_6) / var_322_14

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_6 + var_322_14 and arg_319_1.time_ < var_322_6 + var_322_14 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play426051079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 426051079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play426051080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos6148ui_story = arg_323_1.actors_["6148ui_story"].transform.localPosition

				local var_326_0 = GameObjectTools.GetOrAddComponent(arg_323_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_326_0 then
					var_326_0:EnableDynamicBone(false)
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_1)
				arg_323_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["6148ui_story"].transform.position).z)
				arg_323_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["6148ui_story"].transform.localEulerAngles = arg_323_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["6148ui_story"].transform.position).z)
				arg_323_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["6148ui_story"].transform.localEulerAngles = arg_323_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_326_2 = GameObjectTools.GetOrAddComponent(arg_323_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_326_2 then
					var_326_2:EnableDynamicBone(true)
				end
			end

			local var_326_3 = arg_323_1.actors_["1054ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1054ui_story = var_326_3.localPosition

				local var_326_4 = GameObjectTools.GetOrAddComponent(var_326_3.gameObject, typeof(DynamicBoneHelper))

				if var_326_4 then
					var_326_4:EnableDynamicBone(false)
				end
			end

			local var_326_5 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 then
				var_326_3.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_5)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_5 and arg_323_1.time_ < 0 + var_326_5 + arg_326_0 then
				var_326_3.localPosition = Vector3.New(0, 100, 0)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles

				local var_326_6 = GameObjectTools.GetOrAddComponent(var_326_3.gameObject, typeof(DynamicBoneHelper))

				if var_326_6 then
					var_326_6:EnableDynamicBone(true)
				end
			end

			local var_326_7 = arg_323_1.actors_["1054ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.characterEffect1054ui_story == nil then
				arg_323_1.var_.characterEffect1054ui_story = var_326_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_8 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_8 and not isNil(var_326_7) then
				if arg_323_1.var_.characterEffect1054ui_story and not isNil(var_326_7) then
					arg_323_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_8)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_8 and arg_323_1.time_ < 0 + var_326_8 + arg_326_0 and not isNil(var_326_7) and arg_323_1.var_.characterEffect1054ui_story then
				arg_323_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_326_9 = 0
			local var_326_10 = 0.375

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_9 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_11 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(426051079).content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 15 <= 0 and var_326_10 or var_326_10 * (utf8.len(var_326_11) / 15)

				if (15 <= 0 and var_326_10 or var_326_10 * (utf8.len(var_326_11) / 15)) > 0 and var_326_10 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_9 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_9
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_10, arg_323_1.talkMaxDuration)

			if var_326_9 <= arg_323_1.time_ and arg_323_1.time_ < var_326_9 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_9) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_9 + var_326_14 and arg_323_1.time_ < var_326_9 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play426051080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 426051080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play426051081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.3

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_1 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(426051080).content)

				arg_327_1.text_.text = var_330_1

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_3 = 12 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 12)

				if (12 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 12)) > 0 and var_330_0 < var_330_3 then
					arg_327_1.talkMaxDuration = var_330_3

					if var_330_3 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_3 + 0
					end
				end

				arg_327_1.text_.text = var_330_1
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_4 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_4

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play426051081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 426051081
		arg_331_1.duration_ = 2.3

		local var_331_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play426051082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos6148ui_story = arg_331_1.actors_["6148ui_story"].transform.localPosition

				local var_334_0 = GameObjectTools.GetOrAddComponent(arg_331_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_334_0 then
					var_334_0:EnableDynamicBone(false)
				end
			end

			local var_334_1 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_1 then
				arg_331_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_331_1.time_ - 0) / var_334_1)
				arg_331_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["6148ui_story"].transform.position).z)
				arg_331_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["6148ui_story"].transform.localEulerAngles = arg_331_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_1 and arg_331_1.time_ < 0 + var_334_1 + arg_334_0 then
				arg_331_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_331_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["6148ui_story"].transform.position).z)
				arg_331_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["6148ui_story"].transform.localEulerAngles = arg_331_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_334_2 = GameObjectTools.GetOrAddComponent(arg_331_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_334_2 then
					var_334_2:EnableDynamicBone(true)
				end
			end

			local var_334_3 = arg_331_1.actors_["6148ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_3) and arg_331_1.var_.characterEffect6148ui_story == nil then
				arg_331_1.var_.characterEffect6148ui_story = var_334_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_4 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 and not isNil(var_334_3) then
				if arg_331_1.var_.characterEffect6148ui_story and not isNil(var_334_3) then
					arg_331_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 and not isNil(var_334_3) and arg_331_1.var_.characterEffect6148ui_story then
				arg_331_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_334_6 = 0
			local var_334_7 = 0.175

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_8 = arg_331_1:GetWordFromCfg(426051081)
				local var_334_9 = arg_331_1:FormatText(var_334_8.content)

				arg_331_1.text_.text = var_334_9

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 7 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 7)

				if (7 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 7)) > 0 and var_334_7 < var_334_11 then
					arg_331_1.talkMaxDuration = var_334_11

					if var_334_11 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_9
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051081", "story_v_out_426051.awb") ~= 0 then
					local var_334_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051081", "story_v_out_426051.awb") / 1000

					if var_334_12 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_6
					end

					if var_334_8.prefab_name ~= "" and arg_331_1.actors_[var_334_8.prefab_name] ~= nil then
						local var_334_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_8.prefab_name].transform, "story_v_out_426051", "426051081", "story_v_out_426051.awb")

						arg_331_1:RecordAudio("426051081", var_334_13)
						arg_331_1:RecordAudio("426051081", var_334_13)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_426051", "426051081", "story_v_out_426051.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_426051", "426051081", "story_v_out_426051.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
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

		arg_331_1:InitPlayNodeList()
	end,
	Play426051082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 426051082
		arg_335_1.duration_ = 4.3

		local var_335_0 = {
			zh = 4.3,
			ja = 3.266
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
				arg_335_0:Play426051083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1054ui_story = arg_335_1.actors_["1054ui_story"].transform.localPosition

				local var_338_0 = GameObjectTools.GetOrAddComponent(arg_335_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_338_0 then
					var_338_0:EnableDynamicBone(false)
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_335_1.time_ - 0) / var_338_1)
				arg_335_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1054ui_story"].transform.position).z)
				arg_335_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1054ui_story"].transform.localEulerAngles = arg_335_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_335_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1054ui_story"].transform.position).z)
				arg_335_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1054ui_story"].transform.localEulerAngles = arg_335_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_338_2 = GameObjectTools.GetOrAddComponent(arg_335_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_338_2 then
					var_338_2:EnableDynamicBone(true)
				end
			end

			local var_338_3 = arg_335_1.actors_["1054ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1054ui_story == nil then
				arg_335_1.var_.characterEffect1054ui_story = var_338_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_4 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 and not isNil(var_338_3) then
				if arg_335_1.var_.characterEffect1054ui_story and not isNil(var_338_3) then
					arg_335_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1054ui_story then
				arg_335_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_338_6 = arg_335_1.actors_["6148ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect6148ui_story == nil then
				arg_335_1.var_.characterEffect6148ui_story = var_338_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_7 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 and not isNil(var_338_6) then
				if arg_335_1.var_.characterEffect6148ui_story and not isNil(var_338_6) then
					arg_335_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_335_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_7)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 and not isNil(var_338_6) and arg_335_1.var_.characterEffect6148ui_story then
				arg_335_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_335_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_338_8 = 0
			local var_338_9 = 0.5

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_10 = arg_335_1:GetWordFromCfg(426051082)
				local var_338_11 = arg_335_1:FormatText(var_338_10.content)

				arg_335_1.text_.text = var_338_11

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 20 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 20)

				if (20 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 20)) > 0 and var_338_9 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_11
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051082", "story_v_out_426051.awb") ~= 0 then
					local var_338_14 = manager.audio:GetVoiceLength("story_v_out_426051", "426051082", "story_v_out_426051.awb") / 1000

					if var_338_14 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_14 + var_338_8
					end

					if var_338_10.prefab_name ~= "" and arg_335_1.actors_[var_338_10.prefab_name] ~= nil then
						local var_338_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_10.prefab_name].transform, "story_v_out_426051", "426051082", "story_v_out_426051.awb")

						arg_335_1:RecordAudio("426051082", var_338_15)
						arg_335_1:RecordAudio("426051082", var_338_15)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_426051", "426051082", "story_v_out_426051.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_426051", "426051082", "story_v_out_426051.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_9, arg_335_1.talkMaxDuration)

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_8) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_8 + var_338_16 and arg_335_1.time_ < var_338_8 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play426051083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 426051083
		arg_339_1.duration_ = 1

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"

			SetActive(arg_339_1.choicesGo_, true)

			for iter_340_0, iter_340_1 in ipairs(arg_339_1.choices_) do
				SetActive(iter_340_1.go, iter_340_0 <= 1)
			end

			arg_339_1.choices_[1].txt.text = arg_339_1:FormatText(StoryChoiceCfg[1606].name)
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play426051084(arg_339_1)
			end

			arg_339_1:RecordChoiceLog(426051083, 1606)
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1054ui_story"]) and arg_339_1.var_.characterEffect1054ui_story == nil then
				arg_339_1.var_.characterEffect1054ui_story = arg_339_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1054ui_story"]) then
				if arg_339_1.var_.characterEffect1054ui_story and not isNil(arg_339_1.actors_["1054ui_story"]) then
					arg_339_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1054ui_story"]) and arg_339_1.var_.characterEffect1054ui_story then
				arg_339_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_342_1 = arg_339_1.actors_["6148ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect6148ui_story == nil then
				arg_339_1.var_.characterEffect6148ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect6148ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_339_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_2)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect6148ui_story then
				arg_339_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_339_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_342_3 = 0

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_3 + arg_342_0 then
				arg_339_1.allBtn_.enabled = false
			end

			if arg_339_1.time_ >= var_342_3 + 0.6 and arg_339_1.time_ < var_342_3 + 0.6 + arg_342_0 then
				arg_339_1.allBtn_.enabled = true
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play426051084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 426051084
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play426051085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0.0333333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 0.0333333333333333 + arg_346_0 then
				arg_343_1.var_.moveOldPos1054ui_story = arg_343_1.actors_["1054ui_story"].transform.localPosition

				local var_346_0 = GameObjectTools.GetOrAddComponent(arg_343_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_346_0 then
					var_346_0:EnableDynamicBone(false)
				end
			end

			local var_346_1 = 0.001

			if 0.0333333333333333 <= arg_343_1.time_ and arg_343_1.time_ < 0.0333333333333333 + var_346_1 then
				arg_343_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0.0333333333333333) / var_346_1)
				arg_343_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1054ui_story"].transform.position).z)
				arg_343_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1054ui_story"].transform.localEulerAngles = arg_343_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0.0333333333333333 + var_346_1 and arg_343_1.time_ < 0.0333333333333333 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["1054ui_story"].transform.position).z)
				arg_343_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["1054ui_story"].transform.localEulerAngles = arg_343_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_346_2 = GameObjectTools.GetOrAddComponent(arg_343_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_346_2 then
					var_346_2:EnableDynamicBone(true)
				end
			end

			local var_346_3 = arg_343_1.actors_["6148ui_story"].transform

			if 0.0333333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 0.0333333333333333 + arg_346_0 then
				arg_343_1.var_.moveOldPos6148ui_story = var_346_3.localPosition

				local var_346_4 = GameObjectTools.GetOrAddComponent(var_346_3.gameObject, typeof(DynamicBoneHelper))

				if var_346_4 then
					var_346_4:EnableDynamicBone(false)
				end
			end

			local var_346_5 = 0.001

			if 0.0333333333333333 <= arg_343_1.time_ and arg_343_1.time_ < 0.0333333333333333 + var_346_5 then
				var_346_3.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0.0333333333333333) / var_346_5)
				var_346_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_3.position).x, (manager.ui.mainCamera.transform.position - var_346_3.position).y, (manager.ui.mainCamera.transform.position - var_346_3.position).z)
				var_346_3.localEulerAngles.z = 0
				var_346_3.localEulerAngles.x = 0
				var_346_3.localEulerAngles = var_346_3.localEulerAngles
			end

			if arg_343_1.time_ >= 0.0333333333333333 + var_346_5 and arg_343_1.time_ < 0.0333333333333333 + var_346_5 + arg_346_0 then
				var_346_3.localPosition = Vector3.New(0, 100, 0)
				var_346_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_3.position).x, (manager.ui.mainCamera.transform.position - var_346_3.position).y, (manager.ui.mainCamera.transform.position - var_346_3.position).z)
				var_346_3.localEulerAngles.z = 0
				var_346_3.localEulerAngles.x = 0
				var_346_3.localEulerAngles = var_346_3.localEulerAngles

				local var_346_6 = GameObjectTools.GetOrAddComponent(var_346_3.gameObject, typeof(DynamicBoneHelper))

				if var_346_6 then
					var_346_6:EnableDynamicBone(true)
				end
			end

			local var_346_7 = 0
			local var_346_8 = 0.55

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_7 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_9 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(426051084).content)

				arg_343_1.text_.text = var_346_9

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_11 = 22 <= 0 and var_346_8 or var_346_8 * (utf8.len(var_346_9) / 22)

				if (22 <= 0 and var_346_8 or var_346_8 * (utf8.len(var_346_9) / 22)) > 0 and var_346_8 < var_346_11 then
					arg_343_1.talkMaxDuration = var_346_11

					if var_346_11 + var_346_7 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_7
					end
				end

				arg_343_1.text_.text = var_346_9
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_12 = math.max(var_346_8, arg_343_1.talkMaxDuration)

			if var_346_7 <= arg_343_1.time_ and arg_343_1.time_ < var_346_7 + var_346_12 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_7) / var_346_12

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_7 + var_346_12 and arg_343_1.time_ < var_346_7 + var_346_12 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play426051085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 426051085
		arg_347_1.duration_ = 8

		local var_347_0 = {
			zh = 7.066,
			ja = 8
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play426051086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos6148ui_story = arg_347_1.actors_["6148ui_story"].transform.localPosition

				local var_350_0 = GameObjectTools.GetOrAddComponent(arg_347_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_350_0 then
					var_350_0:EnableDynamicBone(false)
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_347_1.time_ - 0) / var_350_1)
				arg_347_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["6148ui_story"].transform.position).z)
				arg_347_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["6148ui_story"].transform.localEulerAngles = arg_347_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_347_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["6148ui_story"].transform.position).z)
				arg_347_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["6148ui_story"].transform.localEulerAngles = arg_347_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_350_2 = GameObjectTools.GetOrAddComponent(arg_347_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_350_2 then
					var_350_2:EnableDynamicBone(true)
				end
			end

			local var_350_3 = arg_347_1.actors_["6148ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_3) and arg_347_1.var_.characterEffect6148ui_story == nil then
				arg_347_1.var_.characterEffect6148ui_story = var_350_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_4 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 and not isNil(var_350_3) then
				if arg_347_1.var_.characterEffect6148ui_story and not isNil(var_350_3) then
					arg_347_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 and not isNil(var_350_3) and arg_347_1.var_.characterEffect6148ui_story then
				arg_347_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_350_6 = 0
			local var_350_7 = 0.725

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_6 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_8 = arg_347_1:GetWordFromCfg(426051085)
				local var_350_9 = arg_347_1:FormatText(var_350_8.content)

				arg_347_1.text_.text = var_350_9

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_11 = 29 <= 0 and var_350_7 or var_350_7 * (utf8.len(var_350_9) / 29)

				if (29 <= 0 and var_350_7 or var_350_7 * (utf8.len(var_350_9) / 29)) > 0 and var_350_7 < var_350_11 then
					arg_347_1.talkMaxDuration = var_350_11

					if var_350_11 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_6
					end
				end

				arg_347_1.text_.text = var_350_9
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051085", "story_v_out_426051.awb") ~= 0 then
					local var_350_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051085", "story_v_out_426051.awb") / 1000

					if var_350_12 + var_350_6 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_12 + var_350_6
					end

					if var_350_8.prefab_name ~= "" and arg_347_1.actors_[var_350_8.prefab_name] ~= nil then
						local var_350_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_8.prefab_name].transform, "story_v_out_426051", "426051085", "story_v_out_426051.awb")

						arg_347_1:RecordAudio("426051085", var_350_13)
						arg_347_1:RecordAudio("426051085", var_350_13)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_426051", "426051085", "story_v_out_426051.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_426051", "426051085", "story_v_out_426051.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_7, arg_347_1.talkMaxDuration)

			if var_350_6 <= arg_347_1.time_ and arg_347_1.time_ < var_350_6 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_6) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_6 + var_350_14 and arg_347_1.time_ < var_350_6 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play426051086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 426051086
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play426051087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["6148ui_story"]) and arg_351_1.var_.characterEffect6148ui_story == nil then
				arg_351_1.var_.characterEffect6148ui_story = arg_351_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["6148ui_story"]) then
				if arg_351_1.var_.characterEffect6148ui_story and not isNil(arg_351_1.actors_["6148ui_story"]) then
					arg_351_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_351_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_0)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["6148ui_story"]) and arg_351_1.var_.characterEffect6148ui_story then
				arg_351_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_351_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_354_1 = 0
			local var_354_2 = 0.275

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(426051086).content)

				arg_351_1.text_.text = var_354_3

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 11 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 11)

				if (11 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_3) / 11)) > 0 and var_354_2 < var_354_5 then
					arg_351_1.talkMaxDuration = var_354_5

					if var_354_5 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_3
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_6 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_6 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_6

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_6 and arg_351_1.time_ < var_354_1 + var_354_6 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play426051087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 426051087
		arg_355_1.duration_ = 5.6

		local var_355_0 = {
			zh = 5.6,
			ja = 3.666
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play426051088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1054ui_story = arg_355_1.actors_["1054ui_story"].transform.localPosition

				local var_358_0 = GameObjectTools.GetOrAddComponent(arg_355_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_358_0 then
					var_358_0:EnableDynamicBone(false)
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_355_1.time_ - 0) / var_358_1)
				arg_355_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1054ui_story"].transform.position).z)
				arg_355_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1054ui_story"].transform.localEulerAngles = arg_355_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_355_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_355_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_355_1.actors_["1054ui_story"].transform.position).z)
				arg_355_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_355_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_355_1.actors_["1054ui_story"].transform.localEulerAngles = arg_355_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_358_2 = GameObjectTools.GetOrAddComponent(arg_355_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_358_2 then
					var_358_2:EnableDynamicBone(true)
				end
			end

			local var_358_3 = arg_355_1.actors_["1054ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_3) and arg_355_1.var_.characterEffect1054ui_story == nil then
				arg_355_1.var_.characterEffect1054ui_story = var_358_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_4 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 and not isNil(var_358_3) then
				if arg_355_1.var_.characterEffect1054ui_story and not isNil(var_358_3) then
					arg_355_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 and not isNil(var_358_3) and arg_355_1.var_.characterEffect1054ui_story then
				arg_355_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_358_6 = 0
			local var_358_7 = 0.5

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_8 = arg_355_1:GetWordFromCfg(426051087)
				local var_358_9 = arg_355_1:FormatText(var_358_8.content)

				arg_355_1.text_.text = var_358_9

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 19 <= 0 and var_358_7 or var_358_7 * (utf8.len(var_358_9) / 19)

				if (19 <= 0 and var_358_7 or var_358_7 * (utf8.len(var_358_9) / 19)) > 0 and var_358_7 < var_358_11 then
					arg_355_1.talkMaxDuration = var_358_11

					if var_358_11 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_11 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_9
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051087", "story_v_out_426051.awb") ~= 0 then
					local var_358_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051087", "story_v_out_426051.awb") / 1000

					if var_358_12 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_12 + var_358_6
					end

					if var_358_8.prefab_name ~= "" and arg_355_1.actors_[var_358_8.prefab_name] ~= nil then
						local var_358_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_8.prefab_name].transform, "story_v_out_426051", "426051087", "story_v_out_426051.awb")

						arg_355_1:RecordAudio("426051087", var_358_13)
						arg_355_1:RecordAudio("426051087", var_358_13)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_426051", "426051087", "story_v_out_426051.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_426051", "426051087", "story_v_out_426051.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_14 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_14 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_14

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_14 and arg_355_1.time_ < var_358_6 + var_358_14 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play426051088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 426051088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play426051089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos6148ui_story = arg_359_1.actors_["6148ui_story"].transform.localPosition

				local var_362_0 = GameObjectTools.GetOrAddComponent(arg_359_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_362_0 then
					var_362_0:EnableDynamicBone(false)
				end
			end

			local var_362_1 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_1 then
				arg_359_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_1)
				arg_359_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["6148ui_story"].transform.position).z)
				arg_359_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["6148ui_story"].transform.localEulerAngles = arg_359_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_1 and arg_359_1.time_ < 0 + var_362_1 + arg_362_0 then
				arg_359_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_359_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["6148ui_story"].transform.position).z)
				arg_359_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["6148ui_story"].transform.localEulerAngles = arg_359_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_362_2 = GameObjectTools.GetOrAddComponent(arg_359_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_362_2 then
					var_362_2:EnableDynamicBone(true)
				end
			end

			local var_362_3 = arg_359_1.actors_["1054ui_story"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1054ui_story = var_362_3.localPosition

				local var_362_4 = GameObjectTools.GetOrAddComponent(var_362_3.gameObject, typeof(DynamicBoneHelper))

				if var_362_4 then
					var_362_4:EnableDynamicBone(false)
				end
			end

			local var_362_5 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_5 then
				var_362_3.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_359_1.time_ - 0) / var_362_5)
				var_362_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_3.position).x, (manager.ui.mainCamera.transform.position - var_362_3.position).y, (manager.ui.mainCamera.transform.position - var_362_3.position).z)
				var_362_3.localEulerAngles.z = 0
				var_362_3.localEulerAngles.x = 0
				var_362_3.localEulerAngles = var_362_3.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_5 and arg_359_1.time_ < 0 + var_362_5 + arg_362_0 then
				var_362_3.localPosition = Vector3.New(0, 100, 0)
				var_362_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_362_3.position).x, (manager.ui.mainCamera.transform.position - var_362_3.position).y, (manager.ui.mainCamera.transform.position - var_362_3.position).z)
				var_362_3.localEulerAngles.z = 0
				var_362_3.localEulerAngles.x = 0
				var_362_3.localEulerAngles = var_362_3.localEulerAngles

				local var_362_6 = GameObjectTools.GetOrAddComponent(var_362_3.gameObject, typeof(DynamicBoneHelper))

				if var_362_6 then
					var_362_6:EnableDynamicBone(true)
				end
			end

			local var_362_7 = arg_359_1.actors_["1054ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_7) and arg_359_1.var_.characterEffect1054ui_story == nil then
				arg_359_1.var_.characterEffect1054ui_story = var_362_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_8 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_8 and not isNil(var_362_7) then
				if arg_359_1.var_.characterEffect1054ui_story and not isNil(var_362_7) then
					arg_359_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_8)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_8 and arg_359_1.time_ < 0 + var_362_8 + arg_362_0 and not isNil(var_362_7) and arg_359_1.var_.characterEffect1054ui_story then
				arg_359_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_362_9 = 0
			local var_362_10 = 0.725

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_11 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(426051088).content)

				arg_359_1.text_.text = var_362_11

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_13 = 29 <= 0 and var_362_10 or var_362_10 * (utf8.len(var_362_11) / 29)

				if (29 <= 0 and var_362_10 or var_362_10 * (utf8.len(var_362_11) / 29)) > 0 and var_362_10 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_9 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_9
					end
				end

				arg_359_1.text_.text = var_362_11
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_14 = math.max(var_362_10, arg_359_1.talkMaxDuration)

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_14 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_9) / var_362_14

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_9 + var_362_14 and arg_359_1.time_ < var_362_9 + var_362_14 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
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

		arg_359_1:InitPlayNodeList()
	end,
	Play426051089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 426051089
		arg_363_1.duration_ = 8.53

		local var_363_0 = {
			zh = 8.533,
			ja = 6.9
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play426051090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1054ui_story = arg_363_1.actors_["1054ui_story"].transform.localPosition

				local var_366_0 = GameObjectTools.GetOrAddComponent(arg_363_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_366_0 then
					var_366_0:EnableDynamicBone(false)
				end
			end

			local var_366_1 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 then
				arg_363_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_363_1.time_ - 0) / var_366_1)
				arg_363_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1054ui_story"].transform.position).z)
				arg_363_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1054ui_story"].transform.localEulerAngles = arg_363_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 then
				arg_363_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_363_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1054ui_story"].transform.position).z)
				arg_363_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1054ui_story"].transform.localEulerAngles = arg_363_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_366_2 = GameObjectTools.GetOrAddComponent(arg_363_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_366_2 then
					var_366_2:EnableDynamicBone(true)
				end
			end

			local var_366_3 = arg_363_1.actors_["1054ui_story"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_3) and arg_363_1.var_.characterEffect1054ui_story == nil then
				arg_363_1.var_.characterEffect1054ui_story = var_366_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_4 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 and not isNil(var_366_3) then
				if arg_363_1.var_.characterEffect1054ui_story and not isNil(var_366_3) then
					arg_363_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 and not isNil(var_366_3) and arg_363_1.var_.characterEffect1054ui_story then
				arg_363_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_366_6 = 0
			local var_366_7 = 0.75

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_8 = arg_363_1:GetWordFromCfg(426051089)
				local var_366_9 = arg_363_1:FormatText(var_366_8.content)

				arg_363_1.text_.text = var_366_9

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 30 <= 0 and var_366_7 or var_366_7 * (utf8.len(var_366_9) / 30)

				if (30 <= 0 and var_366_7 or var_366_7 * (utf8.len(var_366_9) / 30)) > 0 and var_366_7 < var_366_11 then
					arg_363_1.talkMaxDuration = var_366_11

					if var_366_11 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_11 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_9
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051089", "story_v_out_426051.awb") ~= 0 then
					local var_366_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051089", "story_v_out_426051.awb") / 1000

					if var_366_12 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_6
					end

					if var_366_8.prefab_name ~= "" and arg_363_1.actors_[var_366_8.prefab_name] ~= nil then
						local var_366_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_8.prefab_name].transform, "story_v_out_426051", "426051089", "story_v_out_426051.awb")

						arg_363_1:RecordAudio("426051089", var_366_13)
						arg_363_1:RecordAudio("426051089", var_366_13)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_426051", "426051089", "story_v_out_426051.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_426051", "426051089", "story_v_out_426051.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_14 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_14 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_14

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_14 and arg_363_1.time_ < var_366_6 + var_366_14 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play426051090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 426051090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play426051091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos6148ui_story = arg_367_1.actors_["6148ui_story"].transform.localPosition

				local var_370_0 = GameObjectTools.GetOrAddComponent(arg_367_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_370_0 then
					var_370_0:EnableDynamicBone(false)
				end
			end

			local var_370_1 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_1 then
				arg_367_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_1)
				arg_367_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["6148ui_story"].transform.position).z)
				arg_367_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["6148ui_story"].transform.localEulerAngles = arg_367_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_1 and arg_367_1.time_ < 0 + var_370_1 + arg_370_0 then
				arg_367_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["6148ui_story"].transform.position).z)
				arg_367_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["6148ui_story"].transform.localEulerAngles = arg_367_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_370_2 = GameObjectTools.GetOrAddComponent(arg_367_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_370_2 then
					var_370_2:EnableDynamicBone(true)
				end
			end

			local var_370_3 = arg_367_1.actors_["1054ui_story"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1054ui_story = var_370_3.localPosition

				local var_370_4 = GameObjectTools.GetOrAddComponent(var_370_3.gameObject, typeof(DynamicBoneHelper))

				if var_370_4 then
					var_370_4:EnableDynamicBone(false)
				end
			end

			local var_370_5 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_5 then
				var_370_3.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_5)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_5 and arg_367_1.time_ < 0 + var_370_5 + arg_370_0 then
				var_370_3.localPosition = Vector3.New(0, 100, 0)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles

				local var_370_6 = GameObjectTools.GetOrAddComponent(var_370_3.gameObject, typeof(DynamicBoneHelper))

				if var_370_6 then
					var_370_6:EnableDynamicBone(true)
				end
			end

			local var_370_7 = arg_367_1.actors_["1054ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_7) and arg_367_1.var_.characterEffect1054ui_story == nil then
				arg_367_1.var_.characterEffect1054ui_story = var_370_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_8 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_8 and not isNil(var_370_7) then
				if arg_367_1.var_.characterEffect1054ui_story and not isNil(var_370_7) then
					arg_367_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_367_1.time_ - 0) / var_370_8)
				end
			end

			if arg_367_1.time_ >= 0 + var_370_8 and arg_367_1.time_ < 0 + var_370_8 + arg_370_0 and not isNil(var_370_7) and arg_367_1.var_.characterEffect1054ui_story then
				arg_367_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_370_9 = 0
			local var_370_10 = 0.6

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_9 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_11 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(426051090).content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 24 <= 0 and var_370_10 or var_370_10 * (utf8.len(var_370_11) / 24)

				if (24 <= 0 and var_370_10 or var_370_10 * (utf8.len(var_370_11) / 24)) > 0 and var_370_10 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_9 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_9
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_14 = math.max(var_370_10, arg_367_1.talkMaxDuration)

			if var_370_9 <= arg_367_1.time_ and arg_367_1.time_ < var_370_9 + var_370_14 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_9) / var_370_14

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_9 + var_370_14 and arg_367_1.time_ < var_370_9 + var_370_14 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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

		arg_367_1:InitPlayNodeList()
	end,
	Play426051091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 426051091
		arg_371_1.duration_ = 4.37

		local var_371_0 = {
			zh = 3.666,
			ja = 4.366
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play426051092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos6148ui_story = arg_371_1.actors_["6148ui_story"].transform.localPosition

				local var_374_0 = GameObjectTools.GetOrAddComponent(arg_371_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_374_0 then
					var_374_0:EnableDynamicBone(false)
				end
			end

			local var_374_1 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_1 then
				arg_371_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_371_1.time_ - 0) / var_374_1)
				arg_371_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["6148ui_story"].transform.position).z)
				arg_371_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["6148ui_story"].transform.localEulerAngles = arg_371_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_1 and arg_371_1.time_ < 0 + var_374_1 + arg_374_0 then
				arg_371_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_371_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["6148ui_story"].transform.position).z)
				arg_371_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["6148ui_story"].transform.localEulerAngles = arg_371_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_374_2 = GameObjectTools.GetOrAddComponent(arg_371_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_374_2 then
					var_374_2:EnableDynamicBone(true)
				end
			end

			local var_374_3 = arg_371_1.actors_["6148ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_3) and arg_371_1.var_.characterEffect6148ui_story == nil then
				arg_371_1.var_.characterEffect6148ui_story = var_374_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_4 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 and not isNil(var_374_3) then
				if arg_371_1.var_.characterEffect6148ui_story and not isNil(var_374_3) then
					arg_371_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 and not isNil(var_374_3) and arg_371_1.var_.characterEffect6148ui_story then
				arg_371_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_374_6 = 0
			local var_374_7 = 0.15

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_8 = arg_371_1:GetWordFromCfg(426051091)
				local var_374_9 = arg_371_1:FormatText(var_374_8.content)

				arg_371_1.text_.text = var_374_9

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 6 <= 0 and var_374_7 or var_374_7 * (utf8.len(var_374_9) / 6)

				if (6 <= 0 and var_374_7 or var_374_7 * (utf8.len(var_374_9) / 6)) > 0 and var_374_7 < var_374_11 then
					arg_371_1.talkMaxDuration = var_374_11

					if var_374_11 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_11 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_9
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051091", "story_v_out_426051.awb") ~= 0 then
					local var_374_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051091", "story_v_out_426051.awb") / 1000

					if var_374_12 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_12 + var_374_6
					end

					if var_374_8.prefab_name ~= "" and arg_371_1.actors_[var_374_8.prefab_name] ~= nil then
						local var_374_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_8.prefab_name].transform, "story_v_out_426051", "426051091", "story_v_out_426051.awb")

						arg_371_1:RecordAudio("426051091", var_374_13)
						arg_371_1:RecordAudio("426051091", var_374_13)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_426051", "426051091", "story_v_out_426051.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_426051", "426051091", "story_v_out_426051.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_14 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_14 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_14

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_14 and arg_371_1.time_ < var_374_6 + var_374_14 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
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

		arg_371_1:InitPlayNodeList()
	end,
	Play426051092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 426051092
		arg_375_1.duration_ = 7.1

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play426051093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1054ui_story = arg_375_1.actors_["1054ui_story"].transform.localPosition

				local var_378_0 = GameObjectTools.GetOrAddComponent(arg_375_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_378_0 then
					var_378_0:EnableDynamicBone(false)
				end
			end

			local var_378_1 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 then
				arg_375_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_375_1.time_ - 0) / var_378_1)
				arg_375_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).z)
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles = arg_375_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 then
				arg_375_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_375_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1054ui_story"].transform.position).z)
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1054ui_story"].transform.localEulerAngles = arg_375_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_378_2 = GameObjectTools.GetOrAddComponent(arg_375_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_378_2 then
					var_378_2:EnableDynamicBone(true)
				end
			end

			local var_378_3 = arg_375_1.actors_["1054ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_3) and arg_375_1.var_.characterEffect1054ui_story == nil then
				arg_375_1.var_.characterEffect1054ui_story = var_378_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_4 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 and not isNil(var_378_3) then
				if arg_375_1.var_.characterEffect1054ui_story and not isNil(var_378_3) then
					arg_375_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 and not isNil(var_378_3) and arg_375_1.var_.characterEffect1054ui_story then
				arg_375_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_378_6 = arg_375_1.actors_["6148ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect6148ui_story == nil then
				arg_375_1.var_.characterEffect6148ui_story = var_378_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_7 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 and not isNil(var_378_6) then
				if arg_375_1.var_.characterEffect6148ui_story and not isNil(var_378_6) then
					arg_375_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_375_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_7)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect6148ui_story then
				arg_375_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_375_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_378_8 = 0
			local var_378_9 = 0.675

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:GetWordFromCfg(426051092)
				local var_378_11 = arg_375_1:FormatText(var_378_10.content)

				arg_375_1.text_.text = var_378_11

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_13 = 27 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 27)

				if (27 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 27)) > 0 and var_378_9 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_8
					end
				end

				arg_375_1.text_.text = var_378_11
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051092", "story_v_out_426051.awb") ~= 0 then
					local var_378_14 = manager.audio:GetVoiceLength("story_v_out_426051", "426051092", "story_v_out_426051.awb") / 1000

					if var_378_14 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_8
					end

					if var_378_10.prefab_name ~= "" and arg_375_1.actors_[var_378_10.prefab_name] ~= nil then
						local var_378_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_10.prefab_name].transform, "story_v_out_426051", "426051092", "story_v_out_426051.awb")

						arg_375_1:RecordAudio("426051092", var_378_15)
						arg_375_1:RecordAudio("426051092", var_378_15)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_426051", "426051092", "story_v_out_426051.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_426051", "426051092", "story_v_out_426051.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_16 = math.max(var_378_9, arg_375_1.talkMaxDuration)

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_16 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_8) / var_378_16

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_8 + var_378_16 and arg_375_1.time_ < var_378_8 + var_378_16 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play426051093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 426051093
		arg_379_1.duration_ = 7.9

		local var_379_0 = {
			zh = 6.133,
			ja = 7.9
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play426051094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos6148ui_story = arg_379_1.actors_["6148ui_story"].transform.localPosition

				local var_382_0 = GameObjectTools.GetOrAddComponent(arg_379_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_382_0 then
					var_382_0:EnableDynamicBone(false)
				end
			end

			local var_382_1 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 then
				arg_379_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_379_1.time_ - 0) / var_382_1)
				arg_379_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).z)
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles = arg_379_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 then
				arg_379_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_379_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["6148ui_story"].transform.position).z)
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["6148ui_story"].transform.localEulerAngles = arg_379_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_382_2 = GameObjectTools.GetOrAddComponent(arg_379_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_382_2 then
					var_382_2:EnableDynamicBone(true)
				end
			end

			local var_382_3 = arg_379_1.actors_["6148ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_3) and arg_379_1.var_.characterEffect6148ui_story == nil then
				arg_379_1.var_.characterEffect6148ui_story = var_382_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_4 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 and not isNil(var_382_3) then
				if arg_379_1.var_.characterEffect6148ui_story and not isNil(var_382_3) then
					arg_379_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 and not isNil(var_382_3) and arg_379_1.var_.characterEffect6148ui_story then
				arg_379_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_382_6 = arg_379_1.actors_["1054ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1054ui_story == nil then
				arg_379_1.var_.characterEffect1054ui_story = var_382_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_7 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 and not isNil(var_382_6) then
				if arg_379_1.var_.characterEffect1054ui_story and not isNil(var_382_6) then
					arg_379_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_7)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 and not isNil(var_382_6) and arg_379_1.var_.characterEffect1054ui_story then
				arg_379_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_382_8 = 0
			local var_382_9 = 0.675

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_10 = arg_379_1:GetWordFromCfg(426051093)
				local var_382_11 = arg_379_1:FormatText(var_382_10.content)

				arg_379_1.text_.text = var_382_11

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 27 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 27)

				if (27 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 27)) > 0 and var_382_9 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_11
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051093", "story_v_out_426051.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_426051", "426051093", "story_v_out_426051.awb") / 1000

					if var_382_14 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_8
					end

					if var_382_10.prefab_name ~= "" and arg_379_1.actors_[var_382_10.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_10.prefab_name].transform, "story_v_out_426051", "426051093", "story_v_out_426051.awb")

						arg_379_1:RecordAudio("426051093", var_382_15)
						arg_379_1:RecordAudio("426051093", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_426051", "426051093", "story_v_out_426051.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_426051", "426051093", "story_v_out_426051.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_16 and arg_379_1.time_ < var_382_8 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play426051094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 426051094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play426051095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["6148ui_story"]) and arg_383_1.var_.characterEffect6148ui_story == nil then
				arg_383_1.var_.characterEffect6148ui_story = arg_383_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["6148ui_story"]) then
				if arg_383_1.var_.characterEffect6148ui_story and not isNil(arg_383_1.actors_["6148ui_story"]) then
					arg_383_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_383_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["6148ui_story"]) and arg_383_1.var_.characterEffect6148ui_story then
				arg_383_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_383_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.475

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(426051094).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 19 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 19)

				if (19 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 19)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play426051095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 426051095
		arg_387_1.duration_ = 4.27

		local var_387_0 = {
			zh = 4.266,
			ja = 2.8
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play426051096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos6148ui_story = arg_387_1.actors_["6148ui_story"].transform.localPosition

				local var_390_0 = GameObjectTools.GetOrAddComponent(arg_387_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_390_0 then
					var_390_0:EnableDynamicBone(false)
				end
			end

			local var_390_1 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_1 then
				arg_387_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_387_1.time_ - 0) / var_390_1)
				arg_387_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).z)
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles = arg_387_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_1 and arg_387_1.time_ < 0 + var_390_1 + arg_390_0 then
				arg_387_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_387_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["6148ui_story"].transform.position).z)
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["6148ui_story"].transform.localEulerAngles = arg_387_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_390_2 = GameObjectTools.GetOrAddComponent(arg_387_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_390_2 then
					var_390_2:EnableDynamicBone(true)
				end
			end

			local var_390_3 = arg_387_1.actors_["1054ui_story"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1054ui_story = var_390_3.localPosition

				local var_390_4 = GameObjectTools.GetOrAddComponent(var_390_3.gameObject, typeof(DynamicBoneHelper))

				if var_390_4 then
					var_390_4:EnableDynamicBone(false)
				end
			end

			local var_390_5 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_5 then
				var_390_3.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_387_1.time_ - 0) / var_390_5)
				var_390_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_3.position).x, (manager.ui.mainCamera.transform.position - var_390_3.position).y, (manager.ui.mainCamera.transform.position - var_390_3.position).z)
				var_390_3.localEulerAngles.z = 0
				var_390_3.localEulerAngles.x = 0
				var_390_3.localEulerAngles = var_390_3.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_5 and arg_387_1.time_ < 0 + var_390_5 + arg_390_0 then
				var_390_3.localPosition = Vector3.New(0, 100, 0)
				var_390_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_390_3.position).x, (manager.ui.mainCamera.transform.position - var_390_3.position).y, (manager.ui.mainCamera.transform.position - var_390_3.position).z)
				var_390_3.localEulerAngles.z = 0
				var_390_3.localEulerAngles.x = 0
				var_390_3.localEulerAngles = var_390_3.localEulerAngles

				local var_390_6 = GameObjectTools.GetOrAddComponent(var_390_3.gameObject, typeof(DynamicBoneHelper))

				if var_390_6 then
					var_390_6:EnableDynamicBone(true)
				end
			end

			local var_390_7 = manager.ui.mainCamera.transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.shakeOldPos = var_390_7.localPosition
			end

			local var_390_8 = 0.233333333333333

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_8 then
				local var_390_9, var_390_10 = math.modf((arg_387_1.time_ - 0) / 0.066)

				var_390_7.localPosition = Vector3.New(var_390_10 * 0.13, var_390_10 * 0.13, var_390_10 * 0.13) + arg_387_1.var_.shakeOldPos
			end

			if arg_387_1.time_ >= 0 + var_390_8 and arg_387_1.time_ < 0 + var_390_8 + arg_390_0 then
				var_390_7.localPosition = arg_387_1.var_.shakeOldPos
			end

			local var_390_11 = 0

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_11 + arg_390_0 then
				arg_387_1.allBtn_.enabled = false
			end

			if arg_387_1.time_ >= var_390_11 + 0.233333333333333 and arg_387_1.time_ < var_390_11 + 0.233333333333333 + arg_390_0 then
				arg_387_1.allBtn_.enabled = true
			end

			local var_390_12 = 0
			local var_390_13 = 0.4

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_12 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				arg_387_1.dialog_:SetActive(true)

				arg_387_1.dialogCg_.alpha = 0

				local var_390_14 = LeanTween.value(arg_387_1.dialog_, 0, 1, 0.3)

				var_390_14:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_387_1.dialogCg_.alpha = arg_391_0
				end))
				var_390_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_387_1.dialog_)
					var_390_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_387_1.duration_ = arg_387_1.duration_ + 0.3

				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_15 = arg_387_1:GetWordFromCfg(426051095)
				local var_390_16 = arg_387_1:FormatText(var_390_15.content)

				arg_387_1.text_.text = var_390_16

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_18 = 16 <= 0 and var_390_13 or var_390_13 * (utf8.len(var_390_16) / 16)

				if (16 <= 0 and var_390_13 or var_390_13 * (utf8.len(var_390_16) / 16)) > 0 and var_390_13 < var_390_18 then
					arg_387_1.talkMaxDuration = var_390_18
					var_390_12 = var_390_12 + 0.3

					if var_390_18 + var_390_12 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_18 + var_390_12
					end
				end

				arg_387_1.text_.text = var_390_16
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051095", "story_v_out_426051.awb") ~= 0 then
					local var_390_19 = manager.audio:GetVoiceLength("story_v_out_426051", "426051095", "story_v_out_426051.awb") / 1000

					if var_390_19 + var_390_12 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_19 + var_390_12
					end

					if var_390_15.prefab_name ~= "" and arg_387_1.actors_[var_390_15.prefab_name] ~= nil then
						local var_390_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_15.prefab_name].transform, "story_v_out_426051", "426051095", "story_v_out_426051.awb")

						arg_387_1:RecordAudio("426051095", var_390_20)
						arg_387_1:RecordAudio("426051095", var_390_20)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_426051", "426051095", "story_v_out_426051.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_426051", "426051095", "story_v_out_426051.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_21 = var_390_12 + 0.3
			local var_390_22 = math.max(var_390_13, arg_387_1.talkMaxDuration)

			if var_390_12 + 0.3 <= arg_387_1.time_ and arg_387_1.time_ < var_390_21 + var_390_22 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_21) / var_390_22

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_21 + var_390_22 and arg_387_1.time_ < var_390_21 + var_390_22 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
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

		arg_387_1:InitPlayNodeList()
	end,
	Play426051096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 426051096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play426051097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1054ui_story"]) and arg_393_1.var_.characterEffect1054ui_story == nil then
				arg_393_1.var_.characterEffect1054ui_story = arg_393_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1054ui_story"]) then
				if arg_393_1.var_.characterEffect1054ui_story and not isNil(arg_393_1.actors_["1054ui_story"]) then
					arg_393_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1054ui_story"]) and arg_393_1.var_.characterEffect1054ui_story then
				arg_393_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 1.1

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(426051096).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 44 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 44)

				if (44 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 44)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play426051097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 426051097
		arg_397_1.duration_ = 5.27

		local var_397_0 = {
			zh = 3.933,
			ja = 5.266
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play426051098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos6148ui_story = arg_397_1.actors_["6148ui_story"].transform.localPosition

				local var_400_0 = GameObjectTools.GetOrAddComponent(arg_397_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_400_0 then
					var_400_0:EnableDynamicBone(false)
				end
			end

			local var_400_1 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_1 then
				arg_397_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_397_1.time_ - 0) / var_400_1)
				arg_397_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["6148ui_story"].transform.position).z)
				arg_397_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["6148ui_story"].transform.localEulerAngles = arg_397_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_1 and arg_397_1.time_ < 0 + var_400_1 + arg_400_0 then
				arg_397_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_397_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["6148ui_story"].transform.position).z)
				arg_397_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["6148ui_story"].transform.localEulerAngles = arg_397_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_400_2 = GameObjectTools.GetOrAddComponent(arg_397_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_400_2 then
					var_400_2:EnableDynamicBone(true)
				end
			end

			local var_400_3 = arg_397_1.actors_["6148ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_3) and arg_397_1.var_.characterEffect6148ui_story == nil then
				arg_397_1.var_.characterEffect6148ui_story = var_400_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_4 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 and not isNil(var_400_3) then
				if arg_397_1.var_.characterEffect6148ui_story and not isNil(var_400_3) then
					arg_397_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 and not isNil(var_400_3) and arg_397_1.var_.characterEffect6148ui_story then
				arg_397_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_400_6 = 0
			local var_400_7 = 0.5

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_8 = arg_397_1:GetWordFromCfg(426051097)
				local var_400_9 = arg_397_1:FormatText(var_400_8.content)

				arg_397_1.text_.text = var_400_9

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 20 <= 0 and var_400_7 or var_400_7 * (utf8.len(var_400_9) / 20)

				if (20 <= 0 and var_400_7 or var_400_7 * (utf8.len(var_400_9) / 20)) > 0 and var_400_7 < var_400_11 then
					arg_397_1.talkMaxDuration = var_400_11

					if var_400_11 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_11 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_9
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051097", "story_v_out_426051.awb") ~= 0 then
					local var_400_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051097", "story_v_out_426051.awb") / 1000

					if var_400_12 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_12 + var_400_6
					end

					if var_400_8.prefab_name ~= "" and arg_397_1.actors_[var_400_8.prefab_name] ~= nil then
						local var_400_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_8.prefab_name].transform, "story_v_out_426051", "426051097", "story_v_out_426051.awb")

						arg_397_1:RecordAudio("426051097", var_400_13)
						arg_397_1:RecordAudio("426051097", var_400_13)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_426051", "426051097", "story_v_out_426051.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_426051", "426051097", "story_v_out_426051.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_14 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_14 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_14

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_14 and arg_397_1.time_ < var_400_6 + var_400_14 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
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

		arg_397_1:InitPlayNodeList()
	end,
	Play426051098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 426051098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play426051099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["6148ui_story"]) and arg_401_1.var_.characterEffect6148ui_story == nil then
				arg_401_1.var_.characterEffect6148ui_story = arg_401_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["6148ui_story"]) then
				if arg_401_1.var_.characterEffect6148ui_story and not isNil(arg_401_1.actors_["6148ui_story"]) then
					arg_401_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_401_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["6148ui_story"]) and arg_401_1.var_.characterEffect6148ui_story then
				arg_401_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_401_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_404_1 = 0
			local var_404_2 = 0.175

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_3 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(426051098).content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 7 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 7)

				if (7 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 7)) > 0 and var_404_2 < var_404_5 then
					arg_401_1.talkMaxDuration = var_404_5

					if var_404_5 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_6 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_6 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_6

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_6 and arg_401_1.time_ < var_404_1 + var_404_6 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play426051099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 426051099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play426051100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos6148ui_story = arg_405_1.actors_["6148ui_story"].transform.localPosition

				local var_408_0 = GameObjectTools.GetOrAddComponent(arg_405_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_408_0 then
					var_408_0:EnableDynamicBone(false)
				end
			end

			local var_408_1 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_1 then
				arg_405_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_405_1.time_ - 0) / var_408_1)
				arg_405_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["6148ui_story"].transform.position).z)
				arg_405_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["6148ui_story"].transform.localEulerAngles = arg_405_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_1 and arg_405_1.time_ < 0 + var_408_1 + arg_408_0 then
				arg_405_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_405_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["6148ui_story"].transform.position).z)
				arg_405_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["6148ui_story"].transform.localEulerAngles = arg_405_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_408_2 = GameObjectTools.GetOrAddComponent(arg_405_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_408_2 then
					var_408_2:EnableDynamicBone(true)
				end
			end

			local var_408_3 = arg_405_1.actors_["1054ui_story"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1054ui_story = var_408_3.localPosition

				local var_408_4 = GameObjectTools.GetOrAddComponent(var_408_3.gameObject, typeof(DynamicBoneHelper))

				if var_408_4 then
					var_408_4:EnableDynamicBone(false)
				end
			end

			local var_408_5 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_5 then
				var_408_3.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_405_1.time_ - 0) / var_408_5)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_5 and arg_405_1.time_ < 0 + var_408_5 + arg_408_0 then
				var_408_3.localPosition = Vector3.New(0, 100, 0)
				var_408_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_408_3.position).x, (manager.ui.mainCamera.transform.position - var_408_3.position).y, (manager.ui.mainCamera.transform.position - var_408_3.position).z)
				var_408_3.localEulerAngles.z = 0
				var_408_3.localEulerAngles.x = 0
				var_408_3.localEulerAngles = var_408_3.localEulerAngles

				local var_408_6 = GameObjectTools.GetOrAddComponent(var_408_3.gameObject, typeof(DynamicBoneHelper))

				if var_408_6 then
					var_408_6:EnableDynamicBone(true)
				end
			end

			local var_408_7 = 0
			local var_408_8 = 0.75

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_9 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(426051099).content)

				arg_405_1.text_.text = var_408_9

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 30 <= 0 and var_408_8 or var_408_8 * (utf8.len(var_408_9) / 30)

				if (30 <= 0 and var_408_8 or var_408_8 * (utf8.len(var_408_9) / 30)) > 0 and var_408_8 < var_408_11 then
					arg_405_1.talkMaxDuration = var_408_11

					if var_408_11 + var_408_7 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_11 + var_408_7
					end
				end

				arg_405_1.text_.text = var_408_9
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_8, arg_405_1.talkMaxDuration)

			if var_408_7 <= arg_405_1.time_ and arg_405_1.time_ < var_408_7 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_7) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_7 + var_408_12 and arg_405_1.time_ < var_408_7 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play426051100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 426051100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play426051101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.375

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_1 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(426051100).content)

				arg_409_1.text_.text = var_412_1

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_3 = 15 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 15)

				if (15 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 15)) > 0 and var_412_0 < var_412_3 then
					arg_409_1.talkMaxDuration = var_412_3

					if var_412_3 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_3 + 0
					end
				end

				arg_409_1.text_.text = var_412_1
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_4 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_4

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play426051101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 426051101
		arg_413_1.duration_ = 9.43

		local var_413_0 = {
			zh = 4,
			ja = 9.433
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play426051102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1054ui_story = arg_413_1.actors_["1054ui_story"].transform.localPosition

				local var_416_0 = GameObjectTools.GetOrAddComponent(arg_413_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_416_0 then
					var_416_0:EnableDynamicBone(false)
				end
			end

			local var_416_1 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_1 then
				arg_413_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_413_1.time_ - 0) / var_416_1)
				arg_413_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1054ui_story"].transform.position).z)
				arg_413_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1054ui_story"].transform.localEulerAngles = arg_413_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_1 and arg_413_1.time_ < 0 + var_416_1 + arg_416_0 then
				arg_413_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_413_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1054ui_story"].transform.position).z)
				arg_413_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1054ui_story"].transform.localEulerAngles = arg_413_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_416_2 = GameObjectTools.GetOrAddComponent(arg_413_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_416_2 then
					var_416_2:EnableDynamicBone(true)
				end
			end

			local var_416_3 = arg_413_1.actors_["1054ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_3) and arg_413_1.var_.characterEffect1054ui_story == nil then
				arg_413_1.var_.characterEffect1054ui_story = var_416_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_4 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 and not isNil(var_416_3) then
				if arg_413_1.var_.characterEffect1054ui_story and not isNil(var_416_3) then
					arg_413_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 and not isNil(var_416_3) and arg_413_1.var_.characterEffect1054ui_story then
				arg_413_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_416_6 = 0
			local var_416_7 = 0.375

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:GetWordFromCfg(426051101)
				local var_416_9 = arg_413_1:FormatText(var_416_8.content)

				arg_413_1.text_.text = var_416_9

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_11 = 15 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_9) / 15)

				if (15 <= 0 and var_416_7 or var_416_7 * (utf8.len(var_416_9) / 15)) > 0 and var_416_7 < var_416_11 then
					arg_413_1.talkMaxDuration = var_416_11

					if var_416_11 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_11 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_9
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051101", "story_v_out_426051.awb") ~= 0 then
					local var_416_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051101", "story_v_out_426051.awb") / 1000

					if var_416_12 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_6
					end

					if var_416_8.prefab_name ~= "" and arg_413_1.actors_[var_416_8.prefab_name] ~= nil then
						local var_416_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_8.prefab_name].transform, "story_v_out_426051", "426051101", "story_v_out_426051.awb")

						arg_413_1:RecordAudio("426051101", var_416_13)
						arg_413_1:RecordAudio("426051101", var_416_13)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_426051", "426051101", "story_v_out_426051.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_426051", "426051101", "story_v_out_426051.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_14 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_14 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_14

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_14 and arg_413_1.time_ < var_416_6 + var_416_14 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play426051102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 426051102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play426051103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1054ui_story"]) and arg_417_1.var_.characterEffect1054ui_story == nil then
				arg_417_1.var_.characterEffect1054ui_story = arg_417_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1054ui_story"]) then
				if arg_417_1.var_.characterEffect1054ui_story and not isNil(arg_417_1.actors_["1054ui_story"]) then
					arg_417_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1054ui_story"]) and arg_417_1.var_.characterEffect1054ui_story then
				arg_417_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.225

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(426051102).content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 9 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 9)

				if (9 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 9)) > 0 and var_420_2 < var_420_5 then
					arg_417_1.talkMaxDuration = var_420_5

					if var_420_5 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_3
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_6 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_6 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_6

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_6 and arg_417_1.time_ < var_420_1 + var_420_6 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play426051103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 426051103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play426051104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1054ui_story = arg_421_1.actors_["1054ui_story"].transform.localPosition

				local var_424_0 = GameObjectTools.GetOrAddComponent(arg_421_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_424_0 then
					var_424_0:EnableDynamicBone(false)
				end
			end

			local var_424_1 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_1 then
				arg_421_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 0) / var_424_1)
				arg_421_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1054ui_story"].transform.position).z)
				arg_421_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1054ui_story"].transform.localEulerAngles = arg_421_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_1 and arg_421_1.time_ < 0 + var_424_1 + arg_424_0 then
				arg_421_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1054ui_story"].transform.position).z)
				arg_421_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1054ui_story"].transform.localEulerAngles = arg_421_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_424_2 = GameObjectTools.GetOrAddComponent(arg_421_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_424_2 then
					var_424_2:EnableDynamicBone(true)
				end
			end

			local var_424_3 = 0
			local var_424_4 = 0.575

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_3 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_5 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(426051103).content)

				arg_421_1.text_.text = var_424_5

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_7 = 23 <= 0 and var_424_4 or var_424_4 * (utf8.len(var_424_5) / 23)

				if (23 <= 0 and var_424_4 or var_424_4 * (utf8.len(var_424_5) / 23)) > 0 and var_424_4 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_3 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_3
					end
				end

				arg_421_1.text_.text = var_424_5
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_8 = math.max(var_424_4, arg_421_1.talkMaxDuration)

			if var_424_3 <= arg_421_1.time_ and arg_421_1.time_ < var_424_3 + var_424_8 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_3) / var_424_8

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_3 + var_424_8 and arg_421_1.time_ < var_424_3 + var_424_8 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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

		arg_421_1:InitPlayNodeList()
	end,
	Play426051104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 426051104
		arg_425_1.duration_ = 4.23

		local var_425_0 = {
			zh = 4.233,
			ja = 4.133
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play426051105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos6148ui_story = arg_425_1.actors_["6148ui_story"].transform.localPosition

				local var_428_0 = GameObjectTools.GetOrAddComponent(arg_425_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_428_0 then
					var_428_0:EnableDynamicBone(false)
				end
			end

			local var_428_1 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_1 then
				arg_425_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_425_1.time_ - 0) / var_428_1)
				arg_425_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["6148ui_story"].transform.position).z)
				arg_425_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["6148ui_story"].transform.localEulerAngles = arg_425_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_1 and arg_425_1.time_ < 0 + var_428_1 + arg_428_0 then
				arg_425_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_425_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["6148ui_story"].transform.position).z)
				arg_425_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["6148ui_story"].transform.localEulerAngles = arg_425_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_428_2 = GameObjectTools.GetOrAddComponent(arg_425_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_428_2 then
					var_428_2:EnableDynamicBone(true)
				end
			end

			local var_428_3 = arg_425_1.actors_["6148ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_3) and arg_425_1.var_.characterEffect6148ui_story == nil then
				arg_425_1.var_.characterEffect6148ui_story = var_428_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_4 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 and not isNil(var_428_3) then
				if arg_425_1.var_.characterEffect6148ui_story and not isNil(var_428_3) then
					arg_425_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 and not isNil(var_428_3) and arg_425_1.var_.characterEffect6148ui_story then
				arg_425_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_428_6 = 0
			local var_428_7 = 0.375

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_8 = arg_425_1:GetWordFromCfg(426051104)
				local var_428_9 = arg_425_1:FormatText(var_428_8.content)

				arg_425_1.text_.text = var_428_9

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 15 <= 0 and var_428_7 or var_428_7 * (utf8.len(var_428_9) / 15)

				if (15 <= 0 and var_428_7 or var_428_7 * (utf8.len(var_428_9) / 15)) > 0 and var_428_7 < var_428_11 then
					arg_425_1.talkMaxDuration = var_428_11

					if var_428_11 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_11 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_9
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051104", "story_v_out_426051.awb") ~= 0 then
					local var_428_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051104", "story_v_out_426051.awb") / 1000

					if var_428_12 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_12 + var_428_6
					end

					if var_428_8.prefab_name ~= "" and arg_425_1.actors_[var_428_8.prefab_name] ~= nil then
						local var_428_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_8.prefab_name].transform, "story_v_out_426051", "426051104", "story_v_out_426051.awb")

						arg_425_1:RecordAudio("426051104", var_428_13)
						arg_425_1:RecordAudio("426051104", var_428_13)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_426051", "426051104", "story_v_out_426051.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_426051", "426051104", "story_v_out_426051.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_14 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_14 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_14

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_14 and arg_425_1.time_ < var_428_6 + var_428_14 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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

		arg_425_1:InitPlayNodeList()
	end,
	Play426051105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 426051105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play426051106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["6148ui_story"]) and arg_429_1.var_.characterEffect6148ui_story == nil then
				arg_429_1.var_.characterEffect6148ui_story = arg_429_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["6148ui_story"]) then
				if arg_429_1.var_.characterEffect6148ui_story and not isNil(arg_429_1.actors_["6148ui_story"]) then
					arg_429_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_429_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_0)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["6148ui_story"]) and arg_429_1.var_.characterEffect6148ui_story then
				arg_429_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_429_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_432_1 = 0
			local var_432_2 = 0.3

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_3 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(426051105).content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 12 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 12)

				if (12 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 12)) > 0 and var_432_2 < var_432_5 then
					arg_429_1.talkMaxDuration = var_432_5

					if var_432_5 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_6 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_6 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_6

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_6 and arg_429_1.time_ < var_432_1 + var_432_6 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play426051106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 426051106
		arg_433_1.duration_ = 4.27

		local var_433_0 = {
			zh = 3.833,
			ja = 4.266
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play426051107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1054ui_story = arg_433_1.actors_["1054ui_story"].transform.localPosition

				local var_436_0 = GameObjectTools.GetOrAddComponent(arg_433_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_436_0 then
					var_436_0:EnableDynamicBone(false)
				end
			end

			local var_436_1 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_1 then
				arg_433_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_433_1.time_ - 0) / var_436_1)
				arg_433_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1054ui_story"].transform.position).z)
				arg_433_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1054ui_story"].transform.localEulerAngles = arg_433_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_1 and arg_433_1.time_ < 0 + var_436_1 + arg_436_0 then
				arg_433_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_433_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1054ui_story"].transform.position).z)
				arg_433_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1054ui_story"].transform.localEulerAngles = arg_433_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_436_2 = GameObjectTools.GetOrAddComponent(arg_433_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_436_2 then
					var_436_2:EnableDynamicBone(true)
				end
			end

			local var_436_3 = arg_433_1.actors_["1054ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_3) and arg_433_1.var_.characterEffect1054ui_story == nil then
				arg_433_1.var_.characterEffect1054ui_story = var_436_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_4 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 and not isNil(var_436_3) then
				if arg_433_1.var_.characterEffect1054ui_story and not isNil(var_436_3) then
					arg_433_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 and not isNil(var_436_3) and arg_433_1.var_.characterEffect1054ui_story then
				arg_433_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_436_6 = 0
			local var_436_7 = 0.375

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_8 = arg_433_1:GetWordFromCfg(426051106)
				local var_436_9 = arg_433_1:FormatText(var_436_8.content)

				arg_433_1.text_.text = var_436_9

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 15 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 15)

				if (15 <= 0 and var_436_7 or var_436_7 * (utf8.len(var_436_9) / 15)) > 0 and var_436_7 < var_436_11 then
					arg_433_1.talkMaxDuration = var_436_11

					if var_436_11 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_11 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_9
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051106", "story_v_out_426051.awb") ~= 0 then
					local var_436_12 = manager.audio:GetVoiceLength("story_v_out_426051", "426051106", "story_v_out_426051.awb") / 1000

					if var_436_12 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_12 + var_436_6
					end

					if var_436_8.prefab_name ~= "" and arg_433_1.actors_[var_436_8.prefab_name] ~= nil then
						local var_436_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_8.prefab_name].transform, "story_v_out_426051", "426051106", "story_v_out_426051.awb")

						arg_433_1:RecordAudio("426051106", var_436_13)
						arg_433_1:RecordAudio("426051106", var_436_13)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_426051", "426051106", "story_v_out_426051.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_426051", "426051106", "story_v_out_426051.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_14 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_14 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_14

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_14 and arg_433_1.time_ < var_436_6 + var_436_14 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
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

		arg_433_1:InitPlayNodeList()
	end,
	Play426051107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 426051107
		arg_437_1.duration_ = 7

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play426051108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_9001
			local var_440_9000

			if arg_437_1.bgs_.ST2012 == nil then
				local var_440_0 = Object.Instantiate(arg_437_1.paintGo_)

				var_440_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2012")
				var_440_0.name = "ST2012"
				var_440_0.transform.parent = arg_437_1.stage_.transform
				var_440_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_437_1.bgs_.ST2012 = var_440_0
			end

			if 0.965999998152256 < arg_437_1.time_ and arg_437_1.time_ <= 0.965999998152256 + arg_440_0 then
				local var_440_1 = arg_437_1.bgs_.ST2012

				arg_437_1.bgs_.ST2012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_440_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_440_2 = var_440_1:GetComponent("SpriteRenderer")

				if var_440_2 and var_440_2.sprite then
					local var_440_3 = 2 * (var_440_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_440_1.transform.localScale = Vector3.New(var_440_3 / var_440_2.sprite.bounds.size.y < var_440_3 * manager.ui.mainCameraCom_.aspect / var_440_2.sprite.bounds.size.x and var_440_3 * manager.ui.mainCameraCom_.aspect / var_440_2.sprite.bounds.size.x or var_440_3 / var_440_2.sprite.bounds.size.y, var_440_3 / var_440_2.sprite.bounds.size.y < var_440_3 * manager.ui.mainCameraCom_.aspect / var_440_2.sprite.bounds.size.x and var_440_3 * manager.ui.mainCameraCom_.aspect / var_440_2.sprite.bounds.size.x or var_440_3 / var_440_2.sprite.bounds.size.y, 0)
				end

				for iter_440_0, iter_440_1 in pairs(arg_437_1.bgs_) do
					if iter_440_0 ~= "ST2012" then
						iter_440_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_440_4 = 1.999999999999

			if 1.999999999999 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.allBtn_.enabled = false
			end

			if arg_437_1.time_ >= var_440_4 + 0.3 and arg_437_1.time_ < var_440_4 + 0.3 + arg_440_0 then
				arg_437_1.allBtn_.enabled = true
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				local var_440_5 = arg_437_1.var_.effectjinfangjian1

				if not arg_437_1.var_.effectjinfangjian1 then
					var_440_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_440_5.name = "jinfangjian1"
					arg_437_1.var_.effectjinfangjian1 = var_440_5
				else
					var_440_5.transform:SetParent(var_440_9001)
				end

				var_440_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_440_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_440_7 = arg_437_1.actors_["6148ui_story"].transform

			if 0.965999998152256 < arg_437_1.time_ and arg_437_1.time_ <= 0.965999998152256 + arg_440_0 then
				arg_437_1.var_.moveOldPos6148ui_story = var_440_7.localPosition

				local var_440_8 = GameObjectTools.GetOrAddComponent(var_440_7.gameObject, typeof(DynamicBoneHelper))

				if var_440_8 then
					var_440_8:EnableDynamicBone(false)
				end
			end

			local var_440_9 = 0.001

			if 0.965999998152256 <= arg_437_1.time_ and arg_437_1.time_ < 0.965999998152256 + var_440_9 then
				var_440_7.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_437_1.time_ - 0.965999998152256) / var_440_9)
				var_440_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_7.position).x, (manager.ui.mainCamera.transform.position - var_440_7.position).y, (manager.ui.mainCamera.transform.position - var_440_7.position).z)
				var_440_7.localEulerAngles.z = 0
				var_440_7.localEulerAngles.x = 0
				var_440_7.localEulerAngles = var_440_7.localEulerAngles
			end

			if arg_437_1.time_ >= 0.965999998152256 + var_440_9 and arg_437_1.time_ < 0.965999998152256 + var_440_9 + arg_440_0 then
				var_440_7.localPosition = Vector3.New(0, 100, 0)
				var_440_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_7.position).x, (manager.ui.mainCamera.transform.position - var_440_7.position).y, (manager.ui.mainCamera.transform.position - var_440_7.position).z)
				var_440_7.localEulerAngles.z = 0
				var_440_7.localEulerAngles.x = 0
				var_440_7.localEulerAngles = var_440_7.localEulerAngles

				local var_440_10 = GameObjectTools.GetOrAddComponent(var_440_7.gameObject, typeof(DynamicBoneHelper))

				if var_440_10 then
					var_440_10:EnableDynamicBone(true)
				end
			end

			local var_440_11 = arg_437_1.actors_["1054ui_story"].transform

			if 0.965999998152256 < arg_437_1.time_ and arg_437_1.time_ <= 0.965999998152256 + arg_440_0 then
				arg_437_1.var_.moveOldPos1054ui_story = var_440_11.localPosition

				local var_440_12 = GameObjectTools.GetOrAddComponent(var_440_11.gameObject, typeof(DynamicBoneHelper))

				if var_440_12 then
					var_440_12:EnableDynamicBone(false)
				end
			end

			local var_440_13 = 0.001

			if 0.965999998152256 <= arg_437_1.time_ and arg_437_1.time_ < 0.965999998152256 + var_440_13 then
				var_440_11.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_437_1.time_ - 0.965999998152256) / var_440_13)
				var_440_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_11.position).x, (manager.ui.mainCamera.transform.position - var_440_11.position).y, (manager.ui.mainCamera.transform.position - var_440_11.position).z)
				var_440_11.localEulerAngles.z = 0
				var_440_11.localEulerAngles.x = 0
				var_440_11.localEulerAngles = var_440_11.localEulerAngles
			end

			if arg_437_1.time_ >= 0.965999998152256 + var_440_13 and arg_437_1.time_ < 0.965999998152256 + var_440_13 + arg_440_0 then
				var_440_11.localPosition = Vector3.New(0, 100, 0)
				var_440_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_11.position).x, (manager.ui.mainCamera.transform.position - var_440_11.position).y, (manager.ui.mainCamera.transform.position - var_440_11.position).z)
				var_440_11.localEulerAngles.z = 0
				var_440_11.localEulerAngles.x = 0
				var_440_11.localEulerAngles = var_440_11.localEulerAngles

				local var_440_14 = GameObjectTools.GetOrAddComponent(var_440_11.gameObject, typeof(DynamicBoneHelper))

				if var_440_14 then
					var_440_14:EnableDynamicBone(true)
				end
			end

			local var_440_15 = arg_437_1.actors_["1054ui_story"]

			if 0.965999998152256 < arg_437_1.time_ and arg_437_1.time_ <= 0.965999998152256 + arg_440_0 and not isNil(var_440_15) and arg_437_1.var_.characterEffect1054ui_story == nil then
				arg_437_1.var_.characterEffect1054ui_story = var_440_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_16 = 0.034000001847744

			if 0.965999998152256 <= arg_437_1.time_ and arg_437_1.time_ < 0.965999998152256 + var_440_16 and not isNil(var_440_15) then
				if arg_437_1.var_.characterEffect1054ui_story and not isNil(var_440_15) then
					arg_437_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0.965999998152256) / var_440_16)
				end
			end

			if arg_437_1.time_ >= 0.965999998152256 + var_440_16 and arg_437_1.time_ < 0.965999998152256 + var_440_16 + arg_440_0 and not isNil(var_440_15) and arg_437_1.var_.characterEffect1054ui_story then
				arg_437_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0.965999998152256 < arg_437_1.time_ and arg_437_1.time_ <= 0.965999998152256 + arg_440_0 then
				local var_440_17 = arg_437_1.var_.effectfangjianheian1

				if not arg_437_1.var_.effectfangjianheian1 then
					var_440_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_440_17.name = "fangjianheian1"
					arg_437_1.var_.effectfangjianheian1 = var_440_17
				else
					var_440_17.transform:SetParent(var_440_9000)
				end

				var_440_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_440_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_440_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_437_1.bgmTxt_.text ~= var_440_21 and arg_437_1.bgmTxt_.text ~= "" then
						if arg_437_1.bgmTxt2_.text ~= "" then
							arg_437_1.bgmTxt_.text = arg_437_1.bgmTxt2_.text
						end

						arg_437_1.bgmTxt2_.text = var_440_21

						arg_437_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_437_1.bgmTxt_.text = var_440_21
						arg_437_1.bgmTxt2_.text = var_440_21
					end

					if arg_437_1.bgmTimer then
						arg_437_1.bgmTimer:Stop()

						arg_437_1.bgmTimer = nil
					end

					if arg_437_1.settingData.show_music_name == 1 then
						arg_437_1.musicController:SetSelectedState("show")
						arg_437_1.musicAnimator_:Play("open", 0, 0)

						if arg_437_1.settingData.music_time ~= 0 then
							arg_437_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_437_1.settingData.music_time), function()
								if arg_437_1 == nil or isNil(arg_437_1.bgmTxt_) then
									return
								end

								arg_437_1.musicController:SetSelectedState("hide")
								arg_437_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_437_1.frameCnt_ <= 1 then
				arg_437_1.dialog_:SetActive(false)
			end

			local var_440_22 = 2
			local var_440_23 = 1.025

			if 2 < arg_437_1.time_ and arg_437_1.time_ <= var_440_22 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0

				arg_437_1.dialog_:SetActive(true)

				arg_437_1.dialogCg_.alpha = 0

				local var_440_24 = LeanTween.value(arg_437_1.dialog_, 0, 1, 0.3)

				var_440_24:setOnUpdate(LuaHelper.FloatAction(function(arg_442_0)
					arg_437_1.dialogCg_.alpha = arg_442_0
				end))
				var_440_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_437_1.dialog_)
					var_440_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_437_1.duration_ = arg_437_1.duration_ + 0.3

				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_25 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(426051107).content)

				arg_437_1.text_.text = var_440_25

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_27 = 41 <= 0 and var_440_23 or var_440_23 * (utf8.len(var_440_25) / 41)

				if (41 <= 0 and var_440_23 or var_440_23 * (utf8.len(var_440_25) / 41)) > 0 and var_440_23 < var_440_27 then
					arg_437_1.talkMaxDuration = var_440_27
					var_440_22 = var_440_22 + 0.3

					if var_440_27 + var_440_22 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_27 + var_440_22
					end
				end

				arg_437_1.text_.text = var_440_25
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_28 = var_440_22 + 0.3
			local var_440_29 = math.max(var_440_23, arg_437_1.talkMaxDuration)

			if var_440_22 + 0.3 <= arg_437_1.time_ and arg_437_1.time_ < var_440_28 + var_440_29 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_28) / var_440_29

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_28 + var_440_29 and arg_437_1.time_ < var_440_28 + var_440_29 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play426051108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 426051108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play426051109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0.875

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, false)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_1 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(426051108).content)

				arg_444_1.text_.text = var_447_1

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_3 = 35 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 35)

				if (35 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 35)) > 0 and var_447_0 < var_447_3 then
					arg_444_1.talkMaxDuration = var_447_3

					if var_447_3 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_3 + 0
					end
				end

				arg_444_1.text_.text = var_447_1
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_4 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_4

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play426051109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 426051109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play426051110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.525

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_1 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(426051109).content)

				arg_448_1.text_.text = var_451_1

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_3 = 21 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 21)

				if (21 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 21)) > 0 and var_451_0 < var_451_3 then
					arg_448_1.talkMaxDuration = var_451_3

					if var_451_3 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_3 + 0
					end
				end

				arg_448_1.text_.text = var_451_1
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_4 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_4 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_4

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_4 and arg_448_1.time_ < 0 + var_451_4 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play426051110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 426051110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play426051111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0.35

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_1 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(426051110).content)

				arg_452_1.text_.text = var_455_1

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_3 = 14 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 14)

				if (14 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 14)) > 0 and var_455_0 < var_455_3 then
					arg_452_1.talkMaxDuration = var_455_3

					if var_455_3 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_3 + 0
					end
				end

				arg_452_1.text_.text = var_455_1
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_4 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_4 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_4

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_4 and arg_452_1.time_ < 0 + var_455_4 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play426051111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 426051111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play426051112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0.633333333333333 < arg_456_1.time_ and arg_456_1.time_ <= 0.633333333333333 + arg_459_0 then
				arg_456_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_459_1 = 0
			local var_459_2 = 0.85

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(426051111).content)

				arg_456_1.text_.text = var_459_3

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 34 <= 0 and var_459_2 or var_459_2 * (utf8.len(var_459_3) / 34)

				if (34 <= 0 and var_459_2 or var_459_2 * (utf8.len(var_459_3) / 34)) > 0 and var_459_2 < var_459_5 then
					arg_456_1.talkMaxDuration = var_459_5

					if var_459_5 + var_459_1 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + var_459_1
					end
				end

				arg_456_1.text_.text = var_459_3
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_6 = math.max(var_459_2, arg_456_1.talkMaxDuration)

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_6 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_1) / var_459_6

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_1 + var_459_6 and arg_456_1.time_ < var_459_1 + var_459_6 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play426051112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 426051112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play426051113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0.75

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_1 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(426051112).content)

				arg_460_1.text_.text = var_463_1

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_3 = 30 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 30)

				if (30 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_1) / 30)) > 0 and var_463_0 < var_463_3 then
					arg_460_1.talkMaxDuration = var_463_3

					if var_463_3 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_3 + 0
					end
				end

				arg_460_1.text_.text = var_463_1
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_4 = math.max(var_463_0, arg_460_1.talkMaxDuration)

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_4 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - 0) / var_463_4

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= 0 + var_463_4 and arg_460_1.time_ < 0 + var_463_4 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play426051113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 426051113
		arg_464_1.duration_ = 3.93

		local var_464_0 = {
			zh = 2,
			ja = 3.933
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
				arg_464_0:Play426051114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if arg_464_1.actors_["1012ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1012ui_story"))) then
				local var_467_0 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_464_1.stage_.transform)

				var_467_0.name = "1012ui_story"
				var_467_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_464_1.actors_["1012ui_story"] = var_467_0

				local var_467_1 = var_467_0:GetComponentInChildren(typeof(CharacterEffect))

				var_467_1.enabled = true

				local var_467_2 = GameObjectTools.GetOrAddComponent(var_467_0, typeof(DynamicBoneHelper))

				if var_467_2 then
					var_467_2:EnableDynamicBone(false)
				end

				arg_464_1:ShowWeapon(var_467_1.transform, false)

				arg_464_1.var_["1012ui_story" .. "Animator"] = var_467_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_464_1.var_["1012ui_story" .. "Animator"].applyRootMotion = true
				arg_464_1.var_["1012ui_story" .. "LipSync"] = var_467_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_467_3 = arg_464_1.actors_["1012ui_story"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1012ui_story = var_467_3.localPosition
			end

			local var_467_4 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 then
				var_467_3.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_464_1.time_ - 0) / var_467_4)
				var_467_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_467_3.position).x, (manager.ui.mainCamera.transform.position - var_467_3.position).y, (manager.ui.mainCamera.transform.position - var_467_3.position).z)
				var_467_3.localEulerAngles.z = 0
				var_467_3.localEulerAngles.x = 0
				var_467_3.localEulerAngles = var_467_3.localEulerAngles
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 then
				var_467_3.localPosition = Vector3.New(0, -1.05, -6.24)
				var_467_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_467_3.position).x, (manager.ui.mainCamera.transform.position - var_467_3.position).y, (manager.ui.mainCamera.transform.position - var_467_3.position).z)
				var_467_3.localEulerAngles.z = 0
				var_467_3.localEulerAngles.x = 0
				var_467_3.localEulerAngles = var_467_3.localEulerAngles
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				if arg_464_1.var_.characterEffect1012ui_story == nil then
					arg_464_1.var_.characterEffect1012ui_story = arg_464_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_467_5 = arg_464_1.var_.characterEffect1012ui_story

				arg_464_1.var_.characterEffect1012ui_story.imageEffect:turnOff()

				var_467_5.interferenceEffect.enabled = true
				var_467_5.interferenceEffect.noise = 0.001
				var_467_5.interferenceEffect.simTimeScale = 1
				var_467_5.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				if arg_464_1.var_.characterEffect1012ui_story == nil then
					arg_464_1.var_.characterEffect1012ui_story = arg_464_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_464_1.var_.characterEffect1012ui_story.imageEffect:turnOn(false)
			end

			local var_467_7 = 0
			local var_467_8 = 0.25

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_7 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_9 = arg_464_1:GetWordFromCfg(426051113)
				local var_467_10 = arg_464_1:FormatText(var_467_9.content)

				arg_464_1.text_.text = var_467_10

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_12 = 10 <= 0 and var_467_8 or var_467_8 * (utf8.len(var_467_10) / 10)

				if (10 <= 0 and var_467_8 or var_467_8 * (utf8.len(var_467_10) / 10)) > 0 and var_467_8 < var_467_12 then
					arg_464_1.talkMaxDuration = var_467_12

					if var_467_12 + var_467_7 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_12 + var_467_7
					end
				end

				arg_464_1.text_.text = var_467_10
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051113", "story_v_out_426051.awb") ~= 0 then
					local var_467_13 = manager.audio:GetVoiceLength("story_v_out_426051", "426051113", "story_v_out_426051.awb") / 1000

					if var_467_13 + var_467_7 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_13 + var_467_7
					end

					if var_467_9.prefab_name ~= "" and arg_464_1.actors_[var_467_9.prefab_name] ~= nil then
						local var_467_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_9.prefab_name].transform, "story_v_out_426051", "426051113", "story_v_out_426051.awb")

						arg_464_1:RecordAudio("426051113", var_467_14)
						arg_464_1:RecordAudio("426051113", var_467_14)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_426051", "426051113", "story_v_out_426051.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_426051", "426051113", "story_v_out_426051.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_15 = math.max(var_467_8, arg_464_1.talkMaxDuration)

			if var_467_7 <= arg_464_1.time_ and arg_464_1.time_ < var_467_7 + var_467_15 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_7) / var_467_15

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_7 + var_467_15 and arg_464_1.time_ < var_467_7 + var_467_15 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
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

		arg_464_1:InitPlayNodeList()
	end,
	Play426051114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 426051114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play426051115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.var_.moveOldPos1012ui_story = arg_468_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_471_0 = 0.001

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 then
				arg_468_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_468_1.time_ - 0) / var_471_0)
				arg_468_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1012ui_story"].transform.position).z)
				arg_468_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1012ui_story"].transform.localEulerAngles = arg_468_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 then
				arg_468_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_468_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1012ui_story"].transform.position).z)
				arg_468_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1012ui_story"].transform.localEulerAngles = arg_468_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_471_1 = arg_468_1.actors_["1012ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1012ui_story == nil then
				arg_468_1.var_.characterEffect1012ui_story = var_471_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_2 and not isNil(var_471_1) then
				if arg_468_1.var_.characterEffect1012ui_story and not isNil(var_471_1) then
					arg_468_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_468_1.time_ - 0) / var_471_2)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_2 and arg_468_1.time_ < 0 + var_471_2 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1012ui_story then
				arg_468_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_471_3 = 0
			local var_471_4 = 0.9

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_3 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_5 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(426051114).content)

				arg_468_1.text_.text = var_471_5

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_7 = 36 <= 0 and var_471_4 or var_471_4 * (utf8.len(var_471_5) / 36)

				if (36 <= 0 and var_471_4 or var_471_4 * (utf8.len(var_471_5) / 36)) > 0 and var_471_4 < var_471_7 then
					arg_468_1.talkMaxDuration = var_471_7

					if var_471_7 + var_471_3 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_7 + var_471_3
					end
				end

				arg_468_1.text_.text = var_471_5
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_8 = math.max(var_471_4, arg_468_1.talkMaxDuration)

			if var_471_3 <= arg_468_1.time_ and arg_468_1.time_ < var_471_3 + var_471_8 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_3) / var_471_8

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_3 + var_471_8 and arg_468_1.time_ < var_471_3 + var_471_8 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
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

		arg_468_1:InitPlayNodeList()
	end,
	Play426051115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 426051115
		arg_472_1.duration_ = 2

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play426051116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos1012ui_story = arg_472_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_475_0 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 then
				arg_472_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_472_1.time_ - 0) / var_475_0)
				arg_472_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1012ui_story"].transform.position).z)
				arg_472_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1012ui_story"].transform.localEulerAngles = arg_472_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 then
				arg_472_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_472_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1012ui_story"].transform.position).z)
				arg_472_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1012ui_story"].transform.localEulerAngles = arg_472_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_475_1 = 0
			local var_475_2 = 0.175

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_3 = arg_472_1:GetWordFromCfg(426051115)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_6 = 7 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_4) / 7)

				if (7 <= 0 and var_475_2 or var_475_2 * (utf8.len(var_475_4) / 7)) > 0 and var_475_2 < var_475_6 then
					arg_472_1.talkMaxDuration = var_475_6

					if var_475_6 + var_475_1 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_6 + var_475_1
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051115", "story_v_out_426051.awb") ~= 0 then
					local var_475_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051115", "story_v_out_426051.awb") / 1000

					if var_475_7 + var_475_1 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_1
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_out_426051", "426051115", "story_v_out_426051.awb")

						arg_472_1:RecordAudio("426051115", var_475_8)
						arg_472_1:RecordAudio("426051115", var_475_8)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_426051", "426051115", "story_v_out_426051.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_426051", "426051115", "story_v_out_426051.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_9 = math.max(var_475_2, arg_472_1.talkMaxDuration)

			if var_475_1 <= arg_472_1.time_ and arg_472_1.time_ < var_475_1 + var_475_9 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_1) / var_475_9

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_1 + var_475_9 and arg_472_1.time_ < var_475_1 + var_475_9 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
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

		arg_472_1:InitPlayNodeList()
	end,
	Play426051116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 426051116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play426051117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.475

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_1 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(426051116).content)

				arg_476_1.text_.text = var_479_1

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_3 = 19 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 19)

				if (19 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 19)) > 0 and var_479_0 < var_479_3 then
					arg_476_1.talkMaxDuration = var_479_3

					if var_479_3 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_3 + 0
					end
				end

				arg_476_1.text_.text = var_479_1
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_4 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_4

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play426051117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 426051117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play426051118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_9000

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos1012ui_story = arg_480_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_483_0 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 then
				arg_480_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_480_1.time_ - 0) / var_483_0)
				arg_480_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1012ui_story"].transform.position).z)
				arg_480_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1012ui_story"].transform.localEulerAngles = arg_480_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 then
				arg_480_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_480_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1012ui_story"].transform.position).z)
				arg_480_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1012ui_story"].transform.localEulerAngles = arg_480_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:AudioAction("play", "effect", "se_story_147", "se_story_147_light_button_off", "")
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				local var_483_2 = arg_480_1.var_.effectkaideng1

				if not arg_480_1.var_.effectkaideng1 then
					var_483_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng02_in_keep"), manager.ui.mainCamera.transform)
					var_483_2.name = "kaideng1"
					arg_480_1.var_.effectkaideng1 = var_483_2
				else
					var_483_2.transform:SetParent(var_483_9000)
				end

				var_483_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_483_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_483_4 = 0
			local var_483_5 = 0.525

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_6 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(426051117).content)

				arg_480_1.text_.text = var_483_6

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_8 = 21 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_6) / 21)

				if (21 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_6) / 21)) > 0 and var_483_5 < var_483_8 then
					arg_480_1.talkMaxDuration = var_483_8

					if var_483_8 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_8 + var_483_4
					end
				end

				arg_480_1.text_.text = var_483_6
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_9 = math.max(var_483_5, arg_480_1.talkMaxDuration)

			if var_483_4 <= arg_480_1.time_ and arg_480_1.time_ < var_483_4 + var_483_9 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_4) / var_483_9

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_4 + var_483_9 and arg_480_1.time_ < var_483_4 + var_483_9 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
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

		arg_480_1:InitPlayNodeList()
	end,
	Play426051118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 426051118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play426051119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.475

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_1 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(426051118).content)

				arg_484_1.text_.text = var_487_1

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_3 = 19 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 19)

				if (19 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 19)) > 0 and var_487_0 < var_487_3 then
					arg_484_1.talkMaxDuration = var_487_3

					if var_487_3 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_3 + 0
					end
				end

				arg_484_1.text_.text = var_487_1
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_4 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_4 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_4

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_4 and arg_484_1.time_ < 0 + var_487_4 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play426051119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 426051119
		arg_488_1.duration_ = 7.77

		local var_488_0 = {
			zh = 7.766,
			ja = 7.1
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
				arg_488_0:Play426051120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.var_.moveOldPos1012ui_story = arg_488_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_491_0 = 0.001

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 then
				arg_488_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_488_1.time_ - 0) / var_491_0)
				arg_488_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1012ui_story"].transform.position).z)
				arg_488_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1012ui_story"].transform.localEulerAngles = arg_488_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 then
				arg_488_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_488_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["1012ui_story"].transform.position).z)
				arg_488_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["1012ui_story"].transform.localEulerAngles = arg_488_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_491_3 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_488_1.bgmTxt_.text ~= var_491_3 and arg_488_1.bgmTxt_.text ~= "" then
						if arg_488_1.bgmTxt2_.text ~= "" then
							arg_488_1.bgmTxt_.text = arg_488_1.bgmTxt2_.text
						end

						arg_488_1.bgmTxt2_.text = var_491_3

						arg_488_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_488_1.bgmTxt_.text = var_491_3
						arg_488_1.bgmTxt2_.text = var_491_3
					end

					if arg_488_1.bgmTimer then
						arg_488_1.bgmTimer:Stop()

						arg_488_1.bgmTimer = nil
					end

					if arg_488_1.settingData.show_music_name == 1 then
						arg_488_1.musicController:SetSelectedState("show")
						arg_488_1.musicAnimator_:Play("open", 0, 0)

						if arg_488_1.settingData.music_time ~= 0 then
							arg_488_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_488_1.settingData.music_time), function()
								if arg_488_1 == nil or isNil(arg_488_1.bgmTxt_) then
									return
								end

								arg_488_1.musicController:SetSelectedState("hide")
								arg_488_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_491_4 = 0
			local var_491_5 = 0.875

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_4 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_6 = arg_488_1:GetWordFromCfg(426051119)
				local var_491_7 = arg_488_1:FormatText(var_491_6.content)

				arg_488_1.text_.text = var_491_7

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_9 = 35 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 35)

				if (35 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 35)) > 0 and var_491_5 < var_491_9 then
					arg_488_1.talkMaxDuration = var_491_9

					if var_491_9 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_9 + var_491_4
					end
				end

				arg_488_1.text_.text = var_491_7
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051119", "story_v_out_426051.awb") ~= 0 then
					local var_491_10 = manager.audio:GetVoiceLength("story_v_out_426051", "426051119", "story_v_out_426051.awb") / 1000

					if var_491_10 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_10 + var_491_4
					end

					if var_491_6.prefab_name ~= "" and arg_488_1.actors_[var_491_6.prefab_name] ~= nil then
						local var_491_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_6.prefab_name].transform, "story_v_out_426051", "426051119", "story_v_out_426051.awb")

						arg_488_1:RecordAudio("426051119", var_491_11)
						arg_488_1:RecordAudio("426051119", var_491_11)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_426051", "426051119", "story_v_out_426051.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_426051", "426051119", "story_v_out_426051.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_12 = math.max(var_491_5, arg_488_1.talkMaxDuration)

			if var_491_4 <= arg_488_1.time_ and arg_488_1.time_ < var_491_4 + var_491_12 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_4) / var_491_12

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_4 + var_491_12 and arg_488_1.time_ < var_491_4 + var_491_12 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
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

		arg_488_1:InitPlayNodeList()
	end,
	Play426051120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 426051120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play426051121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.475

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(426051120).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 19 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 19)

				if (19 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 19)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play426051121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 426051121
		arg_497_1.duration_ = 2.7

		local var_497_0 = {
			zh = 2.7,
			ja = 2.633
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play426051122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1012ui_story = arg_497_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1012ui_story"].transform.position).z)
				arg_497_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1012ui_story"].transform.localEulerAngles = arg_497_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_497_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1012ui_story"].transform.position).z)
				arg_497_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1012ui_story"].transform.localEulerAngles = arg_497_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_500_1 = 0
			local var_500_2 = 0.275

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_3 = arg_497_1:GetWordFromCfg(426051121)
				local var_500_4 = arg_497_1:FormatText(var_500_3.content)

				arg_497_1.text_.text = var_500_4

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_6 = 11 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_4) / 11)

				if (11 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_4) / 11)) > 0 and var_500_2 < var_500_6 then
					arg_497_1.talkMaxDuration = var_500_6

					if var_500_6 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_4
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051121", "story_v_out_426051.awb") ~= 0 then
					local var_500_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051121", "story_v_out_426051.awb") / 1000

					if var_500_7 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_1
					end

					if var_500_3.prefab_name ~= "" and arg_497_1.actors_[var_500_3.prefab_name] ~= nil then
						local var_500_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_3.prefab_name].transform, "story_v_out_426051", "426051121", "story_v_out_426051.awb")

						arg_497_1:RecordAudio("426051121", var_500_8)
						arg_497_1:RecordAudio("426051121", var_500_8)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_426051", "426051121", "story_v_out_426051.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_426051", "426051121", "story_v_out_426051.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_9 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_9 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_9

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_9 and arg_497_1.time_ < var_500_1 + var_500_9 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
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

		arg_497_1:InitPlayNodeList()
	end,
	Play426051122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 426051122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play426051123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.725

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(426051122).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 29 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 29)

				if (29 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 29)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play426051123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 426051123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play426051124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.95

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, true)
				arg_505_1.iconController_:SetSelectedState("hero")

				arg_505_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_505_1.callingController_:SetSelectedState("normal")

				arg_505_1.keyicon_.color = Color.New(1, 1, 1)
				arg_505_1.icon_.color = Color.New(1, 1, 1)

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(426051123).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 38 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 38)

				if (38 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 38)) > 0 and var_508_0 < var_508_3 then
					arg_505_1.talkMaxDuration = var_508_3

					if var_508_3 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_3 + 0
					end
				end

				arg_505_1.text_.text = var_508_1
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_4 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_4

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play426051124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 426051124
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play426051125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.var_.moveOldPos1012ui_story = arg_509_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_512_0 = 0.001

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 then
				arg_509_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_509_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_509_1.time_ - 0) / var_512_0)
				arg_509_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1012ui_story"].transform.position).z)
				arg_509_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1012ui_story"].transform.localEulerAngles = arg_509_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 then
				arg_509_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_509_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_509_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_509_1.actors_["1012ui_story"].transform.position).z)
				arg_509_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_509_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_509_1.actors_["1012ui_story"].transform.localEulerAngles = arg_509_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_512_1 = 0
			local var_512_2 = 0.575

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_3 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(426051124).content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 23 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 23)

				if (23 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 23)) > 0 and var_512_2 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_6 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_6 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_6

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_6 and arg_509_1.time_ < var_512_1 + var_512_6 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {
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

		arg_509_1:InitPlayNodeList()
	end,
	Play426051125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 426051125
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play426051126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.575

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(426051125).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 23 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 23)

				if (23 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 23)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play426051126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 426051126
		arg_517_1.duration_ = 9.03

		local var_517_0 = {
			zh = 7.4,
			ja = 9.033
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play426051127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos1012ui_story = arg_517_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_520_0 = 0.001

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 then
				arg_517_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_517_1.time_ - 0) / var_520_0)
				arg_517_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1012ui_story"].transform.position).z)
				arg_517_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1012ui_story"].transform.localEulerAngles = arg_517_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 then
				arg_517_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_517_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1012ui_story"].transform.position).z)
				arg_517_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1012ui_story"].transform.localEulerAngles = arg_517_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_2")
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_520_1 = 0
			local var_520_2 = 0.95

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_3 = arg_517_1:GetWordFromCfg(426051126)
				local var_520_4 = arg_517_1:FormatText(var_520_3.content)

				arg_517_1.text_.text = var_520_4

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_6 = 38 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_4) / 38)

				if (38 <= 0 and var_520_2 or var_520_2 * (utf8.len(var_520_4) / 38)) > 0 and var_520_2 < var_520_6 then
					arg_517_1.talkMaxDuration = var_520_6

					if var_520_6 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_6 + var_520_1
					end
				end

				arg_517_1.text_.text = var_520_4
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051126", "story_v_out_426051.awb") ~= 0 then
					local var_520_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051126", "story_v_out_426051.awb") / 1000

					if var_520_7 + var_520_1 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_1
					end

					if var_520_3.prefab_name ~= "" and arg_517_1.actors_[var_520_3.prefab_name] ~= nil then
						local var_520_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_3.prefab_name].transform, "story_v_out_426051", "426051126", "story_v_out_426051.awb")

						arg_517_1:RecordAudio("426051126", var_520_8)
						arg_517_1:RecordAudio("426051126", var_520_8)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_426051", "426051126", "story_v_out_426051.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_426051", "426051126", "story_v_out_426051.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_9 = math.max(var_520_2, arg_517_1.talkMaxDuration)

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_9 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_1) / var_520_9

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_1 + var_520_9 and arg_517_1.time_ < var_520_1 + var_520_9 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
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

		arg_517_1:InitPlayNodeList()
	end,
	Play426051127 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 426051127
		arg_521_1.duration_ = 4.53

		local var_521_0 = {
			zh = 3.533,
			ja = 4.533
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play426051128(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.5

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:GetWordFromCfg(426051127)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 20 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 20)

				if (20 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 20)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051127", "story_v_out_426051.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051127", "story_v_out_426051.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_out_426051", "426051127", "story_v_out_426051.awb")

						arg_521_1:RecordAudio("426051127", var_524_6)
						arg_521_1:RecordAudio("426051127", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_426051", "426051127", "story_v_out_426051.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_426051", "426051127", "story_v_out_426051.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play426051128 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 426051128
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play426051129(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.4

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(426051128).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 16 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 16)

				if (16 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 16)) > 0 and var_528_0 < var_528_3 then
					arg_525_1.talkMaxDuration = var_528_3

					if var_528_3 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_3 + 0
					end
				end

				arg_525_1.text_.text = var_528_1
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_4 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_4

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play426051129 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 426051129
		arg_529_1.duration_ = 7.8

		local var_529_0 = {
			zh = 4.6,
			ja = 7.8
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play426051130(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_532_0 = 0
			local var_532_1 = 0.475

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_0 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_2 = arg_529_1:GetWordFromCfg(426051129)
				local var_532_3 = arg_529_1:FormatText(var_532_2.content)

				arg_529_1.text_.text = var_532_3

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_5 = 19 <= 0 and var_532_1 or var_532_1 * (utf8.len(var_532_3) / 19)

				if (19 <= 0 and var_532_1 or var_532_1 * (utf8.len(var_532_3) / 19)) > 0 and var_532_1 < var_532_5 then
					arg_529_1.talkMaxDuration = var_532_5

					if var_532_5 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_5 + var_532_0
					end
				end

				arg_529_1.text_.text = var_532_3
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051129", "story_v_out_426051.awb") ~= 0 then
					local var_532_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051129", "story_v_out_426051.awb") / 1000

					if var_532_6 + var_532_0 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_0
					end

					if var_532_2.prefab_name ~= "" and arg_529_1.actors_[var_532_2.prefab_name] ~= nil then
						local var_532_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_2.prefab_name].transform, "story_v_out_426051", "426051129", "story_v_out_426051.awb")

						arg_529_1:RecordAudio("426051129", var_532_7)
						arg_529_1:RecordAudio("426051129", var_532_7)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_out_426051", "426051129", "story_v_out_426051.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_out_426051", "426051129", "story_v_out_426051.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_8 = math.max(var_532_1, arg_529_1.talkMaxDuration)

			if var_532_0 <= arg_529_1.time_ and arg_529_1.time_ < var_532_0 + var_532_8 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_0) / var_532_8

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_0 + var_532_8 and arg_529_1.time_ < var_532_0 + var_532_8 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play426051130 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 426051130
		arg_533_1.duration_ = 6.53

		local var_533_0 = {
			zh = 6.533,
			ja = 5.666
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play426051131(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 0.875

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:GetWordFromCfg(426051130)
				local var_536_2 = arg_533_1:FormatText(var_536_1.content)

				arg_533_1.text_.text = var_536_2

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_4 = 35 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 35)

				if (35 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_2) / 35)) > 0 and var_536_0 < var_536_4 then
					arg_533_1.talkMaxDuration = var_536_4

					if var_536_4 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_4 + 0
					end
				end

				arg_533_1.text_.text = var_536_2
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051130", "story_v_out_426051.awb") ~= 0 then
					local var_536_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051130", "story_v_out_426051.awb") / 1000

					if var_536_5 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_5 + 0
					end

					if var_536_1.prefab_name ~= "" and arg_533_1.actors_[var_536_1.prefab_name] ~= nil then
						local var_536_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_1.prefab_name].transform, "story_v_out_426051", "426051130", "story_v_out_426051.awb")

						arg_533_1:RecordAudio("426051130", var_536_6)
						arg_533_1:RecordAudio("426051130", var_536_6)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_out_426051", "426051130", "story_v_out_426051.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_out_426051", "426051130", "story_v_out_426051.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_7 and arg_533_1.time_ < 0 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play426051131 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 426051131
		arg_537_1.duration_ = 11.63

		local var_537_0 = {
			zh = 11.633,
			ja = 6.7
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play426051132(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_540_0 = 0
			local var_540_1 = 1.45

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_2 = arg_537_1:GetWordFromCfg(426051131)
				local var_540_3 = arg_537_1:FormatText(var_540_2.content)

				arg_537_1.text_.text = var_540_3

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 58 <= 0 and var_540_1 or var_540_1 * (utf8.len(var_540_3) / 58)

				if (58 <= 0 and var_540_1 or var_540_1 * (utf8.len(var_540_3) / 58)) > 0 and var_540_1 < var_540_5 then
					arg_537_1.talkMaxDuration = var_540_5

					if var_540_5 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_5 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_3
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051131", "story_v_out_426051.awb") ~= 0 then
					local var_540_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051131", "story_v_out_426051.awb") / 1000

					if var_540_6 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_6 + var_540_0
					end

					if var_540_2.prefab_name ~= "" and arg_537_1.actors_[var_540_2.prefab_name] ~= nil then
						local var_540_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_2.prefab_name].transform, "story_v_out_426051", "426051131", "story_v_out_426051.awb")

						arg_537_1:RecordAudio("426051131", var_540_7)
						arg_537_1:RecordAudio("426051131", var_540_7)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_426051", "426051131", "story_v_out_426051.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_426051", "426051131", "story_v_out_426051.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_8 and arg_537_1.time_ < var_540_0 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play426051132 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 426051132
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play426051133(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.575

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_1 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(426051132).content)

				arg_541_1.text_.text = var_544_1

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_3 = 23 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 23)

				if (23 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 23)) > 0 and var_544_0 < var_544_3 then
					arg_541_1.talkMaxDuration = var_544_3

					if var_544_3 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_3 + 0
					end
				end

				arg_541_1.text_.text = var_544_1
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_4 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_4 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_4

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_4 and arg_541_1.time_ < 0 + var_544_4 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play426051133 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 426051133
		arg_545_1.duration_ = 9.9

		local var_545_0 = {
			zh = 7.6,
			ja = 9.9
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play426051134(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_548_0 = 0
			local var_548_1 = 0.875

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_2 = arg_545_1:GetWordFromCfg(426051133)
				local var_548_3 = arg_545_1:FormatText(var_548_2.content)

				arg_545_1.text_.text = var_548_3

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 35 <= 0 and var_548_1 or var_548_1 * (utf8.len(var_548_3) / 35)

				if (35 <= 0 and var_548_1 or var_548_1 * (utf8.len(var_548_3) / 35)) > 0 and var_548_1 < var_548_5 then
					arg_545_1.talkMaxDuration = var_548_5

					if var_548_5 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_5 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_3
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051133", "story_v_out_426051.awb") ~= 0 then
					local var_548_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051133", "story_v_out_426051.awb") / 1000

					if var_548_6 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_6 + var_548_0
					end

					if var_548_2.prefab_name ~= "" and arg_545_1.actors_[var_548_2.prefab_name] ~= nil then
						local var_548_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_2.prefab_name].transform, "story_v_out_426051", "426051133", "story_v_out_426051.awb")

						arg_545_1:RecordAudio("426051133", var_548_7)
						arg_545_1:RecordAudio("426051133", var_548_7)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_426051", "426051133", "story_v_out_426051.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_426051", "426051133", "story_v_out_426051.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_8 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_8 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_8

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_8 and arg_545_1.time_ < var_548_0 + var_548_8 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play426051134 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 426051134
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play426051135(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.125

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_1 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(426051134).content)

				arg_549_1.text_.text = var_552_1

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_3 = 5 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 5)

				if (5 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 5)) > 0 and var_552_0 < var_552_3 then
					arg_549_1.talkMaxDuration = var_552_3

					if var_552_3 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_3 + 0
					end
				end

				arg_549_1.text_.text = var_552_1
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_4 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_4

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play426051135 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 426051135
		arg_553_1.duration_ = 9.93

		local var_553_0 = {
			zh = 6.933,
			ja = 9.933
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play426051136(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_556_0 = 0
			local var_556_1 = 0.925

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_2 = arg_553_1:GetWordFromCfg(426051135)
				local var_556_3 = arg_553_1:FormatText(var_556_2.content)

				arg_553_1.text_.text = var_556_3

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 37 <= 0 and var_556_1 or var_556_1 * (utf8.len(var_556_3) / 37)

				if (37 <= 0 and var_556_1 or var_556_1 * (utf8.len(var_556_3) / 37)) > 0 and var_556_1 < var_556_5 then
					arg_553_1.talkMaxDuration = var_556_5

					if var_556_5 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_5 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_3
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051135", "story_v_out_426051.awb") ~= 0 then
					local var_556_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051135", "story_v_out_426051.awb") / 1000

					if var_556_6 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_6 + var_556_0
					end

					if var_556_2.prefab_name ~= "" and arg_553_1.actors_[var_556_2.prefab_name] ~= nil then
						local var_556_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_2.prefab_name].transform, "story_v_out_426051", "426051135", "story_v_out_426051.awb")

						arg_553_1:RecordAudio("426051135", var_556_7)
						arg_553_1:RecordAudio("426051135", var_556_7)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_426051", "426051135", "story_v_out_426051.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_426051", "426051135", "story_v_out_426051.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_8 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_8 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_8

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_8 and arg_553_1.time_ < var_556_0 + var_556_8 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play426051136 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 426051136
		arg_557_1.duration_ = 9.23

		local var_557_0 = {
			zh = 8.266,
			ja = 9.233
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play426051137(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			local var_560_0 = 0
			local var_560_1 = 0.925

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_2 = arg_557_1:GetWordFromCfg(426051136)
				local var_560_3 = arg_557_1:FormatText(var_560_2.content)

				arg_557_1.text_.text = var_560_3

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 37 <= 0 and var_560_1 or var_560_1 * (utf8.len(var_560_3) / 37)

				if (37 <= 0 and var_560_1 or var_560_1 * (utf8.len(var_560_3) / 37)) > 0 and var_560_1 < var_560_5 then
					arg_557_1.talkMaxDuration = var_560_5

					if var_560_5 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_3
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051136", "story_v_out_426051.awb") ~= 0 then
					local var_560_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051136", "story_v_out_426051.awb") / 1000

					if var_560_6 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_6 + var_560_0
					end

					if var_560_2.prefab_name ~= "" and arg_557_1.actors_[var_560_2.prefab_name] ~= nil then
						local var_560_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_2.prefab_name].transform, "story_v_out_426051", "426051136", "story_v_out_426051.awb")

						arg_557_1:RecordAudio("426051136", var_560_7)
						arg_557_1:RecordAudio("426051136", var_560_7)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_426051", "426051136", "story_v_out_426051.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_426051", "426051136", "story_v_out_426051.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_8 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_8 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_8

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_8 and arg_557_1.time_ < var_560_0 + var_560_8 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play426051137 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 426051137
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play426051138(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.55

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_1 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(426051137).content)

				arg_561_1.text_.text = var_564_1

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_3 = 22 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 22)

				if (22 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 22)) > 0 and var_564_0 < var_564_3 then
					arg_561_1.talkMaxDuration = var_564_3

					if var_564_3 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_3 + 0
					end
				end

				arg_561_1.text_.text = var_564_1
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_4 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_4

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play426051138 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 426051138
		arg_565_1.duration_ = 13.3

		local var_565_0 = {
			zh = 7.866,
			ja = 13.3
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play426051139(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos1012ui_story = arg_565_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_568_0 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 then
				arg_565_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_565_1.time_ - 0) / var_568_0)
				arg_565_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1012ui_story"].transform.position).z)
				arg_565_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1012ui_story"].transform.localEulerAngles = arg_565_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 then
				arg_565_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_565_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1012ui_story"].transform.position).z)
				arg_565_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1012ui_story"].transform.localEulerAngles = arg_565_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_2")
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_568_1 = 0
			local var_568_2 = 0.775

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_3 = arg_565_1:GetWordFromCfg(426051138)
				local var_568_4 = arg_565_1:FormatText(var_568_3.content)

				arg_565_1.text_.text = var_568_4

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_6 = 31 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_4) / 31)

				if (31 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_4) / 31)) > 0 and var_568_2 < var_568_6 then
					arg_565_1.talkMaxDuration = var_568_6

					if var_568_6 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_6 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_4
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051138", "story_v_out_426051.awb") ~= 0 then
					local var_568_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051138", "story_v_out_426051.awb") / 1000

					if var_568_7 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_7 + var_568_1
					end

					if var_568_3.prefab_name ~= "" and arg_565_1.actors_[var_568_3.prefab_name] ~= nil then
						local var_568_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_3.prefab_name].transform, "story_v_out_426051", "426051138", "story_v_out_426051.awb")

						arg_565_1:RecordAudio("426051138", var_568_8)
						arg_565_1:RecordAudio("426051138", var_568_8)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_426051", "426051138", "story_v_out_426051.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_426051", "426051138", "story_v_out_426051.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_9 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_9 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_9

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_9 and arg_565_1.time_ < var_568_1 + var_568_9 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
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

		arg_565_1:InitPlayNodeList()
	end,
	Play426051139 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 426051139
		arg_569_1.duration_ = 6.6

		local var_569_0 = {
			zh = 5.8,
			ja = 6.6
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play426051140(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.55

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_1 = arg_569_1:GetWordFromCfg(426051139)
				local var_572_2 = arg_569_1:FormatText(var_572_1.content)

				arg_569_1.text_.text = var_572_2

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_4 = 22 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 22)

				if (22 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_2) / 22)) > 0 and var_572_0 < var_572_4 then
					arg_569_1.talkMaxDuration = var_572_4

					if var_572_4 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_4 + 0
					end
				end

				arg_569_1.text_.text = var_572_2
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051139", "story_v_out_426051.awb") ~= 0 then
					local var_572_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051139", "story_v_out_426051.awb") / 1000

					if var_572_5 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + 0
					end

					if var_572_1.prefab_name ~= "" and arg_569_1.actors_[var_572_1.prefab_name] ~= nil then
						local var_572_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_1.prefab_name].transform, "story_v_out_426051", "426051139", "story_v_out_426051.awb")

						arg_569_1:RecordAudio("426051139", var_572_6)
						arg_569_1:RecordAudio("426051139", var_572_6)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_426051", "426051139", "story_v_out_426051.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_426051", "426051139", "story_v_out_426051.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_7 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_7 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_7

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_7 and arg_569_1.time_ < 0 + var_572_7 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play426051140 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 426051140
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play426051141(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1012ui_story = arg_573_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_576_0 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 then
				arg_573_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_573_1.time_ - 0) / var_576_0)
				arg_573_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1012ui_story"].transform.position).z)
				arg_573_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1012ui_story"].transform.localEulerAngles = arg_573_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 then
				arg_573_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_573_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_573_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_573_1.actors_["1012ui_story"].transform.position).z)
				arg_573_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_573_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_573_1.actors_["1012ui_story"].transform.localEulerAngles = arg_573_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_576_1 = 0
			local var_576_2 = 0.925

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, false)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_3 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(426051140).content)

				arg_573_1.text_.text = var_576_3

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 37 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 37)

				if (37 <= 0 and var_576_2 or var_576_2 * (utf8.len(var_576_3) / 37)) > 0 and var_576_2 < var_576_5 then
					arg_573_1.talkMaxDuration = var_576_5

					if var_576_5 + var_576_1 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + var_576_1
					end
				end

				arg_573_1.text_.text = var_576_3
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_6 = math.max(var_576_2, arg_573_1.talkMaxDuration)

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_6 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_1) / var_576_6

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_1 + var_576_6 and arg_573_1.time_ < var_576_1 + var_576_6 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
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

		arg_573_1:InitPlayNodeList()
	end,
	Play426051141 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 426051141
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play426051142(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0.55

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_1 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(426051141).content)

				arg_577_1.text_.text = var_580_1

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_3 = 22 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 22)

				if (22 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 22)) > 0 and var_580_0 < var_580_3 then
					arg_577_1.talkMaxDuration = var_580_3

					if var_580_3 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_3 + 0
					end
				end

				arg_577_1.text_.text = var_580_1
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_4 = math.max(var_580_0, arg_577_1.talkMaxDuration)

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_4 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - 0) / var_580_4

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= 0 + var_580_4 and arg_577_1.time_ < 0 + var_580_4 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play426051142 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 426051142
		arg_581_1.duration_ = 4.53

		local var_581_0 = {
			zh = 4.466,
			ja = 4.533
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play426051143(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos1012ui_story = arg_581_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_584_0 = 0.001

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 then
				arg_581_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_581_1.time_ - 0) / var_584_0)
				arg_581_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1012ui_story"].transform.position).z)
				arg_581_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1012ui_story"].transform.localEulerAngles = arg_581_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 then
				arg_581_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_581_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1012ui_story"].transform.position).z)
				arg_581_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1012ui_story"].transform.localEulerAngles = arg_581_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_584_1 = 0
			local var_584_2 = 0.6

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_3 = arg_581_1:GetWordFromCfg(426051142)
				local var_584_4 = arg_581_1:FormatText(var_584_3.content)

				arg_581_1.text_.text = var_584_4

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_6 = 24 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_4) / 24)

				if (24 <= 0 and var_584_2 or var_584_2 * (utf8.len(var_584_4) / 24)) > 0 and var_584_2 < var_584_6 then
					arg_581_1.talkMaxDuration = var_584_6

					if var_584_6 + var_584_1 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_6 + var_584_1
					end
				end

				arg_581_1.text_.text = var_584_4
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051142", "story_v_out_426051.awb") ~= 0 then
					local var_584_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051142", "story_v_out_426051.awb") / 1000

					if var_584_7 + var_584_1 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_7 + var_584_1
					end

					if var_584_3.prefab_name ~= "" and arg_581_1.actors_[var_584_3.prefab_name] ~= nil then
						local var_584_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_3.prefab_name].transform, "story_v_out_426051", "426051142", "story_v_out_426051.awb")

						arg_581_1:RecordAudio("426051142", var_584_8)
						arg_581_1:RecordAudio("426051142", var_584_8)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_426051", "426051142", "story_v_out_426051.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_426051", "426051142", "story_v_out_426051.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_9 = math.max(var_584_2, arg_581_1.talkMaxDuration)

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_9 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_1) / var_584_9

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_1 + var_584_9 and arg_581_1.time_ < var_584_1 + var_584_9 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
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

		arg_581_1:InitPlayNodeList()
	end,
	Play426051143 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 426051143
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play426051144(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.2

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(426051143).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 8 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 8)

				if (8 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 8)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play426051144 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 426051144
		arg_589_1.duration_ = 14.5

		local var_589_0 = {
			zh = 8.6,
			ja = 14.5
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play426051145(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos1012ui_story = arg_589_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_592_0 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 then
				arg_589_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_589_1.time_ - 0) / var_592_0)
				arg_589_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1012ui_story"].transform.position).z)
				arg_589_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1012ui_story"].transform.localEulerAngles = arg_589_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 then
				arg_589_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_589_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1012ui_story"].transform.position).z)
				arg_589_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1012ui_story"].transform.localEulerAngles = arg_589_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_592_1 = 0
			local var_592_2 = 0.975

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_3 = arg_589_1:GetWordFromCfg(426051144)
				local var_592_4 = arg_589_1:FormatText(var_592_3.content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_6 = 39 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_4) / 39)

				if (39 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_4) / 39)) > 0 and var_592_2 < var_592_6 then
					arg_589_1.talkMaxDuration = var_592_6

					if var_592_6 + var_592_1 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_6 + var_592_1
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051144", "story_v_out_426051.awb") ~= 0 then
					local var_592_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051144", "story_v_out_426051.awb") / 1000

					if var_592_7 + var_592_1 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_1
					end

					if var_592_3.prefab_name ~= "" and arg_589_1.actors_[var_592_3.prefab_name] ~= nil then
						local var_592_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_3.prefab_name].transform, "story_v_out_426051", "426051144", "story_v_out_426051.awb")

						arg_589_1:RecordAudio("426051144", var_592_8)
						arg_589_1:RecordAudio("426051144", var_592_8)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_426051", "426051144", "story_v_out_426051.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_426051", "426051144", "story_v_out_426051.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_9 = math.max(var_592_2, arg_589_1.talkMaxDuration)

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_9 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_1) / var_592_9

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_1 + var_592_9 and arg_589_1.time_ < var_592_1 + var_592_9 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
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

		arg_589_1:InitPlayNodeList()
	end,
	Play426051145 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 426051145
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play426051146(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.275

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_1 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(426051145).content)

				arg_593_1.text_.text = var_596_1

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_3 = 11 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 11)

				if (11 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 11)) > 0 and var_596_0 < var_596_3 then
					arg_593_1.talkMaxDuration = var_596_3

					if var_596_3 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_3 + 0
					end
				end

				arg_593_1.text_.text = var_596_1
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_4 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_4 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_4

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_4 and arg_593_1.time_ < 0 + var_596_4 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play426051146 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 426051146
		arg_597_1.duration_ = 11.77

		local var_597_0 = {
			zh = 6.4,
			ja = 11.766
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play426051147(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_2")
			end

			local var_600_0 = 0
			local var_600_1 = 0.75

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_2 = arg_597_1:GetWordFromCfg(426051146)
				local var_600_3 = arg_597_1:FormatText(var_600_2.content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 30 <= 0 and var_600_1 or var_600_1 * (utf8.len(var_600_3) / 30)

				if (30 <= 0 and var_600_1 or var_600_1 * (utf8.len(var_600_3) / 30)) > 0 and var_600_1 < var_600_5 then
					arg_597_1.talkMaxDuration = var_600_5

					if var_600_5 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + var_600_0
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051146", "story_v_out_426051.awb") ~= 0 then
					local var_600_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051146", "story_v_out_426051.awb") / 1000

					if var_600_6 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_6 + var_600_0
					end

					if var_600_2.prefab_name ~= "" and arg_597_1.actors_[var_600_2.prefab_name] ~= nil then
						local var_600_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_2.prefab_name].transform, "story_v_out_426051", "426051146", "story_v_out_426051.awb")

						arg_597_1:RecordAudio("426051146", var_600_7)
						arg_597_1:RecordAudio("426051146", var_600_7)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_426051", "426051146", "story_v_out_426051.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_426051", "426051146", "story_v_out_426051.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_8 = math.max(var_600_1, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_8 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_0) / var_600_8

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_8 and arg_597_1.time_ < var_600_0 + var_600_8 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play426051147 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 426051147
		arg_601_1.duration_ = 10.8

		local var_601_0 = {
			zh = 7.833,
			ja = 10.8
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play426051148(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0.9

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_1 = arg_601_1:GetWordFromCfg(426051147)
				local var_604_2 = arg_601_1:FormatText(var_604_1.content)

				arg_601_1.text_.text = var_604_2

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_4 = 36 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 36)

				if (36 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 36)) > 0 and var_604_0 < var_604_4 then
					arg_601_1.talkMaxDuration = var_604_4

					if var_604_4 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_4 + 0
					end
				end

				arg_601_1.text_.text = var_604_2
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051147", "story_v_out_426051.awb") ~= 0 then
					local var_604_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051147", "story_v_out_426051.awb") / 1000

					if var_604_5 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + 0
					end

					if var_604_1.prefab_name ~= "" and arg_601_1.actors_[var_604_1.prefab_name] ~= nil then
						local var_604_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_1.prefab_name].transform, "story_v_out_426051", "426051147", "story_v_out_426051.awb")

						arg_601_1:RecordAudio("426051147", var_604_6)
						arg_601_1:RecordAudio("426051147", var_604_6)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_426051", "426051147", "story_v_out_426051.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_426051", "426051147", "story_v_out_426051.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_7 = math.max(var_604_0, arg_601_1.talkMaxDuration)

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_7 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - 0) / var_604_7

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= 0 + var_604_7 and arg_601_1.time_ < 0 + var_604_7 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play426051148 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 426051148
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play426051149(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.375

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_1 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(426051148).content)

				arg_605_1.text_.text = var_608_1

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_3 = 15 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 15)

				if (15 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 15)) > 0 and var_608_0 < var_608_3 then
					arg_605_1.talkMaxDuration = var_608_3

					if var_608_3 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_3 + 0
					end
				end

				arg_605_1.text_.text = var_608_1
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_4 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_4 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_4

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_4 and arg_605_1.time_ < 0 + var_608_4 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play426051149 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 426051149
		arg_609_1.duration_ = 5.5

		local var_609_0 = {
			zh = 4.2,
			ja = 5.5
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play426051150(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0.475

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_1 = arg_609_1:GetWordFromCfg(426051149)
				local var_612_2 = arg_609_1:FormatText(var_612_1.content)

				arg_609_1.text_.text = var_612_2

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_4 = 19 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_2) / 19)

				if (19 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_2) / 19)) > 0 and var_612_0 < var_612_4 then
					arg_609_1.talkMaxDuration = var_612_4

					if var_612_4 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_4 + 0
					end
				end

				arg_609_1.text_.text = var_612_2
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051149", "story_v_out_426051.awb") ~= 0 then
					local var_612_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051149", "story_v_out_426051.awb") / 1000

					if var_612_5 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_5 + 0
					end

					if var_612_1.prefab_name ~= "" and arg_609_1.actors_[var_612_1.prefab_name] ~= nil then
						local var_612_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_1.prefab_name].transform, "story_v_out_426051", "426051149", "story_v_out_426051.awb")

						arg_609_1:RecordAudio("426051149", var_612_6)
						arg_609_1:RecordAudio("426051149", var_612_6)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_out_426051", "426051149", "story_v_out_426051.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_out_426051", "426051149", "story_v_out_426051.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_7 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_7 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_7

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_7 and arg_609_1.time_ < 0 + var_612_7 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play426051150 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 426051150
		arg_613_1.duration_ = 15.97

		local var_613_0 = {
			zh = 11.466,
			ja = 15.966
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play426051151(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 1.2

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_1 = arg_613_1:GetWordFromCfg(426051150)
				local var_616_2 = arg_613_1:FormatText(var_616_1.content)

				arg_613_1.text_.text = var_616_2

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_4 = 48 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_2) / 48)

				if (48 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_2) / 48)) > 0 and var_616_0 < var_616_4 then
					arg_613_1.talkMaxDuration = var_616_4

					if var_616_4 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_4 + 0
					end
				end

				arg_613_1.text_.text = var_616_2
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051150", "story_v_out_426051.awb") ~= 0 then
					local var_616_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051150", "story_v_out_426051.awb") / 1000

					if var_616_5 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_5 + 0
					end

					if var_616_1.prefab_name ~= "" and arg_613_1.actors_[var_616_1.prefab_name] ~= nil then
						local var_616_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_1.prefab_name].transform, "story_v_out_426051", "426051150", "story_v_out_426051.awb")

						arg_613_1:RecordAudio("426051150", var_616_6)
						arg_613_1:RecordAudio("426051150", var_616_6)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_426051", "426051150", "story_v_out_426051.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_426051", "426051150", "story_v_out_426051.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_7 = math.max(var_616_0, arg_613_1.talkMaxDuration)

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_7 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - 0) / var_616_7

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= 0 + var_616_7 and arg_613_1.time_ < 0 + var_616_7 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play426051151 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 426051151
		arg_617_1.duration_ = 14.2

		local var_617_0 = {
			zh = 10.233,
			ja = 14.2
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play426051152(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 1.15

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_1 = arg_617_1:GetWordFromCfg(426051151)
				local var_620_2 = arg_617_1:FormatText(var_620_1.content)

				arg_617_1.text_.text = var_620_2

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_4 = 46 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 46)

				if (46 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 46)) > 0 and var_620_0 < var_620_4 then
					arg_617_1.talkMaxDuration = var_620_4

					if var_620_4 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_4 + 0
					end
				end

				arg_617_1.text_.text = var_620_2
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051151", "story_v_out_426051.awb") ~= 0 then
					local var_620_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051151", "story_v_out_426051.awb") / 1000

					if var_620_5 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + 0
					end

					if var_620_1.prefab_name ~= "" and arg_617_1.actors_[var_620_1.prefab_name] ~= nil then
						local var_620_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_1.prefab_name].transform, "story_v_out_426051", "426051151", "story_v_out_426051.awb")

						arg_617_1:RecordAudio("426051151", var_620_6)
						arg_617_1:RecordAudio("426051151", var_620_6)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_out_426051", "426051151", "story_v_out_426051.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_out_426051", "426051151", "story_v_out_426051.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_7 = math.max(var_620_0, arg_617_1.talkMaxDuration)

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - 0) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= 0 + var_620_7 and arg_617_1.time_ < 0 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play426051152 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 426051152
		arg_621_1.duration_ = 9.3

		local var_621_0 = {
			zh = 6.733,
			ja = 9.3
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play426051153(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action3_1")
			end

			local var_624_0 = 0
			local var_624_1 = 0.75

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_2 = arg_621_1:GetWordFromCfg(426051152)
				local var_624_3 = arg_621_1:FormatText(var_624_2.content)

				arg_621_1.text_.text = var_624_3

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 30 <= 0 and var_624_1 or var_624_1 * (utf8.len(var_624_3) / 30)

				if (30 <= 0 and var_624_1 or var_624_1 * (utf8.len(var_624_3) / 30)) > 0 and var_624_1 < var_624_5 then
					arg_621_1.talkMaxDuration = var_624_5

					if var_624_5 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + var_624_0
					end
				end

				arg_621_1.text_.text = var_624_3
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051152", "story_v_out_426051.awb") ~= 0 then
					local var_624_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051152", "story_v_out_426051.awb") / 1000

					if var_624_6 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_6 + var_624_0
					end

					if var_624_2.prefab_name ~= "" and arg_621_1.actors_[var_624_2.prefab_name] ~= nil then
						local var_624_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_2.prefab_name].transform, "story_v_out_426051", "426051152", "story_v_out_426051.awb")

						arg_621_1:RecordAudio("426051152", var_624_7)
						arg_621_1:RecordAudio("426051152", var_624_7)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_426051", "426051152", "story_v_out_426051.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_426051", "426051152", "story_v_out_426051.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_8 = math.max(var_624_1, arg_621_1.talkMaxDuration)

			if var_624_0 <= arg_621_1.time_ and arg_621_1.time_ < var_624_0 + var_624_8 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_0) / var_624_8

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_0 + var_624_8 and arg_621_1.time_ < var_624_0 + var_624_8 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play426051153 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 426051153
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play426051154(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.275

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_1 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(426051153).content)

				arg_625_1.text_.text = var_628_1

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_3 = 11 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 11)

				if (11 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 11)) > 0 and var_628_0 < var_628_3 then
					arg_625_1.talkMaxDuration = var_628_3

					if var_628_3 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_3 + 0
					end
				end

				arg_625_1.text_.text = var_628_1
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_4 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_4 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_4

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_4 and arg_625_1.time_ < 0 + var_628_4 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play426051154 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 426051154
		arg_629_1.duration_ = 9.6

		local var_629_0 = {
			zh = 6.1,
			ja = 9.6
		}
		local var_629_1 = manager.audio:GetLocalizationFlag()

		if var_629_0[var_629_1] ~= nil then
			arg_629_1.duration_ = var_629_0[var_629_1]
		end

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play426051155(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.var_.moveOldPos1012ui_story = arg_629_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_632_0 = 0.001

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_0 then
				arg_629_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_629_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_629_1.time_ - 0) / var_632_0)
				arg_629_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1012ui_story"].transform.position).z)
				arg_629_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1012ui_story"].transform.localEulerAngles = arg_629_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_629_1.time_ >= 0 + var_632_0 and arg_629_1.time_ < 0 + var_632_0 + arg_632_0 then
				arg_629_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_629_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_629_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_629_1.actors_["1012ui_story"].transform.position).z)
				arg_629_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_629_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_629_1.actors_["1012ui_story"].transform.localEulerAngles = arg_629_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012actionlink/1012action434")
			end

			local var_632_1 = 0
			local var_632_2 = 0.7

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, true)

				arg_629_1.leftNameTxt_.text = arg_629_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_629_1.leftNameTxt_.transform)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1.leftNameTxt_.text)
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_3 = arg_629_1:GetWordFromCfg(426051154)
				local var_632_4 = arg_629_1:FormatText(var_632_3.content)

				arg_629_1.text_.text = var_632_4

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_6 = 28 <= 0 and var_632_2 or var_632_2 * (utf8.len(var_632_4) / 28)

				if (28 <= 0 and var_632_2 or var_632_2 * (utf8.len(var_632_4) / 28)) > 0 and var_632_2 < var_632_6 then
					arg_629_1.talkMaxDuration = var_632_6

					if var_632_6 + var_632_1 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_6 + var_632_1
					end
				end

				arg_629_1.text_.text = var_632_4
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051154", "story_v_out_426051.awb") ~= 0 then
					local var_632_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051154", "story_v_out_426051.awb") / 1000

					if var_632_7 + var_632_1 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_7 + var_632_1
					end

					if var_632_3.prefab_name ~= "" and arg_629_1.actors_[var_632_3.prefab_name] ~= nil then
						local var_632_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_629_1.actors_[var_632_3.prefab_name].transform, "story_v_out_426051", "426051154", "story_v_out_426051.awb")

						arg_629_1:RecordAudio("426051154", var_632_8)
						arg_629_1:RecordAudio("426051154", var_632_8)
					else
						arg_629_1:AudioAction("play", "voice", "story_v_out_426051", "426051154", "story_v_out_426051.awb")
					end

					arg_629_1:RecordHistoryTalkVoice("story_v_out_426051", "426051154", "story_v_out_426051.awb")
				end

				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_9 = math.max(var_632_2, arg_629_1.talkMaxDuration)

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_9 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_1) / var_632_9

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_1 + var_632_9 and arg_629_1.time_ < var_632_1 + var_632_9 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {
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

		arg_629_1:InitPlayNodeList()
	end,
	Play426051155 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 426051155
		arg_633_1.duration_ = 7.5

		local var_633_0 = {
			zh = 4.4,
			ja = 7.5
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play426051156(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = 0.5

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_1 = arg_633_1:GetWordFromCfg(426051155)
				local var_636_2 = arg_633_1:FormatText(var_636_1.content)

				arg_633_1.text_.text = var_636_2

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_4 = 20 <= 0 and var_636_0 or var_636_0 * (utf8.len(var_636_2) / 20)

				if (20 <= 0 and var_636_0 or var_636_0 * (utf8.len(var_636_2) / 20)) > 0 and var_636_0 < var_636_4 then
					arg_633_1.talkMaxDuration = var_636_4

					if var_636_4 + 0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_4 + 0
					end
				end

				arg_633_1.text_.text = var_636_2
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051155", "story_v_out_426051.awb") ~= 0 then
					local var_636_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051155", "story_v_out_426051.awb") / 1000

					if var_636_5 + 0 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_5 + 0
					end

					if var_636_1.prefab_name ~= "" and arg_633_1.actors_[var_636_1.prefab_name] ~= nil then
						local var_636_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_1.prefab_name].transform, "story_v_out_426051", "426051155", "story_v_out_426051.awb")

						arg_633_1:RecordAudio("426051155", var_636_6)
						arg_633_1:RecordAudio("426051155", var_636_6)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_out_426051", "426051155", "story_v_out_426051.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_out_426051", "426051155", "story_v_out_426051.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_7 = math.max(var_636_0, arg_633_1.talkMaxDuration)

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_7 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - 0) / var_636_7

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= 0 + var_636_7 and arg_633_1.time_ < 0 + var_636_7 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play426051156 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 426051156
		arg_637_1.duration_ = 7.63

		local var_637_0 = {
			zh = 5.666,
			ja = 7.633
		}
		local var_637_1 = manager.audio:GetLocalizationFlag()

		if var_637_0[var_637_1] ~= nil then
			arg_637_1.duration_ = var_637_0[var_637_1]
		end

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play426051157(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0.75

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_1 = arg_637_1:GetWordFromCfg(426051156)
				local var_640_2 = arg_637_1:FormatText(var_640_1.content)

				arg_637_1.text_.text = var_640_2

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_4 = 30 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 30)

				if (30 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 30)) > 0 and var_640_0 < var_640_4 then
					arg_637_1.talkMaxDuration = var_640_4

					if var_640_4 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_4 + 0
					end
				end

				arg_637_1.text_.text = var_640_2
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051156", "story_v_out_426051.awb") ~= 0 then
					local var_640_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051156", "story_v_out_426051.awb") / 1000

					if var_640_5 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_5 + 0
					end

					if var_640_1.prefab_name ~= "" and arg_637_1.actors_[var_640_1.prefab_name] ~= nil then
						local var_640_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_1.prefab_name].transform, "story_v_out_426051", "426051156", "story_v_out_426051.awb")

						arg_637_1:RecordAudio("426051156", var_640_6)
						arg_637_1:RecordAudio("426051156", var_640_6)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_out_426051", "426051156", "story_v_out_426051.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_out_426051", "426051156", "story_v_out_426051.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_7 = math.max(var_640_0, arg_637_1.talkMaxDuration)

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_7 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - 0) / var_640_7

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= 0 + var_640_7 and arg_637_1.time_ < 0 + var_640_7 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play426051157 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 426051157
		arg_641_1.duration_ = 4.1

		local var_641_0 = {
			zh = 3.9,
			ja = 4.1
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play426051158(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			local var_644_0 = 0
			local var_644_1 = 0.425

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_2 = arg_641_1:GetWordFromCfg(426051157)
				local var_644_3 = arg_641_1:FormatText(var_644_2.content)

				arg_641_1.text_.text = var_644_3

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_5 = 17 <= 0 and var_644_1 or var_644_1 * (utf8.len(var_644_3) / 17)

				if (17 <= 0 and var_644_1 or var_644_1 * (utf8.len(var_644_3) / 17)) > 0 and var_644_1 < var_644_5 then
					arg_641_1.talkMaxDuration = var_644_5

					if var_644_5 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_5 + var_644_0
					end
				end

				arg_641_1.text_.text = var_644_3
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051157", "story_v_out_426051.awb") ~= 0 then
					local var_644_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051157", "story_v_out_426051.awb") / 1000

					if var_644_6 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_6 + var_644_0
					end

					if var_644_2.prefab_name ~= "" and arg_641_1.actors_[var_644_2.prefab_name] ~= nil then
						local var_644_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_2.prefab_name].transform, "story_v_out_426051", "426051157", "story_v_out_426051.awb")

						arg_641_1:RecordAudio("426051157", var_644_7)
						arg_641_1:RecordAudio("426051157", var_644_7)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_out_426051", "426051157", "story_v_out_426051.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_out_426051", "426051157", "story_v_out_426051.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_8 = math.max(var_644_1, arg_641_1.talkMaxDuration)

			if var_644_0 <= arg_641_1.time_ and arg_641_1.time_ < var_644_0 + var_644_8 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_0) / var_644_8

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_0 + var_644_8 and arg_641_1.time_ < var_644_0 + var_644_8 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play426051158 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 426051158
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play426051159(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0.3

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_1 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(426051158).content)

				arg_645_1.text_.text = var_648_1

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_3 = 12 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 12)

				if (12 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 12)) > 0 and var_648_0 < var_648_3 then
					arg_645_1.talkMaxDuration = var_648_3

					if var_648_3 + 0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_3 + 0
					end
				end

				arg_645_1.text_.text = var_648_1
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_4 = math.max(var_648_0, arg_645_1.talkMaxDuration)

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_4 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - 0) / var_648_4

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= 0 + var_648_4 and arg_645_1.time_ < 0 + var_648_4 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play426051159 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 426051159
		arg_649_1.duration_ = 7.27

		local var_649_0 = {
			zh = 5.3,
			ja = 7.266
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play426051160(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.6

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_1 = arg_649_1:GetWordFromCfg(426051159)
				local var_652_2 = arg_649_1:FormatText(var_652_1.content)

				arg_649_1.text_.text = var_652_2

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_4 = 24 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_2) / 24)

				if (24 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_2) / 24)) > 0 and var_652_0 < var_652_4 then
					arg_649_1.talkMaxDuration = var_652_4

					if var_652_4 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_4 + 0
					end
				end

				arg_649_1.text_.text = var_652_2
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051159", "story_v_out_426051.awb") ~= 0 then
					local var_652_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051159", "story_v_out_426051.awb") / 1000

					if var_652_5 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_5 + 0
					end

					if var_652_1.prefab_name ~= "" and arg_649_1.actors_[var_652_1.prefab_name] ~= nil then
						local var_652_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_1.prefab_name].transform, "story_v_out_426051", "426051159", "story_v_out_426051.awb")

						arg_649_1:RecordAudio("426051159", var_652_6)
						arg_649_1:RecordAudio("426051159", var_652_6)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_out_426051", "426051159", "story_v_out_426051.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_out_426051", "426051159", "story_v_out_426051.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_7 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_7 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_7

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_7 and arg_649_1.time_ < 0 + var_652_7 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play426051160 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 426051160
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play426051161(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			local var_656_0 = 0.85

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, true)
				arg_653_1.iconController_:SetSelectedState("hero")

				arg_653_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_653_1.callingController_:SetSelectedState("normal")

				arg_653_1.keyicon_.color = Color.New(1, 1, 1)
				arg_653_1.icon_.color = Color.New(1, 1, 1)

				local var_656_1 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(426051160).content)

				arg_653_1.text_.text = var_656_1

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_3 = 34 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 34)

				if (34 <= 0 and var_656_0 or var_656_0 * (utf8.len(var_656_1) / 34)) > 0 and var_656_0 < var_656_3 then
					arg_653_1.talkMaxDuration = var_656_3

					if var_656_3 + 0 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_3 + 0
					end
				end

				arg_653_1.text_.text = var_656_1
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_4 = math.max(var_656_0, arg_653_1.talkMaxDuration)

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_4 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - 0) / var_656_4

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= 0 + var_656_4 and arg_653_1.time_ < 0 + var_656_4 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play426051161 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 426051161
		arg_657_1.duration_ = 4.13

		local var_657_0 = {
			zh = 3.366,
			ja = 4.133
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play426051162(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0.475

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_1 = arg_657_1:GetWordFromCfg(426051161)
				local var_660_2 = arg_657_1:FormatText(var_660_1.content)

				arg_657_1.text_.text = var_660_2

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_4 = 19 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_2) / 19)

				if (19 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_2) / 19)) > 0 and var_660_0 < var_660_4 then
					arg_657_1.talkMaxDuration = var_660_4

					if var_660_4 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_4 + 0
					end
				end

				arg_657_1.text_.text = var_660_2
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051161", "story_v_out_426051.awb") ~= 0 then
					local var_660_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051161", "story_v_out_426051.awb") / 1000

					if var_660_5 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_5 + 0
					end

					if var_660_1.prefab_name ~= "" and arg_657_1.actors_[var_660_1.prefab_name] ~= nil then
						local var_660_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_1.prefab_name].transform, "story_v_out_426051", "426051161", "story_v_out_426051.awb")

						arg_657_1:RecordAudio("426051161", var_660_6)
						arg_657_1:RecordAudio("426051161", var_660_6)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_426051", "426051161", "story_v_out_426051.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_426051", "426051161", "story_v_out_426051.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_7 = math.max(var_660_0, arg_657_1.talkMaxDuration)

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_7 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - 0) / var_660_7

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= 0 + var_660_7 and arg_657_1.time_ < 0 + var_660_7 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play426051162 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 426051162
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play426051163(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1.var_.moveOldPos1012ui_story = arg_661_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_664_0 = 0.001

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 then
				arg_661_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_661_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_661_1.time_ - 0) / var_664_0)
				arg_661_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_661_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_661_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_661_1.actors_["1012ui_story"].transform.position).z)
				arg_661_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_661_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_661_1.actors_["1012ui_story"].transform.localEulerAngles = arg_661_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 then
				arg_661_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_661_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_661_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_661_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_661_1.actors_["1012ui_story"].transform.position).z)
				arg_661_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_661_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_661_1.actors_["1012ui_story"].transform.localEulerAngles = arg_661_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_664_1 = 0
			local var_664_2 = 0.575

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_1 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, false)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_3 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(426051162).content)

				arg_661_1.text_.text = var_664_3

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_5 = 23 <= 0 and var_664_2 or var_664_2 * (utf8.len(var_664_3) / 23)

				if (23 <= 0 and var_664_2 or var_664_2 * (utf8.len(var_664_3) / 23)) > 0 and var_664_2 < var_664_5 then
					arg_661_1.talkMaxDuration = var_664_5

					if var_664_5 + var_664_1 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_5 + var_664_1
					end
				end

				arg_661_1.text_.text = var_664_3
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_6 = math.max(var_664_2, arg_661_1.talkMaxDuration)

			if var_664_1 <= arg_661_1.time_ and arg_661_1.time_ < var_664_1 + var_664_6 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_1) / var_664_6

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_1 + var_664_6 and arg_661_1.time_ < var_664_1 + var_664_6 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {
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

		arg_661_1:InitPlayNodeList()
	end,
	Play426051163 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 426051163
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play426051164(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			local var_668_0 = 0.125

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_1 = arg_665_1:FormatText(arg_665_1:GetWordFromCfg(426051163).content)

				arg_665_1.text_.text = var_668_1

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_3 = 5 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 5)

				if (5 <= 0 and var_668_0 or var_668_0 * (utf8.len(var_668_1) / 5)) > 0 and var_668_0 < var_668_3 then
					arg_665_1.talkMaxDuration = var_668_3

					if var_668_3 + 0 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_3 + 0
					end
				end

				arg_665_1.text_.text = var_668_1
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_4 = math.max(var_668_0, arg_665_1.talkMaxDuration)

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_4 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - 0) / var_668_4

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= 0 + var_668_4 and arg_665_1.time_ < 0 + var_668_4 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play426051164 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 426051164
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play426051165(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 1.175

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, true)
				arg_669_1.iconController_:SetSelectedState("hero")

				arg_669_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_669_1.callingController_:SetSelectedState("normal")

				arg_669_1.keyicon_.color = Color.New(1, 1, 1)
				arg_669_1.icon_.color = Color.New(1, 1, 1)

				local var_672_1 = arg_669_1:FormatText(arg_669_1:GetWordFromCfg(426051164).content)

				arg_669_1.text_.text = var_672_1

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_3 = 47 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_1) / 47)

				if (47 <= 0 and var_672_0 or var_672_0 * (utf8.len(var_672_1) / 47)) > 0 and var_672_0 < var_672_3 then
					arg_669_1.talkMaxDuration = var_672_3

					if var_672_3 + 0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_3 + 0
					end
				end

				arg_669_1.text_.text = var_672_1
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_4 = math.max(var_672_0, arg_669_1.talkMaxDuration)

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_4 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - 0) / var_672_4

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= 0 + var_672_4 and arg_669_1.time_ < 0 + var_672_4 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play426051165 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 426051165
		arg_673_1.duration_ = 6.37

		local var_673_0 = {
			zh = 5.1,
			ja = 6.366
		}
		local var_673_1 = manager.audio:GetLocalizationFlag()

		if var_673_0[var_673_1] ~= nil then
			arg_673_1.duration_ = var_673_0[var_673_1]
		end

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play426051166(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1.var_.moveOldPos1012ui_story = arg_673_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_676_0 = 0.001

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 then
				arg_673_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_673_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_673_1.time_ - 0) / var_676_0)
				arg_673_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_673_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_673_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_673_1.actors_["1012ui_story"].transform.position).z)
				arg_673_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_673_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_673_1.actors_["1012ui_story"].transform.localEulerAngles = arg_673_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 then
				arg_673_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_673_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_673_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_673_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_673_1.actors_["1012ui_story"].transform.position).z)
				arg_673_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_673_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_673_1.actors_["1012ui_story"].transform.localEulerAngles = arg_673_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 then
				arg_673_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_676_1 = 0
			local var_676_2 = 0.725

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_3 = arg_673_1:GetWordFromCfg(426051165)
				local var_676_4 = arg_673_1:FormatText(var_676_3.content)

				arg_673_1.text_.text = var_676_4

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_6 = 29 <= 0 and var_676_2 or var_676_2 * (utf8.len(var_676_4) / 29)

				if (29 <= 0 and var_676_2 or var_676_2 * (utf8.len(var_676_4) / 29)) > 0 and var_676_2 < var_676_6 then
					arg_673_1.talkMaxDuration = var_676_6

					if var_676_6 + var_676_1 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_6 + var_676_1
					end
				end

				arg_673_1.text_.text = var_676_4
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051165", "story_v_out_426051.awb") ~= 0 then
					local var_676_7 = manager.audio:GetVoiceLength("story_v_out_426051", "426051165", "story_v_out_426051.awb") / 1000

					if var_676_7 + var_676_1 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_7 + var_676_1
					end

					if var_676_3.prefab_name ~= "" and arg_673_1.actors_[var_676_3.prefab_name] ~= nil then
						local var_676_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_673_1.actors_[var_676_3.prefab_name].transform, "story_v_out_426051", "426051165", "story_v_out_426051.awb")

						arg_673_1:RecordAudio("426051165", var_676_8)
						arg_673_1:RecordAudio("426051165", var_676_8)
					else
						arg_673_1:AudioAction("play", "voice", "story_v_out_426051", "426051165", "story_v_out_426051.awb")
					end

					arg_673_1:RecordHistoryTalkVoice("story_v_out_426051", "426051165", "story_v_out_426051.awb")
				end

				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_9 = math.max(var_676_2, arg_673_1.talkMaxDuration)

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_9 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_1) / var_676_9

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_1 + var_676_9 and arg_673_1.time_ < var_676_1 + var_676_9 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {
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

		arg_673_1:InitPlayNodeList()
	end,
	Play426051166 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 426051166
		arg_677_1.duration_ = 8.77

		local var_677_0 = {
			zh = 4.866,
			ja = 8.766
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play426051167(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = 0.625

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_1 = arg_677_1:GetWordFromCfg(426051166)
				local var_680_2 = arg_677_1:FormatText(var_680_1.content)

				arg_677_1.text_.text = var_680_2

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_4 = 25 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_2) / 25)

				if (25 <= 0 and var_680_0 or var_680_0 * (utf8.len(var_680_2) / 25)) > 0 and var_680_0 < var_680_4 then
					arg_677_1.talkMaxDuration = var_680_4

					if var_680_4 + 0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_4 + 0
					end
				end

				arg_677_1.text_.text = var_680_2
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051166", "story_v_out_426051.awb") ~= 0 then
					local var_680_5 = manager.audio:GetVoiceLength("story_v_out_426051", "426051166", "story_v_out_426051.awb") / 1000

					if var_680_5 + 0 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_5 + 0
					end

					if var_680_1.prefab_name ~= "" and arg_677_1.actors_[var_680_1.prefab_name] ~= nil then
						local var_680_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_1.prefab_name].transform, "story_v_out_426051", "426051166", "story_v_out_426051.awb")

						arg_677_1:RecordAudio("426051166", var_680_6)
						arg_677_1:RecordAudio("426051166", var_680_6)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_out_426051", "426051166", "story_v_out_426051.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_out_426051", "426051166", "story_v_out_426051.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_7 = math.max(var_680_0, arg_677_1.talkMaxDuration)

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_7 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - 0) / var_680_7

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= 0 + var_680_7 and arg_677_1.time_ < 0 + var_680_7 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play426051167 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 426051167
		arg_681_1.duration_ = 12.83

		local var_681_0 = {
			zh = 8.866,
			ja = 12.833
		}
		local var_681_1 = manager.audio:GetLocalizationFlag()

		if var_681_0[var_681_1] ~= nil then
			arg_681_1.duration_ = var_681_0[var_681_1]
		end

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play426051168(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_1")
			end

			local var_684_0 = 0
			local var_684_1 = 0.85

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_0 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				arg_681_1.leftNameTxt_.text = arg_681_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_2 = arg_681_1:GetWordFromCfg(426051167)
				local var_684_3 = arg_681_1:FormatText(var_684_2.content)

				arg_681_1.text_.text = var_684_3

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_5 = 34 <= 0 and var_684_1 or var_684_1 * (utf8.len(var_684_3) / 34)

				if (34 <= 0 and var_684_1 or var_684_1 * (utf8.len(var_684_3) / 34)) > 0 and var_684_1 < var_684_5 then
					arg_681_1.talkMaxDuration = var_684_5

					if var_684_5 + var_684_0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_5 + var_684_0
					end
				end

				arg_681_1.text_.text = var_684_3
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051167", "story_v_out_426051.awb") ~= 0 then
					local var_684_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051167", "story_v_out_426051.awb") / 1000

					if var_684_6 + var_684_0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_6 + var_684_0
					end

					if var_684_2.prefab_name ~= "" and arg_681_1.actors_[var_684_2.prefab_name] ~= nil then
						local var_684_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_2.prefab_name].transform, "story_v_out_426051", "426051167", "story_v_out_426051.awb")

						arg_681_1:RecordAudio("426051167", var_684_7)
						arg_681_1:RecordAudio("426051167", var_684_7)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_out_426051", "426051167", "story_v_out_426051.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_out_426051", "426051167", "story_v_out_426051.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_8 = math.max(var_684_1, arg_681_1.talkMaxDuration)

			if var_684_0 <= arg_681_1.time_ and arg_681_1.time_ < var_684_0 + var_684_8 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_0) / var_684_8

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_0 + var_684_8 and arg_681_1.time_ < var_684_0 + var_684_8 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play426051168 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 426051168
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play426051169(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0.725

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, true)
				arg_685_1.iconController_:SetSelectedState("hero")

				arg_685_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_685_1.callingController_:SetSelectedState("normal")

				arg_685_1.keyicon_.color = Color.New(1, 1, 1)
				arg_685_1.icon_.color = Color.New(1, 1, 1)

				local var_688_1 = arg_685_1:FormatText(arg_685_1:GetWordFromCfg(426051168).content)

				arg_685_1.text_.text = var_688_1

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_3 = 29 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 29)

				if (29 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_1) / 29)) > 0 and var_688_0 < var_688_3 then
					arg_685_1.talkMaxDuration = var_688_3

					if var_688_3 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_3 + 0
					end
				end

				arg_685_1.text_.text = var_688_1
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_4 = math.max(var_688_0, arg_685_1.talkMaxDuration)

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_4 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - 0) / var_688_4

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= 0 + var_688_4 and arg_685_1.time_ < 0 + var_688_4 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play426051169 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 426051169
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play426051170(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = 1.125

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_1 = arg_689_1:FormatText(arg_689_1:GetWordFromCfg(426051169).content)

				arg_689_1.text_.text = var_692_1

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_3 = 45 <= 0 and var_692_0 or var_692_0 * (utf8.len(var_692_1) / 45)

				if (45 <= 0 and var_692_0 or var_692_0 * (utf8.len(var_692_1) / 45)) > 0 and var_692_0 < var_692_3 then
					arg_689_1.talkMaxDuration = var_692_3

					if var_692_3 + 0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_3 + 0
					end
				end

				arg_689_1.text_.text = var_692_1
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_4 = math.max(var_692_0, arg_689_1.talkMaxDuration)

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_4 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - 0) / var_692_4

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= 0 + var_692_4 and arg_689_1.time_ < 0 + var_692_4 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play426051170 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 426051170
		arg_693_1.duration_ = 8.07

		local var_693_0 = {
			zh = 4.833,
			ja = 8.066
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play426051171(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012actionlink/1012action442")
			end

			local var_696_0 = 0
			local var_696_1 = 0.525

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_0 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_2 = arg_693_1:GetWordFromCfg(426051170)
				local var_696_3 = arg_693_1:FormatText(var_696_2.content)

				arg_693_1.text_.text = var_696_3

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_5 = 21 <= 0 and var_696_1 or var_696_1 * (utf8.len(var_696_3) / 21)

				if (21 <= 0 and var_696_1 or var_696_1 * (utf8.len(var_696_3) / 21)) > 0 and var_696_1 < var_696_5 then
					arg_693_1.talkMaxDuration = var_696_5

					if var_696_5 + var_696_0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_5 + var_696_0
					end
				end

				arg_693_1.text_.text = var_696_3
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_426051", "426051170", "story_v_out_426051.awb") ~= 0 then
					local var_696_6 = manager.audio:GetVoiceLength("story_v_out_426051", "426051170", "story_v_out_426051.awb") / 1000

					if var_696_6 + var_696_0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_6 + var_696_0
					end

					if var_696_2.prefab_name ~= "" and arg_693_1.actors_[var_696_2.prefab_name] ~= nil then
						local var_696_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_2.prefab_name].transform, "story_v_out_426051", "426051170", "story_v_out_426051.awb")

						arg_693_1:RecordAudio("426051170", var_696_7)
						arg_693_1:RecordAudio("426051170", var_696_7)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_out_426051", "426051170", "story_v_out_426051.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_out_426051", "426051170", "story_v_out_426051.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_8 = math.max(var_696_1, arg_693_1.talkMaxDuration)

			if var_696_0 <= arg_693_1.time_ and arg_693_1.time_ < var_696_0 + var_696_8 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_0) / var_696_8

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_0 + var_696_8 and arg_693_1.time_ < var_696_0 + var_696_8 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play426051171 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 426051171
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play426051172(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1.var_.moveOldPos1012ui_story = arg_697_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_700_0 = 0.001

			if 0 <= arg_697_1.time_ and arg_697_1.time_ < 0 + var_700_0 then
				arg_697_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_697_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_697_1.time_ - 0) / var_700_0)
				arg_697_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_697_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_697_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_697_1.actors_["1012ui_story"].transform.position).z)
				arg_697_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_697_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_697_1.actors_["1012ui_story"].transform.localEulerAngles = arg_697_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_697_1.time_ >= 0 + var_700_0 and arg_697_1.time_ < 0 + var_700_0 + arg_700_0 then
				arg_697_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_697_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_697_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_697_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_697_1.actors_["1012ui_story"].transform.position).z)
				arg_697_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_697_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_697_1.actors_["1012ui_story"].transform.localEulerAngles = arg_697_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0.034000001847744 < arg_697_1.time_ and arg_697_1.time_ <= 0.034000001847744 + arg_700_0 then
				arg_697_1:AudioAction("play", "effect", "se_story_131", "se_story_131__fallmetal", "")
			end

			if 0.533333333333333 < arg_697_1.time_ and arg_697_1.time_ <= 0.533333333333333 + arg_700_0 then
				arg_697_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 then
				arg_697_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_700_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_697_1.bgmTxt_.text ~= var_700_5 and arg_697_1.bgmTxt_.text ~= "" then
						if arg_697_1.bgmTxt2_.text ~= "" then
							arg_697_1.bgmTxt_.text = arg_697_1.bgmTxt2_.text
						end

						arg_697_1.bgmTxt2_.text = var_700_5

						arg_697_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_697_1.bgmTxt_.text = var_700_5
						arg_697_1.bgmTxt2_.text = var_700_5
					end

					if arg_697_1.bgmTimer then
						arg_697_1.bgmTimer:Stop()

						arg_697_1.bgmTimer = nil
					end

					if arg_697_1.settingData.show_music_name == 1 then
						arg_697_1.musicController:SetSelectedState("show")
						arg_697_1.musicAnimator_:Play("open", 0, 0)

						if arg_697_1.settingData.music_time ~= 0 then
							arg_697_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_697_1.settingData.music_time), function()
								if arg_697_1 == nil or isNil(arg_697_1.bgmTxt_) then
									return
								end

								arg_697_1.musicController:SetSelectedState("hide")
								arg_697_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_700_6 = 0
			local var_700_7 = 1.125

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= var_700_6 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, false)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_8 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(426051171).content)

				arg_697_1.text_.text = var_700_8

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_10 = 45 <= 0 and var_700_7 or var_700_7 * (utf8.len(var_700_8) / 45)

				if (45 <= 0 and var_700_7 or var_700_7 * (utf8.len(var_700_8) / 45)) > 0 and var_700_7 < var_700_10 then
					arg_697_1.talkMaxDuration = var_700_10

					if var_700_10 + var_700_6 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_10 + var_700_6
					end
				end

				arg_697_1.text_.text = var_700_8
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_11 = math.max(var_700_7, arg_697_1.talkMaxDuration)

			if var_700_6 <= arg_697_1.time_ and arg_697_1.time_ < var_700_6 + var_700_11 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_6) / var_700_11

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_6 + var_700_11 and arg_697_1.time_ < var_700_6 + var_700_11 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {
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

		arg_697_1:InitPlayNodeList()
	end,
	Play426051172 = function(arg_702_0, arg_702_1)
		arg_702_1.time_ = 0
		arg_702_1.frameCnt_ = 0
		arg_702_1.state_ = "playing"
		arg_702_1.curTalkId_ = 426051172
		arg_702_1.duration_ = 6.5

		SetActive(arg_702_1.tipsGo_, false)

		function arg_702_1.onSingleLineFinish_()
			arg_702_1.onSingleLineUpdate_ = nil
			arg_702_1.onSingleLineFinish_ = nil
			arg_702_1.state_ = "waiting"
		end

		function arg_702_1.playNext_(arg_704_0)
			if arg_704_0 == 1 then
				arg_702_0:Play426051173(arg_702_1)
			end
		end

		function arg_702_1.onSingleLineUpdate_(arg_705_0)
			local var_705_9000

			if 0.9 < arg_702_1.time_ and arg_702_1.time_ <= 0.9 + arg_705_0 then
				local var_705_0 = arg_702_1.bgs_.ST2007a

				arg_702_1.bgs_.ST2007a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_705_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_705_1 = var_705_0:GetComponent("SpriteRenderer")

				if var_705_1 and var_705_1.sprite then
					local var_705_2 = 2 * (var_705_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_705_0.transform.localScale = Vector3.New(var_705_2 / var_705_1.sprite.bounds.size.y < var_705_2 * manager.ui.mainCameraCom_.aspect / var_705_1.sprite.bounds.size.x and var_705_2 * manager.ui.mainCameraCom_.aspect / var_705_1.sprite.bounds.size.x or var_705_2 / var_705_1.sprite.bounds.size.y, var_705_2 / var_705_1.sprite.bounds.size.y < var_705_2 * manager.ui.mainCameraCom_.aspect / var_705_1.sprite.bounds.size.x and var_705_2 * manager.ui.mainCameraCom_.aspect / var_705_1.sprite.bounds.size.x or var_705_2 / var_705_1.sprite.bounds.size.y, 0)
				end

				for iter_705_0, iter_705_1 in pairs(arg_702_1.bgs_) do
					if iter_705_0 ~= "ST2007a" then
						iter_705_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_705_3 = 1.5

			if 1.5 < arg_702_1.time_ and arg_702_1.time_ <= var_705_3 + arg_705_0 then
				arg_702_1.allBtn_.enabled = false
			end

			if arg_702_1.time_ >= var_705_3 + 0.3 and arg_702_1.time_ < var_705_3 + 0.3 + arg_705_0 then
				arg_702_1.allBtn_.enabled = true
			end

			if 0.5 < arg_702_1.time_ and arg_702_1.time_ <= 0.5 + arg_705_0 then
				if arg_702_1.var_.effectkaideng1 then
					Object.Destroy(arg_702_1.var_.effectkaideng1)

					arg_702_1.var_.effectkaideng1 = nil
				end
			end

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= 0 + arg_705_0 then
				local var_705_5 = arg_702_1.var_.effectkaimen1

				if not arg_702_1.var_.effectkaimen1 then
					var_705_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_705_5.name = "kaimen1"
					arg_702_1.var_.effectkaimen1 = var_705_5
				else
					var_705_5.transform:SetParent(var_705_9000)
				end

				var_705_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_705_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_705_7 = 0

			if 0 < arg_702_1.time_ and arg_702_1.time_ <= var_705_7 + arg_705_0 then
				arg_702_1.allBtn_.enabled = false
			end

			if arg_702_1.time_ >= var_705_7 + 1.5 and arg_702_1.time_ < var_705_7 + 1.5 + arg_705_0 then
				arg_702_1.allBtn_.enabled = true
			end

			if arg_702_1.frameCnt_ <= 1 then
				arg_702_1.dialog_:SetActive(false)
			end

			local var_705_8 = 1.5
			local var_705_9 = 0.075

			if 1.5 < arg_702_1.time_ and arg_702_1.time_ <= var_705_8 + arg_705_0 then
				arg_702_1.talkMaxDuration = 0

				arg_702_1.dialog_:SetActive(true)

				arg_702_1.dialogCg_.alpha = 0

				local var_705_10 = LeanTween.value(arg_702_1.dialog_, 0, 1, 0.3)

				var_705_10:setOnUpdate(LuaHelper.FloatAction(function(arg_706_0)
					arg_702_1.dialogCg_.alpha = arg_706_0
				end))
				var_705_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_702_1.dialog_)
					var_705_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_702_1.duration_ = arg_702_1.duration_ + 0.3

				SetActive(arg_702_1.leftNameGo_, true)

				arg_702_1.leftNameTxt_.text = arg_702_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_702_1.leftNameTxt_.transform)

				arg_702_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_702_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_702_1:RecordName(arg_702_1.leftNameTxt_.text)
				SetActive(arg_702_1.iconTrs_.gameObject, true)
				arg_702_1.iconController_:SetSelectedState("hero")

				arg_702_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_702_1.callingController_:SetSelectedState("normal")

				arg_702_1.keyicon_.color = Color.New(1, 1, 1)
				arg_702_1.icon_.color = Color.New(1, 1, 1)

				local var_705_11 = arg_702_1:FormatText(arg_702_1:GetWordFromCfg(426051172).content)

				arg_702_1.text_.text = var_705_11

				LuaForUtil.ClearLinePrefixSymbol(arg_702_1.text_)

				local var_705_13 = 3 <= 0 and var_705_9 or var_705_9 * (utf8.len(var_705_11) / 3)

				if (3 <= 0 and var_705_9 or var_705_9 * (utf8.len(var_705_11) / 3)) > 0 and var_705_9 < var_705_13 then
					arg_702_1.talkMaxDuration = var_705_13
					var_705_8 = var_705_8 + 0.3

					if var_705_13 + var_705_8 > arg_702_1.duration_ then
						arg_702_1.duration_ = var_705_13 + var_705_8
					end
				end

				arg_702_1.text_.text = var_705_11
				arg_702_1.typewritter.percent = 0

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(false)
				arg_702_1:RecordContent(arg_702_1.text_.text)
			end

			local var_705_14 = var_705_8 + 0.3
			local var_705_15 = math.max(var_705_9, arg_702_1.talkMaxDuration)

			if var_705_8 + 0.3 <= arg_702_1.time_ and arg_702_1.time_ < var_705_14 + var_705_15 then
				arg_702_1.typewritter.percent = (arg_702_1.time_ - var_705_14) / var_705_15

				arg_702_1.typewritter:SetDirty()
			end

			if arg_702_1.time_ >= var_705_14 + var_705_15 and arg_702_1.time_ < var_705_14 + var_705_15 + arg_705_0 then
				arg_702_1.typewritter.percent = 1

				arg_702_1.typewritter:SetDirty()
				arg_702_1:ShowNextGo(true)
			end
		end

		arg_702_1.nodeConfigList_ = {}

		arg_702_1:InitPlayNodeList()
	end,
	Play426051173 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 426051173
		arg_708_1.duration_ = 5

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play426051174(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 1.275

			if 0 < arg_708_1.time_ and arg_708_1.time_ <= 0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, false)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_1 = arg_708_1:FormatText(arg_708_1:GetWordFromCfg(426051173).content)

				arg_708_1.text_.text = var_711_1

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_3 = 51 <= 0 and var_711_0 or var_711_0 * (utf8.len(var_711_1) / 51)

				if (51 <= 0 and var_711_0 or var_711_0 * (utf8.len(var_711_1) / 51)) > 0 and var_711_0 < var_711_3 then
					arg_708_1.talkMaxDuration = var_711_3

					if var_711_3 + 0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_3 + 0
					end
				end

				arg_708_1.text_.text = var_711_1
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)
				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_4 = math.max(var_711_0, arg_708_1.talkMaxDuration)

			if 0 <= arg_708_1.time_ and arg_708_1.time_ < 0 + var_711_4 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - 0) / var_711_4

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= 0 + var_711_4 and arg_708_1.time_ < 0 + var_711_4 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play426051174 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 426051174
		arg_712_1.duration_ = 5

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play426051175(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0.1

			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				arg_712_1.leftNameTxt_.text = arg_712_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, true)
				arg_712_1.iconController_:SetSelectedState("hero")

				arg_712_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_712_1.callingController_:SetSelectedState("normal")

				arg_712_1.keyicon_.color = Color.New(1, 1, 1)
				arg_712_1.icon_.color = Color.New(1, 1, 1)

				local var_715_1 = arg_712_1:FormatText(arg_712_1:GetWordFromCfg(426051174).content)

				arg_712_1.text_.text = var_715_1

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_3 = 4 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_1) / 4)

				if (4 <= 0 and var_715_0 or var_715_0 * (utf8.len(var_715_1) / 4)) > 0 and var_715_0 < var_715_3 then
					arg_712_1.talkMaxDuration = var_715_3

					if var_715_3 + 0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_3 + 0
					end
				end

				arg_712_1.text_.text = var_715_1
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)
				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_4 = math.max(var_715_0, arg_712_1.talkMaxDuration)

			if 0 <= arg_712_1.time_ and arg_712_1.time_ < 0 + var_715_4 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - 0) / var_715_4

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= 0 + var_715_4 and arg_712_1.time_ < 0 + var_715_4 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play426051175 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 426051175
		arg_716_1.duration_ = 5

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
			arg_716_1.auto_ = false
		end

		function arg_716_1.playNext_(arg_718_0)
			arg_716_1.onStoryFinished_()
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = 1.3

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, false)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_1 = arg_716_1:FormatText(arg_716_1:GetWordFromCfg(426051175).content)

				arg_716_1.text_.text = var_719_1

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_3 = 52 <= 0 and var_719_0 or var_719_0 * (utf8.len(var_719_1) / 52)

				if (52 <= 0 and var_719_0 or var_719_0 * (utf8.len(var_719_1) / 52)) > 0 and var_719_0 < var_719_3 then
					arg_716_1.talkMaxDuration = var_719_3

					if var_719_3 + 0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_3 + 0
					end
				end

				arg_716_1.text_.text = var_719_1
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)
				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_4 = math.max(var_719_0, arg_716_1.talkMaxDuration)

			if 0 <= arg_716_1.time_ and arg_716_1.time_ < 0 + var_719_4 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - 0) / var_719_4

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= 0 + var_719_4 and arg_716_1.time_ < 0 + var_719_4 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2007a",
		"TextureConfig/Background/ST2012"
	},
	voices = {
		"story_v_out_426051.awb"
	}
}
