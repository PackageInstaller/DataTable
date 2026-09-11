return {
	Play1102003001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102003001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102003002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0505 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0505")
				var_4_0.name = "ST0505"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0505 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0505

				arg_1_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0505" then
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

			local var_4_9 = arg_1_1.actors_.ui_story

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_10 and arg_1_1.time_ < 2 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story then
				arg_1_1.var_.characterEffectui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			if 0.125 < arg_1_1.time_ and arg_1_1.time_ <= 0.125 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1102003001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 5 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 5)

				if (5 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 5)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1102003002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102003002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102003003(arg_9_1)
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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1102003002).content)

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
	Play1102003003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102003003
		arg_13_1.duration_ = 6.9

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102003004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1020ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1020ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1020ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1020ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1020ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1020ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1020ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1020ui_story == nil then
				arg_13_1.var_.characterEffect1020ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1020ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1020ui_story then
				arg_13_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(1102003003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 23 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 23)

				if (23 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 23)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003003", "story_v_side_new_1102003.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003003", "story_v_side_new_1102003.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_side_new_1102003", "1102003003", "story_v_side_new_1102003.awb")

						arg_13_1:RecordAudio("1102003003", var_16_15)
						arg_13_1:RecordAudio("1102003003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003003", "story_v_side_new_1102003.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003003", "story_v_side_new_1102003.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102003004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1102003005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1020ui_story"]) and arg_17_1.var_.characterEffect1020ui_story == nil then
				arg_17_1.var_.characterEffect1020ui_story = arg_17_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1020ui_story"]) then
				if arg_17_1.var_.characterEffect1020ui_story and not isNil(arg_17_1.actors_["1020ui_story"]) then
					arg_17_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1020ui_story"]) and arg_17_1.var_.characterEffect1020ui_story then
				arg_17_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.8

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(1102003004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 32 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 32)

				if (32 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 32)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1102003005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102003005
		arg_21_1.duration_ = 6

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1102003006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1020ui_story"]) and arg_21_1.var_.characterEffect1020ui_story == nil then
				arg_21_1.var_.characterEffect1020ui_story = arg_21_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1020ui_story"]) then
				if arg_21_1.var_.characterEffect1020ui_story and not isNil(arg_21_1.actors_["1020ui_story"]) then
					arg_21_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1020ui_story"]) and arg_21_1.var_.characterEffect1020ui_story then
				arg_21_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_24_2 = 0
			local var_24_3 = 0.55

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(1102003005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 22 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 22)

				if (22 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 22)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003005", "story_v_side_new_1102003.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003005", "story_v_side_new_1102003.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_side_new_1102003", "1102003005", "story_v_side_new_1102003.awb")

						arg_21_1:RecordAudio("1102003005", var_24_9)
						arg_21_1:RecordAudio("1102003005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003005", "story_v_side_new_1102003.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003005", "story_v_side_new_1102003.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1102003006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102003006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1102003007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1020ui_story = arg_25_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1020ui_story"].transform.position).z)
				arg_25_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1020ui_story"].transform.localEulerAngles = arg_25_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1020ui_story"].transform.position).z)
				arg_25_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1020ui_story"].transform.localEulerAngles = arg_25_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1020ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1020ui_story == nil then
				arg_25_1.var_.characterEffect1020ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1020ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1020ui_story then
				arg_25_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 0.95

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1102003006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 38 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 38)

				if (38 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 38)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1102003007
		arg_29_1.duration_ = 3.37

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1102003008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1020ui_story = arg_29_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1020ui_story"].transform.position).z)
				arg_29_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1020ui_story"].transform.localEulerAngles = arg_29_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_29_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1020ui_story"].transform.position).z)
				arg_29_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1020ui_story"].transform.localEulerAngles = arg_29_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1020ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1020ui_story == nil then
				arg_29_1.var_.characterEffect1020ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1020ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1020ui_story then
				arg_29_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(1102003007)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003007", "story_v_side_new_1102003.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003007", "story_v_side_new_1102003.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_side_new_1102003", "1102003007", "story_v_side_new_1102003.awb")

						arg_29_1:RecordAudio("1102003007", var_32_11)
						arg_29_1:RecordAudio("1102003007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003007", "story_v_side_new_1102003.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003007", "story_v_side_new_1102003.awb")
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
				actorName = "1020ui_story",
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
	Play1102003008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102003008
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"

			SetActive(arg_33_1.choicesGo_, true)

			for iter_34_0, iter_34_1 in ipairs(arg_33_1.choices_) do
				SetActive(iter_34_1.go, iter_34_0 <= 2)
			end

			arg_33_1.choices_[1].txt.text = arg_33_1:FormatText(StoryChoiceCfg[1194].name)
			arg_33_1.choices_[2].txt.text = arg_33_1:FormatText(StoryChoiceCfg[1195].name)
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102003009(arg_33_1)
			end

			if arg_35_0 == 2 then
				arg_33_0:Play1102003011(arg_33_1)
			end

			arg_33_1:RecordChoiceLog(1102003008, 1194, 1195)
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) and arg_33_1.var_.characterEffect1020ui_story == nil then
				arg_33_1.var_.characterEffect1020ui_story = arg_33_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) then
				if arg_33_1.var_.characterEffect1020ui_story and not isNil(arg_33_1.actors_["1020ui_story"]) then
					arg_33_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) and arg_33_1.var_.characterEffect1020ui_story then
				arg_33_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.allBtn_.enabled = false
			end

			if arg_33_1.time_ >= var_36_1 + 0.5 and arg_33_1.time_ < var_36_1 + 0.5 + arg_36_0 then
				arg_33_1.allBtn_.enabled = true
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1102003009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102003009
		arg_37_1.duration_ = 3.9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1102003010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) and arg_37_1.var_.characterEffect1020ui_story == nil then
				arg_37_1.var_.characterEffect1020ui_story = arg_37_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) then
				if arg_37_1.var_.characterEffect1020ui_story and not isNil(arg_37_1.actors_["1020ui_story"]) then
					arg_37_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) and arg_37_1.var_.characterEffect1020ui_story then
				arg_37_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_2 = 0
			local var_40_3 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(1102003009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 19 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 19)

				if (19 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 19)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003009", "story_v_side_new_1102003.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003009", "story_v_side_new_1102003.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_side_new_1102003", "1102003009", "story_v_side_new_1102003.awb")

						arg_37_1:RecordAudio("1102003009", var_40_9)
						arg_37_1:RecordAudio("1102003009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003009", "story_v_side_new_1102003.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003009", "story_v_side_new_1102003.awb")
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
	Play1102003010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102003010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1102003012(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) and arg_41_1.var_.characterEffect1020ui_story == nil then
				arg_41_1.var_.characterEffect1020ui_story = arg_41_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) then
				if arg_41_1.var_.characterEffect1020ui_story and not isNil(arg_41_1.actors_["1020ui_story"]) then
					arg_41_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) and arg_41_1.var_.characterEffect1020ui_story then
				arg_41_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.175

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

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1102003010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 7 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 7)

				if (7 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 7)) > 0 and var_44_2 < var_44_5 then
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
	Play1102003012 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1102003012
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1102003013(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.175

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

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1102003012).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 7 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 7)

				if (7 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 7)) > 0 and var_48_0 < var_48_3 then
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
	Play1102003013 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1102003013
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1102003014(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1020ui_story = arg_49_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1020ui_story"].transform.position).z)
				arg_49_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1020ui_story"].transform.localEulerAngles = arg_49_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1020ui_story"].transform.position).z)
				arg_49_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1020ui_story"].transform.localEulerAngles = arg_49_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_52_1 = 0
			local var_52_2 = 1.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(1102003013).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 47 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 47)

				if (47 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 47)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003014 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1102003014
		arg_53_1.duration_ = 4.67

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1102003015(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1020ui_story = arg_53_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1020ui_story"].transform.position).z)
				arg_53_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1020ui_story"].transform.localEulerAngles = arg_53_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_53_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1020ui_story"].transform.position).z)
				arg_53_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1020ui_story"].transform.localEulerAngles = arg_53_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1020ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1020ui_story == nil then
				arg_53_1.var_.characterEffect1020ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1020ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1020ui_story then
				arg_53_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.425

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1102003014)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 17 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 17)

				if (17 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 17)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003014", "story_v_side_new_1102003.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003014", "story_v_side_new_1102003.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1102003", "1102003014", "story_v_side_new_1102003.awb")

						arg_53_1:RecordAudio("1102003014", var_56_11)
						arg_53_1:RecordAudio("1102003014", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003014", "story_v_side_new_1102003.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003014", "story_v_side_new_1102003.awb")
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
				actorName = "1020ui_story",
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
	Play1102003015 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1102003015
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1102003016(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1020ui_story = arg_57_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1020ui_story"].transform.position).z)
				arg_57_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1020ui_story"].transform.localEulerAngles = arg_57_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1020ui_story"].transform.position).z)
				arg_57_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1020ui_story"].transform.localEulerAngles = arg_57_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1020ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1020ui_story == nil then
				arg_57_1.var_.characterEffect1020ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1020ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_2)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1020ui_story then
				arg_57_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_60_3 = 0
			local var_60_4 = 1.3

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(1102003015).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 52 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 52)

				if (52 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 52)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play1102003016 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1102003016
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1102003017(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1102003016).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 10 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 10)

				if (10 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 10)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1102003017 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1102003017
		arg_65_1.duration_ = 8.43

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1102003018(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1020ui_story = arg_65_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1020ui_story"].transform.position).z)
				arg_65_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1020ui_story"].transform.localEulerAngles = arg_65_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_65_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1020ui_story"].transform.position).z)
				arg_65_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1020ui_story"].transform.localEulerAngles = arg_65_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1020ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1020ui_story == nil then
				arg_65_1.var_.characterEffect1020ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1020ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1020ui_story then
				arg_65_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_68_4 = 0
			local var_68_5 = 0.775

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(1102003017)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 31 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 31)

				if (31 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 31)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003017", "story_v_side_new_1102003.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003017", "story_v_side_new_1102003.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_new_1102003", "1102003017", "story_v_side_new_1102003.awb")

						arg_65_1:RecordAudio("1102003017", var_68_11)
						arg_65_1:RecordAudio("1102003017", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003017", "story_v_side_new_1102003.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003017", "story_v_side_new_1102003.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play1102003018 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1102003018
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1102003019(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) and arg_69_1.var_.characterEffect1020ui_story == nil then
				arg_69_1.var_.characterEffect1020ui_story = arg_69_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) then
				if arg_69_1.var_.characterEffect1020ui_story and not isNil(arg_69_1.actors_["1020ui_story"]) then
					arg_69_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) and arg_69_1.var_.characterEffect1020ui_story then
				arg_69_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1102003018).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 17 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 17)

				if (17 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 17)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1102003019 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1102003019
		arg_73_1.duration_ = 3.1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1102003020(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1020ui_story"]) and arg_73_1.var_.characterEffect1020ui_story == nil then
				arg_73_1.var_.characterEffect1020ui_story = arg_73_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1020ui_story"]) then
				if arg_73_1.var_.characterEffect1020ui_story and not isNil(arg_73_1.actors_["1020ui_story"]) then
					arg_73_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1020ui_story"]) and arg_73_1.var_.characterEffect1020ui_story then
				arg_73_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_76_2 = 0
			local var_76_3 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(1102003019)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)

				if (12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003019", "story_v_side_new_1102003.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003019", "story_v_side_new_1102003.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_side_new_1102003", "1102003019", "story_v_side_new_1102003.awb")

						arg_73_1:RecordAudio("1102003019", var_76_9)
						arg_73_1:RecordAudio("1102003019", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003019", "story_v_side_new_1102003.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003019", "story_v_side_new_1102003.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1102003020 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1102003020
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1102003021(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1020ui_story = arg_77_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1020ui_story"].transform.position).z)
				arg_77_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1020ui_story"].transform.localEulerAngles = arg_77_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1020ui_story"].transform.position).z)
				arg_77_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1020ui_story"].transform.localEulerAngles = arg_77_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1020ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1020ui_story == nil then
				arg_77_1.var_.characterEffect1020ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1020ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_2)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1020ui_story then
				arg_77_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_80_3 = 0
			local var_80_4 = 0.95

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1102003020).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 38 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 38)

				if (38 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 38)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003021 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1102003021
		arg_81_1.duration_ = 8.93

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1102003022(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1020ui_story = arg_81_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1020ui_story"].transform.position).z)
				arg_81_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1020ui_story"].transform.localEulerAngles = arg_81_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_81_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1020ui_story"].transform.position).z)
				arg_81_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1020ui_story"].transform.localEulerAngles = arg_81_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1020ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1020ui_story == nil then
				arg_81_1.var_.characterEffect1020ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1020ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1020ui_story then
				arg_81_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_84_4 = 0
			local var_84_5 = 1.075

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(1102003021)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 43 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 43)

				if (43 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 43)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003021", "story_v_side_new_1102003.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003021", "story_v_side_new_1102003.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_side_new_1102003", "1102003021", "story_v_side_new_1102003.awb")

						arg_81_1:RecordAudio("1102003021", var_84_11)
						arg_81_1:RecordAudio("1102003021", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003021", "story_v_side_new_1102003.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003021", "story_v_side_new_1102003.awb")
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

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play1102003022 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1102003022
		arg_85_1.duration_ = 10.9

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1102003023(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 1.275

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(1102003022)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 51 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 51)

				if (51 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 51)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003022", "story_v_side_new_1102003.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003022", "story_v_side_new_1102003.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_side_new_1102003", "1102003022", "story_v_side_new_1102003.awb")

						arg_85_1:RecordAudio("1102003022", var_88_6)
						arg_85_1:RecordAudio("1102003022", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003022", "story_v_side_new_1102003.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003022", "story_v_side_new_1102003.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1102003023 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1102003023
		arg_89_1.duration_ = 13.07

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1102003024(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_92_0 = 0
			local var_92_1 = 1.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(1102003023)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 59 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 59)

				if (59 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 59)) > 0 and var_92_1 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003023", "story_v_side_new_1102003.awb") ~= 0 then
					local var_92_6 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003023", "story_v_side_new_1102003.awb") / 1000

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end

					if var_92_2.prefab_name ~= "" and arg_89_1.actors_[var_92_2.prefab_name] ~= nil then
						local var_92_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_2.prefab_name].transform, "story_v_side_new_1102003", "1102003023", "story_v_side_new_1102003.awb")

						arg_89_1:RecordAudio("1102003023", var_92_7)
						arg_89_1:RecordAudio("1102003023", var_92_7)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003023", "story_v_side_new_1102003.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003023", "story_v_side_new_1102003.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1102003024 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1102003024
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1102003025(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1020ui_story"]) and arg_93_1.var_.characterEffect1020ui_story == nil then
				arg_93_1.var_.characterEffect1020ui_story = arg_93_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1020ui_story"]) then
				if arg_93_1.var_.characterEffect1020ui_story and not isNil(arg_93_1.actors_["1020ui_story"]) then
					arg_93_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1020ui_story"]) and arg_93_1.var_.characterEffect1020ui_story then
				arg_93_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.7

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
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

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1102003024).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 28 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 28)

				if (28 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 28)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1102003025 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1102003025
		arg_97_1.duration_ = 8.73

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1102003026(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1020ui_story"]) and arg_97_1.var_.characterEffect1020ui_story == nil then
				arg_97_1.var_.characterEffect1020ui_story = arg_97_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1020ui_story"]) then
				if arg_97_1.var_.characterEffect1020ui_story and not isNil(arg_97_1.actors_["1020ui_story"]) then
					arg_97_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1020ui_story"]) and arg_97_1.var_.characterEffect1020ui_story then
				arg_97_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_100_2 = 0
			local var_100_3 = 0.875

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(1102003025)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 35 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 35)

				if (35 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 35)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003025", "story_v_side_new_1102003.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003025", "story_v_side_new_1102003.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_side_new_1102003", "1102003025", "story_v_side_new_1102003.awb")

						arg_97_1:RecordAudio("1102003025", var_100_9)
						arg_97_1:RecordAudio("1102003025", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003025", "story_v_side_new_1102003.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003025", "story_v_side_new_1102003.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_10 and arg_97_1.time_ < var_100_2 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1102003026 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1102003026
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1102003027(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1020ui_story"]) and arg_101_1.var_.characterEffect1020ui_story == nil then
				arg_101_1.var_.characterEffect1020ui_story = arg_101_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1020ui_story"]) then
				if arg_101_1.var_.characterEffect1020ui_story and not isNil(arg_101_1.actors_["1020ui_story"]) then
					arg_101_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1020ui_story"]) and arg_101_1.var_.characterEffect1020ui_story then
				arg_101_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.55

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1102003026).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 22 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 22)

				if (22 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 22)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1102003027 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1102003027
		arg_105_1.duration_ = 2

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1102003028(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1020ui_story"]) and arg_105_1.var_.characterEffect1020ui_story == nil then
				arg_105_1.var_.characterEffect1020ui_story = arg_105_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1020ui_story"]) then
				if arg_105_1.var_.characterEffect1020ui_story and not isNil(arg_105_1.actors_["1020ui_story"]) then
					arg_105_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1020ui_story"]) and arg_105_1.var_.characterEffect1020ui_story then
				arg_105_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_2 = 0
			local var_108_3 = 0.1

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(1102003027)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 4 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 4)

				if (4 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 4)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003027", "story_v_side_new_1102003.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003027", "story_v_side_new_1102003.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_side_new_1102003", "1102003027", "story_v_side_new_1102003.awb")

						arg_105_1:RecordAudio("1102003027", var_108_9)
						arg_105_1:RecordAudio("1102003027", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003027", "story_v_side_new_1102003.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003027", "story_v_side_new_1102003.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1102003028 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1102003028
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1102003029(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1020ui_story"]) and arg_109_1.var_.characterEffect1020ui_story == nil then
				arg_109_1.var_.characterEffect1020ui_story = arg_109_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1020ui_story"]) then
				if arg_109_1.var_.characterEffect1020ui_story and not isNil(arg_109_1.actors_["1020ui_story"]) then
					arg_109_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1020ui_story"]) and arg_109_1.var_.characterEffect1020ui_story then
				arg_109_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1102003028).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 4 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 4)

				if (4 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 4)) > 0 and var_112_2 < var_112_5 then
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

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1102003029 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1102003029
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1102003030(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.125

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1102003029).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 45 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 45)

				if (45 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 45)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1102003030 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1102003030
		arg_117_1.duration_ = 5.1

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1102003031(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1020ui_story"]) and arg_117_1.var_.characterEffect1020ui_story == nil then
				arg_117_1.var_.characterEffect1020ui_story = arg_117_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1020ui_story"]) then
				if arg_117_1.var_.characterEffect1020ui_story and not isNil(arg_117_1.actors_["1020ui_story"]) then
					arg_117_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1020ui_story"]) and arg_117_1.var_.characterEffect1020ui_story then
				arg_117_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_120_2 = 0
			local var_120_3 = 0.2

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(1102003030)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 8 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 8)

				if (8 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 8)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003030", "story_v_side_new_1102003.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003030", "story_v_side_new_1102003.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_side_new_1102003", "1102003030", "story_v_side_new_1102003.awb")

						arg_117_1:RecordAudio("1102003030", var_120_9)
						arg_117_1:RecordAudio("1102003030", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003030", "story_v_side_new_1102003.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003030", "story_v_side_new_1102003.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1102003031 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1102003031
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1102003032(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1020ui_story = arg_121_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1020ui_story"].transform.position).z)
				arg_121_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1020ui_story"].transform.localEulerAngles = arg_121_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1020ui_story"].transform.position).z)
				arg_121_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1020ui_story"].transform.localEulerAngles = arg_121_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1020ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1020ui_story == nil then
				arg_121_1.var_.characterEffect1020ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1020ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1020ui_story then
				arg_121_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_124_3 = 0
			local var_124_4 = 0.85

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_3 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1102003031).content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 34 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 34)

				if (34 <= 0 and var_124_4 or var_124_4 * (utf8.len(var_124_5) / 34)) > 0 and var_124_4 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_3 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_3
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_4, arg_121_1.talkMaxDuration)

			if var_124_3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_3 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_3) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_3 + var_124_8 and arg_121_1.time_ < var_124_3 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003032 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1102003032
		arg_125_1.duration_ = 11.47

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1102003033(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_0 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				local var_128_1 = Color.New(0, 0, 0)

				var_128_1.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.mask_.color = var_128_1
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				local var_128_2 = Color.New(0, 0, 0)

				var_128_2.a = 1
				arg_125_1.mask_.color = var_128_2
			end

			local var_128_3 = 2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_4 = 2

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_4 then
				local var_128_5 = Color.New(0, 0, 0)

				var_128_5.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_3) / var_128_4)
				arg_125_1.mask_.color = var_128_5
			end

			if arg_125_1.time_ >= var_128_3 + var_128_4 and arg_125_1.time_ < var_128_3 + var_128_4 + arg_128_0 then
				local var_128_6 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_6.a = 0
				arg_125_1.mask_.color = var_128_6
			end

			local var_128_7 = 2

			arg_125_1.isInRecall_ = false

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.screenFilterGo_:SetActive(true)

				arg_125_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_128_0, iter_128_1 in pairs(arg_125_1.actors_) do
					for iter_128_2, iter_128_3 in ipairs((iter_128_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_128_3.color = iter_128_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_128_8 = 0.1

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 then
				arg_125_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_125_1.time_ - var_128_7) / var_128_8)
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 then
				arg_125_1.screenFilterEffect_.weight = 1
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_9 = 3.6
			local var_128_10 = 0.9

			if 3.6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_11 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_11:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_125_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_128_12 = arg_125_1:GetWordFromCfg(1102003032)
				local var_128_13 = arg_125_1:FormatText(var_128_12.content)

				arg_125_1.text_.text = var_128_13

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_15 = 36 <= 0 and var_128_10 or var_128_10 * (utf8.len(var_128_13) / 36)

				if (36 <= 0 and var_128_10 or var_128_10 * (utf8.len(var_128_13) / 36)) > 0 and var_128_10 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15
					var_128_9 = var_128_9 + 0.3

					if var_128_15 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_9
					end
				end

				arg_125_1.text_.text = var_128_13
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003032", "story_v_side_new_1102003.awb") ~= 0 then
					local var_128_16 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003032", "story_v_side_new_1102003.awb") / 1000

					if var_128_16 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_9
					end

					if var_128_12.prefab_name ~= "" and arg_125_1.actors_[var_128_12.prefab_name] ~= nil then
						local var_128_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_12.prefab_name].transform, "story_v_side_new_1102003", "1102003032", "story_v_side_new_1102003.awb")

						arg_125_1:RecordAudio("1102003032", var_128_17)
						arg_125_1:RecordAudio("1102003032", var_128_17)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003032", "story_v_side_new_1102003.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003032", "story_v_side_new_1102003.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_18 = var_128_9 + 0.3
			local var_128_19 = math.max(var_128_10, arg_125_1.talkMaxDuration)

			if var_128_9 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_18 + var_128_19 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_18) / var_128_19

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_18 + var_128_19 and arg_125_1.time_ < var_128_18 + var_128_19 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1102003033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1102003033
		arg_131_1.duration_ = 8.9

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1102003034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_134_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_131_1.stage_.transform)

				var_134_0.name = "1089ui_story"
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1089ui_story"] = var_134_0

				local var_134_1 = var_134_0:GetComponentInChildren(typeof(CharacterEffect))

				var_134_1.enabled = true

				local var_134_2 = GameObjectTools.GetOrAddComponent(var_134_0, typeof(DynamicBoneHelper))

				if var_134_2 then
					var_134_2:EnableDynamicBone(false)
				end

				arg_131_1:ShowWeapon(var_134_1.transform, false)

				arg_131_1.var_["1089ui_story" .. "Animator"] = var_134_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_131_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_131_1.var_["1089ui_story" .. "LipSync"] = var_134_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_134_3 = arg_131_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_131_1.time_ and arg_131_1.time_ <= 1.96599999815226 + arg_134_0 then
				arg_131_1.var_.moveOldPos1089ui_story = var_134_3.localPosition
			end

			local var_134_4 = 0.001

			if 1.96599999815226 <= arg_131_1.time_ and arg_131_1.time_ < 1.96599999815226 + var_134_4 then
				var_134_3.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 1.96599999815226) / var_134_4)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if arg_131_1.time_ >= 1.96599999815226 + var_134_4 and arg_131_1.time_ < 1.96599999815226 + var_134_4 + arg_134_0 then
				var_134_3.localPosition = Vector3.New(0, 100, 0)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			local var_134_5 = arg_131_1.actors_["1089ui_story"]

			if 1.96599999815226 < arg_131_1.time_ and arg_131_1.time_ <= 1.96599999815226 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect1089ui_story == nil then
				arg_131_1.var_.characterEffect1089ui_story = var_134_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.034000001847744

			if 1.96599999815226 <= arg_131_1.time_ and arg_131_1.time_ < 1.96599999815226 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.characterEffect1089ui_story and not isNil(var_134_5) then
					arg_131_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 1.96599999815226) / var_134_6)
				end
			end

			if arg_131_1.time_ >= 1.96599999815226 + var_134_6 and arg_131_1.time_ < 1.96599999815226 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect1089ui_story then
				arg_131_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_134_7 = 0

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_8 = 2

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_8 then
				local var_134_9 = Color.New(0, 0, 0)

				var_134_9.a = Mathf.Lerp(0, 1, (arg_131_1.time_ - var_134_7) / var_134_8)
				arg_131_1.mask_.color = var_134_9
			end

			if arg_131_1.time_ >= var_134_7 + var_134_8 and arg_131_1.time_ < var_134_7 + var_134_8 + arg_134_0 then
				local var_134_10 = Color.New(0, 0, 0)

				var_134_10.a = 1
				arg_131_1.mask_.color = var_134_10
			end

			local var_134_11 = 2

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_12 = 2

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_12 then
				local var_134_13 = Color.New(0, 0, 0)

				var_134_13.a = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_11) / var_134_12)
				arg_131_1.mask_.color = var_134_13
			end

			if arg_131_1.time_ >= var_134_11 + var_134_12 and arg_131_1.time_ < var_134_11 + var_134_12 + arg_134_0 then
				local var_134_14 = Color.New(0, 0, 0)

				arg_131_1.mask_.enabled = false
				var_134_14.a = 0
				arg_131_1.mask_.color = var_134_14
			end

			local var_134_15 = 2

			arg_131_1.isInRecall_ = false

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.screenFilterGo_:SetActive(false)

				for iter_134_0, iter_134_1 in pairs(arg_131_1.actors_) do
					for iter_134_2, iter_134_3 in ipairs((iter_134_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_134_3.color = iter_134_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_134_16 = 0.1

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_16 then
				arg_131_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_15) / var_134_16)
			end

			if arg_131_1.time_ >= var_134_15 + var_134_16 and arg_131_1.time_ < var_134_15 + var_134_16 + arg_134_0 then
				arg_131_1.screenFilterEffect_.weight = 0
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_17 = 3.9
			local var_134_18 = 1.125

			if 3.9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_17 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_19 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_19:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_20 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1102003033).content)

				arg_131_1.text_.text = var_134_20

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_22 = 45 <= 0 and var_134_18 or var_134_18 * (utf8.len(var_134_20) / 45)

				if (45 <= 0 and var_134_18 or var_134_18 * (utf8.len(var_134_20) / 45)) > 0 and var_134_18 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22
					var_134_17 = var_134_17 + 0.3

					if var_134_22 + var_134_17 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_17
					end
				end

				arg_131_1.text_.text = var_134_20
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_23 = var_134_17 + 0.3
			local var_134_24 = math.max(var_134_18, arg_131_1.talkMaxDuration)

			if var_134_17 + 0.3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_23 + var_134_24 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_23) / var_134_24

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_23 + var_134_24 and arg_131_1.time_ < var_134_23 + var_134_24 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play1102003034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1102003034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1102003035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.075

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_1 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1102003034).content)

				arg_137_1.text_.text = var_140_1

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_3 = 43 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 43)

				if (43 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_1) / 43)) > 0 and var_140_0 < var_140_3 then
					arg_137_1.talkMaxDuration = var_140_3

					if var_140_3 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_3 + 0
					end
				end

				arg_137_1.text_.text = var_140_1
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_4 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_4

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1102003035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1102003035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1102003036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_1 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1102003035).content)

				arg_141_1.text_.text = var_144_1

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_3 = 14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 14)

				if (14 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_1) / 14)) > 0 and var_144_0 < var_144_3 then
					arg_141_1.talkMaxDuration = var_144_3

					if var_144_3 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_3 + 0
					end
				end

				arg_141_1.text_.text = var_144_1
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_4 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_4

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1102003036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1102003036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1102003037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 1.275

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1102003036).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 51 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 51)

				if (51 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 51)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1102003037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1102003037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1102003038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.75

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(1102003037).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 30 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 30)

				if (30 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 30)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1102003038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1102003038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1102003039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.075

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1102003038).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 43 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 43)

				if (43 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 43)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1102003039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1102003039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1102003040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.275

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1102003039).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 11 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 11)

				if (11 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 11)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1102003040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1102003040
		arg_161_1.duration_ = 4.63

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1102003041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1020ui_story = arg_161_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1020ui_story"].transform.position).z)
				arg_161_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1020ui_story"].transform.localEulerAngles = arg_161_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_161_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1020ui_story"].transform.position).z)
				arg_161_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1020ui_story"].transform.localEulerAngles = arg_161_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1020ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1020ui_story == nil then
				arg_161_1.var_.characterEffect1020ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1020ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1020ui_story then
				arg_161_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_164_4 = 0
			local var_164_5 = 0.45

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(1102003040)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 18 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 18)

				if (18 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 18)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003040", "story_v_side_new_1102003.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003040", "story_v_side_new_1102003.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_side_new_1102003", "1102003040", "story_v_side_new_1102003.awb")

						arg_161_1:RecordAudio("1102003040", var_164_11)
						arg_161_1:RecordAudio("1102003040", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003040", "story_v_side_new_1102003.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003040", "story_v_side_new_1102003.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play1102003041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1102003041
		arg_165_1.duration_ = 3.33

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1102003042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_168_0 = 0
			local var_168_1 = 0.4

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(1102003041)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 16 <= 0 and var_168_1 or var_168_1 * (utf8.len(var_168_3) / 16)

				if (16 <= 0 and var_168_1 or var_168_1 * (utf8.len(var_168_3) / 16)) > 0 and var_168_1 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003041", "story_v_side_new_1102003.awb") ~= 0 then
					local var_168_6 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003041", "story_v_side_new_1102003.awb") / 1000

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end

					if var_168_2.prefab_name ~= "" and arg_165_1.actors_[var_168_2.prefab_name] ~= nil then
						local var_168_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_2.prefab_name].transform, "story_v_side_new_1102003", "1102003041", "story_v_side_new_1102003.awb")

						arg_165_1:RecordAudio("1102003041", var_168_7)
						arg_165_1:RecordAudio("1102003041", var_168_7)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003041", "story_v_side_new_1102003.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003041", "story_v_side_new_1102003.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_8 and arg_165_1.time_ < var_168_0 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play1102003042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1102003042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1102003043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1020ui_story"]) and arg_169_1.var_.characterEffect1020ui_story == nil then
				arg_169_1.var_.characterEffect1020ui_story = arg_169_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1020ui_story"]) then
				if arg_169_1.var_.characterEffect1020ui_story and not isNil(arg_169_1.actors_["1020ui_story"]) then
					arg_169_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1020ui_story"]) and arg_169_1.var_.characterEffect1020ui_story then
				arg_169_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_172_1 = 0
			local var_172_2 = 0.975

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1102003042).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 39 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 39)

				if (39 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 39)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1102003043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1102003043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1102003044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.275

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1102003043).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 11 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 11)

				if (11 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 11)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1102003044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1102003044
		arg_177_1.duration_ = 3.83

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1102003045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1020ui_story"]) and arg_177_1.var_.characterEffect1020ui_story == nil then
				arg_177_1.var_.characterEffect1020ui_story = arg_177_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1020ui_story"]) then
				if arg_177_1.var_.characterEffect1020ui_story and not isNil(arg_177_1.actors_["1020ui_story"]) then
					arg_177_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1020ui_story"]) and arg_177_1.var_.characterEffect1020ui_story then
				arg_177_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_180_2 = 0
			local var_180_3 = 0.5

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:GetWordFromCfg(1102003044)
				local var_180_5 = arg_177_1:FormatText(var_180_4.content)

				arg_177_1.text_.text = var_180_5

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_7 = 20 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 20)

				if (20 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_5) / 20)) > 0 and var_180_3 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_5
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003044", "story_v_side_new_1102003.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003044", "story_v_side_new_1102003.awb") / 1000

					if var_180_8 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_2
					end

					if var_180_4.prefab_name ~= "" and arg_177_1.actors_[var_180_4.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_4.prefab_name].transform, "story_v_side_new_1102003", "1102003044", "story_v_side_new_1102003.awb")

						arg_177_1:RecordAudio("1102003044", var_180_9)
						arg_177_1:RecordAudio("1102003044", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003044", "story_v_side_new_1102003.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003044", "story_v_side_new_1102003.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_10 and arg_177_1.time_ < var_180_2 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1102003045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1102003045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1102003046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1020ui_story = arg_181_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1020ui_story"].transform.position).z)
				arg_181_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1020ui_story"].transform.localEulerAngles = arg_181_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1020ui_story"].transform.position).z)
				arg_181_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1020ui_story"].transform.localEulerAngles = arg_181_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1020ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1020ui_story == nil then
				arg_181_1.var_.characterEffect1020ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1020ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1020ui_story then
				arg_181_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_184_3 = 0
			local var_184_4 = 0.575

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_5 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1102003045).content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 23 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 23)

				if (23 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 23)) > 0 and var_184_4 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_3
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_4, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_3) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_8 and arg_181_1.time_ < var_184_3 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1102003046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1102003046
		arg_185_1.duration_ = 4.43

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1102003047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1020ui_story = arg_185_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1020ui_story"].transform.position).z)
				arg_185_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1020ui_story"].transform.localEulerAngles = arg_185_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_185_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1020ui_story"].transform.position).z)
				arg_185_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1020ui_story"].transform.localEulerAngles = arg_185_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1020ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1020ui_story == nil then
				arg_185_1.var_.characterEffect1020ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1020ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1020ui_story then
				arg_185_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_188_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_185_1.bgmTxt_.text ~= var_188_6 and arg_185_1.bgmTxt_.text ~= "" then
						if arg_185_1.bgmTxt2_.text ~= "" then
							arg_185_1.bgmTxt_.text = arg_185_1.bgmTxt2_.text
						end

						arg_185_1.bgmTxt2_.text = var_188_6

						arg_185_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_185_1.bgmTxt_.text = var_188_6
						arg_185_1.bgmTxt2_.text = var_188_6
					end

					if arg_185_1.bgmTimer then
						arg_185_1.bgmTimer:Stop()

						arg_185_1.bgmTimer = nil
					end

					if arg_185_1.settingData.show_music_name == 1 then
						arg_185_1.musicController:SetSelectedState("show")
						arg_185_1.musicAnimator_:Play("open", 0, 0)

						if arg_185_1.settingData.music_time ~= 0 then
							arg_185_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_185_1.settingData.music_time), function()
								if arg_185_1 == nil or isNil(arg_185_1.bgmTxt_) then
									return
								end

								arg_185_1.musicController:SetSelectedState("hide")
								arg_185_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_188_7 = 0
			local var_188_8 = 0.375

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_9 = arg_185_1:GetWordFromCfg(1102003046)
				local var_188_10 = arg_185_1:FormatText(var_188_9.content)

				arg_185_1.text_.text = var_188_10

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_12 = 15 <= 0 and var_188_8 or var_188_8 * (utf8.len(var_188_10) / 15)

				if (15 <= 0 and var_188_8 or var_188_8 * (utf8.len(var_188_10) / 15)) > 0 and var_188_8 < var_188_12 then
					arg_185_1.talkMaxDuration = var_188_12

					if var_188_12 + var_188_7 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_7
					end
				end

				arg_185_1.text_.text = var_188_10
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003046", "story_v_side_new_1102003.awb") ~= 0 then
					local var_188_13 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003046", "story_v_side_new_1102003.awb") / 1000

					if var_188_13 + var_188_7 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_7
					end

					if var_188_9.prefab_name ~= "" and arg_185_1.actors_[var_188_9.prefab_name] ~= nil then
						local var_188_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_9.prefab_name].transform, "story_v_side_new_1102003", "1102003046", "story_v_side_new_1102003.awb")

						arg_185_1:RecordAudio("1102003046", var_188_14)
						arg_185_1:RecordAudio("1102003046", var_188_14)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003046", "story_v_side_new_1102003.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003046", "story_v_side_new_1102003.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_15 = math.max(var_188_8, arg_185_1.talkMaxDuration)

			if var_188_7 <= arg_185_1.time_ and arg_185_1.time_ < var_188_7 + var_188_15 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_7) / var_188_15

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_7 + var_188_15 and arg_185_1.time_ < var_188_7 + var_188_15 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play1102003047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1102003047
		arg_190_1.duration_ = 9

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1102003048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if arg_190_1.bgs_.L01f == nil then
				local var_193_0 = Object.Instantiate(arg_190_1.paintGo_)

				var_193_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_193_0.name = "L01f"
				var_193_0.transform.parent = arg_190_1.stage_.transform
				var_193_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_190_1.bgs_.L01f = var_193_0
			end

			if 2 < arg_190_1.time_ and arg_190_1.time_ <= 2 + arg_193_0 then
				local var_193_1 = arg_190_1.bgs_.L01f

				arg_190_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_193_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_193_2 = var_193_1:GetComponent("SpriteRenderer")

				if var_193_2 and var_193_2.sprite then
					local var_193_3 = 2 * (var_193_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_193_1.transform.localScale = Vector3.New(var_193_3 / var_193_2.sprite.bounds.size.y < var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x and var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x or var_193_3 / var_193_2.sprite.bounds.size.y, var_193_3 / var_193_2.sprite.bounds.size.y < var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x and var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x or var_193_3 / var_193_2.sprite.bounds.size.y, 0)
				end

				for iter_193_0, iter_193_1 in pairs(arg_190_1.bgs_) do
					if iter_193_0 ~= "L01f" then
						iter_193_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_193_4 = 4

			if 4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			if arg_190_1.time_ >= var_193_4 + 0.3 and arg_190_1.time_ < var_193_4 + 0.3 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			local var_193_5 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_6 = 2

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 then
				local var_193_7 = Color.New(0, 0, 0)

				var_193_7.a = Mathf.Lerp(0, 1, (arg_190_1.time_ - var_193_5) / var_193_6)
				arg_190_1.mask_.color = var_193_7
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 then
				local var_193_8 = Color.New(0, 0, 0)

				var_193_8.a = 1
				arg_190_1.mask_.color = var_193_8
			end

			local var_193_9 = 2

			if 2 < arg_190_1.time_ and arg_190_1.time_ <= var_193_9 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_10 = 2

			if var_193_9 <= arg_190_1.time_ and arg_190_1.time_ < var_193_9 + var_193_10 then
				local var_193_11 = Color.New(0, 0, 0)

				var_193_11.a = Mathf.Lerp(1, 0, (arg_190_1.time_ - var_193_9) / var_193_10)
				arg_190_1.mask_.color = var_193_11
			end

			if arg_190_1.time_ >= var_193_9 + var_193_10 and arg_190_1.time_ < var_193_9 + var_193_10 + arg_193_0 then
				local var_193_12 = Color.New(0, 0, 0)

				arg_190_1.mask_.enabled = false
				var_193_12.a = 0
				arg_190_1.mask_.color = var_193_12
			end

			local var_193_13 = arg_190_1.actors_["1020ui_story"]

			if 1.98333333333333 < arg_190_1.time_ and arg_190_1.time_ <= 1.98333333333333 + arg_193_0 and not isNil(var_193_13) and arg_190_1.var_.characterEffect1020ui_story == nil then
				arg_190_1.var_.characterEffect1020ui_story = var_193_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_14 = 0.0166666666666666

			if 1.98333333333333 <= arg_190_1.time_ and arg_190_1.time_ < 1.98333333333333 + var_193_14 and not isNil(var_193_13) then
				if arg_190_1.var_.characterEffect1020ui_story and not isNil(var_193_13) then
					arg_190_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 1.98333333333333) / var_193_14)
				end
			end

			if arg_190_1.time_ >= 1.98333333333333 + var_193_14 and arg_190_1.time_ < 1.98333333333333 + var_193_14 + arg_193_0 and not isNil(var_193_13) and arg_190_1.var_.characterEffect1020ui_story then
				arg_190_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_193_15 = arg_190_1.actors_["1020ui_story"].transform

			if 1.966 < arg_190_1.time_ and arg_190_1.time_ <= 1.966 + arg_193_0 then
				arg_190_1.var_.moveOldPos1020ui_story = var_193_15.localPosition
			end

			local var_193_16 = 0.001

			if 1.966 <= arg_190_1.time_ and arg_190_1.time_ < 1.966 + var_193_16 then
				var_193_15.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_190_1.time_ - 1.966) / var_193_16)
				var_193_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_15.position).x, (manager.ui.mainCamera.transform.position - var_193_15.position).y, (manager.ui.mainCamera.transform.position - var_193_15.position).z)
				var_193_15.localEulerAngles.z = 0
				var_193_15.localEulerAngles.x = 0
				var_193_15.localEulerAngles = var_193_15.localEulerAngles
			end

			if arg_190_1.time_ >= 1.966 + var_193_16 and arg_190_1.time_ < 1.966 + var_193_16 + arg_193_0 then
				var_193_15.localPosition = Vector3.New(0, 100, 0)
				var_193_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_15.position).x, (manager.ui.mainCamera.transform.position - var_193_15.position).y, (manager.ui.mainCamera.transform.position - var_193_15.position).z)
				var_193_15.localEulerAngles.z = 0
				var_193_15.localEulerAngles.x = 0
				var_193_15.localEulerAngles = var_193_15.localEulerAngles
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_193_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_19 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_19

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_19
						arg_190_1.bgmTxt2_.text = var_193_19
					end

					if arg_190_1.bgmTimer then
						arg_190_1.bgmTimer:Stop()

						arg_190_1.bgmTimer = nil
					end

					if arg_190_1.settingData.show_music_name == 1 then
						arg_190_1.musicController:SetSelectedState("show")
						arg_190_1.musicAnimator_:Play("open", 0, 0)

						if arg_190_1.settingData.music_time ~= 0 then
							arg_190_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_190_1.settingData.music_time), function()
								if arg_190_1 == nil or isNil(arg_190_1.bgmTxt_) then
									return
								end

								arg_190_1.musicController:SetSelectedState("hide")
								arg_190_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_190_1.time_ and arg_190_1.time_ <= 0.4 + arg_193_0 then
				arg_190_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_193_22 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_190_1.bgmTxt_.text ~= var_193_22 and arg_190_1.bgmTxt_.text ~= "" then
						if arg_190_1.bgmTxt2_.text ~= "" then
							arg_190_1.bgmTxt_.text = arg_190_1.bgmTxt2_.text
						end

						arg_190_1.bgmTxt2_.text = var_193_22

						arg_190_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_190_1.bgmTxt_.text = var_193_22
						arg_190_1.bgmTxt2_.text = var_193_22
					end

					if arg_190_1.bgmTimer then
						arg_190_1.bgmTimer:Stop()

						arg_190_1.bgmTimer = nil
					end

					if arg_190_1.settingData.show_music_name == 1 then
						arg_190_1.musicController:SetSelectedState("show")
						arg_190_1.musicAnimator_:Play("open", 0, 0)

						if arg_190_1.settingData.music_time ~= 0 then
							arg_190_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_190_1.settingData.music_time), function()
								if arg_190_1 == nil or isNil(arg_190_1.bgmTxt_) then
									return
								end

								arg_190_1.musicController:SetSelectedState("hide")
								arg_190_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_190_1.time_ and arg_190_1.time_ <= 1.53333333333333 + arg_193_0 then
				arg_190_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street01", "")
			end

			if 0.125 < arg_190_1.time_ and arg_190_1.time_ <= 0.125 + arg_193_0 then
				arg_190_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_25 = 4
			local var_193_26 = 0.525

			if 4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_25 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_27 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_27:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_190_1.dialogCg_.alpha = arg_196_0
				end))
				var_193_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_28 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(1102003047).content)

				arg_190_1.text_.text = var_193_28

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_30 = 21 <= 0 and var_193_26 or var_193_26 * (utf8.len(var_193_28) / 21)

				if (21 <= 0 and var_193_26 or var_193_26 * (utf8.len(var_193_28) / 21)) > 0 and var_193_26 < var_193_30 then
					arg_190_1.talkMaxDuration = var_193_30
					var_193_25 = var_193_25 + 0.3

					if var_193_30 + var_193_25 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_30 + var_193_25
					end
				end

				arg_190_1.text_.text = var_193_28
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_31 = var_193_25 + 0.3
			local var_193_32 = math.max(var_193_26, arg_190_1.talkMaxDuration)

			if var_193_25 + 0.3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_31 + var_193_32 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_31) / var_193_32

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_31 + var_193_32 and arg_190_1.time_ < var_193_31 + var_193_32 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play1102003048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1102003048
		arg_198_1.duration_ = 5.47

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1102003049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1020ui_story"]) and arg_198_1.var_.characterEffect1020ui_story == nil then
				arg_198_1.var_.characterEffect1020ui_story = arg_198_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1020ui_story"]) then
				if arg_198_1.var_.characterEffect1020ui_story and not isNil(arg_198_1.actors_["1020ui_story"]) then
					arg_198_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1020ui_story"]) and arg_198_1.var_.characterEffect1020ui_story then
				arg_198_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_201_2 = arg_198_1.actors_["1020ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1020ui_story = var_201_2.localPosition
			end

			local var_201_3 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 then
				var_201_2.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_198_1.time_ - 0) / var_201_3)
				var_201_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_2.position).x, (manager.ui.mainCamera.transform.position - var_201_2.position).y, (manager.ui.mainCamera.transform.position - var_201_2.position).z)
				var_201_2.localEulerAngles.z = 0
				var_201_2.localEulerAngles.x = 0
				var_201_2.localEulerAngles = var_201_2.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 then
				var_201_2.localPosition = Vector3.New(0, -0.85, -6.25)
				var_201_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_2.position).x, (manager.ui.mainCamera.transform.position - var_201_2.position).y, (manager.ui.mainCamera.transform.position - var_201_2.position).z)
				var_201_2.localEulerAngles.z = 0
				var_201_2.localEulerAngles.x = 0
				var_201_2.localEulerAngles = var_201_2.localEulerAngles
			end

			local var_201_4 = 0
			local var_201_5 = 0.6

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(1102003048)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 24 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 24)

				if (24 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 24)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003048", "story_v_side_new_1102003.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003048", "story_v_side_new_1102003.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_side_new_1102003", "1102003048", "story_v_side_new_1102003.awb")

						arg_198_1:RecordAudio("1102003048", var_201_11)
						arg_198_1:RecordAudio("1102003048", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003048", "story_v_side_new_1102003.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003048", "story_v_side_new_1102003.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play1102003049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1102003049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1102003050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1020ui_story = arg_202_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1020ui_story"].transform.position).z)
				arg_202_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1020ui_story"].transform.localEulerAngles = arg_202_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1020ui_story"].transform.position).z)
				arg_202_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1020ui_story"].transform.localEulerAngles = arg_202_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1020ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1020ui_story == nil then
				arg_202_1.var_.characterEffect1020ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1020ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_2)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1020ui_story then
				arg_202_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_205_3 = 0
			local var_205_4 = 0.325

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_5 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1102003049).content)

				arg_202_1.text_.text = var_205_5

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_7 = 13 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 13)

				if (13 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_5) / 13)) > 0 and var_205_4 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_5
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_8 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_8 and arg_202_1.time_ < var_205_3 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1102003050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1102003051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 1.3

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(1102003050).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 52 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 52)

				if (52 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 52)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1102003051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1102003051
		arg_210_1.duration_ = 2.83

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1102003052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1020ui_story = arg_210_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1020ui_story"].transform.position).z)
				arg_210_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1020ui_story"].transform.localEulerAngles = arg_210_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_210_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1020ui_story"].transform.position).z)
				arg_210_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1020ui_story"].transform.localEulerAngles = arg_210_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1020ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1020ui_story == nil then
				arg_210_1.var_.characterEffect1020ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect1020ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1020ui_story then
				arg_210_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_213_4 = 0
			local var_213_5 = 0.4

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(1102003051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 16 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 16)

				if (16 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 16)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003051", "story_v_side_new_1102003.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003051", "story_v_side_new_1102003.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_side_new_1102003", "1102003051", "story_v_side_new_1102003.awb")

						arg_210_1:RecordAudio("1102003051", var_213_11)
						arg_210_1:RecordAudio("1102003051", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003051", "story_v_side_new_1102003.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003051", "story_v_side_new_1102003.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1102003052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1102003053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1020ui_story"]) and arg_214_1.var_.characterEffect1020ui_story == nil then
				arg_214_1.var_.characterEffect1020ui_story = arg_214_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1020ui_story"]) then
				if arg_214_1.var_.characterEffect1020ui_story and not isNil(arg_214_1.actors_["1020ui_story"]) then
					arg_214_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1020ui_story"]) and arg_214_1.var_.characterEffect1020ui_story then
				arg_214_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.25

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(1102003052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 10 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 10)

				if (10 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 10)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1102003053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1102003053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1102003054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1020ui_story = arg_218_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1020ui_story"].transform.position).z)
				arg_218_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1020ui_story"].transform.localEulerAngles = arg_218_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1020ui_story"].transform.position).z)
				arg_218_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1020ui_story"].transform.localEulerAngles = arg_218_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_221_1 = 0
			local var_221_2 = 1.425

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_3 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1102003053).content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 57 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 57)

				if (57 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 57)) > 0 and var_221_2 < var_221_5 then
					arg_218_1.talkMaxDuration = var_221_5

					if var_221_5 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_6 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_6 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_6

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_6 and arg_218_1.time_ < var_221_1 + var_221_6 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play1102003054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1102003054
		arg_222_1.duration_ = 2.4

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1102003055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.3

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1292].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:GetWordFromCfg(1102003054)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 12 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 12)

				if (12 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 12)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003054", "story_v_side_new_1102003.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003054", "story_v_side_new_1102003.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_side_new_1102003", "1102003054", "story_v_side_new_1102003.awb")

						arg_222_1:RecordAudio("1102003054", var_225_6)
						arg_222_1:RecordAudio("1102003054", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003054", "story_v_side_new_1102003.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003054", "story_v_side_new_1102003.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1102003055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1102003055
		arg_226_1.duration_ = 2.97

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1102003056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.325

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1293].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:GetWordFromCfg(1102003055)
				local var_229_2 = arg_226_1:FormatText(var_229_1.content)

				arg_226_1.text_.text = var_229_2

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 13 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 13)

				if (13 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 13)) > 0 and var_229_0 < var_229_4 then
					arg_226_1.talkMaxDuration = var_229_4

					if var_229_4 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_4 + 0
					end
				end

				arg_226_1.text_.text = var_229_2
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003055", "story_v_side_new_1102003.awb") ~= 0 then
					local var_229_5 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003055", "story_v_side_new_1102003.awb") / 1000

					if var_229_5 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + 0
					end

					if var_229_1.prefab_name ~= "" and arg_226_1.actors_[var_229_1.prefab_name] ~= nil then
						local var_229_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_1.prefab_name].transform, "story_v_side_new_1102003", "1102003055", "story_v_side_new_1102003.awb")

						arg_226_1:RecordAudio("1102003055", var_229_6)
						arg_226_1:RecordAudio("1102003055", var_229_6)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003055", "story_v_side_new_1102003.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003055", "story_v_side_new_1102003.awb")
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
	Play1102003056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1102003056
		arg_230_1.duration_ = 2.7

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1102003057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1020ui_story = arg_230_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1020ui_story"].transform.position).z)
				arg_230_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1020ui_story"].transform.localEulerAngles = arg_230_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_230_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1020ui_story"].transform.position).z)
				arg_230_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1020ui_story"].transform.localEulerAngles = arg_230_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1020ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1020ui_story == nil then
				arg_230_1.var_.characterEffect1020ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect1020ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1020ui_story then
				arg_230_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_233_4 = 0
			local var_233_5 = 0.2

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(1102003056)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 8 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 8)

				if (8 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 8)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003056", "story_v_side_new_1102003.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003056", "story_v_side_new_1102003.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_side_new_1102003", "1102003056", "story_v_side_new_1102003.awb")

						arg_230_1:RecordAudio("1102003056", var_233_11)
						arg_230_1:RecordAudio("1102003056", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003056", "story_v_side_new_1102003.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003056", "story_v_side_new_1102003.awb")
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

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play1102003057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1102003057
		arg_234_1.duration_ = 4.27

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1102003058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1020ui_story"]) and arg_234_1.var_.characterEffect1020ui_story == nil then
				arg_234_1.var_.characterEffect1020ui_story = arg_234_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1020ui_story"]) then
				if arg_234_1.var_.characterEffect1020ui_story and not isNil(arg_234_1.actors_["1020ui_story"]) then
					arg_234_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1020ui_story"]) and arg_234_1.var_.characterEffect1020ui_story then
				arg_234_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_237_1 = 0
			local var_237_2 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1293].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_3 = arg_234_1:GetWordFromCfg(1102003057)
				local var_237_4 = arg_234_1:FormatText(var_237_3.content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_6 = 18 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_4) / 18)

				if (18 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_4) / 18)) > 0 and var_237_2 < var_237_6 then
					arg_234_1.talkMaxDuration = var_237_6

					if var_237_6 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003057", "story_v_side_new_1102003.awb") ~= 0 then
					local var_237_7 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003057", "story_v_side_new_1102003.awb") / 1000

					if var_237_7 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_1
					end

					if var_237_3.prefab_name ~= "" and arg_234_1.actors_[var_237_3.prefab_name] ~= nil then
						local var_237_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_3.prefab_name].transform, "story_v_side_new_1102003", "1102003057", "story_v_side_new_1102003.awb")

						arg_234_1:RecordAudio("1102003057", var_237_8)
						arg_234_1:RecordAudio("1102003057", var_237_8)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003057", "story_v_side_new_1102003.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003057", "story_v_side_new_1102003.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_9 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_9 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_9

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_9 and arg_234_1.time_ < var_237_1 + var_237_9 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1102003058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1102003058
		arg_238_1.duration_ = 2.7

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1102003059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1020ui_story"]) and arg_238_1.var_.characterEffect1020ui_story == nil then
				arg_238_1.var_.characterEffect1020ui_story = arg_238_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1020ui_story"]) then
				if arg_238_1.var_.characterEffect1020ui_story and not isNil(arg_238_1.actors_["1020ui_story"]) then
					arg_238_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1020ui_story"]) and arg_238_1.var_.characterEffect1020ui_story then
				arg_238_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			local var_241_2 = 0
			local var_241_3 = 0.325

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(1102003058)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 13 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 13)

				if (13 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 13)) > 0 and var_241_3 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003058", "story_v_side_new_1102003.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003058", "story_v_side_new_1102003.awb") / 1000

					if var_241_8 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_2
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_side_new_1102003", "1102003058", "story_v_side_new_1102003.awb")

						arg_238_1:RecordAudio("1102003058", var_241_9)
						arg_238_1:RecordAudio("1102003058", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003058", "story_v_side_new_1102003.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003058", "story_v_side_new_1102003.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_10 and arg_238_1.time_ < var_241_2 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1102003059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1102003059
		arg_242_1.duration_ = 6.3

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1102003060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1020ui_story"]) and arg_242_1.var_.characterEffect1020ui_story == nil then
				arg_242_1.var_.characterEffect1020ui_story = arg_242_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1020ui_story"]) then
				if arg_242_1.var_.characterEffect1020ui_story and not isNil(arg_242_1.actors_["1020ui_story"]) then
					arg_242_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1020ui_story"]) and arg_242_1.var_.characterEffect1020ui_story then
				arg_242_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_245_1 = 0
			local var_245_2 = 0.75

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1293].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:GetWordFromCfg(1102003059)
				local var_245_4 = arg_242_1:FormatText(var_245_3.content)

				arg_242_1.text_.text = var_245_4

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_6 = 30 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_4) / 30)

				if (30 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_4) / 30)) > 0 and var_245_2 < var_245_6 then
					arg_242_1.talkMaxDuration = var_245_6

					if var_245_6 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_6 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_4
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003059", "story_v_side_new_1102003.awb") ~= 0 then
					local var_245_7 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003059", "story_v_side_new_1102003.awb") / 1000

					if var_245_7 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_1
					end

					if var_245_3.prefab_name ~= "" and arg_242_1.actors_[var_245_3.prefab_name] ~= nil then
						local var_245_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_3.prefab_name].transform, "story_v_side_new_1102003", "1102003059", "story_v_side_new_1102003.awb")

						arg_242_1:RecordAudio("1102003059", var_245_8)
						arg_242_1:RecordAudio("1102003059", var_245_8)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003059", "story_v_side_new_1102003.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003059", "story_v_side_new_1102003.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_9 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_9 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_9

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_9 and arg_242_1.time_ < var_245_1 + var_245_9 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1102003060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1102003060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1102003061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.225

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1102003060).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 9 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 9)

				if (9 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 9)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1102003061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1102003061
		arg_250_1.duration_ = 10.67

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1102003062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1020ui_story"]) and arg_250_1.var_.characterEffect1020ui_story == nil then
				arg_250_1.var_.characterEffect1020ui_story = arg_250_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1020ui_story"]) then
				if arg_250_1.var_.characterEffect1020ui_story and not isNil(arg_250_1.actors_["1020ui_story"]) then
					arg_250_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1020ui_story"]) and arg_250_1.var_.characterEffect1020ui_story then
				arg_250_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_253_2 = 0
			local var_253_3 = 1.275

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_4 = arg_250_1:GetWordFromCfg(1102003061)
				local var_253_5 = arg_250_1:FormatText(var_253_4.content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 51 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 51)

				if (51 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_5) / 51)) > 0 and var_253_3 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003061", "story_v_side_new_1102003.awb") ~= 0 then
					local var_253_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003061", "story_v_side_new_1102003.awb") / 1000

					if var_253_8 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_2
					end

					if var_253_4.prefab_name ~= "" and arg_250_1.actors_[var_253_4.prefab_name] ~= nil then
						local var_253_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_4.prefab_name].transform, "story_v_side_new_1102003", "1102003061", "story_v_side_new_1102003.awb")

						arg_250_1:RecordAudio("1102003061", var_253_9)
						arg_250_1:RecordAudio("1102003061", var_253_9)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003061", "story_v_side_new_1102003.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003061", "story_v_side_new_1102003.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_10 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_10 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_10

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_10 and arg_250_1.time_ < var_253_2 + var_253_10 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1102003062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1102003062
		arg_254_1.duration_ = 4.33

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1102003063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_257_0 = 0
			local var_257_1 = 0.35

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_2 = arg_254_1:GetWordFromCfg(1102003062)
				local var_257_3 = arg_254_1:FormatText(var_257_2.content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 14 <= 0 and var_257_1 or var_257_1 * (utf8.len(var_257_3) / 14)

				if (14 <= 0 and var_257_1 or var_257_1 * (utf8.len(var_257_3) / 14)) > 0 and var_257_1 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003062", "story_v_side_new_1102003.awb") ~= 0 then
					local var_257_6 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003062", "story_v_side_new_1102003.awb") / 1000

					if var_257_6 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_0
					end

					if var_257_2.prefab_name ~= "" and arg_254_1.actors_[var_257_2.prefab_name] ~= nil then
						local var_257_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_2.prefab_name].transform, "story_v_side_new_1102003", "1102003062", "story_v_side_new_1102003.awb")

						arg_254_1:RecordAudio("1102003062", var_257_7)
						arg_254_1:RecordAudio("1102003062", var_257_7)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003062", "story_v_side_new_1102003.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003062", "story_v_side_new_1102003.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_8 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_8 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_8

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_8 and arg_254_1.time_ < var_257_0 + var_257_8 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1102003063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1102003063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1102003064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1020ui_story"]) and arg_258_1.var_.characterEffect1020ui_story == nil then
				arg_258_1.var_.characterEffect1020ui_story = arg_258_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1020ui_story"]) then
				if arg_258_1.var_.characterEffect1020ui_story and not isNil(arg_258_1.actors_["1020ui_story"]) then
					arg_258_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1020ui_story"]) and arg_258_1.var_.characterEffect1020ui_story then
				arg_258_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_261_1 = 0
			local var_261_2 = 0.35

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(1102003063).content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 14 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 14)

				if (14 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 14)) > 0 and var_261_2 < var_261_5 then
					arg_258_1.talkMaxDuration = var_261_5

					if var_261_5 + var_261_1 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + var_261_1
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_6 = math.max(var_261_2, arg_258_1.talkMaxDuration)

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_6 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_1) / var_261_6

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_1 + var_261_6 and arg_258_1.time_ < var_261_1 + var_261_6 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1102003064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1102003064
		arg_262_1.duration_ = 5.4

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1102003065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1020ui_story"]) and arg_262_1.var_.characterEffect1020ui_story == nil then
				arg_262_1.var_.characterEffect1020ui_story = arg_262_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1020ui_story"]) then
				if arg_262_1.var_.characterEffect1020ui_story and not isNil(arg_262_1.actors_["1020ui_story"]) then
					arg_262_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1020ui_story"]) and arg_262_1.var_.characterEffect1020ui_story then
				arg_262_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_265_2 = 0
			local var_265_3 = 0.45

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_4 = arg_262_1:GetWordFromCfg(1102003064)
				local var_265_5 = arg_262_1:FormatText(var_265_4.content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 18 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 18)

				if (18 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 18)) > 0 and var_265_3 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003064", "story_v_side_new_1102003.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003064", "story_v_side_new_1102003.awb") / 1000

					if var_265_8 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_2
					end

					if var_265_4.prefab_name ~= "" and arg_262_1.actors_[var_265_4.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_4.prefab_name].transform, "story_v_side_new_1102003", "1102003064", "story_v_side_new_1102003.awb")

						arg_262_1:RecordAudio("1102003064", var_265_9)
						arg_262_1:RecordAudio("1102003064", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003064", "story_v_side_new_1102003.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003064", "story_v_side_new_1102003.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_3, arg_262_1.talkMaxDuration)

			if var_265_2 <= arg_262_1.time_ and arg_262_1.time_ < var_265_2 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_2) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_2 + var_265_10 and arg_262_1.time_ < var_265_2 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1102003065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1102003065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1102003066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1020ui_story"]) and arg_266_1.var_.characterEffect1020ui_story == nil then
				arg_266_1.var_.characterEffect1020ui_story = arg_266_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1020ui_story"]) then
				if arg_266_1.var_.characterEffect1020ui_story and not isNil(arg_266_1.actors_["1020ui_story"]) then
					arg_266_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_266_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1020ui_story"]) and arg_266_1.var_.characterEffect1020ui_story then
				arg_266_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_266_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_269_1 = 0
			local var_269_2 = 0.675

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1102003065).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 27 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 27)

				if (27 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 27)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1102003066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1102003066
		arg_270_1.duration_ = 4.8

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1102003067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1020ui_story"]) and arg_270_1.var_.characterEffect1020ui_story == nil then
				arg_270_1.var_.characterEffect1020ui_story = arg_270_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1020ui_story"]) then
				if arg_270_1.var_.characterEffect1020ui_story and not isNil(arg_270_1.actors_["1020ui_story"]) then
					arg_270_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1020ui_story"]) and arg_270_1.var_.characterEffect1020ui_story then
				arg_270_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_273_2 = 0
			local var_273_3 = 0.55

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_4 = arg_270_1:GetWordFromCfg(1102003066)
				local var_273_5 = arg_270_1:FormatText(var_273_4.content)

				arg_270_1.text_.text = var_273_5

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_7 = 22 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_5) / 22)

				if (22 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_5) / 22)) > 0 and var_273_3 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_2
					end
				end

				arg_270_1.text_.text = var_273_5
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003066", "story_v_side_new_1102003.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003066", "story_v_side_new_1102003.awb") / 1000

					if var_273_8 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_2
					end

					if var_273_4.prefab_name ~= "" and arg_270_1.actors_[var_273_4.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_4.prefab_name].transform, "story_v_side_new_1102003", "1102003066", "story_v_side_new_1102003.awb")

						arg_270_1:RecordAudio("1102003066", var_273_9)
						arg_270_1:RecordAudio("1102003066", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003066", "story_v_side_new_1102003.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003066", "story_v_side_new_1102003.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_3, arg_270_1.talkMaxDuration)

			if var_273_2 <= arg_270_1.time_ and arg_270_1.time_ < var_273_2 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_2) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_2 + var_273_10 and arg_270_1.time_ < var_273_2 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1102003067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1102003067
		arg_274_1.duration_ = 3.8

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1102003068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_277_0 = 0
			local var_277_1 = 0.45

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_2 = arg_274_1:GetWordFromCfg(1102003067)
				local var_277_3 = arg_274_1:FormatText(var_277_2.content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 18 <= 0 and var_277_1 or var_277_1 * (utf8.len(var_277_3) / 18)

				if (18 <= 0 and var_277_1 or var_277_1 * (utf8.len(var_277_3) / 18)) > 0 and var_277_1 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003067", "story_v_side_new_1102003.awb") ~= 0 then
					local var_277_6 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003067", "story_v_side_new_1102003.awb") / 1000

					if var_277_6 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_0
					end

					if var_277_2.prefab_name ~= "" and arg_274_1.actors_[var_277_2.prefab_name] ~= nil then
						local var_277_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_2.prefab_name].transform, "story_v_side_new_1102003", "1102003067", "story_v_side_new_1102003.awb")

						arg_274_1:RecordAudio("1102003067", var_277_7)
						arg_274_1:RecordAudio("1102003067", var_277_7)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003067", "story_v_side_new_1102003.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003067", "story_v_side_new_1102003.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1102003068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1102003068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1102003069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1020ui_story = arg_278_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1020ui_story"].transform.position).z)
				arg_278_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1020ui_story"].transform.localEulerAngles = arg_278_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1020ui_story"].transform.position).z)
				arg_278_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1020ui_story"].transform.localEulerAngles = arg_278_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1020ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1020ui_story == nil then
				arg_278_1.var_.characterEffect1020ui_story = var_281_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_2 and not isNil(var_281_1) then
				if arg_278_1.var_.characterEffect1020ui_story and not isNil(var_281_1) then
					arg_278_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_278_1.time_ - 0) / var_281_2)
				end
			end

			if arg_278_1.time_ >= 0 + var_281_2 and arg_278_1.time_ < 0 + var_281_2 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1020ui_story then
				arg_278_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_281_3 = 0
			local var_281_4 = 0.8

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_5 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(1102003068).content)

				arg_278_1.text_.text = var_281_5

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_7 = 32 <= 0 and var_281_4 or var_281_4 * (utf8.len(var_281_5) / 32)

				if (32 <= 0 and var_281_4 or var_281_4 * (utf8.len(var_281_5) / 32)) > 0 and var_281_4 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_3 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_3
					end
				end

				arg_278_1.text_.text = var_281_5
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_4, arg_278_1.talkMaxDuration)

			if var_281_3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_3 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_3) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_3 + var_281_8 and arg_278_1.time_ < var_281_3 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1102003069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1102003070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.575

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1102003069).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 23 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 23)

				if (23 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 23)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1102003070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1102003070
		arg_286_1.duration_ = 2

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1102003071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1020ui_story = arg_286_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_289_0 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				arg_286_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_286_1.time_ - 0) / var_289_0)
				arg_286_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1020ui_story"].transform.position).z)
				arg_286_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1020ui_story"].transform.localEulerAngles = arg_286_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				arg_286_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_286_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1020ui_story"].transform.position).z)
				arg_286_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1020ui_story"].transform.localEulerAngles = arg_286_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_289_1 = arg_286_1.actors_["1020ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1020ui_story == nil then
				arg_286_1.var_.characterEffect1020ui_story = var_289_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_2 and not isNil(var_289_1) then
				if arg_286_1.var_.characterEffect1020ui_story and not isNil(var_289_1) then
					arg_286_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_2 and arg_286_1.time_ < 0 + var_289_2 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1020ui_story then
				arg_286_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_289_4 = 0
			local var_289_5 = 0.1

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_6 = arg_286_1:GetWordFromCfg(1102003070)
				local var_289_7 = arg_286_1:FormatText(var_289_6.content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_9 = 4 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 4)

				if (4 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 4)) > 0 and var_289_5 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003070", "story_v_side_new_1102003.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003070", "story_v_side_new_1102003.awb") / 1000

					if var_289_10 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_4
					end

					if var_289_6.prefab_name ~= "" and arg_286_1.actors_[var_289_6.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_6.prefab_name].transform, "story_v_side_new_1102003", "1102003070", "story_v_side_new_1102003.awb")

						arg_286_1:RecordAudio("1102003070", var_289_11)
						arg_286_1:RecordAudio("1102003070", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003070", "story_v_side_new_1102003.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003070", "story_v_side_new_1102003.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_12 and arg_286_1.time_ < var_289_4 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1102003071
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1102003072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1020ui_story"]) and arg_290_1.var_.characterEffect1020ui_story == nil then
				arg_290_1.var_.characterEffect1020ui_story = arg_290_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1020ui_story"]) then
				if arg_290_1.var_.characterEffect1020ui_story and not isNil(arg_290_1.actors_["1020ui_story"]) then
					arg_290_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1020ui_story"]) and arg_290_1.var_.characterEffect1020ui_story then
				arg_290_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.375

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

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(1102003071).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 15 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 15)

				if (15 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 15)) > 0 and var_293_2 < var_293_5 then
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
	Play1102003072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1102003072
		arg_294_1.duration_ = 2.83

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1102003073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1020ui_story"]) and arg_294_1.var_.characterEffect1020ui_story == nil then
				arg_294_1.var_.characterEffect1020ui_story = arg_294_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1020ui_story"]) then
				if arg_294_1.var_.characterEffect1020ui_story and not isNil(arg_294_1.actors_["1020ui_story"]) then
					arg_294_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1020ui_story"]) and arg_294_1.var_.characterEffect1020ui_story then
				arg_294_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			local var_297_2 = 0
			local var_297_3 = 0.4

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_4 = arg_294_1:GetWordFromCfg(1102003072)
				local var_297_5 = arg_294_1:FormatText(var_297_4.content)

				arg_294_1.text_.text = var_297_5

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_7 = 16 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 16)

				if (16 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 16)) > 0 and var_297_3 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_2
					end
				end

				arg_294_1.text_.text = var_297_5
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003072", "story_v_side_new_1102003.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003072", "story_v_side_new_1102003.awb") / 1000

					if var_297_8 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_2
					end

					if var_297_4.prefab_name ~= "" and arg_294_1.actors_[var_297_4.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_4.prefab_name].transform, "story_v_side_new_1102003", "1102003072", "story_v_side_new_1102003.awb")

						arg_294_1:RecordAudio("1102003072", var_297_9)
						arg_294_1:RecordAudio("1102003072", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003072", "story_v_side_new_1102003.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003072", "story_v_side_new_1102003.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_3, arg_294_1.talkMaxDuration)

			if var_297_2 <= arg_294_1.time_ and arg_294_1.time_ < var_297_2 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_2) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_2 + var_297_10 and arg_294_1.time_ < var_297_2 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1102003073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1102003073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1102003074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1020ui_story"]) and arg_298_1.var_.characterEffect1020ui_story == nil then
				arg_298_1.var_.characterEffect1020ui_story = arg_298_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_0 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1020ui_story"]) then
				if arg_298_1.var_.characterEffect1020ui_story and not isNil(arg_298_1.actors_["1020ui_story"]) then
					arg_298_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_298_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_298_1.time_ - 0) / var_301_0)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1020ui_story"]) and arg_298_1.var_.characterEffect1020ui_story then
				arg_298_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_298_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_301_1 = 0
			local var_301_2 = 0.575

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 then
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

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_3 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(1102003073).content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 23 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 23)

				if (23 <= 0 and var_301_2 or var_301_2 * (utf8.len(var_301_3) / 23)) > 0 and var_301_2 < var_301_5 then
					arg_298_1.talkMaxDuration = var_301_5

					if var_301_5 + var_301_1 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + var_301_1
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_6 = math.max(var_301_2, arg_298_1.talkMaxDuration)

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_6 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_1) / var_301_6

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_1 + var_301_6 and arg_298_1.time_ < var_301_1 + var_301_6 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1102003074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1102003074
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1102003075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.475

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(1102003074).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 19 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 19)

				if (19 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 19)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1102003075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1102003075
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1102003076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.225

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
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

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(1102003075).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 9 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 9)

				if (9 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 9)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1102003076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1102003076
		arg_310_1.duration_ = 9

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1102003077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if arg_310_1.bgs_.L02f == nil then
				local var_313_0 = Object.Instantiate(arg_310_1.paintGo_)

				var_313_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02f")
				var_313_0.name = "L02f"
				var_313_0.transform.parent = arg_310_1.stage_.transform
				var_313_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.bgs_.L02f = var_313_0
			end

			if 1.999999999999 < arg_310_1.time_ and arg_310_1.time_ <= 1.999999999999 + arg_313_0 then
				local var_313_1 = arg_310_1.bgs_.L02f

				arg_310_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_313_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_313_2 = var_313_1:GetComponent("SpriteRenderer")

				if var_313_2 and var_313_2.sprite then
					local var_313_3 = 2 * (var_313_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_313_1.transform.localScale = Vector3.New(var_313_3 / var_313_2.sprite.bounds.size.y < var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x and var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x or var_313_3 / var_313_2.sprite.bounds.size.y, var_313_3 / var_313_2.sprite.bounds.size.y < var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x and var_313_3 * manager.ui.mainCameraCom_.aspect / var_313_2.sprite.bounds.size.x or var_313_3 / var_313_2.sprite.bounds.size.y, 0)
				end

				for iter_313_0, iter_313_1 in pairs(arg_310_1.bgs_) do
					if iter_313_0 ~= "L02f" then
						iter_313_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_313_4 = 3.999999999999

			if 3.999999999999 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			if arg_310_1.time_ >= var_313_4 + 0.3 and arg_310_1.time_ < var_313_4 + 0.3 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end

			local var_313_5 = 0

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_6 = 2

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_6 then
				local var_313_7 = Color.New(0, 0, 0)

				var_313_7.a = Mathf.Lerp(0, 1, (arg_310_1.time_ - var_313_5) / var_313_6)
				arg_310_1.mask_.color = var_313_7
			end

			if arg_310_1.time_ >= var_313_5 + var_313_6 and arg_310_1.time_ < var_313_5 + var_313_6 + arg_313_0 then
				local var_313_8 = Color.New(0, 0, 0)

				var_313_8.a = 1
				arg_310_1.mask_.color = var_313_8
			end

			local var_313_9 = 2

			if 2 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_10 = 2

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_10 then
				local var_313_11 = Color.New(0, 0, 0)

				var_313_11.a = Mathf.Lerp(1, 0, (arg_310_1.time_ - var_313_9) / var_313_10)
				arg_310_1.mask_.color = var_313_11
			end

			if arg_310_1.time_ >= var_313_9 + var_313_10 and arg_310_1.time_ < var_313_9 + var_313_10 + arg_313_0 then
				local var_313_12 = Color.New(0, 0, 0)

				arg_310_1.mask_.enabled = false
				var_313_12.a = 0
				arg_310_1.mask_.color = var_313_12
			end

			local var_313_13 = arg_310_1.actors_["1020ui_story"].transform

			if 2 < arg_310_1.time_ and arg_310_1.time_ <= 2 + arg_313_0 then
				arg_310_1.var_.moveOldPos1020ui_story = var_313_13.localPosition
			end

			local var_313_14 = 0.001

			if 2 <= arg_310_1.time_ and arg_310_1.time_ < 2 + var_313_14 then
				var_313_13.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_310_1.time_ - 2) / var_313_14)
				var_313_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_13.position).x, (manager.ui.mainCamera.transform.position - var_313_13.position).y, (manager.ui.mainCamera.transform.position - var_313_13.position).z)
				var_313_13.localEulerAngles.z = 0
				var_313_13.localEulerAngles.x = 0
				var_313_13.localEulerAngles = var_313_13.localEulerAngles
			end

			if arg_310_1.time_ >= 2 + var_313_14 and arg_310_1.time_ < 2 + var_313_14 + arg_313_0 then
				var_313_13.localPosition = Vector3.New(0, 100, 0)
				var_313_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_13.position).x, (manager.ui.mainCamera.transform.position - var_313_13.position).y, (manager.ui.mainCamera.transform.position - var_313_13.position).z)
				var_313_13.localEulerAngles.z = 0
				var_313_13.localEulerAngles.x = 0
				var_313_13.localEulerAngles = var_313_13.localEulerAngles
			end

			if 0.125 < arg_310_1.time_ and arg_310_1.time_ <= 0.125 + arg_313_0 then
				arg_310_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street01", "")
			end

			if 1.63333333333333 < arg_310_1.time_ and arg_310_1.time_ <= 1.63333333333333 + arg_313_0 then
				arg_310_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_17 = 3.999999999999
			local var_313_18 = 0.525

			if 3.999999999999 < arg_310_1.time_ and arg_310_1.time_ <= var_313_17 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_19 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_19:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_310_1.dialogCg_.alpha = arg_314_0
				end))
				var_313_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_20 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(1102003076).content)

				arg_310_1.text_.text = var_313_20

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_22 = 21 <= 0 and var_313_18 or var_313_18 * (utf8.len(var_313_20) / 21)

				if (21 <= 0 and var_313_18 or var_313_18 * (utf8.len(var_313_20) / 21)) > 0 and var_313_18 < var_313_22 then
					arg_310_1.talkMaxDuration = var_313_22
					var_313_17 = var_313_17 + 0.3

					if var_313_22 + var_313_17 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_22 + var_313_17
					end
				end

				arg_310_1.text_.text = var_313_20
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_23 = var_313_17 + 0.3
			local var_313_24 = math.max(var_313_18, arg_310_1.talkMaxDuration)

			if var_313_17 + 0.3 <= arg_310_1.time_ and arg_310_1.time_ < var_313_23 + var_313_24 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_23) / var_313_24

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_23 + var_313_24 and arg_310_1.time_ < var_313_23 + var_313_24 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play1102003077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1102003077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1102003078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0.433333333333333 < arg_316_1.time_ and arg_316_1.time_ <= 0.433333333333333 + arg_319_0 then
				arg_316_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_back", "")
			end

			local var_319_1 = 0
			local var_319_2 = 0.95

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1102003077).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 38 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 38)

				if (38 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 38)) > 0 and var_319_2 < var_319_5 then
					arg_316_1.talkMaxDuration = var_319_5

					if var_319_5 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_6 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_6 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_6

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_6 and arg_316_1.time_ < var_319_1 + var_319_6 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1102003078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1102003078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1102003079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.1

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(1102003078).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 4 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 4)

				if (4 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 4)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1102003079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1102003079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1102003080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0.125 < arg_324_1.time_ and arg_324_1.time_ <= 0.125 + arg_327_0 then
				arg_324_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_bag02", "")
			end

			local var_327_1 = 0
			local var_327_2 = 0.85

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_3 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(1102003079).content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 34 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 34)

				if (34 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 34)) > 0 and var_327_2 < var_327_5 then
					arg_324_1.talkMaxDuration = var_327_5

					if var_327_5 + var_327_1 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + var_327_1
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_6 = math.max(var_327_2, arg_324_1.talkMaxDuration)

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_6 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_1) / var_327_6

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_1 + var_327_6 and arg_324_1.time_ < var_327_1 + var_327_6 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1102003080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1102003080
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1102003081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.35

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(1102003080).content)

				arg_328_1.text_.text = var_331_1

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_3 = 14 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 14)

				if (14 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 14)) > 0 and var_331_0 < var_331_3 then
					arg_328_1.talkMaxDuration = var_331_3

					if var_331_3 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_3 + 0
					end
				end

				arg_328_1.text_.text = var_331_1
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_4 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_4

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1102003081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1102003081
		arg_332_1.duration_ = 8.1

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1102003082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1020ui_story = arg_332_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1020ui_story"].transform.position).z)
				arg_332_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1020ui_story"].transform.localEulerAngles = arg_332_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_332_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1020ui_story"].transform.position).z)
				arg_332_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1020ui_story"].transform.localEulerAngles = arg_332_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["1020ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect1020ui_story == nil then
				arg_332_1.var_.characterEffect1020ui_story = var_335_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 and not isNil(var_335_1) then
				if arg_332_1.var_.characterEffect1020ui_story and not isNil(var_335_1) then
					arg_332_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect1020ui_story then
				arg_332_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_335_4 = 0
			local var_335_5 = 0.925

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_6 = arg_332_1:GetWordFromCfg(1102003081)
				local var_335_7 = arg_332_1:FormatText(var_335_6.content)

				arg_332_1.text_.text = var_335_7

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_9 = 37 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 37)

				if (37 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 37)) > 0 and var_335_5 < var_335_9 then
					arg_332_1.talkMaxDuration = var_335_9

					if var_335_9 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_4
					end
				end

				arg_332_1.text_.text = var_335_7
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003081", "story_v_side_new_1102003.awb") ~= 0 then
					local var_335_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003081", "story_v_side_new_1102003.awb") / 1000

					if var_335_10 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_4
					end

					if var_335_6.prefab_name ~= "" and arg_332_1.actors_[var_335_6.prefab_name] ~= nil then
						local var_335_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_6.prefab_name].transform, "story_v_side_new_1102003", "1102003081", "story_v_side_new_1102003.awb")

						arg_332_1:RecordAudio("1102003081", var_335_11)
						arg_332_1:RecordAudio("1102003081", var_335_11)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003081", "story_v_side_new_1102003.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003081", "story_v_side_new_1102003.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_12 = math.max(var_335_5, arg_332_1.talkMaxDuration)

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_12 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_4) / var_335_12

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_4 + var_335_12 and arg_332_1.time_ < var_335_4 + var_335_12 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1102003082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1102003082
		arg_336_1.duration_ = 5.2

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1102003083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action467")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_339_0 = 0
			local var_339_1 = 0.625

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_2 = arg_336_1:GetWordFromCfg(1102003082)
				local var_339_3 = arg_336_1:FormatText(var_339_2.content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 25 <= 0 and var_339_1 or var_339_1 * (utf8.len(var_339_3) / 25)

				if (25 <= 0 and var_339_1 or var_339_1 * (utf8.len(var_339_3) / 25)) > 0 and var_339_1 < var_339_5 then
					arg_336_1.talkMaxDuration = var_339_5

					if var_339_5 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003082", "story_v_side_new_1102003.awb") ~= 0 then
					local var_339_6 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003082", "story_v_side_new_1102003.awb") / 1000

					if var_339_6 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_0
					end

					if var_339_2.prefab_name ~= "" and arg_336_1.actors_[var_339_2.prefab_name] ~= nil then
						local var_339_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_2.prefab_name].transform, "story_v_side_new_1102003", "1102003082", "story_v_side_new_1102003.awb")

						arg_336_1:RecordAudio("1102003082", var_339_7)
						arg_336_1:RecordAudio("1102003082", var_339_7)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003082", "story_v_side_new_1102003.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003082", "story_v_side_new_1102003.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_8 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_8 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_8

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_8 and arg_336_1.time_ < var_339_0 + var_339_8 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1102003083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1102003083
		arg_340_1.duration_ = 6.68

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1102003084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_9001
			local var_343_9000

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1020ui_story = arg_340_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_343_0 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 then
				arg_340_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_340_1.time_ - 0) / var_343_0)
				arg_340_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1020ui_story"].transform.position).z)
				arg_340_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1020ui_story"].transform.localEulerAngles = arg_340_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 then
				arg_340_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1020ui_story"].transform.position).z)
				arg_340_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1020ui_story"].transform.localEulerAngles = arg_340_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_343_1 = arg_340_1.actors_["1020ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1020ui_story == nil then
				arg_340_1.var_.characterEffect1020ui_story = var_343_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_2 and not isNil(var_343_1) then
				if arg_340_1.var_.characterEffect1020ui_story and not isNil(var_343_1) then
					arg_340_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_2)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_2 and arg_340_1.time_ < 0 + var_343_2 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1020ui_story then
				arg_340_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_343_3 = 0

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_3 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_4 = 0.1

			if var_343_3 <= arg_340_1.time_ and arg_340_1.time_ < var_343_3 + var_343_4 then
				local var_343_5 = Color.New(1, 1, 1)

				var_343_5.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_3) / var_343_4)
				arg_340_1.mask_.color = var_343_5
			end

			if arg_340_1.time_ >= var_343_3 + var_343_4 and arg_340_1.time_ < var_343_3 + var_343_4 + arg_343_0 then
				local var_343_6 = Color.New(1, 1, 1)

				arg_340_1.mask_.enabled = false
				var_343_6.a = 0
				arg_340_1.mask_.color = var_343_6
			end

			local var_343_7 = 0.233333333333333

			if 0.233333333333333 < arg_340_1.time_ and arg_340_1.time_ <= var_343_7 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_8 = 0.0499999999999998

			if var_343_7 <= arg_340_1.time_ and arg_340_1.time_ < var_343_7 + var_343_8 then
				local var_343_9 = Color.New(1, 1, 1)

				var_343_9.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_7) / var_343_8)
				arg_340_1.mask_.color = var_343_9
			end

			if arg_340_1.time_ >= var_343_7 + var_343_8 and arg_340_1.time_ < var_343_7 + var_343_8 + arg_343_0 then
				local var_343_10 = Color.New(1, 1, 1)

				arg_340_1.mask_.enabled = false
				var_343_10.a = 0
				arg_340_1.mask_.color = var_343_10
			end

			local var_343_11 = 0.333333333333333

			if 0.333333333333333 < arg_340_1.time_ and arg_340_1.time_ <= var_343_11 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_12 = 0.0333333333333333

			if var_343_11 <= arg_340_1.time_ and arg_340_1.time_ < var_343_11 + var_343_12 then
				local var_343_13 = Color.New(1, 1, 1)

				var_343_13.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_11) / var_343_12)
				arg_340_1.mask_.color = var_343_13
			end

			if arg_340_1.time_ >= var_343_11 + var_343_12 and arg_340_1.time_ < var_343_11 + var_343_12 + arg_343_0 then
				local var_343_14 = Color.New(1, 1, 1)

				arg_340_1.mask_.enabled = false
				var_343_14.a = 0
				arg_340_1.mask_.color = var_343_14
			end

			local var_343_15 = 0.366666666666667

			if 0.366666666666667 < arg_340_1.time_ and arg_340_1.time_ <= var_343_15 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_16 = 0.0333333333333333

			if var_343_15 <= arg_340_1.time_ and arg_340_1.time_ < var_343_15 + var_343_16 then
				local var_343_17 = Color.New(1, 1, 1)

				var_343_17.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_15) / var_343_16)
				arg_340_1.mask_.color = var_343_17
			end

			if arg_340_1.time_ >= var_343_15 + var_343_16 and arg_340_1.time_ < var_343_15 + var_343_16 + arg_343_0 then
				local var_343_18 = Color.New(1, 1, 1)

				arg_340_1.mask_.enabled = false
				var_343_18.a = 0
				arg_340_1.mask_.color = var_343_18
			end

			local var_343_19 = 0.4

			if 0.4 < arg_340_1.time_ and arg_340_1.time_ <= var_343_19 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_20 = 0.0333333333333333

			if var_343_19 <= arg_340_1.time_ and arg_340_1.time_ < var_343_19 + var_343_20 then
				local var_343_21 = Color.New(1, 1, 1)

				var_343_21.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_19) / var_343_20)
				arg_340_1.mask_.color = var_343_21
			end

			if arg_340_1.time_ >= var_343_19 + var_343_20 and arg_340_1.time_ < var_343_19 + var_343_20 + arg_343_0 then
				local var_343_22 = Color.New(1, 1, 1)

				arg_340_1.mask_.enabled = false
				var_343_22.a = 0
				arg_340_1.mask_.color = var_343_22
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				local var_343_23 = arg_340_1.var_.effectfantianxiayu

				if not arg_340_1.var_.effectfantianxiayu then
					var_343_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_343_23.name = "fantianxiayu"
					arg_340_1.var_.effectfantianxiayu = var_343_23
				else
					var_343_23.transform:SetParent(var_343_9001)
				end

				var_343_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_343_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_343_25 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_343_26 = var_343_23.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_343_0, iter_343_1 in ipairs((var_343_26:ToTable())) do
					iter_343_1.transform.localScale = Vector3.New(iter_343_1.transform.localScale.x / var_343_25 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_343_26 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_343_1.transform.localScale.y / var_343_25, iter_343_1.transform.localScale.z)
				end
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				local var_343_28 = arg_340_1.var_.effectfantianxiayu2

				if not arg_340_1.var_.effectfantianxiayu2 then
					var_343_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), manager.ui.mainCamera.transform)
					var_343_28.name = "fantianxiayu2"
					arg_340_1.var_.effectfantianxiayu2 = var_343_28
				else
					var_343_28.transform:SetParent(var_343_9000)
				end

				var_343_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_343_28.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_343_30 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_343_31 = var_343_28.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_343_2, iter_343_3 in ipairs((var_343_31:ToTable())) do
					iter_343_3.transform.localScale = Vector3.New(iter_343_3.transform.localScale.x / var_343_30 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_343_31 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_343_3.transform.localScale.y / var_343_30, iter_343_3.transform.localScale.z)
				end
			end

			local var_343_33 = 0

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_33 + arg_343_0 then
				arg_340_1.allBtn_.enabled = false
			end

			if arg_340_1.time_ >= var_343_33 + 0.433333333333333 and arg_340_1.time_ < var_343_33 + 0.433333333333333 + arg_343_0 then
				arg_340_1.allBtn_.enabled = true
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder01", "")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_rain_loop", "")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_343_39 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_340_1.bgmTxt_.text ~= var_343_39 and arg_340_1.bgmTxt_.text ~= "" then
						if arg_340_1.bgmTxt2_.text ~= "" then
							arg_340_1.bgmTxt_.text = arg_340_1.bgmTxt2_.text
						end

						arg_340_1.bgmTxt2_.text = var_343_39

						arg_340_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_340_1.bgmTxt_.text = var_343_39
						arg_340_1.bgmTxt2_.text = var_343_39
					end

					if arg_340_1.bgmTimer then
						arg_340_1.bgmTimer:Stop()

						arg_340_1.bgmTimer = nil
					end

					if arg_340_1.settingData.show_music_name == 1 then
						arg_340_1.musicController:SetSelectedState("show")
						arg_340_1.musicAnimator_:Play("open", 0, 0)

						if arg_340_1.settingData.music_time ~= 0 then
							arg_340_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_340_1.settingData.music_time), function()
								if arg_340_1 == nil or isNil(arg_340_1.bgmTxt_) then
									return
								end

								arg_340_1.musicController:SetSelectedState("hide")
								arg_340_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_340_1.frameCnt_ <= 1 then
				arg_340_1.dialog_:SetActive(false)
			end

			local var_343_40 = 1.675
			local var_343_41 = 0.325

			if 1.675 < arg_340_1.time_ and arg_340_1.time_ <= var_343_40 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0

				arg_340_1.dialog_:SetActive(true)

				arg_340_1.dialogCg_.alpha = 0

				local var_343_42 = LeanTween.value(arg_340_1.dialog_, 0, 1, 0.3)

				var_343_42:setOnUpdate(LuaHelper.FloatAction(function(arg_345_0)
					arg_340_1.dialogCg_.alpha = arg_345_0
				end))
				var_343_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_340_1.dialog_)
					var_343_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_340_1.duration_ = arg_340_1.duration_ + 0.3

				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_43 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(1102003083).content)

				arg_340_1.text_.text = var_343_43

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_45 = 13 <= 0 and var_343_41 or var_343_41 * (utf8.len(var_343_43) / 13)

				if (13 <= 0 and var_343_41 or var_343_41 * (utf8.len(var_343_43) / 13)) > 0 and var_343_41 < var_343_45 then
					arg_340_1.talkMaxDuration = var_343_45
					var_343_40 = var_343_40 + 0.3

					if var_343_45 + var_343_40 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_45 + var_343_40
					end
				end

				arg_340_1.text_.text = var_343_43
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_46 = var_343_40 + 0.3
			local var_343_47 = math.max(var_343_41, arg_340_1.talkMaxDuration)

			if var_343_40 + 0.3 <= arg_340_1.time_ and arg_340_1.time_ < var_343_46 + var_343_47 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_46) / var_343_47

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_46 + var_343_47 and arg_340_1.time_ < var_343_46 + var_343_47 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play1102003084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1102003084
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1102003085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 1.15

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1102003084).content)

				arg_347_1.text_.text = var_350_1

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_3 = 46 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 46)

				if (46 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 46)) > 0 and var_350_0 < var_350_3 then
					arg_347_1.talkMaxDuration = var_350_3

					if var_350_3 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_3 + 0
					end
				end

				arg_347_1.text_.text = var_350_1
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_4 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_4

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1102003085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1102003085
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1102003086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.175

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1102003085).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 7 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 7)

				if (7 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 7)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1102003086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1102003086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1102003087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.375

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1102003086).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 55 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 55)

				if (55 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 55)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1102003087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1102003087
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1102003088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.1

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1102003087).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 4 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 4)

				if (4 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 4)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1102003088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1102003088
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1102003089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.4

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1102003088).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 16 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 16)

				if (16 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 16)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1102003089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1102003089
		arg_367_1.duration_ = 2

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
			arg_367_1.auto_ = false
		end

		function arg_367_1.playNext_(arg_369_0)
			arg_367_1.onStoryFinished_()
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1020ui_story = arg_367_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1020ui_story"].transform.position).z)
				arg_367_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1020ui_story"].transform.localEulerAngles = arg_367_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_367_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1020ui_story"].transform.position).z)
				arg_367_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1020ui_story"].transform.localEulerAngles = arg_367_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1020ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1020ui_story == nil then
				arg_367_1.var_.characterEffect1020ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1020ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1020ui_story then
				arg_367_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_370_4 = 0
			local var_370_5 = 0.175

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(1102003089)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 7 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 7)

				if (7 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 7)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003089", "story_v_side_new_1102003.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003089", "story_v_side_new_1102003.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_side_new_1102003", "1102003089", "story_v_side_new_1102003.awb")

						arg_367_1:RecordAudio("1102003089", var_370_11)
						arg_367_1:RecordAudio("1102003089", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003089", "story_v_side_new_1102003.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003089", "story_v_side_new_1102003.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play1102003011 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1102003011
		arg_371_1.duration_ = 5.1

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1102003012(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1020ui_story"]) and arg_371_1.var_.characterEffect1020ui_story == nil then
				arg_371_1.var_.characterEffect1020ui_story = arg_371_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1020ui_story"]) then
				if arg_371_1.var_.characterEffect1020ui_story and not isNil(arg_371_1.actors_["1020ui_story"]) then
					arg_371_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1020ui_story"]) and arg_371_1.var_.characterEffect1020ui_story then
				arg_371_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_374_2 = 0
			local var_374_3 = 0.575

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_2 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_4 = arg_371_1:GetWordFromCfg(1102003011)
				local var_374_5 = arg_371_1:FormatText(var_374_4.content)

				arg_371_1.text_.text = var_374_5

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_7 = 23 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_5) / 23)

				if (23 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_5) / 23)) > 0 and var_374_3 < var_374_7 then
					arg_371_1.talkMaxDuration = var_374_7

					if var_374_7 + var_374_2 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_7 + var_374_2
					end
				end

				arg_371_1.text_.text = var_374_5
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003011", "story_v_side_new_1102003.awb") ~= 0 then
					local var_374_8 = manager.audio:GetVoiceLength("story_v_side_new_1102003", "1102003011", "story_v_side_new_1102003.awb") / 1000

					if var_374_8 + var_374_2 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_8 + var_374_2
					end

					if var_374_4.prefab_name ~= "" and arg_371_1.actors_[var_374_4.prefab_name] ~= nil then
						local var_374_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_4.prefab_name].transform, "story_v_side_new_1102003", "1102003011", "story_v_side_new_1102003.awb")

						arg_371_1:RecordAudio("1102003011", var_374_9)
						arg_371_1:RecordAudio("1102003011", var_374_9)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1102003", "1102003011", "story_v_side_new_1102003.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1102003", "1102003011", "story_v_side_new_1102003.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_10 = math.max(var_374_3, arg_371_1.talkMaxDuration)

			if var_374_2 <= arg_371_1.time_ and arg_371_1.time_ < var_374_2 + var_374_10 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_2) / var_374_10

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_2 + var_374_10 and arg_371_1.time_ < var_374_2 + var_374_10 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/L02f"
	},
	voices = {
		"story_v_side_new_1102003.awb"
	}
}
