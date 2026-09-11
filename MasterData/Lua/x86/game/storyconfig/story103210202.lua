return {
	Play321022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L13g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L13g")
				var_4_0.name = "L13g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L13g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L13g

				arg_1_1.bgs_.L13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L13g" then
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

			local var_4_9 = arg_1_1.actors_.ui_story

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story == nil then
				arg_1_1.var_.characterEffectui_story = var_4_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_10 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_10 and not isNil(var_4_9) then
				if arg_1_1.var_.characterEffectui_story and not isNil(var_4_9) then
					arg_1_1.var_.characterEffectui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_10 and arg_1_1.time_ < 0 + var_4_10 + arg_4_0 and not isNil(var_4_9) and arg_1_1.var_.characterEffectui_story then
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

			if 0.579204597510398 < arg_1_1.time_ and arg_1_1.time_ <= 0.579204597510398 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordhit", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 1.999999999999
			local var_4_20 = 1.375

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(321022001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 55 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 55)

				if (55 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 55)) > 0 and var_4_20 < var_4_24 then
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
	Play321022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321022002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.1 < arg_9_1.time_ and arg_9_1.time_ <= 0.1 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_monster", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1.1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321022002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 44 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 44)

				if (44 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 44)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321022003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321022003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321022004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1284ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1284ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1284ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1284ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1284ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1284ui_story = var_16_3.localPosition

				arg_13_1:ShowWeapon(arg_13_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.985, -6.22)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1284ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1284ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1284ui_story then
				arg_13_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(321022003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 4 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 4)

				if (4 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 4)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022003", "story_v_out_321022.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022003", "story_v_out_321022.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_321022", "321022003", "story_v_out_321022.awb")

						arg_13_1:RecordAudio("321022003", var_16_15)
						arg_13_1:RecordAudio("321022003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321022", "321022003", "story_v_out_321022.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321022", "321022003", "story_v_out_321022.awb")
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
				actorName = "1284ui_story",
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
	Play321022004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321022004
		arg_17_1.duration_ = 5.83

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321022005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_9000

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1284ui_story"]) and arg_17_1.var_.characterEffect1284ui_story == nil then
				arg_17_1.var_.characterEffect1284ui_story = arg_17_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1284ui_story"]) then
				if arg_17_1.var_.characterEffect1284ui_story and not isNil(arg_17_1.actors_["1284ui_story"]) then
					arg_17_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1284ui_story"]) and arg_17_1.var_.characterEffect1284ui_story then
				arg_17_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_20_1 = arg_17_1.actors_["1284ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1284ui_story = var_20_1.localPosition

				arg_17_1:ShowWeapon(arg_17_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_20_2 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 then
				var_20_1.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_2)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 then
				var_20_1.localPosition = Vector3.New(0, 100, 0)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			local var_20_3 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_4 = 0.4

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_4 then
				local var_20_5 = Color.New(1, 0.8030638, 0.384167)

				var_20_5.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_3) / var_20_4)
				arg_17_1.mask_.color = var_20_5
			end

			if arg_17_1.time_ >= var_20_3 + var_20_4 and arg_17_1.time_ < var_20_3 + var_20_4 + arg_20_0 then
				local var_20_6 = Color.New(1, 0.8030638, 0.384167)

				arg_17_1.mask_.enabled = false
				var_20_6.a = 0
				arg_17_1.mask_.color = var_20_6
			end

			if 0.2 < arg_17_1.time_ and arg_17_1.time_ <= 0.2 + arg_20_0 then
				local var_20_7 = arg_17_1.var_.effect498

				if not arg_17_1.var_.effect498 then
					var_20_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_20_7.name = "498"
					arg_17_1.var_.effect498 = var_20_7
				else
					var_20_7.transform:SetParent(var_20_9000)
				end

				var_20_7.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_20_7.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_20_9 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_20_10 = var_20_7.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_20_0, iter_20_1 in ipairs((var_20_10:ToTable())) do
					iter_20_1.transform.localScale = Vector3.New(iter_20_1.transform.localScale.x / var_20_9 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_20_10 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_20_1.transform.localScale.y / var_20_9, iter_20_1.transform.localScale.z)
				end
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:AudioAction("play", "effect", "se_story_140", "se_story_140_magic", "")
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_13 = 0.833333333333333
			local var_20_14 = 1.225

			if 0.833333333333333 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_15 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_15:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_16 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(321022004).content)

				arg_17_1.text_.text = var_20_16

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_18 = 49 <= 0 and var_20_14 or var_20_14 * (utf8.len(var_20_16) / 49)

				if (49 <= 0 and var_20_14 or var_20_14 * (utf8.len(var_20_16) / 49)) > 0 and var_20_14 < var_20_18 then
					arg_17_1.talkMaxDuration = var_20_18
					var_20_13 = var_20_13 + 0.3

					if var_20_18 + var_20_13 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_13
					end
				end

				arg_17_1.text_.text = var_20_16
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_19 = var_20_13 + 0.3
			local var_20_20 = math.max(var_20_14, arg_17_1.talkMaxDuration)

			if var_20_13 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_19) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 321022005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play321022006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword", "")
			end

			local var_26_1 = 0
			local var_26_2 = 1.25

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_3 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(321022005).content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 50 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 50)

				if (50 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 50)) > 0 and var_26_2 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_1
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_6 = math.max(var_26_2, arg_23_1.talkMaxDuration)

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_6 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_1) / var_26_6

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_1 + var_26_6 and arg_23_1.time_ < var_26_1 + var_26_6 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play321022006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 321022006
		arg_27_1.duration_ = 2.3

		local var_27_0 = {
			zh = 2.033,
			ja = 2.3
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play321022007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1284ui_story = arg_27_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1284ui_story"].transform.position).z)
				arg_27_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1284ui_story"].transform.localEulerAngles = arg_27_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_27_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1284ui_story"].transform.position).z)
				arg_27_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1284ui_story"].transform.localEulerAngles = arg_27_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1284ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1284ui_story == nil then
				arg_27_1.var_.characterEffect1284ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1284ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1284ui_story then
				arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_2")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_30_4 = 0
			local var_30_5 = 0.25

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(321022006)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 10 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 10)

				if (10 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 10)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022006", "story_v_out_321022.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022006", "story_v_out_321022.awb") / 1000

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end

					if var_30_6.prefab_name ~= "" and arg_27_1.actors_[var_30_6.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_6.prefab_name].transform, "story_v_out_321022", "321022006", "story_v_out_321022.awb")

						arg_27_1:RecordAudio("321022006", var_30_11)
						arg_27_1:RecordAudio("321022006", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_321022", "321022006", "story_v_out_321022.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_321022", "321022006", "story_v_out_321022.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_12 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_12 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_12

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_12 and arg_27_1.time_ < var_30_4 + var_30_12 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play321022007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 321022007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play321022008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = arg_31_1.actors_["1284ui_story"].transform.localPosition

				arg_31_1:ShowWeapon(arg_31_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).z)
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles = arg_31_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).z)
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles = arg_31_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if 0.733333333333333 < arg_31_1.time_ and arg_31_1.time_ <= 0.733333333333333 + arg_34_0 then
				arg_31_1:AudioAction("play", "effect", "se_story_140", "se_story_140_monster_death", "")
			end

			local var_34_2 = 0
			local var_34_3 = 1.6

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_4 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(321022007).content)

				arg_31_1.text_.text = var_34_4

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_6 = 64 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_4) / 64)

				if (64 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_4) / 64)) > 0 and var_34_3 < var_34_6 then
					arg_31_1.talkMaxDuration = var_34_6

					if var_34_6 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_6 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_4
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_7 and arg_31_1.time_ < var_34_2 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play321022008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 321022008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play321022009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.025

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

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(321022008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 41 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 41)

				if (41 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 41)) > 0 and var_38_0 < var_38_3 then
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
	Play321022009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 321022009
		arg_39_1.duration_ = 2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play321022010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1284ui_story = arg_39_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1284ui_story"].transform.position).z)
				arg_39_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1284ui_story"].transform.localEulerAngles = arg_39_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_39_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1284ui_story"].transform.position).z)
				arg_39_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1284ui_story"].transform.localEulerAngles = arg_39_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1284ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1284ui_story == nil then
				arg_39_1.var_.characterEffect1284ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1284ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1284ui_story then
				arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_42_4 = 0
			local var_42_5 = 0.175

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(321022009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 7 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 7)

				if (7 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 7)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022009", "story_v_out_321022.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022009", "story_v_out_321022.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_321022", "321022009", "story_v_out_321022.awb")

						arg_39_1:RecordAudio("321022009", var_42_11)
						arg_39_1:RecordAudio("321022009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_321022", "321022009", "story_v_out_321022.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_321022", "321022009", "story_v_out_321022.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play321022010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321022010
		arg_43_1.duration_ = 2.97

		local var_43_0 = {
			zh = 2.066,
			ja = 2.966
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321022011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1284ui_story = arg_43_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).z)
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles = arg_43_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).z)
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles = arg_43_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_46_1 = "10104ui_story"

			if arg_43_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_46_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_43_1.stage_.transform)

				var_46_2.name = var_46_1
				var_46_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_[var_46_1] = var_46_2

				local var_46_3 = var_46_2:GetComponentInChildren(typeof(CharacterEffect))

				var_46_3.enabled = true

				local var_46_4 = GameObjectTools.GetOrAddComponent(var_46_2, typeof(DynamicBoneHelper))

				if var_46_4 then
					var_46_4:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_3.transform, false)

				arg_43_1.var_[var_46_1 .. "Animator"] = var_46_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_[var_46_1 .. "Animator"].applyRootMotion = true
				arg_43_1.var_[var_46_1 .. "LipSync"] = var_46_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_5 = arg_43_1.actors_["10104ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10104ui_story = var_46_5.localPosition
			end

			local var_46_6 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 then
				var_46_5.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_43_1.time_ - 0) / var_46_6)
				var_46_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_5.position).x, (manager.ui.mainCamera.transform.position - var_46_5.position).y, (manager.ui.mainCamera.transform.position - var_46_5.position).z)
				var_46_5.localEulerAngles.z = 0
				var_46_5.localEulerAngles.x = 0
				var_46_5.localEulerAngles = var_46_5.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 then
				var_46_5.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_46_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_5.position).x, (manager.ui.mainCamera.transform.position - var_46_5.position).y, (manager.ui.mainCamera.transform.position - var_46_5.position).z)
				var_46_5.localEulerAngles.z = 0
				var_46_5.localEulerAngles.x = 0
				var_46_5.localEulerAngles = var_46_5.localEulerAngles
			end

			local var_46_7 = arg_43_1.actors_["10104ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.characterEffect10104ui_story == nil then
				arg_43_1.var_.characterEffect10104ui_story = var_46_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_8 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_8 and not isNil(var_46_7) then
				if arg_43_1.var_.characterEffect10104ui_story and not isNil(var_46_7) then
					arg_43_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_8 and arg_43_1.time_ < 0 + var_46_8 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.characterEffect10104ui_story then
				arg_43_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_46_10 = arg_43_1.actors_["1284ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect1284ui_story == nil then
				arg_43_1.var_.characterEffect1284ui_story = var_46_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_11 and not isNil(var_46_10) then
				if arg_43_1.var_.characterEffect1284ui_story and not isNil(var_46_10) then
					arg_43_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_11)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_11 and arg_43_1.time_ < 0 + var_46_11 + arg_46_0 and not isNil(var_46_10) and arg_43_1.var_.characterEffect1284ui_story then
				arg_43_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_46_12 = 0
			local var_46_13 = 0.225

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:GetWordFromCfg(321022010)
				local var_46_15 = arg_43_1:FormatText(var_46_14.content)

				arg_43_1.text_.text = var_46_15

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_17 = 9 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 9)

				if (9 <= 0 and var_46_13 or var_46_13 * (utf8.len(var_46_15) / 9)) > 0 and var_46_13 < var_46_17 then
					arg_43_1.talkMaxDuration = var_46_17

					if var_46_17 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_17 + var_46_12
					end
				end

				arg_43_1.text_.text = var_46_15
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022010", "story_v_out_321022.awb") ~= 0 then
					local var_46_18 = manager.audio:GetVoiceLength("story_v_out_321022", "321022010", "story_v_out_321022.awb") / 1000

					if var_46_18 + var_46_12 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_12
					end

					if var_46_14.prefab_name ~= "" and arg_43_1.actors_[var_46_14.prefab_name] ~= nil then
						local var_46_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_14.prefab_name].transform, "story_v_out_321022", "321022010", "story_v_out_321022.awb")

						arg_43_1:RecordAudio("321022010", var_46_19)
						arg_43_1:RecordAudio("321022010", var_46_19)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_321022", "321022010", "story_v_out_321022.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_321022", "321022010", "story_v_out_321022.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_20 = math.max(var_46_13, arg_43_1.talkMaxDuration)

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_20 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_12) / var_46_20

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_12 + var_46_20 and arg_43_1.time_ < var_46_12 + var_46_20 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play321022011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321022011
		arg_47_1.duration_ = 2.47

		local var_47_0 = {
			zh = 2.033,
			ja = 2.466
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
				arg_47_0:Play321022012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1284ui_story = arg_47_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1284ui_story"].transform.position).z)
				arg_47_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1284ui_story"].transform.localEulerAngles = arg_47_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_47_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1284ui_story"].transform.position).z)
				arg_47_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1284ui_story"].transform.localEulerAngles = arg_47_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["10104ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10104ui_story = var_50_1.localPosition
			end

			local var_50_2 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 then
				var_50_1.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_2)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 then
				var_50_1.localPosition = Vector3.New(0, 100, 0)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			local var_50_3 = arg_47_1.actors_["1284ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1284ui_story == nil then
				arg_47_1.var_.characterEffect1284ui_story = var_50_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_4 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 and not isNil(var_50_3) then
				if arg_47_1.var_.characterEffect1284ui_story and not isNil(var_50_3) then
					arg_47_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1284ui_story then
				arg_47_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_50_6 = arg_47_1.actors_["10104ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect10104ui_story == nil then
				arg_47_1.var_.characterEffect10104ui_story = var_50_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_7 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 and not isNil(var_50_6) then
				if arg_47_1.var_.characterEffect10104ui_story and not isNil(var_50_6) then
					arg_47_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_7)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect10104ui_story then
				arg_47_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_50_8 = 0
			local var_50_9 = 0.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(321022011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 9 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 9)

				if (9 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 9)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022011", "story_v_out_321022.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022011", "story_v_out_321022.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_321022", "321022011", "story_v_out_321022.awb")

						arg_47_1:RecordAudio("321022011", var_50_15)
						arg_47_1:RecordAudio("321022011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_321022", "321022011", "story_v_out_321022.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_321022", "321022011", "story_v_out_321022.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play321022012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321022012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play321022013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1284ui_story"]) and arg_51_1.var_.characterEffect1284ui_story == nil then
				arg_51_1.var_.characterEffect1284ui_story = arg_51_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1284ui_story"]) then
				if arg_51_1.var_.characterEffect1284ui_story and not isNil(arg_51_1.actors_["1284ui_story"]) then
					arg_51_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1284ui_story"]) and arg_51_1.var_.characterEffect1284ui_story then
				arg_51_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0.833333333333333 < arg_51_1.time_ and arg_51_1.time_ <= 0.833333333333333 + arg_54_0 then
				arg_51_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_scan", "")
			end

			local var_54_2 = 0
			local var_54_3 = 1.1

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(321022012).content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 44 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 44)

				if (44 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 44)) > 0 and var_54_3 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_7 and arg_51_1.time_ < var_54_2 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play321022013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321022013
		arg_55_1.duration_ = 2.53

		local var_55_0 = {
			zh = 2.466,
			ja = 2.533
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
				arg_55_0:Play321022014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1284ui_story = arg_55_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1284ui_story"].transform.position).z)
				arg_55_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1284ui_story"].transform.localEulerAngles = arg_55_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1284ui_story"].transform.position).z)
				arg_55_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1284ui_story"].transform.localEulerAngles = arg_55_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["10104ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10104ui_story = var_58_1.localPosition
			end

			local var_58_2 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 then
				var_58_1.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_55_1.time_ - 0) / var_58_2)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 then
				var_58_1.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			local var_58_3 = arg_55_1.actors_["10104ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect10104ui_story == nil then
				arg_55_1.var_.characterEffect10104ui_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect10104ui_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect10104ui_story then
				arg_55_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_58_6 = 0
			local var_58_7 = 0.25

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:GetWordFromCfg(321022013)
				local var_58_9 = arg_55_1:FormatText(var_58_8.content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 10 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 10)

				if (10 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 10)) > 0 and var_58_7 < var_58_11 then
					arg_55_1.talkMaxDuration = var_58_11

					if var_58_11 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022013", "story_v_out_321022.awb") ~= 0 then
					local var_58_12 = manager.audio:GetVoiceLength("story_v_out_321022", "321022013", "story_v_out_321022.awb") / 1000

					if var_58_12 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_6
					end

					if var_58_8.prefab_name ~= "" and arg_55_1.actors_[var_58_8.prefab_name] ~= nil then
						local var_58_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_8.prefab_name].transform, "story_v_out_321022", "321022013", "story_v_out_321022.awb")

						arg_55_1:RecordAudio("321022013", var_58_13)
						arg_55_1:RecordAudio("321022013", var_58_13)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321022", "321022013", "story_v_out_321022.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321022", "321022013", "story_v_out_321022.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_14 and arg_55_1.time_ < var_58_6 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play321022014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321022014
		arg_59_1.duration_ = 2.07

		local var_59_0 = {
			zh = 2.066,
			ja = 1.999999999999
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
				arg_59_0:Play321022015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if arg_59_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_62_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_59_1.stage_.transform)

				var_62_0.name = "1043ui_story"
				var_62_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.actors_["1043ui_story"] = var_62_0

				local var_62_1 = var_62_0:GetComponentInChildren(typeof(CharacterEffect))

				var_62_1.enabled = true

				local var_62_2 = GameObjectTools.GetOrAddComponent(var_62_0, typeof(DynamicBoneHelper))

				if var_62_2 then
					var_62_2:EnableDynamicBone(false)
				end

				arg_59_1:ShowWeapon(var_62_1.transform, false)

				arg_59_1.var_["1043ui_story" .. "Animator"] = var_62_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_59_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_59_1.var_["1043ui_story" .. "LipSync"] = var_62_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_62_3 = arg_59_1.actors_["1043ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1043ui_story = var_62_3.localPosition
			end

			local var_62_4 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				var_62_3.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_59_1.time_ - 0) / var_62_4)
				var_62_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_3.position).x, (manager.ui.mainCamera.transform.position - var_62_3.position).y, (manager.ui.mainCamera.transform.position - var_62_3.position).z)
				var_62_3.localEulerAngles.z = 0
				var_62_3.localEulerAngles.x = 0
				var_62_3.localEulerAngles = var_62_3.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				var_62_3.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_62_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_3.position).x, (manager.ui.mainCamera.transform.position - var_62_3.position).y, (manager.ui.mainCamera.transform.position - var_62_3.position).z)
				var_62_3.localEulerAngles.z = 0
				var_62_3.localEulerAngles.x = 0
				var_62_3.localEulerAngles = var_62_3.localEulerAngles
			end

			local var_62_5 = arg_59_1.actors_["10104ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10104ui_story = var_62_5.localPosition
			end

			local var_62_6 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_6 then
				var_62_5.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_6)
				var_62_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_5.position).x, (manager.ui.mainCamera.transform.position - var_62_5.position).y, (manager.ui.mainCamera.transform.position - var_62_5.position).z)
				var_62_5.localEulerAngles.z = 0
				var_62_5.localEulerAngles.x = 0
				var_62_5.localEulerAngles = var_62_5.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_6 and arg_59_1.time_ < 0 + var_62_6 + arg_62_0 then
				var_62_5.localPosition = Vector3.New(0, 100, 0)
				var_62_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_5.position).x, (manager.ui.mainCamera.transform.position - var_62_5.position).y, (manager.ui.mainCamera.transform.position - var_62_5.position).z)
				var_62_5.localEulerAngles.z = 0
				var_62_5.localEulerAngles.x = 0
				var_62_5.localEulerAngles = var_62_5.localEulerAngles
			end

			local var_62_7 = arg_59_1.actors_["1043ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.characterEffect1043ui_story == nil then
				arg_59_1.var_.characterEffect1043ui_story = var_62_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_8 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_8 and not isNil(var_62_7) then
				if arg_59_1.var_.characterEffect1043ui_story and not isNil(var_62_7) then
					arg_59_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_8 and arg_59_1.time_ < 0 + var_62_8 + arg_62_0 and not isNil(var_62_7) and arg_59_1.var_.characterEffect1043ui_story then
				arg_59_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_62_10 = arg_59_1.actors_["10104ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_10) and arg_59_1.var_.characterEffect10104ui_story == nil then
				arg_59_1.var_.characterEffect10104ui_story = var_62_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_11 and not isNil(var_62_10) then
				if arg_59_1.var_.characterEffect10104ui_story and not isNil(var_62_10) then
					arg_59_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_11)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_11 and arg_59_1.time_ < 0 + var_62_11 + arg_62_0 and not isNil(var_62_10) and arg_59_1.var_.characterEffect10104ui_story then
				arg_59_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_62_12 = 0
			local var_62_13 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_14 = arg_59_1:GetWordFromCfg(321022014)
				local var_62_15 = arg_59_1:FormatText(var_62_14.content)

				arg_59_1.text_.text = var_62_15

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_17 = 11 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 11)

				if (11 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_15) / 11)) > 0 and var_62_13 < var_62_17 then
					arg_59_1.talkMaxDuration = var_62_17

					if var_62_17 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_17 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_15
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022014", "story_v_out_321022.awb") ~= 0 then
					local var_62_18 = manager.audio:GetVoiceLength("story_v_out_321022", "321022014", "story_v_out_321022.awb") / 1000

					if var_62_18 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_18 + var_62_12
					end

					if var_62_14.prefab_name ~= "" and arg_59_1.actors_[var_62_14.prefab_name] ~= nil then
						local var_62_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_14.prefab_name].transform, "story_v_out_321022", "321022014", "story_v_out_321022.awb")

						arg_59_1:RecordAudio("321022014", var_62_19)
						arg_59_1:RecordAudio("321022014", var_62_19)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321022", "321022014", "story_v_out_321022.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321022", "321022014", "story_v_out_321022.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_20 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 <= arg_59_1.time_ and arg_59_1.time_ < var_62_12 + var_62_20 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_12) / var_62_20

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_12 + var_62_20 and arg_59_1.time_ < var_62_12 + var_62_20 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play321022015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321022015
		arg_63_1.duration_ = 3.07

		local var_63_0 = {
			zh = 2.3,
			ja = 3.066
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play321022016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1043ui_story = arg_63_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1043ui_story"].transform.position).z)
				arg_63_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1043ui_story"].transform.localEulerAngles = arg_63_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.81, -1.01, -5.73)
				arg_63_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1043ui_story"].transform.position).z)
				arg_63_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1043ui_story"].transform.localEulerAngles = arg_63_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["10104ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10104ui_story = var_66_1.localPosition
			end

			local var_66_2 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 then
				var_66_1.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_63_1.time_ - 0) / var_66_2)
				var_66_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_1.position).x, (manager.ui.mainCamera.transform.position - var_66_1.position).y, (manager.ui.mainCamera.transform.position - var_66_1.position).z)
				var_66_1.localEulerAngles.z = 0
				var_66_1.localEulerAngles.x = 0
				var_66_1.localEulerAngles = var_66_1.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 then
				var_66_1.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				var_66_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_1.position).x, (manager.ui.mainCamera.transform.position - var_66_1.position).y, (manager.ui.mainCamera.transform.position - var_66_1.position).z)
				var_66_1.localEulerAngles.z = 0
				var_66_1.localEulerAngles.x = 0
				var_66_1.localEulerAngles = var_66_1.localEulerAngles
			end

			local var_66_3 = arg_63_1.actors_["10104ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect10104ui_story == nil then
				arg_63_1.var_.characterEffect10104ui_story = var_66_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_4 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 and not isNil(var_66_3) then
				if arg_63_1.var_.characterEffect10104ui_story and not isNil(var_66_3) then
					arg_63_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect10104ui_story then
				arg_63_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_66_6 = arg_63_1.actors_["1043ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect1043ui_story == nil then
				arg_63_1.var_.characterEffect1043ui_story = var_66_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_7 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 and not isNil(var_66_6) then
				if arg_63_1.var_.characterEffect1043ui_story and not isNil(var_66_6) then
					arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_7)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect1043ui_story then
				arg_63_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_66_8 = 0
			local var_66_9 = 0.325

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(321022015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 13 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 13)

				if (13 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 13)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022015", "story_v_out_321022.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022015", "story_v_out_321022.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_321022", "321022015", "story_v_out_321022.awb")

						arg_63_1:RecordAudio("321022015", var_66_15)
						arg_63_1:RecordAudio("321022015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321022", "321022015", "story_v_out_321022.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321022", "321022015", "story_v_out_321022.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play321022016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321022016
		arg_67_1.duration_ = 5.1

		local var_67_0 = {
			zh = 3.666,
			ja = 5.1
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
				arg_67_0:Play321022017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1043ui_story"]) and arg_67_1.var_.characterEffect1043ui_story == nil then
				arg_67_1.var_.characterEffect1043ui_story = arg_67_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1043ui_story"]) then
				if arg_67_1.var_.characterEffect1043ui_story and not isNil(arg_67_1.actors_["1043ui_story"]) then
					arg_67_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1043ui_story"]) and arg_67_1.var_.characterEffect1043ui_story then
				arg_67_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_70_2 = arg_67_1.actors_["10104ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect10104ui_story == nil then
				arg_67_1.var_.characterEffect10104ui_story = var_70_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_3 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_3 and not isNil(var_70_2) then
				if arg_67_1.var_.characterEffect10104ui_story and not isNil(var_70_2) then
					arg_67_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_67_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_3)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_3 and arg_67_1.time_ < 0 + var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect10104ui_story then
				arg_67_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_67_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_70_4 = 0
			local var_70_5 = 0.45

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(321022016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 18 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 18)

				if (18 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 18)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022016", "story_v_out_321022.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022016", "story_v_out_321022.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_321022", "321022016", "story_v_out_321022.awb")

						arg_67_1:RecordAudio("321022016", var_70_11)
						arg_67_1:RecordAudio("321022016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321022", "321022016", "story_v_out_321022.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321022", "321022016", "story_v_out_321022.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play321022017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321022017
		arg_71_1.duration_ = 3.4

		local var_71_0 = {
			zh = 1.733,
			ja = 3.4
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play321022018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["10104ui_story"]) and arg_71_1.var_.characterEffect10104ui_story == nil then
				arg_71_1.var_.characterEffect10104ui_story = arg_71_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["10104ui_story"]) then
				if arg_71_1.var_.characterEffect10104ui_story and not isNil(arg_71_1.actors_["10104ui_story"]) then
					arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["10104ui_story"]) and arg_71_1.var_.characterEffect10104ui_story then
				arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_74_2 = arg_71_1.actors_["1043ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1043ui_story == nil then
				arg_71_1.var_.characterEffect1043ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect1043ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1043ui_story then
				arg_71_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_74_4 = 0
			local var_74_5 = 0.2

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(321022017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 8 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 8)

				if (8 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 8)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022017", "story_v_out_321022.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022017", "story_v_out_321022.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_321022", "321022017", "story_v_out_321022.awb")

						arg_71_1:RecordAudio("321022017", var_74_11)
						arg_71_1:RecordAudio("321022017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321022", "321022017", "story_v_out_321022.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321022", "321022017", "story_v_out_321022.awb")
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
	Play321022018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321022018
		arg_75_1.duration_ = 5.13

		local var_75_0 = {
			zh = 4.2,
			ja = 5.133
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
				arg_75_0:Play321022019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1043ui_story = arg_75_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1043ui_story, Vector3.New(0.81, -1.01, -5.73), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1043ui_story"].transform.position).z)
				arg_75_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1043ui_story"].transform.localEulerAngles = arg_75_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0.81, -1.01, -5.73)
				arg_75_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1043ui_story"].transform.position).z)
				arg_75_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1043ui_story"].transform.localEulerAngles = arg_75_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1043ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1043ui_story == nil then
				arg_75_1.var_.characterEffect1043ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1043ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1043ui_story then
				arg_75_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_78_4 = arg_75_1.actors_["10104ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10104ui_story == nil then
				arg_75_1.var_.characterEffect10104ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_5 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 and not isNil(var_78_4) then
				if arg_75_1.var_.characterEffect10104ui_story and not isNil(var_78_4) then
					arg_75_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_5)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10104ui_story then
				arg_75_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action2_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_78_6 = 0
			local var_78_7 = 0.425

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(321022018)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 17 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 17)

				if (17 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 17)) > 0 and var_78_7 < var_78_11 then
					arg_75_1.talkMaxDuration = var_78_11

					if var_78_11 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022018", "story_v_out_321022.awb") ~= 0 then
					local var_78_12 = manager.audio:GetVoiceLength("story_v_out_321022", "321022018", "story_v_out_321022.awb") / 1000

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end

					if var_78_8.prefab_name ~= "" and arg_75_1.actors_[var_78_8.prefab_name] ~= nil then
						local var_78_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_8.prefab_name].transform, "story_v_out_321022", "321022018", "story_v_out_321022.awb")

						arg_75_1:RecordAudio("321022018", var_78_13)
						arg_75_1:RecordAudio("321022018", var_78_13)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321022", "321022018", "story_v_out_321022.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321022", "321022018", "story_v_out_321022.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play321022019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321022019
		arg_79_1.duration_ = 2.17

		local var_79_0 = {
			zh = 1.266,
			ja = 2.166
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
				arg_79_0:Play321022020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1043ui_story"]) and arg_79_1.var_.characterEffect1043ui_story == nil then
				arg_79_1.var_.characterEffect1043ui_story = arg_79_1.actors_["1043ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1043ui_story"]) then
				if arg_79_1.var_.characterEffect1043ui_story and not isNil(arg_79_1.actors_["1043ui_story"]) then
					arg_79_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1043ui_story"]) and arg_79_1.var_.characterEffect1043ui_story then
				arg_79_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.125

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1165].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(321022019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 5 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_4) / 5)

				if (5 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_4) / 5)) > 0 and var_82_2 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022019", "story_v_out_321022.awb") ~= 0 then
					local var_82_7 = manager.audio:GetVoiceLength("story_v_out_321022", "321022019", "story_v_out_321022.awb") / 1000

					if var_82_7 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_1
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_321022", "321022019", "story_v_out_321022.awb")

						arg_79_1:RecordAudio("321022019", var_82_8)
						arg_79_1:RecordAudio("321022019", var_82_8)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_321022", "321022019", "story_v_out_321022.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_321022", "321022019", "story_v_out_321022.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_9 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_9 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_9

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_9 and arg_79_1.time_ < var_82_1 + var_82_9 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321022020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321022020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321022021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1043ui_story = arg_83_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).z)
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles = arg_83_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1043ui_story"].transform.position).z)
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1043ui_story"].transform.localEulerAngles = arg_83_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["10104ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10104ui_story = var_86_1.localPosition
			end

			local var_86_2 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 then
				var_86_1.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_2)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 then
				var_86_1.localPosition = Vector3.New(0, 100, 0)
				var_86_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_1.position).x, (manager.ui.mainCamera.transform.position - var_86_1.position).y, (manager.ui.mainCamera.transform.position - var_86_1.position).z)
				var_86_1.localEulerAngles.z = 0
				var_86_1.localEulerAngles.x = 0
				var_86_1.localEulerAngles = var_86_1.localEulerAngles
			end

			if 0.034000001847744 < arg_83_1.time_ and arg_83_1.time_ <= 0.034000001847744 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door_wood", "")
			end

			local var_86_4 = 0
			local var_86_5 = 0.95

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(321022020).content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 38 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 38)

				if (38 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 38)) > 0 and var_86_5 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_9 and arg_83_1.time_ < var_86_4 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play321022021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321022021
		arg_87_1.duration_ = 8.7

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321022022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.ST0506 == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0506")
				var_90_0.name = "ST0506"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.ST0506 = var_90_0
			end

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.ST0506

				arg_87_1.bgs_.ST0506.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "ST0506" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			if arg_87_1.time_ >= var_90_4 + 0.3 and arg_87_1.time_ < var_90_4 + 0.3 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_5 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_5 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_6 = 2

			if var_90_5 <= arg_87_1.time_ and arg_87_1.time_ < var_90_5 + var_90_6 then
				local var_90_7 = Color.New(0, 0, 0)

				var_90_7.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_5) / var_90_6)
				arg_87_1.mask_.color = var_90_7
			end

			if arg_87_1.time_ >= var_90_5 + var_90_6 and arg_87_1.time_ < var_90_5 + var_90_6 + arg_90_0 then
				local var_90_8 = Color.New(0, 0, 0)

				var_90_8.a = 1
				arg_87_1.mask_.color = var_90_8
			end

			local var_90_9 = 2

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_10 = 2

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_10 then
				local var_90_11 = Color.New(0, 0, 0)

				var_90_11.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_9) / var_90_10)
				arg_87_1.mask_.color = var_90_11
			end

			if arg_87_1.time_ >= var_90_9 + var_90_10 and arg_87_1.time_ < var_90_9 + var_90_10 + arg_90_0 then
				local var_90_12 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_12.a = 0
				arg_87_1.mask_.color = var_90_12
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_13 = 3.7
			local var_90_14 = 0.95

			if 3.7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_13 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_15 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_15:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_16 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(321022021).content)

				arg_87_1.text_.text = var_90_16

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_18 = 38 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 38)

				if (38 <= 0 and var_90_14 or var_90_14 * (utf8.len(var_90_16) / 38)) > 0 and var_90_14 < var_90_18 then
					arg_87_1.talkMaxDuration = var_90_18
					var_90_13 = var_90_13 + 0.3

					if var_90_18 + var_90_13 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_18 + var_90_13
					end
				end

				arg_87_1.text_.text = var_90_16
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_19 = var_90_13 + 0.3
			local var_90_20 = math.max(var_90_14, arg_87_1.talkMaxDuration)

			if var_90_13 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_19 + var_90_20 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_19) / var_90_20

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_19 + var_90_20 and arg_87_1.time_ < var_90_19 + var_90_20 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321022022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321022022
		arg_93_1.duration_ = 2.9

		local var_93_0 = {
			zh = 2.5,
			ja = 2.9
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play321022023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1284ui_story = arg_93_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1284ui_story"].transform.position).z)
				arg_93_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1284ui_story"].transform.localEulerAngles = arg_93_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_93_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1284ui_story"].transform.position).z)
				arg_93_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1284ui_story"].transform.localEulerAngles = arg_93_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1284ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1284ui_story == nil then
				arg_93_1.var_.characterEffect1284ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1284ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1284ui_story then
				arg_93_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_96_4 = 0
			local var_96_5 = 0.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(321022022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 9 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 9)

				if (9 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 9)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022022", "story_v_out_321022.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022022", "story_v_out_321022.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_321022", "321022022", "story_v_out_321022.awb")

						arg_93_1:RecordAudio("321022022", var_96_11)
						arg_93_1:RecordAudio("321022022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_321022", "321022022", "story_v_out_321022.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_321022", "321022022", "story_v_out_321022.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321022023
		arg_97_1.duration_ = 1.93

		local var_97_0 = {
			zh = 1.066,
			ja = 1.933
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
				arg_97_0:Play321022024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1284ui_story = arg_97_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1284ui_story"].transform.position).z)
				arg_97_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1284ui_story"].transform.localEulerAngles = arg_97_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_97_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1284ui_story"].transform.position).z)
				arg_97_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1284ui_story"].transform.localEulerAngles = arg_97_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10104ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10104ui_story = var_100_1.localPosition
			end

			local var_100_2 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 then
				var_100_1.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_2)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 then
				var_100_1.localPosition = Vector3.New(0, 100, 0)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			local var_100_3 = arg_97_1.actors_["1284ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1284ui_story == nil then
				arg_97_1.var_.characterEffect1284ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect1284ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_4)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect1284ui_story then
				arg_97_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_100_5 = 0
			local var_100_6 = 0.1

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_7 = arg_97_1:GetWordFromCfg(321022023)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 4 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 4)

				if (4 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 4)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022023", "story_v_out_321022.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_321022", "321022023", "story_v_out_321022.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_321022", "321022023", "story_v_out_321022.awb")

						arg_97_1:RecordAudio("321022023", var_100_12)
						arg_97_1:RecordAudio("321022023", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321022", "321022023", "story_v_out_321022.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321022", "321022023", "story_v_out_321022.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play321022024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321022024
		arg_101_1.duration_ = 9.63

		local var_101_0 = {
			zh = 5.7,
			ja = 9.633
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
				arg_101_0:Play321022025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10104ui_story = arg_101_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10104ui_story"].transform.position).z)
				arg_101_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10104ui_story"].transform.localEulerAngles = arg_101_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["10104ui_story"].transform.position).z)
				arg_101_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["10104ui_story"].transform.localEulerAngles = arg_101_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1284ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1284ui_story = var_104_1.localPosition
			end

			local var_104_2 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 then
				var_104_1.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_101_1.time_ - 0) / var_104_2)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 then
				var_104_1.localPosition = Vector3.New(0, -0.985, -6.22)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			local var_104_3 = arg_101_1.actors_["1284ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1284ui_story == nil then
				arg_101_1.var_.characterEffect1284ui_story = var_104_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 and not isNil(var_104_3) then
				if arg_101_1.var_.characterEffect1284ui_story and not isNil(var_104_3) then
					arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1284ui_story then
				arg_101_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_104_6 = arg_101_1.actors_["10104ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10104ui_story == nil then
				arg_101_1.var_.characterEffect10104ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect10104ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10104ui_story then
				arg_101_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_104_8 = 0
			local var_104_9 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(321022024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 33 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 33)

				if (33 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 33)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022024", "story_v_out_321022.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022024", "story_v_out_321022.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_321022", "321022024", "story_v_out_321022.awb")

						arg_101_1:RecordAudio("321022024", var_104_15)
						arg_101_1:RecordAudio("321022024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321022", "321022024", "story_v_out_321022.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321022", "321022024", "story_v_out_321022.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321022025
		arg_105_1.duration_ = 17.33

		local var_105_0 = {
			zh = 12.366,
			ja = 17.333
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
				arg_105_0:Play321022026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1284ui_story = arg_105_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1284ui_story"].transform.position).z)
				arg_105_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1284ui_story"].transform.localEulerAngles = arg_105_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1284ui_story"].transform.position).z)
				arg_105_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1284ui_story"].transform.localEulerAngles = arg_105_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_108_1 = "1011ui_story"

			if arg_105_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_108_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_105_1.stage_.transform)

				var_108_2.name = var_108_1
				var_108_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_[var_108_1] = var_108_2

				local var_108_3 = var_108_2:GetComponentInChildren(typeof(CharacterEffect))

				var_108_3.enabled = true

				local var_108_4 = GameObjectTools.GetOrAddComponent(var_108_2, typeof(DynamicBoneHelper))

				if var_108_4 then
					var_108_4:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_3.transform, false)

				arg_105_1.var_[var_108_1 .. "Animator"] = var_108_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_[var_108_1 .. "Animator"].applyRootMotion = true
				arg_105_1.var_[var_108_1 .. "LipSync"] = var_108_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_108_5 = arg_105_1.actors_["1011ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1011ui_story = var_108_5.localPosition
			end

			local var_108_6 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 then
				var_108_5.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_105_1.time_ - 0) / var_108_6)
				var_108_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_5.position).x, (manager.ui.mainCamera.transform.position - var_108_5.position).y, (manager.ui.mainCamera.transform.position - var_108_5.position).z)
				var_108_5.localEulerAngles.z = 0
				var_108_5.localEulerAngles.x = 0
				var_108_5.localEulerAngles = var_108_5.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 then
				var_108_5.localPosition = Vector3.New(0, -0.71, -6)
				var_108_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_5.position).x, (manager.ui.mainCamera.transform.position - var_108_5.position).y, (manager.ui.mainCamera.transform.position - var_108_5.position).z)
				var_108_5.localEulerAngles.z = 0
				var_108_5.localEulerAngles.x = 0
				var_108_5.localEulerAngles = var_108_5.localEulerAngles
			end

			local var_108_7 = arg_105_1.actors_["1011ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.characterEffect1011ui_story == nil then
				arg_105_1.var_.characterEffect1011ui_story = var_108_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_8 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_8 and not isNil(var_108_7) then
				if arg_105_1.var_.characterEffect1011ui_story and not isNil(var_108_7) then
					arg_105_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_8 and arg_105_1.time_ < 0 + var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.characterEffect1011ui_story then
				arg_105_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_108_10 = arg_105_1.actors_["1284ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_10) and arg_105_1.var_.characterEffect1284ui_story == nil then
				arg_105_1.var_.characterEffect1284ui_story = var_108_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_11 and not isNil(var_108_10) then
				if arg_105_1.var_.characterEffect1284ui_story and not isNil(var_108_10) then
					arg_105_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_11)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_11 and arg_105_1.time_ < 0 + var_108_11 + arg_108_0 and not isNil(var_108_10) and arg_105_1.var_.characterEffect1284ui_story then
				arg_105_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_108_12 = 0
			local var_108_13 = 1.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:GetWordFromCfg(321022025)
				local var_108_15 = arg_105_1:FormatText(var_108_14.content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 58 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 58)

				if (58 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 58)) > 0 and var_108_13 < var_108_17 then
					arg_105_1.talkMaxDuration = var_108_17

					if var_108_17 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022025", "story_v_out_321022.awb") ~= 0 then
					local var_108_18 = manager.audio:GetVoiceLength("story_v_out_321022", "321022025", "story_v_out_321022.awb") / 1000

					if var_108_18 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_12
					end

					if var_108_14.prefab_name ~= "" and arg_105_1.actors_[var_108_14.prefab_name] ~= nil then
						local var_108_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_14.prefab_name].transform, "story_v_out_321022", "321022025", "story_v_out_321022.awb")

						arg_105_1:RecordAudio("321022025", var_108_19)
						arg_105_1:RecordAudio("321022025", var_108_19)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321022", "321022025", "story_v_out_321022.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321022", "321022025", "story_v_out_321022.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_20 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_20 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_20

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_20 and arg_105_1.time_ < var_108_12 + var_108_20 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321022026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321022026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321022027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1011ui_story = arg_109_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).z)
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles = arg_109_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).z)
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles = arg_109_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1011ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1011ui_story == nil then
				arg_109_1.var_.characterEffect1011ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1011ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1011ui_story then
				arg_109_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_109_1.time_ and arg_109_1.time_ <= 0.034000001847744 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_112_4 = 0
			local var_112_5 = 0.95

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(321022026).content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_8 = 38 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_6) / 38)

				if (38 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_6) / 38)) > 0 and var_112_5 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_9 and arg_109_1.time_ < var_112_4 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321022027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321022027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321022028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 1.1

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

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(321022027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 44)

				if (44 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 44)) > 0 and var_116_0 < var_116_3 then
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
	Play321022028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321022028
		arg_117_1.duration_ = 7.9

		local var_117_0 = {
			zh = 5.633,
			ja = 7.9
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321022029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1284ui_story = arg_117_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).z)
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles = arg_117_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_117_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).z)
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles = arg_117_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1284ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1284ui_story == nil then
				arg_117_1.var_.characterEffect1284ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1284ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1284ui_story then
				arg_117_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			local var_120_4 = 0
			local var_120_5 = 0.7

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(321022028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 28 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 28)

				if (28 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 28)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022028", "story_v_out_321022.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022028", "story_v_out_321022.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_321022", "321022028", "story_v_out_321022.awb")

						arg_117_1:RecordAudio("321022028", var_120_11)
						arg_117_1:RecordAudio("321022028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321022", "321022028", "story_v_out_321022.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321022", "321022028", "story_v_out_321022.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 321022029
		arg_121_1.duration_ = 14.43

		local var_121_0 = {
			zh = 9.3,
			ja = 14.433
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
				arg_121_0:Play321022030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10104ui_story = arg_121_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).z)
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles = arg_121_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_121_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10104ui_story"].transform.position).z)
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10104ui_story"].transform.localEulerAngles = arg_121_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10104ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10104ui_story == nil then
				arg_121_1.var_.characterEffect10104ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10104ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10104ui_story then
				arg_121_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1284ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1284ui_story == nil then
				arg_121_1.var_.characterEffect1284ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect1284ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1284ui_story then
				arg_121_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_124_6 = 0
			local var_124_7 = 1.225

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(321022029)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 49 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 49)

				if (49 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 49)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022029", "story_v_out_321022.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_321022", "321022029", "story_v_out_321022.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_321022", "321022029", "story_v_out_321022.awb")

						arg_121_1:RecordAudio("321022029", var_124_13)
						arg_121_1:RecordAudio("321022029", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_321022", "321022029", "story_v_out_321022.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_321022", "321022029", "story_v_out_321022.awb")
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
				actorName = "10104ui_story",
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
	Play321022030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 321022030
		arg_125_1.duration_ = 7.5

		local var_125_0 = {
			zh = 5.633,
			ja = 7.5
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play321022031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1284ui_story"]) and arg_125_1.var_.characterEffect1284ui_story == nil then
				arg_125_1.var_.characterEffect1284ui_story = arg_125_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1284ui_story"]) then
				if arg_125_1.var_.characterEffect1284ui_story and not isNil(arg_125_1.actors_["1284ui_story"]) then
					arg_125_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1284ui_story"]) and arg_125_1.var_.characterEffect1284ui_story then
				arg_125_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["10104ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10104ui_story == nil then
				arg_125_1.var_.characterEffect10104ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect10104ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10104ui_story then
				arg_125_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284actionlink/1284action445")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_128_4 = 0
			local var_128_5 = 0.65

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(321022030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 26 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 26)

				if (26 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 26)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022030", "story_v_out_321022.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022030", "story_v_out_321022.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_321022", "321022030", "story_v_out_321022.awb")

						arg_125_1:RecordAudio("321022030", var_128_11)
						arg_125_1:RecordAudio("321022030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_321022", "321022030", "story_v_out_321022.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_321022", "321022030", "story_v_out_321022.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play321022031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321022031
		arg_129_1.duration_ = 7.2

		local var_129_0 = {
			zh = 5.266,
			ja = 7.2
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
				arg_129_0:Play321022032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10104ui_story"]) and arg_129_1.var_.characterEffect10104ui_story == nil then
				arg_129_1.var_.characterEffect10104ui_story = arg_129_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10104ui_story"]) then
				if arg_129_1.var_.characterEffect10104ui_story and not isNil(arg_129_1.actors_["10104ui_story"]) then
					arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10104ui_story"]) and arg_129_1.var_.characterEffect10104ui_story then
				arg_129_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_132_2 = arg_129_1.actors_["1284ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1284ui_story == nil then
				arg_129_1.var_.characterEffect1284ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect1284ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect1284ui_story then
				arg_129_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_132_4 = 0
			local var_132_5 = 0.5

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(321022031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 20 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 20)

				if (20 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 20)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022031", "story_v_out_321022.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022031", "story_v_out_321022.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_321022", "321022031", "story_v_out_321022.awb")

						arg_129_1:RecordAudio("321022031", var_132_11)
						arg_129_1:RecordAudio("321022031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_321022", "321022031", "story_v_out_321022.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_321022", "321022031", "story_v_out_321022.awb")
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

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321022032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321022032
		arg_133_1.duration_ = 16.23

		local var_133_0 = {
			zh = 10.5,
			ja = 16.233
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
				arg_133_0:Play321022033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 1.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(321022032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 51 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 51)

				if (51 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 51)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022032", "story_v_out_321022.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022032", "story_v_out_321022.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_321022", "321022032", "story_v_out_321022.awb")

						arg_133_1:RecordAudio("321022032", var_136_6)
						arg_133_1:RecordAudio("321022032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_321022", "321022032", "story_v_out_321022.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_321022", "321022032", "story_v_out_321022.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321022033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321022033
		arg_137_1.duration_ = 5.57

		local var_137_0 = {
			zh = 4.1,
			ja = 5.566
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
				arg_137_0:Play321022034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10104ui_story = arg_137_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10104ui_story"].transform.position).z)
				arg_137_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10104ui_story"].transform.localEulerAngles = arg_137_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_137_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10104ui_story"].transform.position).z)
				arg_137_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10104ui_story"].transform.localEulerAngles = arg_137_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			local var_140_1 = 0
			local var_140_2 = 0.575

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(321022033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 23 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 23)

				if (23 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_4) / 23)) > 0 and var_140_2 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022033", "story_v_out_321022.awb") ~= 0 then
					local var_140_7 = manager.audio:GetVoiceLength("story_v_out_321022", "321022033", "story_v_out_321022.awb") / 1000

					if var_140_7 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_1
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_321022", "321022033", "story_v_out_321022.awb")

						arg_137_1:RecordAudio("321022033", var_140_8)
						arg_137_1:RecordAudio("321022033", var_140_8)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_321022", "321022033", "story_v_out_321022.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_321022", "321022033", "story_v_out_321022.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_9 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_9 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_9

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_9 and arg_137_1.time_ < var_140_1 + var_140_9 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321022034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321022034
		arg_141_1.duration_ = 8.2

		local var_141_0 = {
			zh = 4.8,
			ja = 8.2
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
				arg_141_0:Play321022035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10104ui_story = arg_141_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10104ui_story"].transform.position).z)
				arg_141_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10104ui_story"].transform.localEulerAngles = arg_141_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10104ui_story"].transform.position).z)
				arg_141_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10104ui_story"].transform.localEulerAngles = arg_141_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1011ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1011ui_story = var_144_1.localPosition
			end

			local var_144_2 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 then
				var_144_1.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_141_1.time_ - 0) / var_144_2)
				var_144_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_1.position).x, (manager.ui.mainCamera.transform.position - var_144_1.position).y, (manager.ui.mainCamera.transform.position - var_144_1.position).z)
				var_144_1.localEulerAngles.z = 0
				var_144_1.localEulerAngles.x = 0
				var_144_1.localEulerAngles = var_144_1.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 then
				var_144_1.localPosition = Vector3.New(0, -0.71, -6)
				var_144_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_1.position).x, (manager.ui.mainCamera.transform.position - var_144_1.position).y, (manager.ui.mainCamera.transform.position - var_144_1.position).z)
				var_144_1.localEulerAngles.z = 0
				var_144_1.localEulerAngles.x = 0
				var_144_1.localEulerAngles = var_144_1.localEulerAngles
			end

			local var_144_3 = arg_141_1.actors_["1011ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1011ui_story == nil then
				arg_141_1.var_.characterEffect1011ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect1011ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1011ui_story then
				arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_144_6 = arg_141_1.actors_["10104ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect10104ui_story == nil then
				arg_141_1.var_.characterEffect10104ui_story = var_144_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_7 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 and not isNil(var_144_6) then
				if arg_141_1.var_.characterEffect10104ui_story and not isNil(var_144_6) then
					arg_141_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_7)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 and not isNil(var_144_6) and arg_141_1.var_.characterEffect10104ui_story then
				arg_141_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_8 = arg_141_1.actors_["1284ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1284ui_story = var_144_8.localPosition
			end

			local var_144_9 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 then
				var_144_8.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_9)
				var_144_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_8.position).x, (manager.ui.mainCamera.transform.position - var_144_8.position).y, (manager.ui.mainCamera.transform.position - var_144_8.position).z)
				var_144_8.localEulerAngles.z = 0
				var_144_8.localEulerAngles.x = 0
				var_144_8.localEulerAngles = var_144_8.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 then
				var_144_8.localPosition = Vector3.New(0, 100, 0)
				var_144_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_8.position).x, (manager.ui.mainCamera.transform.position - var_144_8.position).y, (manager.ui.mainCamera.transform.position - var_144_8.position).z)
				var_144_8.localEulerAngles.z = 0
				var_144_8.localEulerAngles.x = 0
				var_144_8.localEulerAngles = var_144_8.localEulerAngles
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_144_10 = 0
			local var_144_11 = 0.6

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_12 = arg_141_1:GetWordFromCfg(321022034)
				local var_144_13 = arg_141_1:FormatText(var_144_12.content)

				arg_141_1.text_.text = var_144_13

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 24 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 24)

				if (24 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 24)) > 0 and var_144_11 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15

					if var_144_15 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_13
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022034", "story_v_out_321022.awb") ~= 0 then
					local var_144_16 = manager.audio:GetVoiceLength("story_v_out_321022", "321022034", "story_v_out_321022.awb") / 1000

					if var_144_16 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_10
					end

					if var_144_12.prefab_name ~= "" and arg_141_1.actors_[var_144_12.prefab_name] ~= nil then
						local var_144_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_12.prefab_name].transform, "story_v_out_321022", "321022034", "story_v_out_321022.awb")

						arg_141_1:RecordAudio("321022034", var_144_17)
						arg_141_1:RecordAudio("321022034", var_144_17)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_321022", "321022034", "story_v_out_321022.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_321022", "321022034", "story_v_out_321022.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_18 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_18 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_10) / var_144_18

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_10 + var_144_18 and arg_141_1.time_ < var_144_10 + var_144_18 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321022035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play321022036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1011ui_story = arg_145_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).z)
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles = arg_145_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1011ui_story"].transform.position).z)
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1011ui_story"].transform.localEulerAngles = arg_145_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1011ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1011ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_2)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1011ui_story then
				arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 1.66666666666667 < arg_145_1.time_ and arg_145_1.time_ <= 1.66666666666667 + arg_148_0 then
				arg_145_1:AudioAction("play", "effect", "se_story_140", "se_story_140_frame", "")
			end

			local var_148_4 = 0
			local var_148_5 = 1.35

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(321022035).content)

				arg_145_1.text_.text = var_148_6

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_8 = 53 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_6) / 53)

				if (53 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_6) / 53)) > 0 and var_148_5 < var_148_8 then
					arg_145_1.talkMaxDuration = var_148_8

					if var_148_8 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_6
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_9 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_9 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_9

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_9 and arg_145_1.time_ < var_148_4 + var_148_9 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play321022036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321022036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play321022037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0.05 < arg_149_1.time_ and arg_149_1.time_ <= 0.05 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_140", "se_story_140_door", "")
			end

			local var_152_1 = 0
			local var_152_2 = 1

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(321022036).content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 40 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 40)

				if (40 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_3) / 40)) > 0 and var_152_2 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_6 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_6 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_6

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_6 and arg_149_1.time_ < var_152_1 + var_152_6 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play321022037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321022037
		arg_153_1.duration_ = 11.27

		local var_153_0 = {
			zh = 8.033,
			ja = 11.266
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play321022038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = arg_153_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1011ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_156_4 = 0
			local var_156_5 = 0.75

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(321022037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 30 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 30)

				if (30 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 30)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022037", "story_v_out_321022.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022037", "story_v_out_321022.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_321022", "321022037", "story_v_out_321022.awb")

						arg_153_1:RecordAudio("321022037", var_156_11)
						arg_153_1:RecordAudio("321022037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321022", "321022037", "story_v_out_321022.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321022", "321022037", "story_v_out_321022.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play321022038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321022038
		arg_157_1.duration_ = 5.73

		local var_157_0 = {
			zh = 4.6,
			ja = 5.733
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play321022039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10104ui_story = arg_157_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10104ui_story"].transform.position).z)
				arg_157_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10104ui_story"].transform.localEulerAngles = arg_157_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_157_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10104ui_story"].transform.position).z)
				arg_157_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10104ui_story"].transform.localEulerAngles = arg_157_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1011ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1011ui_story = var_160_1.localPosition
			end

			local var_160_2 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 then
				var_160_1.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 then
				var_160_1.localPosition = Vector3.New(0, 100, 0)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			local var_160_3 = arg_157_1.actors_["10104ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect10104ui_story == nil then
				arg_157_1.var_.characterEffect10104ui_story = var_160_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 and not isNil(var_160_3) then
				if arg_157_1.var_.characterEffect10104ui_story and not isNil(var_160_3) then
					arg_157_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect10104ui_story then
				arg_157_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_160_6 = arg_157_1.actors_["1011ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1011ui_story == nil then
				arg_157_1.var_.characterEffect1011ui_story = var_160_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_7 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 and not isNil(var_160_6) then
				if arg_157_1.var_.characterEffect1011ui_story and not isNil(var_160_6) then
					arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_7)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 and not isNil(var_160_6) and arg_157_1.var_.characterEffect1011ui_story then
				arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_160_8 = 0
			local var_160_9 = 0.4

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(321022038)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 16 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 16)

				if (16 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 16)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022038", "story_v_out_321022.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022038", "story_v_out_321022.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_321022", "321022038", "story_v_out_321022.awb")

						arg_157_1:RecordAudio("321022038", var_160_15)
						arg_157_1:RecordAudio("321022038", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321022", "321022038", "story_v_out_321022.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321022", "321022038", "story_v_out_321022.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play321022039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321022039
		arg_161_1.duration_ = 4.77

		local var_161_0 = {
			zh = 3.266,
			ja = 4.766
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play321022040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1284ui_story = arg_161_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1284ui_story"].transform.position).z)
				arg_161_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1284ui_story"].transform.localEulerAngles = arg_161_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_161_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1284ui_story"].transform.position).z)
				arg_161_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1284ui_story"].transform.localEulerAngles = arg_161_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["10104ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10104ui_story = var_164_1.localPosition
			end

			local var_164_2 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 then
				var_164_1.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_2)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 then
				var_164_1.localPosition = Vector3.New(0, 100, 0)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			local var_164_3 = arg_161_1.actors_["1284ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect1284ui_story == nil then
				arg_161_1.var_.characterEffect1284ui_story = var_164_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_4 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 and not isNil(var_164_3) then
				if arg_161_1.var_.characterEffect1284ui_story and not isNil(var_164_3) then
					arg_161_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect1284ui_story then
				arg_161_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_164_6 = arg_161_1.actors_["10104ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10104ui_story == nil then
				arg_161_1.var_.characterEffect10104ui_story = var_164_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_7 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 and not isNil(var_164_6) then
				if arg_161_1.var_.characterEffect10104ui_story and not isNil(var_164_6) then
					arg_161_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_7)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 and not isNil(var_164_6) and arg_161_1.var_.characterEffect10104ui_story then
				arg_161_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_164_8 = 0
			local var_164_9 = 0.4

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(321022039)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 16 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 16)

				if (16 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 16)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022039", "story_v_out_321022.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022039", "story_v_out_321022.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_321022", "321022039", "story_v_out_321022.awb")

						arg_161_1:RecordAudio("321022039", var_164_15)
						arg_161_1:RecordAudio("321022039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321022", "321022039", "story_v_out_321022.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321022", "321022039", "story_v_out_321022.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321022040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321022040
		arg_165_1.duration_ = 6.9

		local var_165_0 = {
			zh = 5.1,
			ja = 6.9
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play321022041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = arg_165_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_165_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1011ui_story"].transform.position).z)
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1011ui_story"].transform.localEulerAngles = arg_165_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1011ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["1284ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1284ui_story == nil then
				arg_165_1.var_.characterEffect1284ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect1284ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect1284ui_story then
				arg_165_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_168_6 = 0
			local var_168_7 = 0.65

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(321022040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 26 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 26)

				if (26 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 26)) > 0 and var_168_7 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022040", "story_v_out_321022.awb") ~= 0 then
					local var_168_12 = manager.audio:GetVoiceLength("story_v_out_321022", "321022040", "story_v_out_321022.awb") / 1000

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_321022", "321022040", "story_v_out_321022.awb")

						arg_165_1:RecordAudio("321022040", var_168_13)
						arg_165_1:RecordAudio("321022040", var_168_13)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_321022", "321022040", "story_v_out_321022.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_321022", "321022040", "story_v_out_321022.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play321022041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321022041
		arg_169_1.duration_ = 20.17

		local var_169_0 = {
			zh = 11.6,
			ja = 20.166
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play321022042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.45

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:GetWordFromCfg(321022041)
				local var_172_2 = arg_169_1:FormatText(var_172_1.content)

				arg_169_1.text_.text = var_172_2

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 56 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 56)

				if (56 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_2) / 56)) > 0 and var_172_0 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end

				arg_169_1.text_.text = var_172_2
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022041", "story_v_out_321022.awb") ~= 0 then
					local var_172_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022041", "story_v_out_321022.awb") / 1000

					if var_172_5 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + 0
					end

					if var_172_1.prefab_name ~= "" and arg_169_1.actors_[var_172_1.prefab_name] ~= nil then
						local var_172_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_1.prefab_name].transform, "story_v_out_321022", "321022041", "story_v_out_321022.awb")

						arg_169_1:RecordAudio("321022041", var_172_6)
						arg_169_1:RecordAudio("321022041", var_172_6)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321022", "321022041", "story_v_out_321022.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321022", "321022041", "story_v_out_321022.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play321022042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321022042
		arg_173_1.duration_ = 9.67

		local var_173_0 = {
			zh = 6.666,
			ja = 9.666
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play321022043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_176_0 = 0
			local var_176_1 = 0.825

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(321022042)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 33 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 33)

				if (33 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 33)) > 0 and var_176_1 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022042", "story_v_out_321022.awb") ~= 0 then
					local var_176_6 = manager.audio:GetVoiceLength("story_v_out_321022", "321022042", "story_v_out_321022.awb") / 1000

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end

					if var_176_2.prefab_name ~= "" and arg_173_1.actors_[var_176_2.prefab_name] ~= nil then
						local var_176_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_2.prefab_name].transform, "story_v_out_321022", "321022042", "story_v_out_321022.awb")

						arg_173_1:RecordAudio("321022042", var_176_7)
						arg_173_1:RecordAudio("321022042", var_176_7)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321022", "321022042", "story_v_out_321022.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321022", "321022042", "story_v_out_321022.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play321022043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321022043
		arg_177_1.duration_ = 3.4

		local var_177_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play321022044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1284ui_story"]) and arg_177_1.var_.characterEffect1284ui_story == nil then
				arg_177_1.var_.characterEffect1284ui_story = arg_177_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1284ui_story"]) then
				if arg_177_1.var_.characterEffect1284ui_story and not isNil(arg_177_1.actors_["1284ui_story"]) then
					arg_177_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1284ui_story"]) and arg_177_1.var_.characterEffect1284ui_story then
				arg_177_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_180_2 = arg_177_1.actors_["1011ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1011ui_story == nil then
				arg_177_1.var_.characterEffect1011ui_story = var_180_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_3 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.characterEffect1011ui_story and not isNil(var_180_2) then
					arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_3)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.characterEffect1011ui_story then
				arg_177_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_180_4 = 0
			local var_180_5 = 0.275

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(321022043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 11 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 11)

				if (11 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 11)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022043", "story_v_out_321022.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022043", "story_v_out_321022.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_321022", "321022043", "story_v_out_321022.awb")

						arg_177_1:RecordAudio("321022043", var_180_11)
						arg_177_1:RecordAudio("321022043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321022", "321022043", "story_v_out_321022.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321022", "321022043", "story_v_out_321022.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play321022044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321022044
		arg_181_1.duration_ = 2.4

		local var_181_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play321022045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10104ui_story = arg_181_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10104ui_story"].transform.position).z)
				arg_181_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10104ui_story"].transform.localEulerAngles = arg_181_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_181_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10104ui_story"].transform.position).z)
				arg_181_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10104ui_story"].transform.localEulerAngles = arg_181_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1011ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1011ui_story = var_184_1.localPosition
			end

			local var_184_2 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 then
				var_184_1.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_2)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 then
				var_184_1.localPosition = Vector3.New(0, 100, 0)
				var_184_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_1.position).x, (manager.ui.mainCamera.transform.position - var_184_1.position).y, (manager.ui.mainCamera.transform.position - var_184_1.position).z)
				var_184_1.localEulerAngles.z = 0
				var_184_1.localEulerAngles.x = 0
				var_184_1.localEulerAngles = var_184_1.localEulerAngles
			end

			local var_184_3 = arg_181_1.actors_["10104ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_3) and arg_181_1.var_.characterEffect10104ui_story == nil then
				arg_181_1.var_.characterEffect10104ui_story = var_184_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_4 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 and not isNil(var_184_3) then
				if arg_181_1.var_.characterEffect10104ui_story and not isNil(var_184_3) then
					arg_181_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 and not isNil(var_184_3) and arg_181_1.var_.characterEffect10104ui_story then
				arg_181_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_184_6 = arg_181_1.actors_["1284ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1284ui_story == nil then
				arg_181_1.var_.characterEffect1284ui_story = var_184_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_7 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 and not isNil(var_184_6) then
				if arg_181_1.var_.characterEffect1284ui_story and not isNil(var_184_6) then
					arg_181_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_7)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 and not isNil(var_184_6) and arg_181_1.var_.characterEffect1284ui_story then
				arg_181_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_184_8 = 0
			local var_184_9 = 0.075

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_10 = arg_181_1:GetWordFromCfg(321022044)
				local var_184_11 = arg_181_1:FormatText(var_184_10.content)

				arg_181_1.text_.text = var_184_11

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_13 = 3 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 3)

				if (3 <= 0 and var_184_9 or var_184_9 * (utf8.len(var_184_11) / 3)) > 0 and var_184_9 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_8
					end
				end

				arg_181_1.text_.text = var_184_11
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022044", "story_v_out_321022.awb") ~= 0 then
					local var_184_14 = manager.audio:GetVoiceLength("story_v_out_321022", "321022044", "story_v_out_321022.awb") / 1000

					if var_184_14 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_14 + var_184_8
					end

					if var_184_10.prefab_name ~= "" and arg_181_1.actors_[var_184_10.prefab_name] ~= nil then
						local var_184_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_10.prefab_name].transform, "story_v_out_321022", "321022044", "story_v_out_321022.awb")

						arg_181_1:RecordAudio("321022044", var_184_15)
						arg_181_1:RecordAudio("321022044", var_184_15)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321022", "321022044", "story_v_out_321022.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321022", "321022044", "story_v_out_321022.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_16 = math.max(var_184_9, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_16 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_8) / var_184_16

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_16 and arg_181_1.time_ < var_184_8 + var_184_16 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321022045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321022045
		arg_185_1.duration_ = 6.03

		local var_185_0 = {
			zh = 3.7,
			ja = 6.033
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321022046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1284ui_story = arg_185_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1284ui_story"].transform.position).z)
				arg_185_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1284ui_story"].transform.localEulerAngles = arg_185_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_185_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1284ui_story"].transform.position).z)
				arg_185_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1284ui_story"].transform.localEulerAngles = arg_185_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1284ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1284ui_story == nil then
				arg_185_1.var_.characterEffect1284ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1284ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1284ui_story then
				arg_185_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_188_4 = arg_185_1.actors_["10104ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect10104ui_story == nil then
				arg_185_1.var_.characterEffect10104ui_story = var_188_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_5 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_5 and not isNil(var_188_4) then
				if arg_185_1.var_.characterEffect10104ui_story and not isNil(var_188_4) then
					arg_185_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_5)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_5 and arg_185_1.time_ < 0 + var_188_5 + arg_188_0 and not isNil(var_188_4) and arg_185_1.var_.characterEffect10104ui_story then
				arg_185_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284actionlink/1284action428")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_188_6 = 0
			local var_188_7 = 0.525

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(321022045)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_11 = 21 <= 0 and var_188_7 or var_188_7 * (utf8.len(var_188_9) / 21)

				if (21 <= 0 and var_188_7 or var_188_7 * (utf8.len(var_188_9) / 21)) > 0 and var_188_7 < var_188_11 then
					arg_185_1.talkMaxDuration = var_188_11

					if var_188_11 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_11 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022045", "story_v_out_321022.awb") ~= 0 then
					local var_188_12 = manager.audio:GetVoiceLength("story_v_out_321022", "321022045", "story_v_out_321022.awb") / 1000

					if var_188_12 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_6
					end

					if var_188_8.prefab_name ~= "" and arg_185_1.actors_[var_188_8.prefab_name] ~= nil then
						local var_188_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_8.prefab_name].transform, "story_v_out_321022", "321022045", "story_v_out_321022.awb")

						arg_185_1:RecordAudio("321022045", var_188_13)
						arg_185_1:RecordAudio("321022045", var_188_13)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_321022", "321022045", "story_v_out_321022.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_321022", "321022045", "story_v_out_321022.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_14 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_14 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_14

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_14 and arg_185_1.time_ < var_188_6 + var_188_14 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play321022046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321022046
		arg_189_1.duration_ = 10.6

		local var_189_0 = {
			zh = 7.833,
			ja = 10.6
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play321022047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["10104ui_story"]) and arg_189_1.var_.characterEffect10104ui_story == nil then
				arg_189_1.var_.characterEffect10104ui_story = arg_189_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["10104ui_story"]) then
				if arg_189_1.var_.characterEffect10104ui_story and not isNil(arg_189_1.actors_["10104ui_story"]) then
					arg_189_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["10104ui_story"]) and arg_189_1.var_.characterEffect10104ui_story then
				arg_189_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["1284ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1284ui_story == nil then
				arg_189_1.var_.characterEffect1284ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect1284ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1284ui_story then
				arg_189_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_192_4 = 0
			local var_192_5 = 0.9

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(321022046)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 36 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 36)

				if (36 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 36)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022046", "story_v_out_321022.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_321022", "321022046", "story_v_out_321022.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_321022", "321022046", "story_v_out_321022.awb")

						arg_189_1:RecordAudio("321022046", var_192_11)
						arg_189_1:RecordAudio("321022046", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321022", "321022046", "story_v_out_321022.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321022", "321022046", "story_v_out_321022.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play321022047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321022047
		arg_193_1.duration_ = 9.5

		local var_193_0 = {
			zh = 6.066,
			ja = 9.5
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play321022048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.775

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(321022047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 31 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 31)

				if (31 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 31)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022047", "story_v_out_321022.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022047", "story_v_out_321022.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_321022", "321022047", "story_v_out_321022.awb")

						arg_193_1:RecordAudio("321022047", var_196_6)
						arg_193_1:RecordAudio("321022047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321022", "321022047", "story_v_out_321022.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321022", "321022047", "story_v_out_321022.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play321022048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321022048
		arg_197_1.duration_ = 10.5

		local var_197_0 = {
			zh = 6.433,
			ja = 10.5
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play321022049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10104ui_story = arg_197_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10104ui_story"].transform.position).z)
				arg_197_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10104ui_story"].transform.localEulerAngles = arg_197_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_197_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10104ui_story"].transform.position).z)
				arg_197_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10104ui_story"].transform.localEulerAngles = arg_197_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_200_1 = 0
			local var_200_2 = 0.8

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:GetWordFromCfg(321022048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_6 = 32 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 32)

				if (32 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_4) / 32)) > 0 and var_200_2 < var_200_6 then
					arg_197_1.talkMaxDuration = var_200_6

					if var_200_6 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022048", "story_v_out_321022.awb") ~= 0 then
					local var_200_7 = manager.audio:GetVoiceLength("story_v_out_321022", "321022048", "story_v_out_321022.awb") / 1000

					if var_200_7 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_1
					end

					if var_200_3.prefab_name ~= "" and arg_197_1.actors_[var_200_3.prefab_name] ~= nil then
						local var_200_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_3.prefab_name].transform, "story_v_out_321022", "321022048", "story_v_out_321022.awb")

						arg_197_1:RecordAudio("321022048", var_200_8)
						arg_197_1:RecordAudio("321022048", var_200_8)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321022", "321022048", "story_v_out_321022.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321022", "321022048", "story_v_out_321022.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_9 and arg_197_1.time_ < var_200_1 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play321022049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321022049
		arg_201_1.duration_ = 2.5

		local var_201_0 = {
			zh = 1.999999999999,
			ja = 2.5
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play321022050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1284ui_story = arg_201_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1284ui_story"].transform.position).z)
				arg_201_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1284ui_story"].transform.localEulerAngles = arg_201_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_201_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1284ui_story"].transform.position).z)
				arg_201_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1284ui_story"].transform.localEulerAngles = arg_201_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1284ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1284ui_story == nil then
				arg_201_1.var_.characterEffect1284ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1284ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1284ui_story then
				arg_201_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_204_4 = arg_201_1.actors_["10104ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10104ui_story == nil then
				arg_201_1.var_.characterEffect10104ui_story = var_204_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_5 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 and not isNil(var_204_4) then
				if arg_201_1.var_.characterEffect10104ui_story and not isNil(var_204_4) then
					arg_201_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_5)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.characterEffect10104ui_story then
				arg_201_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_2")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_204_6 = 0
			local var_204_7 = 0.15

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(321022049)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 6 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 6)

				if (6 <= 0 and var_204_7 or var_204_7 * (utf8.len(var_204_9) / 6)) > 0 and var_204_7 < var_204_11 then
					arg_201_1.talkMaxDuration = var_204_11

					if var_204_11 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022049", "story_v_out_321022.awb") ~= 0 then
					local var_204_12 = manager.audio:GetVoiceLength("story_v_out_321022", "321022049", "story_v_out_321022.awb") / 1000

					if var_204_12 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_6
					end

					if var_204_8.prefab_name ~= "" and arg_201_1.actors_[var_204_8.prefab_name] ~= nil then
						local var_204_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_8.prefab_name].transform, "story_v_out_321022", "321022049", "story_v_out_321022.awb")

						arg_201_1:RecordAudio("321022049", var_204_13)
						arg_201_1:RecordAudio("321022049", var_204_13)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321022", "321022049", "story_v_out_321022.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321022", "321022049", "story_v_out_321022.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play321022050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321022050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321022051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10104ui_story = arg_205_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10104ui_story"].transform.position).z)
				arg_205_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10104ui_story"].transform.localEulerAngles = arg_205_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10104ui_story"].transform.position).z)
				arg_205_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10104ui_story"].transform.localEulerAngles = arg_205_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1284ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1284ui_story = var_208_1.localPosition
			end

			local var_208_2 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 then
				var_208_1.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_2)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 then
				var_208_1.localPosition = Vector3.New(0, 100, 0)
				var_208_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_1.position).x, (manager.ui.mainCamera.transform.position - var_208_1.position).y, (manager.ui.mainCamera.transform.position - var_208_1.position).z)
				var_208_1.localEulerAngles.z = 0
				var_208_1.localEulerAngles.x = 0
				var_208_1.localEulerAngles = var_208_1.localEulerAngles
			end

			local var_208_3 = arg_205_1.actors_["1284ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect1284ui_story == nil then
				arg_205_1.var_.characterEffect1284ui_story = var_208_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_4 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 and not isNil(var_208_3) then
				if arg_205_1.var_.characterEffect1284ui_story and not isNil(var_208_3) then
					arg_205_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_4)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect1284ui_story then
				arg_205_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_208_5 = 0
			local var_208_6 = 1.35

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_7 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(321022050).content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 54 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_7) / 54)

				if (54 <= 0 and var_208_6 or var_208_6 * (utf8.len(var_208_7) / 54)) > 0 and var_208_6 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_5 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_5
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_6, arg_205_1.talkMaxDuration)

			if var_208_5 <= arg_205_1.time_ and arg_205_1.time_ < var_208_5 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_5) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_5 + var_208_10 and arg_205_1.time_ < var_208_5 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play321022051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321022051
		arg_209_1.duration_ = 7.68

		local var_209_0 = {
			zh = 7.68266666666667,
			ja = 6.84966666666667
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play321022052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.bgs_.L08f == nil then
				local var_212_0 = Object.Instantiate(arg_209_1.paintGo_)

				var_212_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08f")
				var_212_0.name = "L08f"
				var_212_0.transform.parent = arg_209_1.stage_.transform
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.bgs_.L08f = var_212_0
			end

			if 1.76666666666667 < arg_209_1.time_ and arg_209_1.time_ <= 1.76666666666667 + arg_212_0 then
				local var_212_1 = arg_209_1.bgs_.L08f

				arg_209_1.bgs_.L08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_212_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_212_2 = var_212_1:GetComponent("SpriteRenderer")

				if var_212_2 and var_212_2.sprite then
					local var_212_3 = 2 * (var_212_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_212_1.transform.localScale = Vector3.New(var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, var_212_3 / var_212_2.sprite.bounds.size.y < var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x and var_212_3 * manager.ui.mainCameraCom_.aspect / var_212_2.sprite.bounds.size.x or var_212_3 / var_212_2.sprite.bounds.size.y, 0)
				end

				for iter_212_0, iter_212_1 in pairs(arg_209_1.bgs_) do
					if iter_212_0 ~= "L08f" then
						iter_212_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_212_4 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.allBtn_.enabled = false
			end

			if arg_209_1.time_ >= var_212_4 + 0.3 and arg_209_1.time_ < var_212_4 + 0.3 + arg_212_0 then
				arg_209_1.allBtn_.enabled = true
			end

			local var_212_5 = 0

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_5 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_6 = 1.76666666666667

			if var_212_5 <= arg_209_1.time_ and arg_209_1.time_ < var_212_5 + var_212_6 then
				local var_212_7 = Color.New(0, 0, 0)

				var_212_7.a = Mathf.Lerp(0, 1, (arg_209_1.time_ - var_212_5) / var_212_6)
				arg_209_1.mask_.color = var_212_7
			end

			if arg_209_1.time_ >= var_212_5 + var_212_6 and arg_209_1.time_ < var_212_5 + var_212_6 + arg_212_0 then
				local var_212_8 = Color.New(0, 0, 0)

				var_212_8.a = 1
				arg_209_1.mask_.color = var_212_8
			end

			local var_212_9 = 1.76666666666667

			if 1.76666666666667 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 then
				arg_209_1.mask_.enabled = true
				arg_209_1.mask_.raycastTarget = true

				arg_209_1:SetGaussion(false)
			end

			local var_212_10 = 2

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_10 then
				local var_212_11 = Color.New(0, 0, 0)

				var_212_11.a = Mathf.Lerp(1, 0, (arg_209_1.time_ - var_212_9) / var_212_10)
				arg_209_1.mask_.color = var_212_11
			end

			if arg_209_1.time_ >= var_212_9 + var_212_10 and arg_209_1.time_ < var_212_9 + var_212_10 + arg_212_0 then
				local var_212_12 = Color.New(0, 0, 0)

				arg_209_1.mask_.enabled = false
				var_212_12.a = 0
				arg_209_1.mask_.color = var_212_12
			end

			if 1.76666666666667 < arg_209_1.time_ and arg_209_1.time_ <= 1.76666666666667 + arg_212_0 then
				arg_209_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_209_1.frameCnt_ <= 1 then
				arg_209_1.dialog_:SetActive(false)
			end

			local var_212_14 = 3.61666666666667
			local var_212_15 = 0.15

			if 3.61666666666667 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				arg_209_1.dialog_:SetActive(true)

				arg_209_1.dialogCg_.alpha = 0

				local var_212_16 = LeanTween.value(arg_209_1.dialog_, 0, 1, 0.3)

				var_212_16:setOnUpdate(LuaHelper.FloatAction(function(arg_213_0)
					arg_209_1.dialogCg_.alpha = arg_213_0
				end))
				var_212_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_209_1.dialog_)
					var_212_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_209_1.duration_ = arg_209_1.duration_ + 0.3

				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_17 = arg_209_1:GetWordFromCfg(321022051)
				local var_212_18 = arg_209_1:FormatText(var_212_17.content)

				arg_209_1.text_.text = var_212_18

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 6 <= 0 and var_212_15 or var_212_15 * (utf8.len(var_212_18) / 6)

				if (6 <= 0 and var_212_15 or var_212_15 * (utf8.len(var_212_18) / 6)) > 0 and var_212_15 < var_212_20 then
					arg_209_1.talkMaxDuration = var_212_20
					var_212_14 = var_212_14 + 0.3

					if var_212_20 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_14
					end
				end

				arg_209_1.text_.text = var_212_18
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022051", "story_v_out_321022.awb") ~= 0 then
					local var_212_21 = manager.audio:GetVoiceLength("story_v_out_321022", "321022051", "story_v_out_321022.awb") / 1000

					if var_212_21 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_21 + var_212_14
					end

					if var_212_17.prefab_name ~= "" and arg_209_1.actors_[var_212_17.prefab_name] ~= nil then
						local var_212_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_17.prefab_name].transform, "story_v_out_321022", "321022051", "story_v_out_321022.awb")

						arg_209_1:RecordAudio("321022051", var_212_22)
						arg_209_1:RecordAudio("321022051", var_212_22)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321022", "321022051", "story_v_out_321022.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321022", "321022051", "story_v_out_321022.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_23 = var_212_14 + 0.3
			local var_212_24 = math.max(var_212_15, arg_209_1.talkMaxDuration)

			if var_212_14 + 0.3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_24 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_23) / var_212_24

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_23 + var_212_24 and arg_209_1.time_ < var_212_23 + var_212_24 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play321022052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 321022052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play321022053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.625

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(321022052).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 65 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 65)

				if (65 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 65)) > 0 and var_218_0 < var_218_3 then
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
	Play321022053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 321022053
		arg_219_1.duration_ = 6.07

		local var_219_0 = {
			zh = 5,
			ja = 6.066
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play321022054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.325

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:GetWordFromCfg(321022053)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 13 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 13)

				if (13 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 13)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022053", "story_v_out_321022.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022053", "story_v_out_321022.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_321022", "321022053", "story_v_out_321022.awb")

						arg_219_1:RecordAudio("321022053", var_222_6)
						arg_219_1:RecordAudio("321022053", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_321022", "321022053", "story_v_out_321022.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_321022", "321022053", "story_v_out_321022.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play321022054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 321022054
		arg_223_1.duration_ = 7.87

		local var_223_0 = {
			zh = 6.466,
			ja = 7.866
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
				arg_223_0:Play321022055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.725

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_1 = arg_223_1:GetWordFromCfg(321022054)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 29 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 29)

				if (29 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 29)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022054", "story_v_out_321022.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022054", "story_v_out_321022.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_321022", "321022054", "story_v_out_321022.awb")

						arg_223_1:RecordAudio("321022054", var_226_6)
						arg_223_1:RecordAudio("321022054", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_321022", "321022054", "story_v_out_321022.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_321022", "321022054", "story_v_out_321022.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play321022055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 321022055
		arg_227_1.duration_ = 8.9

		local var_227_0 = {
			zh = 7.433,
			ja = 8.9
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
				arg_227_0:Play321022056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.65

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:GetWordFromCfg(321022055)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 26 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 26)

				if (26 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 26)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022055", "story_v_out_321022.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022055", "story_v_out_321022.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_321022", "321022055", "story_v_out_321022.awb")

						arg_227_1:RecordAudio("321022055", var_230_6)
						arg_227_1:RecordAudio("321022055", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_321022", "321022055", "story_v_out_321022.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_321022", "321022055", "story_v_out_321022.awb")
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
	Play321022056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 321022056
		arg_231_1.duration_ = 12.7

		local var_231_0 = {
			zh = 12.266,
			ja = 12.7
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play321022057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.775

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(321022056)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 31 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 31)

				if (31 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 31)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022056", "story_v_out_321022.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022056", "story_v_out_321022.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_321022", "321022056", "story_v_out_321022.awb")

						arg_231_1:RecordAudio("321022056", var_234_6)
						arg_231_1:RecordAudio("321022056", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_321022", "321022056", "story_v_out_321022.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_321022", "321022056", "story_v_out_321022.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play321022057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 321022057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play321022058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.45

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(321022057).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 58 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 58)

				if (58 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 58)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play321022058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 321022058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play321022059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.675

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(321022058).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 27 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 27)

				if (27 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 27)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play321022059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 321022059
		arg_243_1.duration_ = 9

		local var_243_0 = {
			zh = 6.333,
			ja = 9
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
				arg_243_0:Play321022060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.8

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:GetWordFromCfg(321022059)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 32 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 32)

				if (32 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 32)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022059", "story_v_out_321022.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022059", "story_v_out_321022.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_321022", "321022059", "story_v_out_321022.awb")

						arg_243_1:RecordAudio("321022059", var_246_6)
						arg_243_1:RecordAudio("321022059", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_321022", "321022059", "story_v_out_321022.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_321022", "321022059", "story_v_out_321022.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play321022060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 321022060
		arg_247_1.duration_ = 8

		local var_247_0 = {
			zh = 8,
			ja = 7.733
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play321022061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.7

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[184].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_otis")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(321022060)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 28 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 28)

				if (28 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 28)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321022", "321022060", "story_v_out_321022.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_321022", "321022060", "story_v_out_321022.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_321022", "321022060", "story_v_out_321022.awb")

						arg_247_1:RecordAudio("321022060", var_250_6)
						arg_247_1:RecordAudio("321022060", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_321022", "321022060", "story_v_out_321022.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_321022", "321022060", "story_v_out_321022.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play321022061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 321022061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play321022062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 1.325

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(321022061).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 53 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 53)

				if (53 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 53)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play321022062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 321022062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play321022063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0.426197500200942 < arg_255_1.time_ and arg_255_1.time_ <= 0.426197500200942 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_16", "se_story_16_whoosh", "")
			end

			local var_258_1 = 0
			local var_258_2 = 1.25

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(321022062).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 50 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 50)

				if (50 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 50)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play321022063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 321022063
		arg_259_1.duration_ = 1

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"

			SetActive(arg_259_1.choicesGo_, true)

			for iter_260_0, iter_260_1 in ipairs(arg_259_1.choices_) do
				SetActive(iter_260_1.go, iter_260_0 <= 2)
			end

			arg_259_1.choices_[1].txt.text = arg_259_1:FormatText(StoryChoiceCfg[1251].name)
			arg_259_1.choices_[2].txt.text = arg_259_1:FormatText(StoryChoiceCfg[1252].name)
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play321022064(arg_259_1)
			end

			if arg_261_0 == 2 then
				arg_259_0:Play321022064(arg_259_1)
			end

			arg_259_1:RecordChoiceLog(321022063, 1251, 1252)
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			return
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play321022064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 321022064
		arg_263_1.duration_ = 5.49

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
			arg_263_1.auto_ = false
		end

		function arg_263_1.playNext_(arg_265_0)
			arg_263_1.onStoryFinished_()
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "se_story_140", "se_story_140_hit", "")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_266_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_263_1.bgmTxt_.text ~= var_266_3 and arg_263_1.bgmTxt_.text ~= "" then
						if arg_263_1.bgmTxt2_.text ~= "" then
							arg_263_1.bgmTxt_.text = arg_263_1.bgmTxt2_.text
						end

						arg_263_1.bgmTxt2_.text = var_266_3

						arg_263_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_263_1.bgmTxt_.text = var_266_3
						arg_263_1.bgmTxt2_.text = var_266_3
					end

					if arg_263_1.bgmTimer then
						arg_263_1.bgmTimer:Stop()

						arg_263_1.bgmTimer = nil
					end

					if arg_263_1.settingData.show_music_name == 1 then
						arg_263_1.musicController:SetSelectedState("show")
						arg_263_1.musicAnimator_:Play("open", 0, 0)

						if arg_263_1.settingData.music_time ~= 0 then
							arg_263_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_263_1.settingData.music_time), function()
								if arg_263_1 == nil or isNil(arg_263_1.bgmTxt_) then
									return
								end

								arg_263_1.musicController:SetSelectedState("hide")
								arg_263_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_266_4 = manager.ui.mainCamera.transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.shakeOldPos = var_266_4.localPosition
			end

			local var_266_5 = 0.833333333333333

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_5 then
				local var_266_6, var_266_7 = math.modf((arg_263_1.time_ - 0) / 0.066)

				var_266_4.localPosition = Vector3.New(var_266_7 * 0.13, var_266_7 * 0.13, var_266_7 * 0.13) + arg_263_1.var_.shakeOldPos
			end

			if arg_263_1.time_ >= 0 + var_266_5 and arg_263_1.time_ < 0 + var_266_5 + arg_266_0 then
				var_266_4.localPosition = arg_263_1.var_.shakeOldPos
			end

			local var_266_8 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			if arg_263_1.time_ >= var_266_8 + 0.566666666666667 and arg_263_1.time_ < var_266_8 + 0.566666666666667 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_9 = 0.491666666666667
			local var_266_10 = 0.075

			if 0.491666666666667 < arg_263_1.time_ and arg_263_1.time_ <= var_266_9 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_11 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_11:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_263_1.dialogCg_.alpha = arg_268_0
				end))
				var_266_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_12 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(321022064).content)

				arg_263_1.text_.text = var_266_12

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_14 = 3 <= 0 and var_266_10 or var_266_10 * (utf8.len(var_266_12) / 3)

				if (3 <= 0 and var_266_10 or var_266_10 * (utf8.len(var_266_12) / 3)) > 0 and var_266_10 < var_266_14 then
					arg_263_1.talkMaxDuration = var_266_14
					var_266_9 = var_266_9 + 0.3

					if var_266_14 + var_266_9 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_14 + var_266_9
					end
				end

				arg_263_1.text_.text = var_266_12
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_15 = var_266_9 + 0.3
			local var_266_16 = math.max(var_266_10, arg_263_1.talkMaxDuration)

			if var_266_9 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_16 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_16

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_16 and arg_263_1.time_ < var_266_15 + var_266_16 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L13g",
		"TextureConfig/Background/ST0506",
		"TextureConfig/Background/L08f"
	},
	voices = {
		"story_v_out_321022.awb"
	}
}
