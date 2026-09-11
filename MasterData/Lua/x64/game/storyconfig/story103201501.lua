return {
	Play320151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320151001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L07k == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L07k")
				var_4_0.name = "L07k"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L07k = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L07k

				arg_1_1.bgs_.L07k.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L07k" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999998

			if 1.999999999998 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_6_story_new_industry", "bgm_activity_3_6_story_new_industry")

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

			local var_4_15 = 1.999999999998
			local var_4_16 = 1.3

			if 1.999999999998 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(320151001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 52)

				if (52 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 52)) > 0 and var_4_16 < var_4_20 then
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
	Play320151002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320151002
		arg_9_1.duration_ = 3.47

		local var_9_0 = {
			zh = 2.833,
			ja = 3.466
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
				arg_9_0:Play320151003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(320151002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 8)

				if (8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 8)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151002", "story_v_out_320151.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151002", "story_v_out_320151.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_320151", "320151002", "story_v_out_320151.awb")

						arg_9_1:RecordAudio("320151002", var_12_6)
						arg_9_1:RecordAudio("320151002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320151", "320151002", "story_v_out_320151.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320151", "320151002", "story_v_out_320151.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play320151003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320151003
		arg_13_1.duration_ = 7.53

		local var_13_0 = {
			zh = 3.533,
			ja = 7.533
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
				arg_13_0:Play320151004(arg_13_1)
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
				arg_13_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.325

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

				local var_16_10 = arg_13_1:GetWordFromCfg(320151003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 13 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 13)

				if (13 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 13)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151003", "story_v_out_320151.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_320151", "320151003", "story_v_out_320151.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_320151", "320151003", "story_v_out_320151.awb")

						arg_13_1:RecordAudio("320151003", var_16_15)
						arg_13_1:RecordAudio("320151003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_320151", "320151003", "story_v_out_320151.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_320151", "320151003", "story_v_out_320151.awb")
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
	Play320151004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320151004
		arg_17_1.duration_ = 3.53

		local var_17_0 = {
			zh = 3.533,
			ja = 1.6
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
				arg_17_0:Play320151005(arg_17_1)
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
			local var_20_2 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(320151004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 10 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 10)

				if (10 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 10)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151004", "story_v_out_320151.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151004", "story_v_out_320151.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_320151", "320151004", "story_v_out_320151.awb")

						arg_17_1:RecordAudio("320151004", var_20_8)
						arg_17_1:RecordAudio("320151004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320151", "320151004", "story_v_out_320151.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320151", "320151004", "story_v_out_320151.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play320151005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320151005
		arg_21_1.duration_ = 12.07

		local var_21_0 = {
			zh = 7.633,
			ja = 12.066
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
				arg_21_0:Play320151006(arg_21_1)
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
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.8

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

				local var_24_4 = arg_21_1:GetWordFromCfg(320151005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 32 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 32)

				if (32 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 32)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151005", "story_v_out_320151.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151005", "story_v_out_320151.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_320151", "320151005", "story_v_out_320151.awb")

						arg_21_1:RecordAudio("320151005", var_24_9)
						arg_21_1:RecordAudio("320151005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320151", "320151005", "story_v_out_320151.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320151", "320151005", "story_v_out_320151.awb")
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
	Play320151006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320151006
		arg_25_1.duration_ = 8.1

		local var_25_0 = {
			zh = 5.6,
			ja = 8.1
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
				arg_25_0:Play320151007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.6

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(320151006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 24 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 24)

				if (24 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 24)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151006", "story_v_out_320151.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151006", "story_v_out_320151.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_320151", "320151006", "story_v_out_320151.awb")

						arg_25_1:RecordAudio("320151006", var_28_6)
						arg_25_1:RecordAudio("320151006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320151", "320151006", "story_v_out_320151.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320151", "320151006", "story_v_out_320151.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play320151007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320151007
		arg_29_1.duration_ = 9.9

		local var_29_0 = {
			zh = 5.9,
			ja = 9.9
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
				arg_29_0:Play320151008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) and arg_29_1.var_.characterEffect1020ui_story == nil then
				arg_29_1.var_.characterEffect1020ui_story = arg_29_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) then
				if arg_29_1.var_.characterEffect1020ui_story and not isNil(arg_29_1.actors_["1020ui_story"]) then
					arg_29_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1020ui_story"]) and arg_29_1.var_.characterEffect1020ui_story then
				arg_29_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.6

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(320151007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 24 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 24)

				if (24 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 24)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151007", "story_v_out_320151.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151007", "story_v_out_320151.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_320151", "320151007", "story_v_out_320151.awb")

						arg_29_1:RecordAudio("320151007", var_32_8)
						arg_29_1:RecordAudio("320151007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320151", "320151007", "story_v_out_320151.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320151", "320151007", "story_v_out_320151.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play320151008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320151008
		arg_33_1.duration_ = 2.6

		local var_33_0 = {
			zh = 2.166,
			ja = 2.6
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
				arg_33_0:Play320151009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) and arg_33_1.var_.characterEffect1020ui_story == nil then
				arg_33_1.var_.characterEffect1020ui_story = arg_33_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) then
				if arg_33_1.var_.characterEffect1020ui_story and not isNil(arg_33_1.actors_["1020ui_story"]) then
					arg_33_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1020ui_story"]) and arg_33_1.var_.characterEffect1020ui_story then
				arg_33_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_36_2 = 0
			local var_36_3 = 0.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(320151008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 8 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 8)

				if (8 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 8)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151008", "story_v_out_320151.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151008", "story_v_out_320151.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_320151", "320151008", "story_v_out_320151.awb")

						arg_33_1:RecordAudio("320151008", var_36_9)
						arg_33_1:RecordAudio("320151008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320151", "320151008", "story_v_out_320151.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320151", "320151008", "story_v_out_320151.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_10 and arg_33_1.time_ < var_36_2 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play320151009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320151009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play320151010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) and arg_37_1.var_.characterEffect1020ui_story == nil then
				arg_37_1.var_.characterEffect1020ui_story = arg_37_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) then
				if arg_37_1.var_.characterEffect1020ui_story and not isNil(arg_37_1.actors_["1020ui_story"]) then
					arg_37_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1020ui_story"]) and arg_37_1.var_.characterEffect1020ui_story then
				arg_37_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 1.575

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(320151009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 63 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 63)

				if (63 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 63)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320151010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320151010
		arg_41_1.duration_ = 5.4

		local var_41_0 = {
			zh = 2.966,
			ja = 5.4
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
				arg_41_0:Play320151011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) and arg_41_1.var_.characterEffect1020ui_story == nil then
				arg_41_1.var_.characterEffect1020ui_story = arg_41_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) then
				if arg_41_1.var_.characterEffect1020ui_story and not isNil(arg_41_1.actors_["1020ui_story"]) then
					arg_41_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1020ui_story"]) and arg_41_1.var_.characterEffect1020ui_story then
				arg_41_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_44_2 = 0
			local var_44_3 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(320151010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 10 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 10)

				if (10 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 10)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151010", "story_v_out_320151.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151010", "story_v_out_320151.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_320151", "320151010", "story_v_out_320151.awb")

						arg_41_1:RecordAudio("320151010", var_44_9)
						arg_41_1:RecordAudio("320151010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_320151", "320151010", "story_v_out_320151.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_320151", "320151010", "story_v_out_320151.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play320151011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 320151011
		arg_45_1.duration_ = 8.2

		local var_45_0 = {
			zh = 6.86600000298023,
			ja = 8.20000000298023
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play320151012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if arg_45_1.bgs_.L01f == nil then
				local var_48_0 = Object.Instantiate(arg_45_1.paintGo_)

				var_48_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_48_0.name = "L01f"
				var_48_0.transform.parent = arg_45_1.stage_.transform
				var_48_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.bgs_.L01f = var_48_0
			end

			if 2.00000000298023 < arg_45_1.time_ and arg_45_1.time_ <= 2.00000000298023 + arg_48_0 then
				local var_48_1 = arg_45_1.bgs_.L01f

				arg_45_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_2 = var_48_1:GetComponent("SpriteRenderer")

				if var_48_2 and var_48_2.sprite then
					local var_48_3 = 2 * (var_48_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_1.transform.localScale = Vector3.New(var_48_3 / var_48_2.sprite.bounds.size.y < var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x and var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x or var_48_3 / var_48_2.sprite.bounds.size.y, var_48_3 / var_48_2.sprite.bounds.size.y < var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x and var_48_3 * manager.ui.mainCameraCom_.aspect / var_48_2.sprite.bounds.size.x or var_48_3 / var_48_2.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "L01f" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_4 = 4

			if 4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= var_48_4 + 0.3 and arg_45_1.time_ < var_48_4 + 0.3 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_5 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_6 = 2

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_6 then
				local var_48_7 = Color.New(0, 0, 0)

				var_48_7.a = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_5) / var_48_6)
				arg_45_1.mask_.color = var_48_7
			end

			if arg_45_1.time_ >= var_48_5 + var_48_6 and arg_45_1.time_ < var_48_5 + var_48_6 + arg_48_0 then
				local var_48_8 = Color.New(0, 0, 0)

				var_48_8.a = 1
				arg_45_1.mask_.color = var_48_8
			end

			local var_48_9 = 2

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_9 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_10 = 2

			if var_48_9 <= arg_45_1.time_ and arg_45_1.time_ < var_48_9 + var_48_10 then
				local var_48_11 = Color.New(0, 0, 0)

				var_48_11.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_9) / var_48_10)
				arg_45_1.mask_.color = var_48_11
			end

			if arg_45_1.time_ >= var_48_9 + var_48_10 and arg_45_1.time_ < var_48_9 + var_48_10 + arg_48_0 then
				local var_48_12 = Color.New(0, 0, 0)

				arg_45_1.mask_.enabled = false
				var_48_12.a = 0
				arg_45_1.mask_.color = var_48_12
			end

			local var_48_13 = arg_45_1.actors_["1020ui_story"].transform

			if 3.8 < arg_45_1.time_ and arg_45_1.time_ <= 3.8 + arg_48_0 then
				arg_45_1.var_.moveOldPos1020ui_story = var_48_13.localPosition
			end

			local var_48_14 = 0.001

			if 3.8 <= arg_45_1.time_ and arg_45_1.time_ < 3.8 + var_48_14 then
				var_48_13.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_45_1.time_ - 3.8) / var_48_14)
				var_48_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_13.position).x, (manager.ui.mainCamera.transform.position - var_48_13.position).y, (manager.ui.mainCamera.transform.position - var_48_13.position).z)
				var_48_13.localEulerAngles.z = 0
				var_48_13.localEulerAngles.x = 0
				var_48_13.localEulerAngles = var_48_13.localEulerAngles
			end

			if arg_45_1.time_ >= 3.8 + var_48_14 and arg_45_1.time_ < 3.8 + var_48_14 + arg_48_0 then
				var_48_13.localPosition = Vector3.New(0, -0.85, -6.25)
				var_48_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_13.position).x, (manager.ui.mainCamera.transform.position - var_48_13.position).y, (manager.ui.mainCamera.transform.position - var_48_13.position).z)
				var_48_13.localEulerAngles.z = 0
				var_48_13.localEulerAngles.x = 0
				var_48_13.localEulerAngles = var_48_13.localEulerAngles
			end

			local var_48_15 = arg_45_1.actors_["1020ui_story"]

			if 3.8 < arg_45_1.time_ and arg_45_1.time_ <= 3.8 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.characterEffect1020ui_story == nil then
				arg_45_1.var_.characterEffect1020ui_story = var_48_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_16 = 0.200000002980232

			if 3.8 <= arg_45_1.time_ and arg_45_1.time_ < 3.8 + var_48_16 and not isNil(var_48_15) then
				if arg_45_1.var_.characterEffect1020ui_story and not isNil(var_48_15) then
					arg_45_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 3.8 + var_48_16 and arg_45_1.time_ < 3.8 + var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.characterEffect1020ui_story then
				arg_45_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 3.8 < arg_45_1.time_ and arg_45_1.time_ <= 3.8 + arg_48_0 then
				arg_45_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 3.8 < arg_45_1.time_ and arg_45_1.time_ <= 3.8 + arg_48_0 then
				arg_45_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_18 = arg_45_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_45_1.time_ and arg_45_1.time_ <= 1.96599999815226 + arg_48_0 then
				arg_45_1.var_.moveOldPos1020ui_story = var_48_18.localPosition
			end

			local var_48_19 = 0.001

			if 1.96599999815226 <= arg_45_1.time_ and arg_45_1.time_ < 1.96599999815226 + var_48_19 then
				var_48_18.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 1.96599999815226) / var_48_19)
				var_48_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_18.position).x, (manager.ui.mainCamera.transform.position - var_48_18.position).y, (manager.ui.mainCamera.transform.position - var_48_18.position).z)
				var_48_18.localEulerAngles.z = 0
				var_48_18.localEulerAngles.x = 0
				var_48_18.localEulerAngles = var_48_18.localEulerAngles
			end

			if arg_45_1.time_ >= 1.96599999815226 + var_48_19 and arg_45_1.time_ < 1.96599999815226 + var_48_19 + arg_48_0 then
				var_48_18.localPosition = Vector3.New(0, 100, 0)
				var_48_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_18.position).x, (manager.ui.mainCamera.transform.position - var_48_18.position).y, (manager.ui.mainCamera.transform.position - var_48_18.position).z)
				var_48_18.localEulerAngles.z = 0
				var_48_18.localEulerAngles.x = 0
				var_48_18.localEulerAngles = var_48_18.localEulerAngles
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_20 = 4.00000000298023
			local var_48_21 = 0.325

			if 4.00000000298023 < arg_45_1.time_ and arg_45_1.time_ <= var_48_20 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_22 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_22:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_23 = arg_45_1:GetWordFromCfg(320151011)
				local var_48_24 = arg_45_1:FormatText(var_48_23.content)

				arg_45_1.text_.text = var_48_24

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_26 = 13 <= 0 and var_48_21 or var_48_21 * (utf8.len(var_48_24) / 13)

				if (13 <= 0 and var_48_21 or var_48_21 * (utf8.len(var_48_24) / 13)) > 0 and var_48_21 < var_48_26 then
					arg_45_1.talkMaxDuration = var_48_26
					var_48_20 = var_48_20 + 0.3

					if var_48_26 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_26 + var_48_20
					end
				end

				arg_45_1.text_.text = var_48_24
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151011", "story_v_out_320151.awb") ~= 0 then
					local var_48_27 = manager.audio:GetVoiceLength("story_v_out_320151", "320151011", "story_v_out_320151.awb") / 1000

					if var_48_27 + var_48_20 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_27 + var_48_20
					end

					if var_48_23.prefab_name ~= "" and arg_45_1.actors_[var_48_23.prefab_name] ~= nil then
						local var_48_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_23.prefab_name].transform, "story_v_out_320151", "320151011", "story_v_out_320151.awb")

						arg_45_1:RecordAudio("320151011", var_48_28)
						arg_45_1:RecordAudio("320151011", var_48_28)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_320151", "320151011", "story_v_out_320151.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_320151", "320151011", "story_v_out_320151.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_29 = var_48_20 + 0.3
			local var_48_30 = math.max(var_48_21, arg_45_1.talkMaxDuration)

			if var_48_20 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_29 + var_48_30 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_29) / var_48_30

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_29 + var_48_30 and arg_45_1.time_ < var_48_29 + var_48_30 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play320151012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 320151012
		arg_51_1.duration_ = 3.3

		local var_51_0 = {
			zh = 3.233,
			ja = 3.3
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
				arg_51_0:Play320151013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_54_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_51_1.stage_.transform)

				var_54_0.name = "1056ui_story"
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1056ui_story"] = var_54_0

				local var_54_1 = var_54_0:GetComponentInChildren(typeof(CharacterEffect))

				var_54_1.enabled = true

				local var_54_2 = GameObjectTools.GetOrAddComponent(var_54_0, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_1.transform, false)

				arg_51_1.var_["1056ui_story" .. "Animator"] = var_54_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_51_1.var_["1056ui_story" .. "LipSync"] = var_54_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_3 = arg_51_1.actors_["1056ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1056ui_story = var_54_3.localPosition
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_51_1.time_ - 0) / var_54_4)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0.7, -1, -5.75)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			local var_54_5 = arg_51_1.actors_["1056ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect1056ui_story == nil then
				arg_51_1.var_.characterEffect1056ui_story = var_54_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_6 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.characterEffect1056ui_story and not isNil(var_54_5) then
					arg_51_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.characterEffect1056ui_story then
				arg_51_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_54_8 = arg_51_1.actors_["1020ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1020ui_story = var_54_8.localPosition
			end

			local var_54_9 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_9 then
				var_54_8.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1020ui_story, Vector3.New(-0.7, -0.85, -6.25), (arg_51_1.time_ - 0) / var_54_9)
				var_54_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_8.position).x, (manager.ui.mainCamera.transform.position - var_54_8.position).y, (manager.ui.mainCamera.transform.position - var_54_8.position).z)
				var_54_8.localEulerAngles.z = 0
				var_54_8.localEulerAngles.x = 0
				var_54_8.localEulerAngles = var_54_8.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_9 and arg_51_1.time_ < 0 + var_54_9 + arg_54_0 then
				var_54_8.localPosition = Vector3.New(-0.7, -0.85, -6.25)
				var_54_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_8.position).x, (manager.ui.mainCamera.transform.position - var_54_8.position).y, (manager.ui.mainCamera.transform.position - var_54_8.position).z)
				var_54_8.localEulerAngles.z = 0
				var_54_8.localEulerAngles.x = 0
				var_54_8.localEulerAngles = var_54_8.localEulerAngles
			end

			local var_54_10 = arg_51_1.actors_["1020ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_10) and arg_51_1.var_.characterEffect1020ui_story == nil then
				arg_51_1.var_.characterEffect1020ui_story = var_54_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_11 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_11 and not isNil(var_54_10) then
				if arg_51_1.var_.characterEffect1020ui_story and not isNil(var_54_10) then
					arg_51_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_11)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_11 and arg_51_1.time_ < 0 + var_54_11 + arg_54_0 and not isNil(var_54_10) and arg_51_1.var_.characterEffect1020ui_story then
				arg_51_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_54_12 = 0
			local var_54_13 = 0.375

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_12 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_14 = arg_51_1:GetWordFromCfg(320151012)
				local var_54_15 = arg_51_1:FormatText(var_54_14.content)

				arg_51_1.text_.text = var_54_15

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_17 = 15 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 15)

				if (15 <= 0 and var_54_13 or var_54_13 * (utf8.len(var_54_15) / 15)) > 0 and var_54_13 < var_54_17 then
					arg_51_1.talkMaxDuration = var_54_17

					if var_54_17 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_12
					end
				end

				arg_51_1.text_.text = var_54_15
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151012", "story_v_out_320151.awb") ~= 0 then
					local var_54_18 = manager.audio:GetVoiceLength("story_v_out_320151", "320151012", "story_v_out_320151.awb") / 1000

					if var_54_18 + var_54_12 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_18 + var_54_12
					end

					if var_54_14.prefab_name ~= "" and arg_51_1.actors_[var_54_14.prefab_name] ~= nil then
						local var_54_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_14.prefab_name].transform, "story_v_out_320151", "320151012", "story_v_out_320151.awb")

						arg_51_1:RecordAudio("320151012", var_54_19)
						arg_51_1:RecordAudio("320151012", var_54_19)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_320151", "320151012", "story_v_out_320151.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_320151", "320151012", "story_v_out_320151.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_20 = math.max(var_54_13, arg_51_1.talkMaxDuration)

			if var_54_12 <= arg_51_1.time_ and arg_51_1.time_ < var_54_12 + var_54_20 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_12) / var_54_20

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_12 + var_54_20 and arg_51_1.time_ < var_54_12 + var_54_20 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_51_1:InitPlayNodeList()
	end,
	Play320151013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 320151013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play320151014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1056ui_story = arg_55_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1056ui_story"].transform.position).z)
				arg_55_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1056ui_story"].transform.localEulerAngles = arg_55_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1056ui_story"].transform.position).z)
				arg_55_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1056ui_story"].transform.localEulerAngles = arg_55_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1056ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1056ui_story == nil then
				arg_55_1.var_.characterEffect1056ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1056ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_2)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1056ui_story then
				arg_55_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_58_3 = arg_55_1.actors_["1020ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1020ui_story = var_58_3.localPosition
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_3.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_4)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_3.localPosition = Vector3.New(0, 100, 0)
				var_58_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_3.position).x, (manager.ui.mainCamera.transform.position - var_58_3.position).y, (manager.ui.mainCamera.transform.position - var_58_3.position).z)
				var_58_3.localEulerAngles.z = 0
				var_58_3.localEulerAngles.x = 0
				var_58_3.localEulerAngles = var_58_3.localEulerAngles
			end

			local var_58_5 = arg_55_1.actors_["1020ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect1020ui_story == nil then
				arg_55_1.var_.characterEffect1020ui_story = var_58_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_6 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 and not isNil(var_58_5) then
				if arg_55_1.var_.characterEffect1020ui_story and not isNil(var_58_5) then
					arg_55_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_6)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.characterEffect1020ui_story then
				arg_55_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_58_7 = 0
			local var_58_8 = 1.6

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_9 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(320151013).content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 64 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_9) / 64)

				if (64 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_9) / 64)) > 0 and var_58_8 < var_58_11 then
					arg_55_1.talkMaxDuration = var_58_11

					if var_58_11 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_7
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_8, arg_55_1.talkMaxDuration)

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_7) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_7 + var_58_12 and arg_55_1.time_ < var_58_7 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_55_1:InitPlayNodeList()
	end,
	Play320151014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 320151014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play320151015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.625

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(320151014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 25 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 25)

				if (25 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 25)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play320151015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 320151015
		arg_63_1.duration_ = 11.23

		local var_63_0 = {
			zh = 7.333,
			ja = 11.233
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
				arg_63_0:Play320151016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1020ui_story = arg_63_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1020ui_story, Vector3.New(-0.7, -0.85, -6.25), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1020ui_story"].transform.position).z)
				arg_63_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1020ui_story"].transform.localEulerAngles = arg_63_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(-0.7, -0.85, -6.25)
				arg_63_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1020ui_story"].transform.position).z)
				arg_63_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1020ui_story"].transform.localEulerAngles = arg_63_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1020ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1020ui_story == nil then
				arg_63_1.var_.characterEffect1020ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1020ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1020ui_story then
				arg_63_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_66_4 = 0
			local var_66_5 = 0.825

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(320151015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 33 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 33)

				if (33 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 33)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151015", "story_v_out_320151.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151015", "story_v_out_320151.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_320151", "320151015", "story_v_out_320151.awb")

						arg_63_1:RecordAudio("320151015", var_66_11)
						arg_63_1:RecordAudio("320151015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_320151", "320151015", "story_v_out_320151.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_320151", "320151015", "story_v_out_320151.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play320151016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 320151016
		arg_67_1.duration_ = 7.67

		local var_67_0 = {
			zh = 6.066,
			ja = 7.666
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
				arg_67_0:Play320151017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1056ui_story = arg_67_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1056ui_story, Vector3.New(0.7, -1, -5.75), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1056ui_story"].transform.position).z)
				arg_67_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1056ui_story"].transform.localEulerAngles = arg_67_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0.7, -1, -5.75)
				arg_67_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1056ui_story"].transform.position).z)
				arg_67_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1056ui_story"].transform.localEulerAngles = arg_67_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1056ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1056ui_story == nil then
				arg_67_1.var_.characterEffect1056ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1056ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1056ui_story then
				arg_67_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action7_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_70_4 = arg_67_1.actors_["1020ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1020ui_story == nil then
				arg_67_1.var_.characterEffect1020ui_story = var_70_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_5 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 and not isNil(var_70_4) then
				if arg_67_1.var_.characterEffect1020ui_story and not isNil(var_70_4) then
					arg_67_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_5)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1020ui_story then
				arg_67_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_70_6 = 0
			local var_70_7 = 0.875

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:GetWordFromCfg(320151016)
				local var_70_9 = arg_67_1:FormatText(var_70_8.content)

				arg_67_1.text_.text = var_70_9

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 35 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 35)

				if (35 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 35)) > 0 and var_70_7 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_9
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151016", "story_v_out_320151.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_320151", "320151016", "story_v_out_320151.awb") / 1000

					if var_70_12 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_6
					end

					if var_70_8.prefab_name ~= "" and arg_67_1.actors_[var_70_8.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_8.prefab_name].transform, "story_v_out_320151", "320151016", "story_v_out_320151.awb")

						arg_67_1:RecordAudio("320151016", var_70_13)
						arg_67_1:RecordAudio("320151016", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_320151", "320151016", "story_v_out_320151.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_320151", "320151016", "story_v_out_320151.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play320151017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 320151017
		arg_71_1.duration_ = 4.87

		local var_71_0 = {
			zh = 3.333,
			ja = 4.866
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
				arg_71_0:Play320151018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1020ui_story"]) and arg_71_1.var_.characterEffect1020ui_story == nil then
				arg_71_1.var_.characterEffect1020ui_story = arg_71_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1020ui_story"]) then
				if arg_71_1.var_.characterEffect1020ui_story and not isNil(arg_71_1.actors_["1020ui_story"]) then
					arg_71_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1020ui_story"]) and arg_71_1.var_.characterEffect1020ui_story then
				arg_71_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action446")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_74_2 = arg_71_1.actors_["1056ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1056ui_story == nil then
				arg_71_1.var_.characterEffect1056ui_story = var_74_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_3 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_3 and not isNil(var_74_2) then
				if arg_71_1.var_.characterEffect1056ui_story and not isNil(var_74_2) then
					arg_71_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_3)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_3 and arg_71_1.time_ < 0 + var_74_3 + arg_74_0 and not isNil(var_74_2) and arg_71_1.var_.characterEffect1056ui_story then
				arg_71_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_74_4 = 0
			local var_74_5 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(320151017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 16 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 16)

				if (16 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 16)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151017", "story_v_out_320151.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151017", "story_v_out_320151.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_320151", "320151017", "story_v_out_320151.awb")

						arg_71_1:RecordAudio("320151017", var_74_11)
						arg_71_1:RecordAudio("320151017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_320151", "320151017", "story_v_out_320151.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_320151", "320151017", "story_v_out_320151.awb")
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
	Play320151018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 320151018
		arg_75_1.duration_ = 11.63

		local var_75_0 = {
			zh = 10.166,
			ja = 11.633
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
				arg_75_0:Play320151019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1056ui_story"]) and arg_75_1.var_.characterEffect1056ui_story == nil then
				arg_75_1.var_.characterEffect1056ui_story = arg_75_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1056ui_story"]) then
				if arg_75_1.var_.characterEffect1056ui_story and not isNil(arg_75_1.actors_["1056ui_story"]) then
					arg_75_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1056ui_story"]) and arg_75_1.var_.characterEffect1056ui_story then
				arg_75_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action7_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_78_2 = arg_75_1.actors_["1020ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect1020ui_story == nil then
				arg_75_1.var_.characterEffect1020ui_story = var_78_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_3 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.characterEffect1020ui_story and not isNil(var_78_2) then
					arg_75_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_3)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.characterEffect1020ui_story then
				arg_75_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_78_4 = 0
			local var_78_5 = 1.325

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(320151018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 53 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 53)

				if (53 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 53)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151018", "story_v_out_320151.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151018", "story_v_out_320151.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_out_320151", "320151018", "story_v_out_320151.awb")

						arg_75_1:RecordAudio("320151018", var_78_11)
						arg_75_1:RecordAudio("320151018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_320151", "320151018", "story_v_out_320151.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_320151", "320151018", "story_v_out_320151.awb")
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
	Play320151019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 320151019
		arg_79_1.duration_ = 6.43

		local var_79_0 = {
			zh = 3.333,
			ja = 6.433
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
				arg_79_0:Play320151020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1020ui_story"]) and arg_79_1.var_.characterEffect1020ui_story == nil then
				arg_79_1.var_.characterEffect1020ui_story = arg_79_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1020ui_story"]) then
				if arg_79_1.var_.characterEffect1020ui_story and not isNil(arg_79_1.actors_["1020ui_story"]) then
					arg_79_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1020ui_story"]) and arg_79_1.var_.characterEffect1020ui_story then
				arg_79_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action468")
			end

			local var_82_2 = arg_79_1.actors_["1056ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1056ui_story == nil then
				arg_79_1.var_.characterEffect1056ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.characterEffect1056ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_3)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1056ui_story then
				arg_79_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_82_4 = 0
			local var_82_5 = 0.35

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(320151019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)

				if (14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151019", "story_v_out_320151.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151019", "story_v_out_320151.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_320151", "320151019", "story_v_out_320151.awb")

						arg_79_1:RecordAudio("320151019", var_82_11)
						arg_79_1:RecordAudio("320151019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_320151", "320151019", "story_v_out_320151.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_320151", "320151019", "story_v_out_320151.awb")
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
	Play320151020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 320151020
		arg_83_1.duration_ = 12.73

		local var_83_0 = {
			zh = 11,
			ja = 12.733
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
				arg_83_0:Play320151021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.15

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(320151020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 46 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 46)

				if (46 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 46)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151020", "story_v_out_320151.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151020", "story_v_out_320151.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_320151", "320151020", "story_v_out_320151.awb")

						arg_83_1:RecordAudio("320151020", var_86_6)
						arg_83_1:RecordAudio("320151020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_320151", "320151020", "story_v_out_320151.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_320151", "320151020", "story_v_out_320151.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play320151021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 320151021
		arg_87_1.duration_ = 9.1

		local var_87_0 = {
			zh = 5.166,
			ja = 9.1
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play320151022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1020ui_story"]) and arg_87_1.var_.characterEffect1020ui_story == nil then
				arg_87_1.var_.characterEffect1020ui_story = arg_87_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1020ui_story"]) then
				if arg_87_1.var_.characterEffect1020ui_story and not isNil(arg_87_1.actors_["1020ui_story"]) then
					arg_87_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1020ui_story"]) and arg_87_1.var_.characterEffect1020ui_story then
				arg_87_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_90_2 = 0
			local var_90_3 = 0.6

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(320151021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 24 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 24)

				if (24 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 24)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151021", "story_v_out_320151.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151021", "story_v_out_320151.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_320151", "320151021", "story_v_out_320151.awb")

						arg_87_1:RecordAudio("320151021", var_90_9)
						arg_87_1:RecordAudio("320151021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_320151", "320151021", "story_v_out_320151.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_320151", "320151021", "story_v_out_320151.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play320151022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 320151022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play320151023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1020ui_story = arg_91_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).z)
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles = arg_91_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).z)
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles = arg_91_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1020ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1020ui_story == nil then
				arg_91_1.var_.characterEffect1020ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1020ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1020ui_story then
				arg_91_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_94_3 = arg_91_1.actors_["1056ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1056ui_story = var_94_3.localPosition
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_3.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_4)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_3.localPosition = Vector3.New(0, 100, 0)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			local var_94_5 = arg_91_1.actors_["1056ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect1056ui_story == nil then
				arg_91_1.var_.characterEffect1056ui_story = var_94_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.characterEffect1056ui_story and not isNil(var_94_5) then
					arg_91_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_6)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect1056ui_story then
				arg_91_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_94_7 = 0
			local var_94_8 = 0.6

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_9 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(320151022).content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 24 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_9) / 24)

				if (24 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_9) / 24)) > 0 and var_94_8 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_7
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_8, arg_91_1.talkMaxDuration)

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_7) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_7 + var_94_12 and arg_91_1.time_ < var_94_7 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320151023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 320151023
		arg_95_1.duration_ = 8.5

		local var_95_0 = {
			zh = 7.3,
			ja = 8.5
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play320151024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1020ui_story = arg_95_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1020ui_story"].transform.position).z)
				arg_95_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1020ui_story"].transform.localEulerAngles = arg_95_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_95_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1020ui_story"].transform.position).z)
				arg_95_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1020ui_story"].transform.localEulerAngles = arg_95_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1020ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1020ui_story == nil then
				arg_95_1.var_.characterEffect1020ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1020ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1020ui_story then
				arg_95_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_98_4 = 0
			local var_98_5 = 0.85

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(320151023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 34 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 34)

				if (34 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 34)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151023", "story_v_out_320151.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151023", "story_v_out_320151.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_320151", "320151023", "story_v_out_320151.awb")

						arg_95_1:RecordAudio("320151023", var_98_11)
						arg_95_1:RecordAudio("320151023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_320151", "320151023", "story_v_out_320151.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_320151", "320151023", "story_v_out_320151.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play320151024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 320151024
		arg_99_1.duration_ = 7.7

		local var_99_0 = {
			zh = 7.7,
			ja = 7.566
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
				arg_99_0:Play320151025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 2 < arg_99_1.time_ and arg_99_1.time_ <= 2 + arg_102_0 then
				local var_102_0 = arg_99_1.bgs_.L01f

				arg_99_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_102_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_102_1 = var_102_0:GetComponent("SpriteRenderer")

				if var_102_1 and var_102_1.sprite then
					local var_102_2 = 2 * (var_102_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_102_0.transform.localScale = Vector3.New(var_102_2 / var_102_1.sprite.bounds.size.y < var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x and var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x or var_102_2 / var_102_1.sprite.bounds.size.y, var_102_2 / var_102_1.sprite.bounds.size.y < var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x and var_102_2 * manager.ui.mainCameraCom_.aspect / var_102_1.sprite.bounds.size.x or var_102_2 / var_102_1.sprite.bounds.size.y, 0)
				end

				for iter_102_0, iter_102_1 in pairs(arg_99_1.bgs_) do
					if iter_102_0 ~= "L01f" then
						iter_102_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_102_3 = 4

			if 4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_3 + 0.3 and arg_99_1.time_ < var_102_3 + 0.3 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			local var_102_4 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_5 = 2

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_5 then
				local var_102_6 = Color.New(0, 0, 0)

				var_102_6.a = Mathf.Lerp(0, 1, (arg_99_1.time_ - var_102_4) / var_102_5)
				arg_99_1.mask_.color = var_102_6
			end

			if arg_99_1.time_ >= var_102_4 + var_102_5 and arg_99_1.time_ < var_102_4 + var_102_5 + arg_102_0 then
				local var_102_7 = Color.New(0, 0, 0)

				var_102_7.a = 1
				arg_99_1.mask_.color = var_102_7
			end

			local var_102_8 = 2

			if 2 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.mask_.enabled = true
				arg_99_1.mask_.raycastTarget = true

				arg_99_1:SetGaussion(false)
			end

			local var_102_9 = 2

			if var_102_8 <= arg_99_1.time_ and arg_99_1.time_ < var_102_8 + var_102_9 then
				local var_102_10 = Color.New(0, 0, 0)

				var_102_10.a = Mathf.Lerp(1, 0, (arg_99_1.time_ - var_102_8) / var_102_9)
				arg_99_1.mask_.color = var_102_10
			end

			if arg_99_1.time_ >= var_102_8 + var_102_9 and arg_99_1.time_ < var_102_8 + var_102_9 + arg_102_0 then
				local var_102_11 = Color.New(0, 0, 0)

				arg_99_1.mask_.enabled = false
				var_102_11.a = 0
				arg_99_1.mask_.color = var_102_11
			end

			local var_102_12 = arg_99_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_99_1.time_ and arg_99_1.time_ <= 1.96599999815226 + arg_102_0 then
				arg_99_1.var_.moveOldPos1020ui_story = var_102_12.localPosition
			end

			local var_102_13 = 0.001

			if 1.96599999815226 <= arg_99_1.time_ and arg_99_1.time_ < 1.96599999815226 + var_102_13 then
				var_102_12.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 1.96599999815226) / var_102_13)
				var_102_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_12.position).x, (manager.ui.mainCamera.transform.position - var_102_12.position).y, (manager.ui.mainCamera.transform.position - var_102_12.position).z)
				var_102_12.localEulerAngles.z = 0
				var_102_12.localEulerAngles.x = 0
				var_102_12.localEulerAngles = var_102_12.localEulerAngles
			end

			if arg_99_1.time_ >= 1.96599999815226 + var_102_13 and arg_99_1.time_ < 1.96599999815226 + var_102_13 + arg_102_0 then
				var_102_12.localPosition = Vector3.New(0, 100, 0)
				var_102_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_12.position).x, (manager.ui.mainCamera.transform.position - var_102_12.position).y, (manager.ui.mainCamera.transform.position - var_102_12.position).z)
				var_102_12.localEulerAngles.z = 0
				var_102_12.localEulerAngles.x = 0
				var_102_12.localEulerAngles = var_102_12.localEulerAngles
			end

			local var_102_14 = arg_99_1.actors_["1020ui_story"]

			if 1.96599999815226 < arg_99_1.time_ and arg_99_1.time_ <= 1.96599999815226 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.characterEffect1020ui_story == nil then
				arg_99_1.var_.characterEffect1020ui_story = var_102_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_15 = 0.034000001847744

			if 1.96599999815226 <= arg_99_1.time_ and arg_99_1.time_ < 1.96599999815226 + var_102_15 and not isNil(var_102_14) then
				if arg_99_1.var_.characterEffect1020ui_story and not isNil(var_102_14) then
					arg_99_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 1.96599999815226) / var_102_15)
				end
			end

			if arg_99_1.time_ >= 1.96599999815226 + var_102_15 and arg_99_1.time_ < 1.96599999815226 + var_102_15 + arg_102_0 and not isNil(var_102_14) and arg_99_1.var_.characterEffect1020ui_story then
				arg_99_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_102_16 = arg_99_1.actors_["1056ui_story"].transform

			if 1.96599999815226 < arg_99_1.time_ and arg_99_1.time_ <= 1.96599999815226 + arg_102_0 then
				arg_99_1.var_.moveOldPos1056ui_story = var_102_16.localPosition
			end

			local var_102_17 = 0.001

			if 1.96599999815226 <= arg_99_1.time_ and arg_99_1.time_ < 1.96599999815226 + var_102_17 then
				var_102_16.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 1.96599999815226) / var_102_17)
				var_102_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_16.position).x, (manager.ui.mainCamera.transform.position - var_102_16.position).y, (manager.ui.mainCamera.transform.position - var_102_16.position).z)
				var_102_16.localEulerAngles.z = 0
				var_102_16.localEulerAngles.x = 0
				var_102_16.localEulerAngles = var_102_16.localEulerAngles
			end

			if arg_99_1.time_ >= 1.96599999815226 + var_102_17 and arg_99_1.time_ < 1.96599999815226 + var_102_17 + arg_102_0 then
				var_102_16.localPosition = Vector3.New(0, 100, 0)
				var_102_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_16.position).x, (manager.ui.mainCamera.transform.position - var_102_16.position).y, (manager.ui.mainCamera.transform.position - var_102_16.position).z)
				var_102_16.localEulerAngles.z = 0
				var_102_16.localEulerAngles.x = 0
				var_102_16.localEulerAngles = var_102_16.localEulerAngles
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_18 = 4
			local var_102_19 = 0.525

			if 4 < arg_99_1.time_ and arg_99_1.time_ <= var_102_18 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_20 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_20:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_21 = arg_99_1:GetWordFromCfg(320151024)
				local var_102_22 = arg_99_1:FormatText(var_102_21.content)

				arg_99_1.text_.text = var_102_22

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_24 = 21 <= 0 and var_102_19 or var_102_19 * (utf8.len(var_102_22) / 21)

				if (21 <= 0 and var_102_19 or var_102_19 * (utf8.len(var_102_22) / 21)) > 0 and var_102_19 < var_102_24 then
					arg_99_1.talkMaxDuration = var_102_24
					var_102_18 = var_102_18 + 0.3

					if var_102_24 + var_102_18 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_24 + var_102_18
					end
				end

				arg_99_1.text_.text = var_102_22
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151024", "story_v_out_320151.awb") ~= 0 then
					local var_102_25 = manager.audio:GetVoiceLength("story_v_out_320151", "320151024", "story_v_out_320151.awb") / 1000

					if var_102_25 + var_102_18 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_25 + var_102_18
					end

					if var_102_21.prefab_name ~= "" and arg_99_1.actors_[var_102_21.prefab_name] ~= nil then
						local var_102_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_21.prefab_name].transform, "story_v_out_320151", "320151024", "story_v_out_320151.awb")

						arg_99_1:RecordAudio("320151024", var_102_26)
						arg_99_1:RecordAudio("320151024", var_102_26)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_320151", "320151024", "story_v_out_320151.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_320151", "320151024", "story_v_out_320151.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_27 = var_102_18 + 0.3
			local var_102_28 = math.max(var_102_19, arg_99_1.talkMaxDuration)

			if var_102_18 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_27 + var_102_28 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_27) / var_102_28

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_27 + var_102_28 and arg_99_1.time_ < var_102_27 + var_102_28 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play320151025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320151025
		arg_105_1.duration_ = 4.1

		local var_105_0 = {
			zh = 2.166,
			ja = 4.1
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
				arg_105_0:Play320151026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.2

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1027].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(320151025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 8 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 8)

				if (8 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 8)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151025", "story_v_out_320151.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151025", "story_v_out_320151.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_320151", "320151025", "story_v_out_320151.awb")

						arg_105_1:RecordAudio("320151025", var_108_6)
						arg_105_1:RecordAudio("320151025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_320151", "320151025", "story_v_out_320151.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_320151", "320151025", "story_v_out_320151.awb")
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
	Play320151026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 320151026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play320151027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(320151026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 45 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 45)

				if (45 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 45)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play320151027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 320151027
		arg_113_1.duration_ = 4.43

		local var_113_0 = {
			zh = 4.3,
			ja = 4.433
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
				arg_113_0:Play320151028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(320151027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 22 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 22)

				if (22 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 22)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151027", "story_v_out_320151.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151027", "story_v_out_320151.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_320151", "320151027", "story_v_out_320151.awb")

						arg_113_1:RecordAudio("320151027", var_116_6)
						arg_113_1:RecordAudio("320151027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_320151", "320151027", "story_v_out_320151.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_320151", "320151027", "story_v_out_320151.awb")
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
	Play320151028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 320151028
		arg_117_1.duration_ = 5.47

		local var_117_0 = {
			zh = 5.466,
			ja = 4.266
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
				arg_117_0:Play320151029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.7

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(320151028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 28 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 28)

				if (28 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 28)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151028", "story_v_out_320151.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151028", "story_v_out_320151.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_320151", "320151028", "story_v_out_320151.awb")

						arg_117_1:RecordAudio("320151028", var_120_6)
						arg_117_1:RecordAudio("320151028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_320151", "320151028", "story_v_out_320151.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_320151", "320151028", "story_v_out_320151.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play320151029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 320151029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play320151030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1.2

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(320151029).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 48 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 48)

				if (48 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 48)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play320151030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320151030
		arg_125_1.duration_ = 12.5

		local var_125_0 = {
			zh = 8.466,
			ja = 12.5
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
				arg_125_0:Play320151031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.bgs_.ST05a == nil then
				local var_128_0 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST05a")
				var_128_0.name = "ST05a"
				var_128_0.transform.parent = arg_125_1.stage_.transform
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_.ST05a = var_128_0
			end

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				local var_128_1 = arg_125_1.bgs_.ST05a

				arg_125_1.bgs_.ST05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_2 = var_128_1:GetComponent("SpriteRenderer")

				if var_128_2 and var_128_2.sprite then
					local var_128_3 = 2 * (var_128_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_1.transform.localScale = Vector3.New(var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "ST05a" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_4 = 4

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			if arg_125_1.time_ >= var_128_4 + 0.3 and arg_125_1.time_ < var_128_4 + 0.3 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_5 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_6 = 2

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 then
				local var_128_7 = Color.New(0, 0, 0)

				var_128_7.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - var_128_5) / var_128_6)
				arg_125_1.mask_.color = var_128_7
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 then
				local var_128_8 = Color.New(0, 0, 0)

				var_128_8.a = 1
				arg_125_1.mask_.color = var_128_8
			end

			local var_128_9 = 2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_10 = 2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 then
				local var_128_11 = Color.New(0, 0, 0)

				var_128_11.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_9) / var_128_10)
				arg_125_1.mask_.color = var_128_11
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 then
				local var_128_12 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_12.a = 0
				arg_125_1.mask_.color = var_128_12
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_13 = 4
			local var_128_14 = 0.45

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_15 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_15:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_16 = arg_125_1:GetWordFromCfg(320151030)
				local var_128_17 = arg_125_1:FormatText(var_128_16.content)

				arg_125_1.text_.text = var_128_17

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_19 = 18 <= 0 and var_128_14 or var_128_14 * (utf8.len(var_128_17) / 18)

				if (18 <= 0 and var_128_14 or var_128_14 * (utf8.len(var_128_17) / 18)) > 0 and var_128_14 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19
					var_128_13 = var_128_13 + 0.3

					if var_128_19 + var_128_13 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_13
					end
				end

				arg_125_1.text_.text = var_128_17
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151030", "story_v_out_320151.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_out_320151", "320151030", "story_v_out_320151.awb") / 1000

					if var_128_20 + var_128_13 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_13
					end

					if var_128_16.prefab_name ~= "" and arg_125_1.actors_[var_128_16.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_16.prefab_name].transform, "story_v_out_320151", "320151030", "story_v_out_320151.awb")

						arg_125_1:RecordAudio("320151030", var_128_21)
						arg_125_1:RecordAudio("320151030", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320151", "320151030", "story_v_out_320151.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320151", "320151030", "story_v_out_320151.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = var_128_13 + 0.3
			local var_128_23 = math.max(var_128_14, arg_125_1.talkMaxDuration)

			if var_128_13 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_22 + var_128_23 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_22) / var_128_23

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_22 + var_128_23 and arg_125_1.time_ < var_128_22 + var_128_23 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320151031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 320151031
		arg_131_1.duration_ = 12.6

		local var_131_0 = {
			zh = 6.466,
			ja = 12.6
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
				arg_131_0:Play320151032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_134_0 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_131_1.stage_.transform)

				var_134_0.name = "10100ui_story"
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["10100ui_story"] = var_134_0

				local var_134_1 = var_134_0:GetComponentInChildren(typeof(CharacterEffect))

				var_134_1.enabled = true

				local var_134_2 = GameObjectTools.GetOrAddComponent(var_134_0, typeof(DynamicBoneHelper))

				if var_134_2 then
					var_134_2:EnableDynamicBone(false)
				end

				arg_131_1:ShowWeapon(var_134_1.transform, false)

				arg_131_1.var_["10100ui_story" .. "Animator"] = var_134_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_131_1.var_["10100ui_story" .. "Animator"].applyRootMotion = true
				arg_131_1.var_["10100ui_story" .. "LipSync"] = var_134_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_134_3 = arg_131_1.actors_["10100ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10100ui_story = var_134_3.localPosition
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_3.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_131_1.time_ - 0) / var_134_4)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			local var_134_5 = arg_131_1.actors_["10100ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect10100ui_story == nil then
				arg_131_1.var_.characterEffect10100ui_story = var_134_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.characterEffect10100ui_story and not isNil(var_134_5) then
					arg_131_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect10100ui_story then
				arg_131_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action3_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_134_8 = 0
			local var_134_9 = 0.725

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_8 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_10 = arg_131_1:GetWordFromCfg(320151031)
				local var_134_11 = arg_131_1:FormatText(var_134_10.content)

				arg_131_1.text_.text = var_134_11

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_13 = 29 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 29)

				if (29 <= 0 and var_134_9 or var_134_9 * (utf8.len(var_134_11) / 29)) > 0 and var_134_9 < var_134_13 then
					arg_131_1.talkMaxDuration = var_134_13

					if var_134_13 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_13 + var_134_8
					end
				end

				arg_131_1.text_.text = var_134_11
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151031", "story_v_out_320151.awb") ~= 0 then
					local var_134_14 = manager.audio:GetVoiceLength("story_v_out_320151", "320151031", "story_v_out_320151.awb") / 1000

					if var_134_14 + var_134_8 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_14 + var_134_8
					end

					if var_134_10.prefab_name ~= "" and arg_131_1.actors_[var_134_10.prefab_name] ~= nil then
						local var_134_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_10.prefab_name].transform, "story_v_out_320151", "320151031", "story_v_out_320151.awb")

						arg_131_1:RecordAudio("320151031", var_134_15)
						arg_131_1:RecordAudio("320151031", var_134_15)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_320151", "320151031", "story_v_out_320151.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_320151", "320151031", "story_v_out_320151.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_16 = math.max(var_134_9, arg_131_1.talkMaxDuration)

			if var_134_8 <= arg_131_1.time_ and arg_131_1.time_ < var_134_8 + var_134_16 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_8) / var_134_16

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_8 + var_134_16 and arg_131_1.time_ < var_134_8 + var_134_16 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play320151032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 320151032
		arg_135_1.duration_ = 6.87

		local var_135_0 = {
			zh = 5.266,
			ja = 6.866
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
				arg_135_0:Play320151033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10100ui_story"]) and arg_135_1.var_.characterEffect10100ui_story == nil then
				arg_135_1.var_.characterEffect10100ui_story = arg_135_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10100ui_story"]) then
				if arg_135_1.var_.characterEffect10100ui_story and not isNil(arg_135_1.actors_["10100ui_story"]) then
					arg_135_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10100ui_story"]) and arg_135_1.var_.characterEffect10100ui_story then
				arg_135_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(320151032)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 22 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_4) / 22)

				if (22 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_4) / 22)) > 0 and var_138_2 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151032", "story_v_out_320151.awb") ~= 0 then
					local var_138_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151032", "story_v_out_320151.awb") / 1000

					if var_138_7 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_1
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_320151", "320151032", "story_v_out_320151.awb")

						arg_135_1:RecordAudio("320151032", var_138_8)
						arg_135_1:RecordAudio("320151032", var_138_8)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_320151", "320151032", "story_v_out_320151.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_320151", "320151032", "story_v_out_320151.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_9 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_9 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_9

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_9 and arg_135_1.time_ < var_138_1 + var_138_9 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play320151033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 320151033
		arg_139_1.duration_ = 8.53

		local var_139_0 = {
			zh = 6.933,
			ja = 8.533
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play320151034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10100ui_story"]) and arg_139_1.var_.characterEffect10100ui_story == nil then
				arg_139_1.var_.characterEffect10100ui_story = arg_139_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10100ui_story"]) then
				if arg_139_1.var_.characterEffect10100ui_story and not isNil(arg_139_1.actors_["10100ui_story"]) then
					arg_139_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10100ui_story"]) and arg_139_1.var_.characterEffect10100ui_story then
				arg_139_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action3_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_2 = 0
			local var_142_3 = 0.8

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:GetWordFromCfg(320151033)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 32 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 32)

				if (32 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 32)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151033", "story_v_out_320151.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151033", "story_v_out_320151.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_out_320151", "320151033", "story_v_out_320151.awb")

						arg_139_1:RecordAudio("320151033", var_142_9)
						arg_139_1:RecordAudio("320151033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_320151", "320151033", "story_v_out_320151.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_320151", "320151033", "story_v_out_320151.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play320151034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 320151034
		arg_143_1.duration_ = 7.27

		local var_143_0 = {
			zh = 7.266,
			ja = 5.8
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
				arg_143_0:Play320151035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10100ui_story"]) and arg_143_1.var_.characterEffect10100ui_story == nil then
				arg_143_1.var_.characterEffect10100ui_story = arg_143_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10100ui_story"]) then
				if arg_143_1.var_.characterEffect10100ui_story and not isNil(arg_143_1.actors_["10100ui_story"]) then
					arg_143_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10100ui_story"]) and arg_143_1.var_.characterEffect10100ui_story then
				arg_143_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.8

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowbossma")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(320151034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 32 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 32)

				if (32 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 32)) > 0 and var_146_2 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151034", "story_v_out_320151.awb") ~= 0 then
					local var_146_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151034", "story_v_out_320151.awb") / 1000

					if var_146_7 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_1
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_320151", "320151034", "story_v_out_320151.awb")

						arg_143_1:RecordAudio("320151034", var_146_8)
						arg_143_1:RecordAudio("320151034", var_146_8)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_320151", "320151034", "story_v_out_320151.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_320151", "320151034", "story_v_out_320151.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_9 and arg_143_1.time_ < var_146_1 + var_146_9 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play320151035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 320151035
		arg_147_1.duration_ = 12.23

		local var_147_0 = {
			zh = 12.233,
			ja = 11
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
				arg_147_0:Play320151036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10100ui_story"]) and arg_147_1.var_.characterEffect10100ui_story == nil then
				arg_147_1.var_.characterEffect10100ui_story = arg_147_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10100ui_story"]) then
				if arg_147_1.var_.characterEffect10100ui_story and not isNil(arg_147_1.actors_["10100ui_story"]) then
					arg_147_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10100ui_story"]) and arg_147_1.var_.characterEffect10100ui_story then
				arg_147_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_2 = 0
			local var_150_3 = 1.3

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(320151035)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 52 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 52)

				if (52 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 52)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151035", "story_v_out_320151.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151035", "story_v_out_320151.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_320151", "320151035", "story_v_out_320151.awb")

						arg_147_1:RecordAudio("320151035", var_150_9)
						arg_147_1:RecordAudio("320151035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_320151", "320151035", "story_v_out_320151.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_320151", "320151035", "story_v_out_320151.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play320151036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 320151036
		arg_151_1.duration_ = 9.3

		local var_151_0 = {
			zh = 5.8,
			ja = 9.3
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
				arg_151_0:Play320151037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.675

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(320151036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 27 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 27)

				if (27 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 27)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151036", "story_v_out_320151.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151036", "story_v_out_320151.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_320151", "320151036", "story_v_out_320151.awb")

						arg_151_1:RecordAudio("320151036", var_154_6)
						arg_151_1:RecordAudio("320151036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_320151", "320151036", "story_v_out_320151.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_320151", "320151036", "story_v_out_320151.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play320151037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 320151037
		arg_155_1.duration_ = 9

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play320151038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if arg_155_1.bgs_.L02f == nil then
				local var_158_0 = Object.Instantiate(arg_155_1.paintGo_)

				var_158_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02f")
				var_158_0.name = "L02f"
				var_158_0.transform.parent = arg_155_1.stage_.transform
				var_158_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.bgs_.L02f = var_158_0
			end

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= 2 + arg_158_0 then
				local var_158_1 = arg_155_1.bgs_.L02f

				arg_155_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_2 = var_158_1:GetComponent("SpriteRenderer")

				if var_158_2 and var_158_2.sprite then
					local var_158_3 = 2 * (var_158_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_1.transform.localScale = Vector3.New(var_158_3 / var_158_2.sprite.bounds.size.y < var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x and var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x or var_158_3 / var_158_2.sprite.bounds.size.y, var_158_3 / var_158_2.sprite.bounds.size.y < var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x and var_158_3 * manager.ui.mainCameraCom_.aspect / var_158_2.sprite.bounds.size.x or var_158_3 / var_158_2.sprite.bounds.size.y, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "L02f" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_4 = 4

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.allBtn_.enabled = false
			end

			if arg_155_1.time_ >= var_158_4 + 0.3 and arg_155_1.time_ < var_158_4 + 0.3 + arg_158_0 then
				arg_155_1.allBtn_.enabled = true
			end

			local var_158_5 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_6 = 2

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_6 then
				local var_158_7 = Color.New(0, 0, 0)

				var_158_7.a = Mathf.Lerp(0, 1, (arg_155_1.time_ - var_158_5) / var_158_6)
				arg_155_1.mask_.color = var_158_7
			end

			if arg_155_1.time_ >= var_158_5 + var_158_6 and arg_155_1.time_ < var_158_5 + var_158_6 + arg_158_0 then
				local var_158_8 = Color.New(0, 0, 0)

				var_158_8.a = 1
				arg_155_1.mask_.color = var_158_8
			end

			local var_158_9 = 2

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_9 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_10 = 2

			if var_158_9 <= arg_155_1.time_ and arg_155_1.time_ < var_158_9 + var_158_10 then
				local var_158_11 = Color.New(0, 0, 0)

				var_158_11.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_9) / var_158_10)
				arg_155_1.mask_.color = var_158_11
			end

			if arg_155_1.time_ >= var_158_9 + var_158_10 and arg_155_1.time_ < var_158_9 + var_158_10 + arg_158_0 then
				local var_158_12 = Color.New(0, 0, 0)

				arg_155_1.mask_.enabled = false
				var_158_12.a = 0
				arg_155_1.mask_.color = var_158_12
			end

			local var_158_13 = arg_155_1.actors_["10100ui_story"].transform

			if 1.96599999815226 < arg_155_1.time_ and arg_155_1.time_ <= 1.96599999815226 + arg_158_0 then
				arg_155_1.var_.moveOldPos10100ui_story = var_158_13.localPosition
			end

			local var_158_14 = 0.001

			if 1.96599999815226 <= arg_155_1.time_ and arg_155_1.time_ < 1.96599999815226 + var_158_14 then
				var_158_13.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 1.96599999815226) / var_158_14)
				var_158_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_13.position).x, (manager.ui.mainCamera.transform.position - var_158_13.position).y, (manager.ui.mainCamera.transform.position - var_158_13.position).z)
				var_158_13.localEulerAngles.z = 0
				var_158_13.localEulerAngles.x = 0
				var_158_13.localEulerAngles = var_158_13.localEulerAngles
			end

			if arg_155_1.time_ >= 1.96599999815226 + var_158_14 and arg_155_1.time_ < 1.96599999815226 + var_158_14 + arg_158_0 then
				var_158_13.localPosition = Vector3.New(0, 100, 0)
				var_158_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_13.position).x, (manager.ui.mainCamera.transform.position - var_158_13.position).y, (manager.ui.mainCamera.transform.position - var_158_13.position).z)
				var_158_13.localEulerAngles.z = 0
				var_158_13.localEulerAngles.x = 0
				var_158_13.localEulerAngles = var_158_13.localEulerAngles
			end

			local var_158_15 = arg_155_1.actors_["10100ui_story"]

			if 1.96599999815226 < arg_155_1.time_ and arg_155_1.time_ <= 1.96599999815226 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.characterEffect10100ui_story == nil then
				arg_155_1.var_.characterEffect10100ui_story = var_158_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_16 = 0.034000001847744

			if 1.96599999815226 <= arg_155_1.time_ and arg_155_1.time_ < 1.96599999815226 + var_158_16 and not isNil(var_158_15) then
				if arg_155_1.var_.characterEffect10100ui_story and not isNil(var_158_15) then
					arg_155_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 1.96599999815226) / var_158_16)
				end
			end

			if arg_155_1.time_ >= 1.96599999815226 + var_158_16 and arg_155_1.time_ < 1.96599999815226 + var_158_16 + arg_158_0 and not isNil(var_158_15) and arg_155_1.var_.characterEffect10100ui_story then
				arg_155_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 1.96599999815226 < arg_155_1.time_ and arg_155_1.time_ <= 1.96599999815226 + arg_158_0 then
				arg_155_1:AudioAction("play", "music", "se_story_121_04", "se_story_121_04_hitdown", "")

				local var_158_19 = manager.audio:GetAudioName("se_story_121_04", "se_story_121_04_hitdown")

				if "" ~= "" then
					if arg_155_1.bgmTxt_.text ~= var_158_19 and arg_155_1.bgmTxt_.text ~= "" then
						if arg_155_1.bgmTxt2_.text ~= "" then
							arg_155_1.bgmTxt_.text = arg_155_1.bgmTxt2_.text
						end

						arg_155_1.bgmTxt2_.text = var_158_19

						arg_155_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_155_1.bgmTxt_.text = var_158_19
						arg_155_1.bgmTxt2_.text = var_158_19
					end

					if arg_155_1.bgmTimer then
						arg_155_1.bgmTimer:Stop()

						arg_155_1.bgmTimer = nil
					end

					if arg_155_1.settingData.show_music_name == 1 then
						arg_155_1.musicController:SetSelectedState("show")
						arg_155_1.musicAnimator_:Play("open", 0, 0)

						if arg_155_1.settingData.music_time ~= 0 then
							arg_155_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_155_1.settingData.music_time), function()
								if arg_155_1 == nil or isNil(arg_155_1.bgmTxt_) then
									return
								end

								arg_155_1.musicController:SetSelectedState("hide")
								arg_155_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_158_20 = manager.ui.mainCamera.transform

			if 1.96599999815226 < arg_155_1.time_ and arg_155_1.time_ <= 1.96599999815226 + arg_158_0 then
				arg_155_1.var_.shakeOldPos = var_158_20.localPosition
			end

			local var_158_21 = 1

			if 1.96599999815226 <= arg_155_1.time_ and arg_155_1.time_ < 1.96599999815226 + var_158_21 then
				local var_158_22, var_158_23 = math.modf((arg_155_1.time_ - 1.96599999815226) / 0.066)

				var_158_20.localPosition = Vector3.New(var_158_23 * 0.13, var_158_23 * 0.13, var_158_23 * 0.13) + arg_155_1.var_.shakeOldPos
			end

			if arg_155_1.time_ >= 1.96599999815226 + var_158_21 and arg_155_1.time_ < 1.96599999815226 + var_158_21 + arg_158_0 then
				var_158_20.localPosition = arg_155_1.var_.shakeOldPos
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_24 = 4
			local var_158_25 = 1.025

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_24 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_26 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_26:setOnUpdate(LuaHelper.FloatAction(function(arg_160_0)
					arg_155_1.dialogCg_.alpha = arg_160_0
				end))
				var_158_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_27 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(320151037).content)

				arg_155_1.text_.text = var_158_27

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_29 = 41 <= 0 and var_158_25 or var_158_25 * (utf8.len(var_158_27) / 41)

				if (41 <= 0 and var_158_25 or var_158_25 * (utf8.len(var_158_27) / 41)) > 0 and var_158_25 < var_158_29 then
					arg_155_1.talkMaxDuration = var_158_29
					var_158_24 = var_158_24 + 0.3

					if var_158_29 + var_158_24 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_29 + var_158_24
					end
				end

				arg_155_1.text_.text = var_158_27
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_30 = var_158_24 + 0.3
			local var_158_31 = math.max(var_158_25, arg_155_1.talkMaxDuration)

			if var_158_24 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_30 + var_158_31 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_30) / var_158_31

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_30 + var_158_31 and arg_155_1.time_ < var_158_30 + var_158_31 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play320151038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 320151038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play320151039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.4

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(320151038).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 56 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 56)

				if (56 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 56)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play320151039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 320151039
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play320151040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0.659000001847744 < arg_166_1.time_ and arg_166_1.time_ <= 0.659000001847744 + arg_169_0 then
				arg_166_1:AudioAction("play", "music", "se_story_123_01", "se_story_123_01_gun", "")

				local var_169_2 = manager.audio:GetAudioName("se_story_123_01", "se_story_123_01_gun")

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

			local var_169_3 = 0
			local var_169_4 = 1.625

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_3 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_5 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(320151039).content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 65 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 65)

				if (65 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 65)) > 0 and var_169_4 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_3 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_3
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_4, arg_166_1.talkMaxDuration)

			if var_169_3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_3 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_3) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_3 + var_169_8 and arg_166_1.time_ < var_169_3 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play320151040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 320151040
		arg_171_1.duration_ = 6.53

		local var_171_0 = {
			zh = 6.366,
			ja = 6.533
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
				arg_171_0:Play320151041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.85

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(320151040)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 34 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 34)

				if (34 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 34)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151040", "story_v_out_320151.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151040", "story_v_out_320151.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_320151", "320151040", "story_v_out_320151.awb")

						arg_171_1:RecordAudio("320151040", var_174_6)
						arg_171_1:RecordAudio("320151040", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_320151", "320151040", "story_v_out_320151.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_320151", "320151040", "story_v_out_320151.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play320151041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 320151041
		arg_175_1.duration_ = 4.77

		local var_175_0 = {
			zh = 3.733,
			ja = 4.766
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
				arg_175_0:Play320151042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(320151041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)

				if (21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151041", "story_v_out_320151.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151041", "story_v_out_320151.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_320151", "320151041", "story_v_out_320151.awb")

						arg_175_1:RecordAudio("320151041", var_178_6)
						arg_175_1:RecordAudio("320151041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_320151", "320151041", "story_v_out_320151.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_320151", "320151041", "story_v_out_320151.awb")
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
	Play320151042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 320151042
		arg_179_1.duration_ = 14.7

		local var_179_0 = {
			zh = 10.033,
			ja = 14.7
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
				arg_179_0:Play320151043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if arg_179_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_182_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_179_1.stage_.transform)

				var_182_0.name = "1089ui_story"
				var_182_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["1089ui_story"] = var_182_0

				local var_182_1 = var_182_0:GetComponentInChildren(typeof(CharacterEffect))

				var_182_1.enabled = true

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end

				arg_179_1:ShowWeapon(var_182_1.transform, false)

				arg_179_1.var_["1089ui_story" .. "Animator"] = var_182_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_179_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_179_1.var_["1089ui_story" .. "LipSync"] = var_182_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_182_3 = arg_179_1.actors_["1089ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1089ui_story = var_182_3.localPosition

				arg_179_1:ShowWeapon(arg_179_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_3.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_179_1.time_ - 0) / var_182_4)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles
			end

			local var_182_5 = arg_179_1.actors_["1089ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.characterEffect1089ui_story == nil then
				arg_179_1.var_.characterEffect1089ui_story = var_182_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_6 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_6 and not isNil(var_182_5) then
				if arg_179_1.var_.characterEffect1089ui_story and not isNil(var_182_5) then
					arg_179_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_6 and arg_179_1.time_ < 0 + var_182_6 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.characterEffect1089ui_story then
				arg_179_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				if arg_179_1.var_.characterEffect1089ui_story == nil then
					arg_179_1.var_.characterEffect1089ui_story = arg_179_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_182_8 = arg_179_1.var_.characterEffect1089ui_story

				arg_179_1.var_.characterEffect1089ui_story.imageEffect:turnOff()

				var_182_8.interferenceEffect.enabled = true
				var_182_8.interferenceEffect.noise = 0.001
				var_182_8.interferenceEffect.simTimeScale = 1
				var_182_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				if arg_179_1.var_.characterEffect1089ui_story == nil then
					arg_179_1.var_.characterEffect1089ui_story = arg_179_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_179_1.var_.characterEffect1089ui_story.imageEffect:turnOn(false)
			end

			local var_182_10 = 0
			local var_182_11 = 1.125

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_12 = arg_179_1:GetWordFromCfg(320151042)
				local var_182_13 = arg_179_1:FormatText(var_182_12.content)

				arg_179_1.text_.text = var_182_13

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_15 = 45 <= 0 and var_182_11 or var_182_11 * (utf8.len(var_182_13) / 45)

				if (45 <= 0 and var_182_11 or var_182_11 * (utf8.len(var_182_13) / 45)) > 0 and var_182_11 < var_182_15 then
					arg_179_1.talkMaxDuration = var_182_15

					if var_182_15 + var_182_10 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_15 + var_182_10
					end
				end

				arg_179_1.text_.text = var_182_13
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151042", "story_v_out_320151.awb") ~= 0 then
					local var_182_16 = manager.audio:GetVoiceLength("story_v_out_320151", "320151042", "story_v_out_320151.awb") / 1000

					if var_182_16 + var_182_10 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_16 + var_182_10
					end

					if var_182_12.prefab_name ~= "" and arg_179_1.actors_[var_182_12.prefab_name] ~= nil then
						local var_182_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_12.prefab_name].transform, "story_v_out_320151", "320151042", "story_v_out_320151.awb")

						arg_179_1:RecordAudio("320151042", var_182_17)
						arg_179_1:RecordAudio("320151042", var_182_17)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_320151", "320151042", "story_v_out_320151.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_320151", "320151042", "story_v_out_320151.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_18 = math.max(var_182_11, arg_179_1.talkMaxDuration)

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_18 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_10) / var_182_18

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_10 + var_182_18 and arg_179_1.time_ < var_182_10 + var_182_18 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play320151043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 320151043
		arg_183_1.duration_ = 2.43

		local var_183_0 = {
			zh = 1.6,
			ja = 2.433
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
				arg_183_0:Play320151044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.15

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(320151043)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 6 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 6)

				if (6 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 6)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151043", "story_v_out_320151.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151043", "story_v_out_320151.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_320151", "320151043", "story_v_out_320151.awb")

						arg_183_1:RecordAudio("320151043", var_186_6)
						arg_183_1:RecordAudio("320151043", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_320151", "320151043", "story_v_out_320151.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_320151", "320151043", "story_v_out_320151.awb")
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
	Play320151044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 320151044
		arg_187_1.duration_ = 4.43

		local var_187_0 = {
			zh = 3.8,
			ja = 4.433
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
				arg_187_0:Play320151045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1089ui_story"]) and arg_187_1.var_.characterEffect1089ui_story == nil then
				arg_187_1.var_.characterEffect1089ui_story = arg_187_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1089ui_story"]) then
				if arg_187_1.var_.characterEffect1089ui_story and not isNil(arg_187_1.actors_["1089ui_story"]) then
					arg_187_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1089ui_story"]) and arg_187_1.var_.characterEffect1089ui_story then
				arg_187_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.4

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(320151044)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_6 = 16 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_4) / 16)

				if (16 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_4) / 16)) > 0 and var_190_2 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151044", "story_v_out_320151.awb") ~= 0 then
					local var_190_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151044", "story_v_out_320151.awb") / 1000

					if var_190_7 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_1
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_320151", "320151044", "story_v_out_320151.awb")

						arg_187_1:RecordAudio("320151044", var_190_8)
						arg_187_1:RecordAudio("320151044", var_190_8)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_320151", "320151044", "story_v_out_320151.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_320151", "320151044", "story_v_out_320151.awb")
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

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play320151045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 320151045
		arg_191_1.duration_ = 2.2

		local var_191_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_191_0:Play320151046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1089ui_story"]) and arg_191_1.var_.characterEffect1089ui_story == nil then
				arg_191_1.var_.characterEffect1089ui_story = arg_191_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1089ui_story"]) then
				if arg_191_1.var_.characterEffect1089ui_story and not isNil(arg_191_1.actors_["1089ui_story"]) then
					arg_191_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1089ui_story"]) and arg_191_1.var_.characterEffect1089ui_story then
				arg_191_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_194_2 = 0
			local var_194_3 = 0.125

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(320151045)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 5 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 5)

				if (5 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 5)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151045", "story_v_out_320151.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151045", "story_v_out_320151.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_320151", "320151045", "story_v_out_320151.awb")

						arg_191_1:RecordAudio("320151045", var_194_9)
						arg_191_1:RecordAudio("320151045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_320151", "320151045", "story_v_out_320151.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_320151", "320151045", "story_v_out_320151.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play320151046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 320151046
		arg_195_1.duration_ = 7.93

		local var_195_0 = {
			zh = 6.999999999999,
			ja = 7.933
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
				arg_195_0:Play320151047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_9001
			local var_198_9000

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				local var_198_0 = arg_195_1.bgs_.L07k

				arg_195_1.bgs_.L07k.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_198_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_1 = var_198_0:GetComponent("SpriteRenderer")

				if var_198_1 and var_198_1.sprite then
					local var_198_2 = 2 * (var_198_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_198_0.transform.localScale = Vector3.New(var_198_2 / var_198_1.sprite.bounds.size.y < var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x and var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x or var_198_2 / var_198_1.sprite.bounds.size.y, var_198_2 / var_198_1.sprite.bounds.size.y < var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x and var_198_2 * manager.ui.mainCameraCom_.aspect / var_198_1.sprite.bounds.size.x or var_198_2 / var_198_1.sprite.bounds.size.y, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "L07k" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_3 = 4

			if 4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			if arg_195_1.time_ >= var_198_3 + 0.3 and arg_195_1.time_ < var_198_3 + 0.3 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end

			local var_198_4 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_5 = 2

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_5 then
				local var_198_6 = Color.New(0, 0, 0)

				var_198_6.a = Mathf.Lerp(0, 1, (arg_195_1.time_ - var_198_4) / var_198_5)
				arg_195_1.mask_.color = var_198_6
			end

			if arg_195_1.time_ >= var_198_4 + var_198_5 and arg_195_1.time_ < var_198_4 + var_198_5 + arg_198_0 then
				local var_198_7 = Color.New(0, 0, 0)

				var_198_7.a = 1
				arg_195_1.mask_.color = var_198_7
			end

			local var_198_8 = 2

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_9 = 2

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_9 then
				local var_198_10 = Color.New(0, 0, 0)

				var_198_10.a = Mathf.Lerp(1, 0, (arg_195_1.time_ - var_198_8) / var_198_9)
				arg_195_1.mask_.color = var_198_10
			end

			if arg_195_1.time_ >= var_198_8 + var_198_9 and arg_195_1.time_ < var_198_8 + var_198_9 + arg_198_0 then
				local var_198_11 = Color.New(0, 0, 0)

				arg_195_1.mask_.enabled = false
				var_198_11.a = 0
				arg_195_1.mask_.color = var_198_11
			end

			local var_198_12 = arg_195_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_195_1.time_ and arg_195_1.time_ <= 1.96599999815226 + arg_198_0 then
				arg_195_1.var_.moveOldPos1089ui_story = var_198_12.localPosition
			end

			local var_198_13 = 0.001

			if 1.96599999815226 <= arg_195_1.time_ and arg_195_1.time_ < 1.96599999815226 + var_198_13 then
				var_198_12.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 1.96599999815226) / var_198_13)
				var_198_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_12.position).x, (manager.ui.mainCamera.transform.position - var_198_12.position).y, (manager.ui.mainCamera.transform.position - var_198_12.position).z)
				var_198_12.localEulerAngles.z = 0
				var_198_12.localEulerAngles.x = 0
				var_198_12.localEulerAngles = var_198_12.localEulerAngles
			end

			if arg_195_1.time_ >= 1.96599999815226 + var_198_13 and arg_195_1.time_ < 1.96599999815226 + var_198_13 + arg_198_0 then
				var_198_12.localPosition = Vector3.New(0, 100, 0)
				var_198_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_12.position).x, (manager.ui.mainCamera.transform.position - var_198_12.position).y, (manager.ui.mainCamera.transform.position - var_198_12.position).z)
				var_198_12.localEulerAngles.z = 0
				var_198_12.localEulerAngles.x = 0
				var_198_12.localEulerAngles = var_198_12.localEulerAngles
			end

			local var_198_14 = arg_195_1.actors_["1089ui_story"]

			if 1.96599999815226 < arg_195_1.time_ and arg_195_1.time_ <= 1.96599999815226 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.characterEffect1089ui_story == nil then
				arg_195_1.var_.characterEffect1089ui_story = var_198_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_15 = 0.034000001847744

			if 1.96599999815226 <= arg_195_1.time_ and arg_195_1.time_ < 1.96599999815226 + var_198_15 and not isNil(var_198_14) then
				if arg_195_1.var_.characterEffect1089ui_story and not isNil(var_198_14) then
					arg_195_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 1.96599999815226) / var_198_15)
				end
			end

			if arg_195_1.time_ >= 1.96599999815226 + var_198_15 and arg_195_1.time_ < 1.96599999815226 + var_198_15 + arg_198_0 and not isNil(var_198_14) and arg_195_1.var_.characterEffect1089ui_story then
				arg_195_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_198_16 = arg_195_1.actors_["1020ui_story"].transform

			if 3.8 < arg_195_1.time_ and arg_195_1.time_ <= 3.8 + arg_198_0 then
				arg_195_1.var_.moveOldPos1020ui_story = var_198_16.localPosition
			end

			local var_198_17 = 0.001

			if 3.8 <= arg_195_1.time_ and arg_195_1.time_ < 3.8 + var_198_17 then
				var_198_16.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_195_1.time_ - 3.8) / var_198_17)
				var_198_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_16.position).x, (manager.ui.mainCamera.transform.position - var_198_16.position).y, (manager.ui.mainCamera.transform.position - var_198_16.position).z)
				var_198_16.localEulerAngles.z = 0
				var_198_16.localEulerAngles.x = 0
				var_198_16.localEulerAngles = var_198_16.localEulerAngles
			end

			if arg_195_1.time_ >= 3.8 + var_198_17 and arg_195_1.time_ < 3.8 + var_198_17 + arg_198_0 then
				var_198_16.localPosition = Vector3.New(0, -0.85, -6.25)
				var_198_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_16.position).x, (manager.ui.mainCamera.transform.position - var_198_16.position).y, (manager.ui.mainCamera.transform.position - var_198_16.position).z)
				var_198_16.localEulerAngles.z = 0
				var_198_16.localEulerAngles.x = 0
				var_198_16.localEulerAngles = var_198_16.localEulerAngles
			end

			local var_198_18 = arg_195_1.actors_["1020ui_story"]

			if 3.8 < arg_195_1.time_ and arg_195_1.time_ <= 3.8 + arg_198_0 and not isNil(var_198_18) and arg_195_1.var_.characterEffect1020ui_story == nil then
				arg_195_1.var_.characterEffect1020ui_story = var_198_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_19 = 0.200000002980232

			if 3.8 <= arg_195_1.time_ and arg_195_1.time_ < 3.8 + var_198_19 and not isNil(var_198_18) then
				if arg_195_1.var_.characterEffect1020ui_story and not isNil(var_198_18) then
					arg_195_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 3.8 + var_198_19 and arg_195_1.time_ < 3.8 + var_198_19 + arg_198_0 and not isNil(var_198_18) and arg_195_1.var_.characterEffect1020ui_story then
				arg_195_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 3.8 < arg_195_1.time_ and arg_195_1.time_ <= 3.8 + arg_198_0 then
				arg_195_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 3.8 < arg_195_1.time_ and arg_195_1.time_ <= 3.8 + arg_198_0 then
				arg_195_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				local var_198_21 = arg_195_1.var_.effectxiayu15

				if not arg_195_1.var_.effectxiayu15 then
					var_198_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), manager.ui.mainCamera.transform)
					var_198_21.name = "xiayu15"
					arg_195_1.var_.effectxiayu15 = var_198_21
				else
					var_198_21.transform:SetParent(var_198_9001)
				end

				var_198_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_198_21.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_198_23 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_198_2, iter_198_3 in ipairs((var_198_21.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_198_3.transform.localScale = Vector3.New(iter_198_3.transform.localScale.x / var_198_23 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_198_3.transform.localScale.y / var_198_23, iter_198_3.transform.localScale.z)
				end
			end

			if 2 < arg_195_1.time_ and arg_195_1.time_ <= 2 + arg_198_0 then
				local var_198_25 = arg_195_1.var_.effectxiayu16

				if not arg_195_1.var_.effectxiayu16 then
					var_198_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_light"), manager.ui.mainCamera.transform)
					var_198_25.name = "xiayu16"
					arg_195_1.var_.effectxiayu16 = var_198_25
				else
					var_198_25.transform:SetParent(var_198_9000)
				end

				var_198_25.transform.localPosition = Vector3.New(0, 0, 0)
				var_198_25.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.72828609496355 < arg_195_1.time_ and arg_195_1.time_ <= 1.72828609496355 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_28 = 4
			local var_198_29 = 0.175

			if 4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_28 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_30 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_30:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_31 = arg_195_1:GetWordFromCfg(320151046)
				local var_198_32 = arg_195_1:FormatText(var_198_31.content)

				arg_195_1.text_.text = var_198_32

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_34 = 7 <= 0 and var_198_29 or var_198_29 * (utf8.len(var_198_32) / 7)

				if (7 <= 0 and var_198_29 or var_198_29 * (utf8.len(var_198_32) / 7)) > 0 and var_198_29 < var_198_34 then
					arg_195_1.talkMaxDuration = var_198_34
					var_198_28 = var_198_28 + 0.3

					if var_198_34 + var_198_28 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_34 + var_198_28
					end
				end

				arg_195_1.text_.text = var_198_32
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151046", "story_v_out_320151.awb") ~= 0 then
					local var_198_35 = manager.audio:GetVoiceLength("story_v_out_320151", "320151046", "story_v_out_320151.awb") / 1000

					if var_198_35 + var_198_28 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_35 + var_198_28
					end

					if var_198_31.prefab_name ~= "" and arg_195_1.actors_[var_198_31.prefab_name] ~= nil then
						local var_198_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_31.prefab_name].transform, "story_v_out_320151", "320151046", "story_v_out_320151.awb")

						arg_195_1:RecordAudio("320151046", var_198_36)
						arg_195_1:RecordAudio("320151046", var_198_36)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_320151", "320151046", "story_v_out_320151.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_320151", "320151046", "story_v_out_320151.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_37 = var_198_28 + 0.3
			local var_198_38 = math.max(var_198_29, arg_195_1.talkMaxDuration)

			if var_198_28 + 0.3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_37 + var_198_38 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_37) / var_198_38

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_37 + var_198_38 and arg_195_1.time_ < var_198_37 + var_198_38 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play320151047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320151047
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play320151048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1020ui_story = arg_201_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1020ui_story"].transform.position).z)
				arg_201_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1020ui_story"].transform.localEulerAngles = arg_201_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1020ui_story"].transform.position).z)
				arg_201_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1020ui_story"].transform.localEulerAngles = arg_201_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1020ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1020ui_story == nil then
				arg_201_1.var_.characterEffect1020ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect1020ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_2)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect1020ui_story then
				arg_201_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_204_3 = 0
			local var_204_4 = 1.025

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_3 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_5 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(320151047).content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 41 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 41)

				if (41 <= 0 and var_204_4 or var_204_4 * (utf8.len(var_204_5) / 41)) > 0 and var_204_4 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_3 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_3
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_8 = math.max(var_204_4, arg_201_1.talkMaxDuration)

			if var_204_3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_3 + var_204_8 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_3) / var_204_8

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_3 + var_204_8 and arg_201_1.time_ < var_204_3 + var_204_8 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
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

		arg_201_1:InitPlayNodeList()
	end,
	Play320151048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320151048
		arg_205_1.duration_ = 4.4

		local var_205_0 = {
			zh = 4.4,
			ja = 1.8
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play320151049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.45

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:GetWordFromCfg(320151048)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 18 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 18)

				if (18 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 18)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151048", "story_v_out_320151.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151048", "story_v_out_320151.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_320151", "320151048", "story_v_out_320151.awb")

						arg_205_1:RecordAudio("320151048", var_208_6)
						arg_205_1:RecordAudio("320151048", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_320151", "320151048", "story_v_out_320151.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_320151", "320151048", "story_v_out_320151.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play320151049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320151049
		arg_209_1.duration_ = 8.8

		local var_209_0 = {
			zh = 8.8,
			ja = 8.266
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
				arg_209_0:Play320151050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1020ui_story = arg_209_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1020ui_story"].transform.position).z)
				arg_209_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1020ui_story"].transform.localEulerAngles = arg_209_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_209_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1020ui_story"].transform.position).z)
				arg_209_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1020ui_story"].transform.localEulerAngles = arg_209_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1020ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1020ui_story == nil then
				arg_209_1.var_.characterEffect1020ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1020ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1020ui_story then
				arg_209_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_212_4 = 0
			local var_212_5 = 0.95

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(320151049)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 38 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 38)

				if (38 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 38)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151049", "story_v_out_320151.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151049", "story_v_out_320151.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_320151", "320151049", "story_v_out_320151.awb")

						arg_209_1:RecordAudio("320151049", var_212_11)
						arg_209_1:RecordAudio("320151049", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_320151", "320151049", "story_v_out_320151.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_320151", "320151049", "story_v_out_320151.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play320151050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320151050
		arg_213_1.duration_ = 14.77

		local var_213_0 = {
			zh = 8.666,
			ja = 14.766
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play320151051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 1.125

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(320151050)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 45 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 45)

				if (45 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 45)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151050", "story_v_out_320151.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151050", "story_v_out_320151.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_320151", "320151050", "story_v_out_320151.awb")

						arg_213_1:RecordAudio("320151050", var_216_6)
						arg_213_1:RecordAudio("320151050", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320151", "320151050", "story_v_out_320151.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320151", "320151050", "story_v_out_320151.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play320151051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320151051
		arg_217_1.duration_ = 15.73

		local var_217_0 = {
			zh = 11.6,
			ja = 15.733
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play320151052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action468")
			end

			local var_220_0 = 0
			local var_220_1 = 1.225

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(320151051)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 49 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 49)

				if (49 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 49)) > 0 and var_220_1 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151051", "story_v_out_320151.awb") ~= 0 then
					local var_220_6 = manager.audio:GetVoiceLength("story_v_out_320151", "320151051", "story_v_out_320151.awb") / 1000

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end

					if var_220_2.prefab_name ~= "" and arg_217_1.actors_[var_220_2.prefab_name] ~= nil then
						local var_220_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_2.prefab_name].transform, "story_v_out_320151", "320151051", "story_v_out_320151.awb")

						arg_217_1:RecordAudio("320151051", var_220_7)
						arg_217_1:RecordAudio("320151051", var_220_7)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_320151", "320151051", "story_v_out_320151.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_320151", "320151051", "story_v_out_320151.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play320151052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320151052
		arg_221_1.duration_ = 6.9

		local var_221_0 = {
			zh = 5.933,
			ja = 6.9
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play320151053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if arg_221_1.actors_["10101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10101ui_story"))) then
				local var_224_0 = Object.Instantiate(Asset.Load("Char/" .. "10101ui_story"), arg_221_1.stage_.transform)

				var_224_0.name = "10101ui_story"
				var_224_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["10101ui_story"] = var_224_0

				local var_224_1 = var_224_0:GetComponentInChildren(typeof(CharacterEffect))

				var_224_1.enabled = true

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end

				arg_221_1:ShowWeapon(var_224_1.transform, false)

				arg_221_1.var_["10101ui_story" .. "Animator"] = var_224_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_221_1.var_["10101ui_story" .. "Animator"].applyRootMotion = true
				arg_221_1.var_["10101ui_story" .. "LipSync"] = var_224_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_224_3 = arg_221_1.actors_["10101ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10101ui_story = var_224_3.localPosition
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_3.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10101ui_story, Vector3.New(0.7, -1.16, -6.01), (arg_221_1.time_ - 0) / var_224_4)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_3.localPosition = Vector3.New(0.7, -1.16, -6.01)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			local var_224_5 = arg_221_1.actors_["10101ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect10101ui_story == nil then
				arg_221_1.var_.characterEffect10101ui_story = var_224_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_6 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.characterEffect10101ui_story and not isNil(var_224_5) then
					arg_221_1.var_.characterEffect10101ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect10101ui_story then
				arg_221_1.var_.characterEffect10101ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/story1022/story1022action/1022action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10101ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_224_8 = arg_221_1.actors_["1020ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1020ui_story = var_224_8.localPosition
			end

			local var_224_9 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_9 then
				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1020ui_story, Vector3.New(-0.7, -0.85, -6.25), (arg_221_1.time_ - 0) / var_224_9)
				var_224_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_8.position).x, (manager.ui.mainCamera.transform.position - var_224_8.position).y, (manager.ui.mainCamera.transform.position - var_224_8.position).z)
				var_224_8.localEulerAngles.z = 0
				var_224_8.localEulerAngles.x = 0
				var_224_8.localEulerAngles = var_224_8.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_9 and arg_221_1.time_ < 0 + var_224_9 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(-0.7, -0.85, -6.25)
				var_224_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_8.position).x, (manager.ui.mainCamera.transform.position - var_224_8.position).y, (manager.ui.mainCamera.transform.position - var_224_8.position).z)
				var_224_8.localEulerAngles.z = 0
				var_224_8.localEulerAngles.x = 0
				var_224_8.localEulerAngles = var_224_8.localEulerAngles
			end

			local var_224_10 = arg_221_1.actors_["1020ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_10) and arg_221_1.var_.characterEffect1020ui_story == nil then
				arg_221_1.var_.characterEffect1020ui_story = var_224_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_11 and not isNil(var_224_10) then
				if arg_221_1.var_.characterEffect1020ui_story and not isNil(var_224_10) then
					arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_11)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_11 and arg_221_1.time_ < 0 + var_224_11 + arg_224_0 and not isNil(var_224_10) and arg_221_1.var_.characterEffect1020ui_story then
				arg_221_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_224_12 = 0
			local var_224_13 = 0.65

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1023].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_14 = arg_221_1:GetWordFromCfg(320151052)
				local var_224_15 = arg_221_1:FormatText(var_224_14.content)

				arg_221_1.text_.text = var_224_15

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_17 = 26 <= 0 and var_224_13 or var_224_13 * (utf8.len(var_224_15) / 26)

				if (26 <= 0 and var_224_13 or var_224_13 * (utf8.len(var_224_15) / 26)) > 0 and var_224_13 < var_224_17 then
					arg_221_1.talkMaxDuration = var_224_17

					if var_224_17 + var_224_12 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_17 + var_224_12
					end
				end

				arg_221_1.text_.text = var_224_15
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151052", "story_v_out_320151.awb") ~= 0 then
					local var_224_18 = manager.audio:GetVoiceLength("story_v_out_320151", "320151052", "story_v_out_320151.awb") / 1000

					if var_224_18 + var_224_12 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_18 + var_224_12
					end

					if var_224_14.prefab_name ~= "" and arg_221_1.actors_[var_224_14.prefab_name] ~= nil then
						local var_224_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_14.prefab_name].transform, "story_v_out_320151", "320151052", "story_v_out_320151.awb")

						arg_221_1:RecordAudio("320151052", var_224_19)
						arg_221_1:RecordAudio("320151052", var_224_19)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320151", "320151052", "story_v_out_320151.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320151", "320151052", "story_v_out_320151.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_20 = math.max(var_224_13, arg_221_1.talkMaxDuration)

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_20 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_12) / var_224_20

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_12 + var_224_20 and arg_221_1.time_ < var_224_12 + var_224_20 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_221_1:InitPlayNodeList()
	end,
	Play320151053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320151053
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play320151054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10101ui_story"]) and arg_225_1.var_.characterEffect10101ui_story == nil then
				arg_225_1.var_.characterEffect10101ui_story = arg_225_1.actors_["10101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10101ui_story"]) then
				if arg_225_1.var_.characterEffect10101ui_story and not isNil(arg_225_1.actors_["10101ui_story"]) then
					arg_225_1.var_.characterEffect10101ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10101ui_story"]) and arg_225_1.var_.characterEffect10101ui_story then
				arg_225_1.var_.characterEffect10101ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10101ui_story.fillRatio = 0.5
			end

			local var_228_1 = arg_225_1.actors_["10101ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10101ui_story = var_228_1.localPosition
			end

			local var_228_2 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 then
				var_228_1.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10101ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_2)
				var_228_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_1.position).x, (manager.ui.mainCamera.transform.position - var_228_1.position).y, (manager.ui.mainCamera.transform.position - var_228_1.position).z)
				var_228_1.localEulerAngles.z = 0
				var_228_1.localEulerAngles.x = 0
				var_228_1.localEulerAngles = var_228_1.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 then
				var_228_1.localPosition = Vector3.New(0, 100, 0)
				var_228_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_1.position).x, (manager.ui.mainCamera.transform.position - var_228_1.position).y, (manager.ui.mainCamera.transform.position - var_228_1.position).z)
				var_228_1.localEulerAngles.z = 0
				var_228_1.localEulerAngles.x = 0
				var_228_1.localEulerAngles = var_228_1.localEulerAngles
			end

			local var_228_3 = arg_225_1.actors_["1020ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1020ui_story = var_228_3.localPosition
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0, 100, 0)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = 0
			local var_228_6 = 1.075

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(320151053).content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 43 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_7) / 43)

				if (43 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_7) / 43)) > 0 and var_228_6 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_10 and arg_225_1.time_ < var_228_5 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_225_1:InitPlayNodeList()
	end,
	Play320151054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320151054
		arg_229_1.duration_ = 8.43

		local var_229_0 = {
			zh = 8.433,
			ja = 7.666
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play320151055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.825

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(320151054)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 28 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 28)

				if (28 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 28)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151054", "story_v_out_320151.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151054", "story_v_out_320151.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_320151", "320151054", "story_v_out_320151.awb")

						arg_229_1:RecordAudio("320151054", var_232_6)
						arg_229_1:RecordAudio("320151054", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_320151", "320151054", "story_v_out_320151.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_320151", "320151054", "story_v_out_320151.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play320151055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320151055
		arg_233_1.duration_ = 7.77

		local var_233_0 = {
			zh = 3.466,
			ja = 7.766
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play320151056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1020ui_story = arg_233_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).z)
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles = arg_233_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_233_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1020ui_story"].transform.position).z)
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1020ui_story"].transform.localEulerAngles = arg_233_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1020ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1020ui_story == nil then
				arg_233_1.var_.characterEffect1020ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1020ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1020ui_story then
				arg_233_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_2")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_236_4 = 0
			local var_236_5 = 0.4

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(320151055)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 16 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 16)

				if (16 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 16)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151055", "story_v_out_320151.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151055", "story_v_out_320151.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_320151", "320151055", "story_v_out_320151.awb")

						arg_233_1:RecordAudio("320151055", var_236_11)
						arg_233_1:RecordAudio("320151055", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_320151", "320151055", "story_v_out_320151.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_320151", "320151055", "story_v_out_320151.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play320151056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320151056
		arg_237_1.duration_ = 7.93

		local var_237_0 = {
			zh = 5.733,
			ja = 7.933
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play320151057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1020ui_story"]) and arg_237_1.var_.characterEffect1020ui_story == nil then
				arg_237_1.var_.characterEffect1020ui_story = arg_237_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1020ui_story"]) then
				if arg_237_1.var_.characterEffect1020ui_story and not isNil(arg_237_1.actors_["1020ui_story"]) then
					arg_237_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1020ui_story"]) and arg_237_1.var_.characterEffect1020ui_story then
				arg_237_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.625

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(320151056)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 25 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 25)

				if (25 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 25)) > 0 and var_240_2 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151056", "story_v_out_320151.awb") ~= 0 then
					local var_240_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151056", "story_v_out_320151.awb") / 1000

					if var_240_7 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_1
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_320151", "320151056", "story_v_out_320151.awb")

						arg_237_1:RecordAudio("320151056", var_240_8)
						arg_237_1:RecordAudio("320151056", var_240_8)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320151", "320151056", "story_v_out_320151.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320151", "320151056", "story_v_out_320151.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_9 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_9 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_9

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_9 and arg_237_1.time_ < var_240_1 + var_240_9 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320151057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320151057
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play320151058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1020ui_story = arg_241_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).z)
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles = arg_241_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1020ui_story"].transform.position).z)
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1020ui_story"].transform.localEulerAngles = arg_241_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1020ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1020ui_story == nil then
				arg_241_1.var_.characterEffect1020ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1020ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_2)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1020ui_story then
				arg_241_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_244_3 = 0
			local var_244_4 = 1.05

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(320151057).content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 42 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 42)

				if (42 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 42)) > 0 and var_244_4 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_8 and arg_241_1.time_ < var_244_3 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play320151058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320151058
		arg_245_1.duration_ = 5.9

		local var_245_0 = {
			zh = 5.9,
			ja = 5.7
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320151059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.7

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(320151058)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 28 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 28)

				if (28 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 28)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151058", "story_v_out_320151.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151058", "story_v_out_320151.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_320151", "320151058", "story_v_out_320151.awb")

						arg_245_1:RecordAudio("320151058", var_248_6)
						arg_245_1:RecordAudio("320151058", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_320151", "320151058", "story_v_out_320151.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_320151", "320151058", "story_v_out_320151.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320151059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320151059
		arg_249_1.duration_ = 5.03

		local var_249_0 = {
			zh = 2.5,
			ja = 5.033
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play320151060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1020ui_story = arg_249_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1020ui_story"].transform.position).z)
				arg_249_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1020ui_story"].transform.localEulerAngles = arg_249_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_249_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1020ui_story"].transform.position).z)
				arg_249_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1020ui_story"].transform.localEulerAngles = arg_249_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1020ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1020ui_story == nil then
				arg_249_1.var_.characterEffect1020ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1020ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1020ui_story then
				arg_249_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_252_4 = 0
			local var_252_5 = 0.3

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(320151059)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 12 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 12)

				if (12 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 12)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151059", "story_v_out_320151.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151059", "story_v_out_320151.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_320151", "320151059", "story_v_out_320151.awb")

						arg_249_1:RecordAudio("320151059", var_252_11)
						arg_249_1:RecordAudio("320151059", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320151", "320151059", "story_v_out_320151.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320151", "320151059", "story_v_out_320151.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play320151060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320151060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play320151061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1020ui_story = arg_253_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).z)
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles = arg_253_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).z)
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles = arg_253_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1020ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1020ui_story == nil then
				arg_253_1.var_.characterEffect1020ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1020ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_2)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1020ui_story then
				arg_253_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_256_3 = 0
			local var_256_4 = 1.025

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_3 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_5 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(320151060).content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 41 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 41)

				if (41 <= 0 and var_256_4 or var_256_4 * (utf8.len(var_256_5) / 41)) > 0 and var_256_4 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_3 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_3
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_4, arg_253_1.talkMaxDuration)

			if var_256_3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_3 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_3) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_3 + var_256_8 and arg_253_1.time_ < var_256_3 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play320151061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320151061
		arg_257_1.duration_ = 12.5

		local var_257_0 = {
			zh = 9.133,
			ja = 12.5
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play320151062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.95

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(320151061)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 38 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 38)

				if (38 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 38)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151061", "story_v_out_320151.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151061", "story_v_out_320151.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_320151", "320151061", "story_v_out_320151.awb")

						arg_257_1:RecordAudio("320151061", var_260_6)
						arg_257_1:RecordAudio("320151061", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320151", "320151061", "story_v_out_320151.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320151", "320151061", "story_v_out_320151.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play320151062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320151062
		arg_261_1.duration_ = 10.97

		local var_261_0 = {
			zh = 7.1,
			ja = 10.966
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play320151063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1020ui_story = arg_261_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1020ui_story"].transform.position).z)
				arg_261_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1020ui_story"].transform.localEulerAngles = arg_261_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_261_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1020ui_story"].transform.position).z)
				arg_261_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1020ui_story"].transform.localEulerAngles = arg_261_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1020ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1020ui_story == nil then
				arg_261_1.var_.characterEffect1020ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1020ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1020ui_story then
				arg_261_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_264_4 = 0
			local var_264_5 = 0.85

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(320151062)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 34 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 34)

				if (34 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 34)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151062", "story_v_out_320151.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151062", "story_v_out_320151.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_320151", "320151062", "story_v_out_320151.awb")

						arg_261_1:RecordAudio("320151062", var_264_11)
						arg_261_1:RecordAudio("320151062", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_320151", "320151062", "story_v_out_320151.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_320151", "320151062", "story_v_out_320151.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play320151063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320151063
		arg_265_1.duration_ = 11.03

		local var_265_0 = {
			zh = 6.4,
			ja = 11.033
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play320151064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) and arg_265_1.var_.characterEffect1020ui_story == nil then
				arg_265_1.var_.characterEffect1020ui_story = arg_265_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) then
				if arg_265_1.var_.characterEffect1020ui_story and not isNil(arg_265_1.actors_["1020ui_story"]) then
					arg_265_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1020ui_story"]) and arg_265_1.var_.characterEffect1020ui_story then
				arg_265_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 0.6

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(320151063)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 24 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_4) / 24)

				if (24 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_4) / 24)) > 0 and var_268_2 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151063", "story_v_out_320151.awb") ~= 0 then
					local var_268_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151063", "story_v_out_320151.awb") / 1000

					if var_268_7 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_1
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_320151", "320151063", "story_v_out_320151.awb")

						arg_265_1:RecordAudio("320151063", var_268_8)
						arg_265_1:RecordAudio("320151063", var_268_8)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_320151", "320151063", "story_v_out_320151.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_320151", "320151063", "story_v_out_320151.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_9 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_9 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_9

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_9 and arg_265_1.time_ < var_268_1 + var_268_9 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320151064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320151064
		arg_269_1.duration_ = 6.1

		local var_269_0 = {
			zh = 3.066,
			ja = 6.1
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play320151065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) and arg_269_1.var_.characterEffect1020ui_story == nil then
				arg_269_1.var_.characterEffect1020ui_story = arg_269_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) then
				if arg_269_1.var_.characterEffect1020ui_story and not isNil(arg_269_1.actors_["1020ui_story"]) then
					arg_269_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1020ui_story"]) and arg_269_1.var_.characterEffect1020ui_story then
				arg_269_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_272_2 = 0
			local var_272_3 = 0.275

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:GetWordFromCfg(320151064)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 11 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 11)

				if (11 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 11)) > 0 and var_272_3 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151064", "story_v_out_320151.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151064", "story_v_out_320151.awb") / 1000

					if var_272_8 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_2
					end

					if var_272_4.prefab_name ~= "" and arg_269_1.actors_[var_272_4.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_4.prefab_name].transform, "story_v_out_320151", "320151064", "story_v_out_320151.awb")

						arg_269_1:RecordAudio("320151064", var_272_9)
						arg_269_1:RecordAudio("320151064", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_320151", "320151064", "story_v_out_320151.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_320151", "320151064", "story_v_out_320151.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_10 and arg_269_1.time_ < var_272_2 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play320151065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320151065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320151066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1020ui_story = arg_273_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).z)
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles = arg_273_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1020ui_story"].transform.position).z)
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1020ui_story"].transform.localEulerAngles = arg_273_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1020ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1020ui_story == nil then
				arg_273_1.var_.characterEffect1020ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1020ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_2)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1020ui_story then
				arg_273_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_276_3 = 0
			local var_276_4 = 1.375

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_3 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_5 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(320151065).content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_7 = 55 <= 0 and var_276_4 or var_276_4 * (utf8.len(var_276_5) / 55)

				if (55 <= 0 and var_276_4 or var_276_4 * (utf8.len(var_276_5) / 55)) > 0 and var_276_4 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_3 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_3
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_8 = math.max(var_276_4, arg_273_1.talkMaxDuration)

			if var_276_3 <= arg_273_1.time_ and arg_273_1.time_ < var_276_3 + var_276_8 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_3) / var_276_8

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_3 + var_276_8 and arg_273_1.time_ < var_276_3 + var_276_8 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play320151066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320151066
		arg_277_1.duration_ = 15

		local var_277_0 = {
			zh = 15,
			ja = 8.933
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play320151067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.15

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(320151066)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 46 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 46)

				if (46 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 46)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151066", "story_v_out_320151.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151066", "story_v_out_320151.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_320151", "320151066", "story_v_out_320151.awb")

						arg_277_1:RecordAudio("320151066", var_280_6)
						arg_277_1:RecordAudio("320151066", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_320151", "320151066", "story_v_out_320151.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_320151", "320151066", "story_v_out_320151.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play320151067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320151067
		arg_281_1.duration_ = 19.2

		local var_281_0 = {
			zh = 10.033,
			ja = 19.2
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320151068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:GetWordFromCfg(320151067)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 40 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 40)

				if (40 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 40)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151067", "story_v_out_320151.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151067", "story_v_out_320151.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_320151", "320151067", "story_v_out_320151.awb")

						arg_281_1:RecordAudio("320151067", var_284_6)
						arg_281_1:RecordAudio("320151067", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320151", "320151067", "story_v_out_320151.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320151", "320151067", "story_v_out_320151.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320151068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320151068
		arg_285_1.duration_ = 18.53

		local var_285_0 = {
			zh = 10.366,
			ja = 18.533
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play320151069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 1.15

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:GetWordFromCfg(320151068)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 46 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 46)

				if (46 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 46)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151068", "story_v_out_320151.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151068", "story_v_out_320151.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_320151", "320151068", "story_v_out_320151.awb")

						arg_285_1:RecordAudio("320151068", var_288_6)
						arg_285_1:RecordAudio("320151068", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_320151", "320151068", "story_v_out_320151.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_320151", "320151068", "story_v_out_320151.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play320151069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 320151069
		arg_289_1.duration_ = 2.8

		local var_289_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play320151070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1020ui_story = arg_289_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).z)
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles = arg_289_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_289_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1020ui_story"].transform.position).z)
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1020ui_story"].transform.localEulerAngles = arg_289_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1020ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1020ui_story == nil then
				arg_289_1.var_.characterEffect1020ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1020ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1020ui_story then
				arg_289_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_292_4 = 0
			local var_292_5 = 0.175

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(320151069)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 7 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 7)

				if (7 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 7)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151069", "story_v_out_320151.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151069", "story_v_out_320151.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_320151", "320151069", "story_v_out_320151.awb")

						arg_289_1:RecordAudio("320151069", var_292_11)
						arg_289_1:RecordAudio("320151069", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_320151", "320151069", "story_v_out_320151.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_320151", "320151069", "story_v_out_320151.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play320151070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 320151070
		arg_293_1.duration_ = 16.3

		local var_293_0 = {
			zh = 9.333,
			ja = 16.3
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play320151071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story == nil then
				arg_293_1.var_.characterEffect1020ui_story = arg_293_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) then
				if arg_293_1.var_.characterEffect1020ui_story and not isNil(arg_293_1.actors_["1020ui_story"]) then
					arg_293_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1020ui_story"]) and arg_293_1.var_.characterEffect1020ui_story then
				arg_293_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.95

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:GetWordFromCfg(320151070)
				local var_296_4 = arg_293_1:FormatText(var_296_3.content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_6 = 38 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_4) / 38)

				if (38 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_4) / 38)) > 0 and var_296_2 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151070", "story_v_out_320151.awb") ~= 0 then
					local var_296_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151070", "story_v_out_320151.awb") / 1000

					if var_296_7 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_1
					end

					if var_296_3.prefab_name ~= "" and arg_293_1.actors_[var_296_3.prefab_name] ~= nil then
						local var_296_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_3.prefab_name].transform, "story_v_out_320151", "320151070", "story_v_out_320151.awb")

						arg_293_1:RecordAudio("320151070", var_296_8)
						arg_293_1:RecordAudio("320151070", var_296_8)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_320151", "320151070", "story_v_out_320151.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_320151", "320151070", "story_v_out_320151.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_9 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_9 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_9

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_9 and arg_293_1.time_ < var_296_1 + var_296_9 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play320151071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 320151071
		arg_297_1.duration_ = 5.3

		local var_297_0 = {
			zh = 4.066,
			ja = 5.3
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play320151072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1020ui_story"]) and arg_297_1.var_.characterEffect1020ui_story == nil then
				arg_297_1.var_.characterEffect1020ui_story = arg_297_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1020ui_story"]) then
				if arg_297_1.var_.characterEffect1020ui_story and not isNil(arg_297_1.actors_["1020ui_story"]) then
					arg_297_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1020ui_story"]) and arg_297_1.var_.characterEffect1020ui_story then
				arg_297_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			local var_300_2 = 0
			local var_300_3 = 0.575

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(320151071)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 23 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 23)

				if (23 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 23)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151071", "story_v_out_320151.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151071", "story_v_out_320151.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_320151", "320151071", "story_v_out_320151.awb")

						arg_297_1:RecordAudio("320151071", var_300_9)
						arg_297_1:RecordAudio("320151071", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_320151", "320151071", "story_v_out_320151.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_320151", "320151071", "story_v_out_320151.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play320151072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 320151072
		arg_301_1.duration_ = 13.73

		local var_301_0 = {
			zh = 8,
			ja = 13.733
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play320151073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.9

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(320151072)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 36 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 36)

				if (36 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 36)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151072", "story_v_out_320151.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151072", "story_v_out_320151.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_320151", "320151072", "story_v_out_320151.awb")

						arg_301_1:RecordAudio("320151072", var_304_6)
						arg_301_1:RecordAudio("320151072", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_320151", "320151072", "story_v_out_320151.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_320151", "320151072", "story_v_out_320151.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play320151073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 320151073
		arg_305_1.duration_ = 10.47

		local var_305_0 = {
			zh = 9.3,
			ja = 10.466
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play320151074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_308_0 = 0
			local var_308_1 = 1.05

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(320151073)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 40 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_3) / 40)

				if (40 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_3) / 40)) > 0 and var_308_1 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151073", "story_v_out_320151.awb") ~= 0 then
					local var_308_6 = manager.audio:GetVoiceLength("story_v_out_320151", "320151073", "story_v_out_320151.awb") / 1000

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end

					if var_308_2.prefab_name ~= "" and arg_305_1.actors_[var_308_2.prefab_name] ~= nil then
						local var_308_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_2.prefab_name].transform, "story_v_out_320151", "320151073", "story_v_out_320151.awb")

						arg_305_1:RecordAudio("320151073", var_308_7)
						arg_305_1:RecordAudio("320151073", var_308_7)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_320151", "320151073", "story_v_out_320151.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_320151", "320151073", "story_v_out_320151.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play320151074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 320151074
		arg_309_1.duration_ = 8.57

		local var_309_0 = {
			zh = 4.7,
			ja = 8.566
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play320151075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1020ui_story"]) and arg_309_1.var_.characterEffect1020ui_story == nil then
				arg_309_1.var_.characterEffect1020ui_story = arg_309_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1020ui_story"]) then
				if arg_309_1.var_.characterEffect1020ui_story and not isNil(arg_309_1.actors_["1020ui_story"]) then
					arg_309_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_0)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1020ui_story"]) and arg_309_1.var_.characterEffect1020ui_story then
				arg_309_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_312_1 = 0
			local var_312_2 = 0.45

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(320151074)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 18 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_4) / 18)

				if (18 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_4) / 18)) > 0 and var_312_2 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151074", "story_v_out_320151.awb") ~= 0 then
					local var_312_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151074", "story_v_out_320151.awb") / 1000

					if var_312_7 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_1
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_320151", "320151074", "story_v_out_320151.awb")

						arg_309_1:RecordAudio("320151074", var_312_8)
						arg_309_1:RecordAudio("320151074", var_312_8)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_320151", "320151074", "story_v_out_320151.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_320151", "320151074", "story_v_out_320151.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_9 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_9 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_9

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_9 and arg_309_1.time_ < var_312_1 + var_312_9 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play320151075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 320151075
		arg_313_1.duration_ = 8.1

		local var_313_0 = {
			zh = 4.633,
			ja = 8.1
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play320151076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1020ui_story"]) and arg_313_1.var_.characterEffect1020ui_story == nil then
				arg_313_1.var_.characterEffect1020ui_story = arg_313_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1020ui_story"]) then
				if arg_313_1.var_.characterEffect1020ui_story and not isNil(arg_313_1.actors_["1020ui_story"]) then
					arg_313_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1020ui_story"]) and arg_313_1.var_.characterEffect1020ui_story then
				arg_313_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_316_2 = 0
			local var_316_3 = 0.55

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_4 = arg_313_1:GetWordFromCfg(320151075)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 22 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 22)

				if (22 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 22)) > 0 and var_316_3 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151075", "story_v_out_320151.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151075", "story_v_out_320151.awb") / 1000

					if var_316_8 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_2
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_out_320151", "320151075", "story_v_out_320151.awb")

						arg_313_1:RecordAudio("320151075", var_316_9)
						arg_313_1:RecordAudio("320151075", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_320151", "320151075", "story_v_out_320151.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_320151", "320151075", "story_v_out_320151.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_10 and arg_313_1.time_ < var_316_2 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play320151076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 320151076
		arg_317_1.duration_ = 11.03

		local var_317_0 = {
			zh = 10.366,
			ja = 11.033
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play320151077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.2

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:GetWordFromCfg(320151076)
				local var_320_2 = arg_317_1:FormatText(var_320_1.content)

				arg_317_1.text_.text = var_320_2

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 48 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 48)

				if (48 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_2) / 48)) > 0 and var_320_0 < var_320_4 then
					arg_317_1.talkMaxDuration = var_320_4

					if var_320_4 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_4 + 0
					end
				end

				arg_317_1.text_.text = var_320_2
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151076", "story_v_out_320151.awb") ~= 0 then
					local var_320_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151076", "story_v_out_320151.awb") / 1000

					if var_320_5 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + 0
					end

					if var_320_1.prefab_name ~= "" and arg_317_1.actors_[var_320_1.prefab_name] ~= nil then
						local var_320_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_1.prefab_name].transform, "story_v_out_320151", "320151076", "story_v_out_320151.awb")

						arg_317_1:RecordAudio("320151076", var_320_6)
						arg_317_1:RecordAudio("320151076", var_320_6)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_320151", "320151076", "story_v_out_320151.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_320151", "320151076", "story_v_out_320151.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_7 and arg_317_1.time_ < 0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play320151077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 320151077
		arg_321_1.duration_ = 18.27

		local var_321_0 = {
			zh = 11.6,
			ja = 18.266
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play320151078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 1.2

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(320151077)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 48 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 48)

				if (48 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 48)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151077", "story_v_out_320151.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151077", "story_v_out_320151.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_320151", "320151077", "story_v_out_320151.awb")

						arg_321_1:RecordAudio("320151077", var_324_6)
						arg_321_1:RecordAudio("320151077", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_320151", "320151077", "story_v_out_320151.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_320151", "320151077", "story_v_out_320151.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play320151078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 320151078
		arg_325_1.duration_ = 19.93

		local var_325_0 = {
			zh = 12.9,
			ja = 19.933
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play320151079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 1.45

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:GetWordFromCfg(320151078)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 58 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 58)

				if (58 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 58)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151078", "story_v_out_320151.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151078", "story_v_out_320151.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_320151", "320151078", "story_v_out_320151.awb")

						arg_325_1:RecordAudio("320151078", var_328_6)
						arg_325_1:RecordAudio("320151078", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_320151", "320151078", "story_v_out_320151.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_320151", "320151078", "story_v_out_320151.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play320151079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 320151079
		arg_329_1.duration_ = 15.77

		local var_329_0 = {
			zh = 11.266,
			ja = 15.766
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play320151080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 1.375

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:GetWordFromCfg(320151079)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 55 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 55)

				if (55 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 55)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151079", "story_v_out_320151.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151079", "story_v_out_320151.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_320151", "320151079", "story_v_out_320151.awb")

						arg_329_1:RecordAudio("320151079", var_332_6)
						arg_329_1:RecordAudio("320151079", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_320151", "320151079", "story_v_out_320151.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_320151", "320151079", "story_v_out_320151.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play320151080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 320151080
		arg_333_1.duration_ = 16.73

		local var_333_0 = {
			zh = 12.266,
			ja = 16.733
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play320151081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action445")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_336_0 = 0
			local var_336_1 = 1.575

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_2 = arg_333_1:GetWordFromCfg(320151080)
				local var_336_3 = arg_333_1:FormatText(var_336_2.content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 63 <= 0 and var_336_1 or var_336_1 * (utf8.len(var_336_3) / 63)

				if (63 <= 0 and var_336_1 or var_336_1 * (utf8.len(var_336_3) / 63)) > 0 and var_336_1 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_0
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151080", "story_v_out_320151.awb") ~= 0 then
					local var_336_6 = manager.audio:GetVoiceLength("story_v_out_320151", "320151080", "story_v_out_320151.awb") / 1000

					if var_336_6 + var_336_0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_6 + var_336_0
					end

					if var_336_2.prefab_name ~= "" and arg_333_1.actors_[var_336_2.prefab_name] ~= nil then
						local var_336_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_2.prefab_name].transform, "story_v_out_320151", "320151080", "story_v_out_320151.awb")

						arg_333_1:RecordAudio("320151080", var_336_7)
						arg_333_1:RecordAudio("320151080", var_336_7)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_320151", "320151080", "story_v_out_320151.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_320151", "320151080", "story_v_out_320151.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_8 = math.max(var_336_1, arg_333_1.talkMaxDuration)

			if var_336_0 <= arg_333_1.time_ and arg_333_1.time_ < var_336_0 + var_336_8 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_0) / var_336_8

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_0 + var_336_8 and arg_333_1.time_ < var_336_0 + var_336_8 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play320151081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 320151081
		arg_337_1.duration_ = 7.5

		local var_337_0 = {
			zh = 7.066,
			ja = 7.5
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play320151082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1020ui_story"]) and arg_337_1.var_.characterEffect1020ui_story == nil then
				arg_337_1.var_.characterEffect1020ui_story = arg_337_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1020ui_story"]) then
				if arg_337_1.var_.characterEffect1020ui_story and not isNil(arg_337_1.actors_["1020ui_story"]) then
					arg_337_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1020ui_story"]) and arg_337_1.var_.characterEffect1020ui_story then
				arg_337_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_table", "")
			end

			local var_340_2 = 0
			local var_340_3 = 0.8

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_4 = arg_337_1:GetWordFromCfg(320151081)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 32 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 32)

				if (32 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 32)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151081", "story_v_out_320151.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151081", "story_v_out_320151.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_out_320151", "320151081", "story_v_out_320151.awb")

						arg_337_1:RecordAudio("320151081", var_340_9)
						arg_337_1:RecordAudio("320151081", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_320151", "320151081", "story_v_out_320151.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_320151", "320151081", "story_v_out_320151.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play320151082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 320151082
		arg_341_1.duration_ = 15.4

		local var_341_0 = {
			zh = 9.6,
			ja = 15.4
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play320151083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1020ui_story"]) and arg_341_1.var_.characterEffect1020ui_story == nil then
				arg_341_1.var_.characterEffect1020ui_story = arg_341_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1020ui_story"]) then
				if arg_341_1.var_.characterEffect1020ui_story and not isNil(arg_341_1.actors_["1020ui_story"]) then
					arg_341_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1020ui_story"]) and arg_341_1.var_.characterEffect1020ui_story then
				arg_341_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action5_2")
			end

			local var_344_2 = 0
			local var_344_3 = 1.1

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_2 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_4 = arg_341_1:GetWordFromCfg(320151082)
				local var_344_5 = arg_341_1:FormatText(var_344_4.content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 44 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 44)

				if (44 <= 0 and var_344_3 or var_344_3 * (utf8.len(var_344_5) / 44)) > 0 and var_344_3 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_2
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151082", "story_v_out_320151.awb") ~= 0 then
					local var_344_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151082", "story_v_out_320151.awb") / 1000

					if var_344_8 + var_344_2 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_8 + var_344_2
					end

					if var_344_4.prefab_name ~= "" and arg_341_1.actors_[var_344_4.prefab_name] ~= nil then
						local var_344_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_4.prefab_name].transform, "story_v_out_320151", "320151082", "story_v_out_320151.awb")

						arg_341_1:RecordAudio("320151082", var_344_9)
						arg_341_1:RecordAudio("320151082", var_344_9)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_320151", "320151082", "story_v_out_320151.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_320151", "320151082", "story_v_out_320151.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_10 = math.max(var_344_3, arg_341_1.talkMaxDuration)

			if var_344_2 <= arg_341_1.time_ and arg_341_1.time_ < var_344_2 + var_344_10 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_2) / var_344_10

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_2 + var_344_10 and arg_341_1.time_ < var_344_2 + var_344_10 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play320151083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 320151083
		arg_345_1.duration_ = 10.13

		local var_345_0 = {
			zh = 4.7,
			ja = 10.133
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play320151084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.6

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(320151083)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 24 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 24)

				if (24 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 24)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151083", "story_v_out_320151.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151083", "story_v_out_320151.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_320151", "320151083", "story_v_out_320151.awb")

						arg_345_1:RecordAudio("320151083", var_348_6)
						arg_345_1:RecordAudio("320151083", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_320151", "320151083", "story_v_out_320151.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_320151", "320151083", "story_v_out_320151.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play320151084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 320151084
		arg_349_1.duration_ = 14.8

		local var_349_0 = {
			zh = 11.366,
			ja = 14.8
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play320151085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1020ui_story"]) and arg_349_1.var_.characterEffect1020ui_story == nil then
				arg_349_1.var_.characterEffect1020ui_story = arg_349_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1020ui_story"]) then
				if arg_349_1.var_.characterEffect1020ui_story and not isNil(arg_349_1.actors_["1020ui_story"]) then
					arg_349_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1020ui_story"]) and arg_349_1.var_.characterEffect1020ui_story then
				arg_349_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 1.125

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:GetWordFromCfg(320151084)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_6 = 45 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_4) / 45)

				if (45 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_4) / 45)) > 0 and var_352_2 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151084", "story_v_out_320151.awb") ~= 0 then
					local var_352_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151084", "story_v_out_320151.awb") / 1000

					if var_352_7 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_1
					end

					if var_352_3.prefab_name ~= "" and arg_349_1.actors_[var_352_3.prefab_name] ~= nil then
						local var_352_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_3.prefab_name].transform, "story_v_out_320151", "320151084", "story_v_out_320151.awb")

						arg_349_1:RecordAudio("320151084", var_352_8)
						arg_349_1:RecordAudio("320151084", var_352_8)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_320151", "320151084", "story_v_out_320151.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_320151", "320151084", "story_v_out_320151.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_9 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_9 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_9

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_9 and arg_349_1.time_ < var_352_1 + var_352_9 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play320151085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 320151085
		arg_353_1.duration_ = 12.53

		local var_353_0 = {
			zh = 7.033,
			ja = 12.533
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play320151086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1020ui_story"]) and arg_353_1.var_.characterEffect1020ui_story == nil then
				arg_353_1.var_.characterEffect1020ui_story = arg_353_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1020ui_story"]) then
				if arg_353_1.var_.characterEffect1020ui_story and not isNil(arg_353_1.actors_["1020ui_story"]) then
					arg_353_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1020ui_story"]) and arg_353_1.var_.characterEffect1020ui_story then
				arg_353_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_356_2 = 0
			local var_356_3 = 0.7

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_4 = arg_353_1:GetWordFromCfg(320151085)
				local var_356_5 = arg_353_1:FormatText(var_356_4.content)

				arg_353_1.text_.text = var_356_5

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_7 = 28 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 28)

				if (28 <= 0 and var_356_3 or var_356_3 * (utf8.len(var_356_5) / 28)) > 0 and var_356_3 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_2
					end
				end

				arg_353_1.text_.text = var_356_5
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151085", "story_v_out_320151.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151085", "story_v_out_320151.awb") / 1000

					if var_356_8 + var_356_2 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_2
					end

					if var_356_4.prefab_name ~= "" and arg_353_1.actors_[var_356_4.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_4.prefab_name].transform, "story_v_out_320151", "320151085", "story_v_out_320151.awb")

						arg_353_1:RecordAudio("320151085", var_356_9)
						arg_353_1:RecordAudio("320151085", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_320151", "320151085", "story_v_out_320151.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_320151", "320151085", "story_v_out_320151.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_3, arg_353_1.talkMaxDuration)

			if var_356_2 <= arg_353_1.time_ and arg_353_1.time_ < var_356_2 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_2) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_2 + var_356_10 and arg_353_1.time_ < var_356_2 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play320151086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 320151086
		arg_357_1.duration_ = 14.13

		local var_357_0 = {
			zh = 10.666,
			ja = 14.133
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play320151087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 1.1

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:GetWordFromCfg(320151086)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 44 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 44)

				if (44 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 44)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151086", "story_v_out_320151.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151086", "story_v_out_320151.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_320151", "320151086", "story_v_out_320151.awb")

						arg_357_1:RecordAudio("320151086", var_360_6)
						arg_357_1:RecordAudio("320151086", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_320151", "320151086", "story_v_out_320151.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_320151", "320151086", "story_v_out_320151.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play320151087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 320151087
		arg_361_1.duration_ = 8.8

		local var_361_0 = {
			zh = 5.766,
			ja = 8.8
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play320151088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1020ui_story"]) and arg_361_1.var_.characterEffect1020ui_story == nil then
				arg_361_1.var_.characterEffect1020ui_story = arg_361_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1020ui_story"]) then
				if arg_361_1.var_.characterEffect1020ui_story and not isNil(arg_361_1.actors_["1020ui_story"]) then
					arg_361_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1020ui_story"]) and arg_361_1.var_.characterEffect1020ui_story then
				arg_361_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.675

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(320151087)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 28 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 28)

				if (28 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_4) / 28)) > 0 and var_364_2 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151087", "story_v_out_320151.awb") ~= 0 then
					local var_364_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151087", "story_v_out_320151.awb") / 1000

					if var_364_7 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_1
					end

					if var_364_3.prefab_name ~= "" and arg_361_1.actors_[var_364_3.prefab_name] ~= nil then
						local var_364_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_3.prefab_name].transform, "story_v_out_320151", "320151087", "story_v_out_320151.awb")

						arg_361_1:RecordAudio("320151087", var_364_8)
						arg_361_1:RecordAudio("320151087", var_364_8)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_320151", "320151087", "story_v_out_320151.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_320151", "320151087", "story_v_out_320151.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_9 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_9 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_9

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_9 and arg_361_1.time_ < var_364_1 + var_364_9 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play320151088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 320151088
		arg_365_1.duration_ = 8.37

		local var_365_0 = {
			zh = 7.3,
			ja = 8.366
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play320151089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1020ui_story"]) and arg_365_1.var_.characterEffect1020ui_story == nil then
				arg_365_1.var_.characterEffect1020ui_story = arg_365_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1020ui_story"]) then
				if arg_365_1.var_.characterEffect1020ui_story and not isNil(arg_365_1.actors_["1020ui_story"]) then
					arg_365_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1020ui_story"]) and arg_365_1.var_.characterEffect1020ui_story then
				arg_365_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_368_2 = 0
			local var_368_3 = 0.875

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(320151088)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 35 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 35)

				if (35 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 35)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151088", "story_v_out_320151.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151088", "story_v_out_320151.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_out_320151", "320151088", "story_v_out_320151.awb")

						arg_365_1:RecordAudio("320151088", var_368_9)
						arg_365_1:RecordAudio("320151088", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_320151", "320151088", "story_v_out_320151.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_320151", "320151088", "story_v_out_320151.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_10 and arg_365_1.time_ < var_368_2 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play320151089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 320151089
		arg_369_1.duration_ = 10.8

		local var_369_0 = {
			zh = 10.8,
			ja = 10.533
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play320151090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1020ui_story"]) and arg_369_1.var_.characterEffect1020ui_story == nil then
				arg_369_1.var_.characterEffect1020ui_story = arg_369_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1020ui_story"]) then
				if arg_369_1.var_.characterEffect1020ui_story and not isNil(arg_369_1.actors_["1020ui_story"]) then
					arg_369_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1020ui_story"]) and arg_369_1.var_.characterEffect1020ui_story then
				arg_369_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 1.025

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:GetWordFromCfg(320151089)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_6 = 41 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_4) / 41)

				if (41 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_4) / 41)) > 0 and var_372_2 < var_372_6 then
					arg_369_1.talkMaxDuration = var_372_6

					if var_372_6 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_6 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151089", "story_v_out_320151.awb") ~= 0 then
					local var_372_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151089", "story_v_out_320151.awb") / 1000

					if var_372_7 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_1
					end

					if var_372_3.prefab_name ~= "" and arg_369_1.actors_[var_372_3.prefab_name] ~= nil then
						local var_372_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_3.prefab_name].transform, "story_v_out_320151", "320151089", "story_v_out_320151.awb")

						arg_369_1:RecordAudio("320151089", var_372_8)
						arg_369_1:RecordAudio("320151089", var_372_8)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_320151", "320151089", "story_v_out_320151.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_320151", "320151089", "story_v_out_320151.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_9 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_9 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_9

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_9 and arg_369_1.time_ < var_372_1 + var_372_9 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play320151090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 320151090
		arg_373_1.duration_ = 14.07

		local var_373_0 = {
			zh = 10.266,
			ja = 14.066
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play320151091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1020ui_story"]) and arg_373_1.var_.characterEffect1020ui_story == nil then
				arg_373_1.var_.characterEffect1020ui_story = arg_373_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1020ui_story"]) then
				if arg_373_1.var_.characterEffect1020ui_story and not isNil(arg_373_1.actors_["1020ui_story"]) then
					arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1020ui_story"]) and arg_373_1.var_.characterEffect1020ui_story then
				arg_373_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_2 = 0
			local var_376_3 = 1

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(320151090)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 40 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 40)

				if (40 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 40)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151090", "story_v_out_320151.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151090", "story_v_out_320151.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_320151", "320151090", "story_v_out_320151.awb")

						arg_373_1:RecordAudio("320151090", var_376_9)
						arg_373_1:RecordAudio("320151090", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_320151", "320151090", "story_v_out_320151.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_320151", "320151090", "story_v_out_320151.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play320151091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 320151091
		arg_377_1.duration_ = 9.63

		local var_377_0 = {
			zh = 9.633,
			ja = 8.7
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play320151092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) and arg_377_1.var_.characterEffect1020ui_story == nil then
				arg_377_1.var_.characterEffect1020ui_story = arg_377_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) then
				if arg_377_1.var_.characterEffect1020ui_story and not isNil(arg_377_1.actors_["1020ui_story"]) then
					arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_0)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1020ui_story"]) and arg_377_1.var_.characterEffect1020ui_story then
				arg_377_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_380_1 = 0
			local var_380_2 = 1.025

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(320151091)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_6 = 41 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_4) / 41)

				if (41 <= 0 and var_380_2 or var_380_2 * (utf8.len(var_380_4) / 41)) > 0 and var_380_2 < var_380_6 then
					arg_377_1.talkMaxDuration = var_380_6

					if var_380_6 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_6 + var_380_1
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151091", "story_v_out_320151.awb") ~= 0 then
					local var_380_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151091", "story_v_out_320151.awb") / 1000

					if var_380_7 + var_380_1 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_1
					end

					if var_380_3.prefab_name ~= "" and arg_377_1.actors_[var_380_3.prefab_name] ~= nil then
						local var_380_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_3.prefab_name].transform, "story_v_out_320151", "320151091", "story_v_out_320151.awb")

						arg_377_1:RecordAudio("320151091", var_380_8)
						arg_377_1:RecordAudio("320151091", var_380_8)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_320151", "320151091", "story_v_out_320151.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_320151", "320151091", "story_v_out_320151.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_9 = math.max(var_380_2, arg_377_1.talkMaxDuration)

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_9 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_1) / var_380_9

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_1 + var_380_9 and arg_377_1.time_ < var_380_1 + var_380_9 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play320151092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 320151092
		arg_381_1.duration_ = 7.07

		local var_381_0 = {
			zh = 6.066,
			ja = 7.066
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play320151093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1020ui_story"]) and arg_381_1.var_.characterEffect1020ui_story == nil then
				arg_381_1.var_.characterEffect1020ui_story = arg_381_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1020ui_story"]) then
				if arg_381_1.var_.characterEffect1020ui_story and not isNil(arg_381_1.actors_["1020ui_story"]) then
					arg_381_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1020ui_story"]) and arg_381_1.var_.characterEffect1020ui_story then
				arg_381_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action464")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_384_2 = 0
			local var_384_3 = 0.625

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_2 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_4 = arg_381_1:GetWordFromCfg(320151092)
				local var_384_5 = arg_381_1:FormatText(var_384_4.content)

				arg_381_1.text_.text = var_384_5

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_7 = 25 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 25)

				if (25 <= 0 and var_384_3 or var_384_3 * (utf8.len(var_384_5) / 25)) > 0 and var_384_3 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_2
					end
				end

				arg_381_1.text_.text = var_384_5
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151092", "story_v_out_320151.awb") ~= 0 then
					local var_384_8 = manager.audio:GetVoiceLength("story_v_out_320151", "320151092", "story_v_out_320151.awb") / 1000

					if var_384_8 + var_384_2 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_2
					end

					if var_384_4.prefab_name ~= "" and arg_381_1.actors_[var_384_4.prefab_name] ~= nil then
						local var_384_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_4.prefab_name].transform, "story_v_out_320151", "320151092", "story_v_out_320151.awb")

						arg_381_1:RecordAudio("320151092", var_384_9)
						arg_381_1:RecordAudio("320151092", var_384_9)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_320151", "320151092", "story_v_out_320151.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_320151", "320151092", "story_v_out_320151.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_10 = math.max(var_384_3, arg_381_1.talkMaxDuration)

			if var_384_2 <= arg_381_1.time_ and arg_381_1.time_ < var_384_2 + var_384_10 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_2) / var_384_10

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_2 + var_384_10 and arg_381_1.time_ < var_384_2 + var_384_10 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play320151093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 320151093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play320151094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1020ui_story = arg_385_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1020ui_story"].transform.position).z)
				arg_385_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1020ui_story"].transform.localEulerAngles = arg_385_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_385_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1020ui_story"].transform.position).z)
				arg_385_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1020ui_story"].transform.localEulerAngles = arg_385_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1020ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1020ui_story == nil then
				arg_385_1.var_.characterEffect1020ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1020ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_2)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1020ui_story then
				arg_385_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_388_3 = 0
			local var_388_4 = 0.625

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_3 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_5 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(320151093).content)

				arg_385_1.text_.text = var_388_5

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_7 = 25 <= 0 and var_388_4 or var_388_4 * (utf8.len(var_388_5) / 25)

				if (25 <= 0 and var_388_4 or var_388_4 * (utf8.len(var_388_5) / 25)) > 0 and var_388_4 < var_388_7 then
					arg_385_1.talkMaxDuration = var_388_7

					if var_388_7 + var_388_3 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_7 + var_388_3
					end
				end

				arg_385_1.text_.text = var_388_5
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_8 = math.max(var_388_4, arg_385_1.talkMaxDuration)

			if var_388_3 <= arg_385_1.time_ and arg_385_1.time_ < var_388_3 + var_388_8 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_3) / var_388_8

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_3 + var_388_8 and arg_385_1.time_ < var_388_3 + var_388_8 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	Play320151094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 320151094
		arg_389_1.duration_ = 14

		local var_389_0 = {
			zh = 12.066,
			ja = 14
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play320151095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1020ui_story = arg_389_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).z)
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles = arg_389_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_389_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1020ui_story"].transform.position).z)
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1020ui_story"].transform.localEulerAngles = arg_389_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1020ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1020ui_story == nil then
				arg_389_1.var_.characterEffect1020ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1020ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1020ui_story then
				arg_389_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_392_4 = 0
			local var_392_5 = 1.15

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_6 = arg_389_1:GetWordFromCfg(320151094)
				local var_392_7 = arg_389_1:FormatText(var_392_6.content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 46 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 46)

				if (46 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 46)) > 0 and var_392_5 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_4
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151094", "story_v_out_320151.awb") ~= 0 then
					local var_392_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151094", "story_v_out_320151.awb") / 1000

					if var_392_10 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_4
					end

					if var_392_6.prefab_name ~= "" and arg_389_1.actors_[var_392_6.prefab_name] ~= nil then
						local var_392_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_6.prefab_name].transform, "story_v_out_320151", "320151094", "story_v_out_320151.awb")

						arg_389_1:RecordAudio("320151094", var_392_11)
						arg_389_1:RecordAudio("320151094", var_392_11)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_320151", "320151094", "story_v_out_320151.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_320151", "320151094", "story_v_out_320151.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_12 = math.max(var_392_5, arg_389_1.talkMaxDuration)

			if var_392_4 <= arg_389_1.time_ and arg_389_1.time_ < var_392_4 + var_392_12 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_4) / var_392_12

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_4 + var_392_12 and arg_389_1.time_ < var_392_4 + var_392_12 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
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

		arg_389_1:InitPlayNodeList()
	end,
	Play320151095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 320151095
		arg_393_1.duration_ = 6.97

		local var_393_0 = {
			zh = 4.433,
			ja = 6.966
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play320151096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_396_0 = 0
			local var_396_1 = 0.525

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_2 = arg_393_1:GetWordFromCfg(320151095)
				local var_396_3 = arg_393_1:FormatText(var_396_2.content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 22 <= 0 and var_396_1 or var_396_1 * (utf8.len(var_396_3) / 22)

				if (22 <= 0 and var_396_1 or var_396_1 * (utf8.len(var_396_3) / 22)) > 0 and var_396_1 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151095", "story_v_out_320151.awb") ~= 0 then
					local var_396_6 = manager.audio:GetVoiceLength("story_v_out_320151", "320151095", "story_v_out_320151.awb") / 1000

					if var_396_6 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_0
					end

					if var_396_2.prefab_name ~= "" and arg_393_1.actors_[var_396_2.prefab_name] ~= nil then
						local var_396_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_2.prefab_name].transform, "story_v_out_320151", "320151095", "story_v_out_320151.awb")

						arg_393_1:RecordAudio("320151095", var_396_7)
						arg_393_1:RecordAudio("320151095", var_396_7)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_320151", "320151095", "story_v_out_320151.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_320151", "320151095", "story_v_out_320151.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_8 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_8 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_8

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_8 and arg_393_1.time_ < var_396_0 + var_396_8 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play320151096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 320151096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play320151097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1020ui_story = arg_397_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_400_0 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 then
				arg_397_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_397_1.time_ - 0) / var_400_0)
				arg_397_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1020ui_story"].transform.position).z)
				arg_397_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1020ui_story"].transform.localEulerAngles = arg_397_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 then
				arg_397_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_397_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1020ui_story"].transform.position).z)
				arg_397_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1020ui_story"].transform.localEulerAngles = arg_397_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_400_1 = arg_397_1.actors_["1020ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1020ui_story == nil then
				arg_397_1.var_.characterEffect1020ui_story = var_400_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 and not isNil(var_400_1) then
				if arg_397_1.var_.characterEffect1020ui_story and not isNil(var_400_1) then
					arg_397_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_2)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1020ui_story then
				arg_397_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_400_3 = 0
			local var_400_4 = 0.875

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_5 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(320151096).content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 35 <= 0 and var_400_4 or var_400_4 * (utf8.len(var_400_5) / 35)

				if (35 <= 0 and var_400_4 or var_400_4 * (utf8.len(var_400_5) / 35)) > 0 and var_400_4 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_3 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_3
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_8 = math.max(var_400_4, arg_397_1.talkMaxDuration)

			if var_400_3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_3 + var_400_8 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_3) / var_400_8

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_3 + var_400_8 and arg_397_1.time_ < var_400_3 + var_400_8 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
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

		arg_397_1:InitPlayNodeList()
	end,
	Play320151097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 320151097
		arg_401_1.duration_ = 9.37

		local var_401_0 = {
			zh = 5.2,
			ja = 9.366
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play320151098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.45

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:GetWordFromCfg(320151097)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 18 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 18)

				if (18 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 18)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151097", "story_v_out_320151.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151097", "story_v_out_320151.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_320151", "320151097", "story_v_out_320151.awb")

						arg_401_1:RecordAudio("320151097", var_404_6)
						arg_401_1:RecordAudio("320151097", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_320151", "320151097", "story_v_out_320151.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_320151", "320151097", "story_v_out_320151.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play320151098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 320151098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play320151099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0.1 < arg_405_1.time_ and arg_405_1.time_ <= 0.1 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_136", "se_story_136_table", "")
			end

			local var_408_1 = 0
			local var_408_2 = 1.775

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(320151098).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 71 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 71)

				if (71 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 71)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play320151099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 320151099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play320151100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 1.075

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_1 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(320151099).content)

				arg_409_1.text_.text = var_412_1

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_3 = 43 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 43)

				if (43 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 43)) > 0 and var_412_0 < var_412_3 then
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
	Play320151100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 320151100
		arg_413_1.duration_ = 5.63

		local var_413_0 = {
			zh = 1.966,
			ja = 5.633
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
				arg_413_0:Play320151101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1020ui_story = arg_413_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1020ui_story"].transform.position).z)
				arg_413_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1020ui_story"].transform.localEulerAngles = arg_413_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_413_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1020ui_story"].transform.position).z)
				arg_413_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1020ui_story"].transform.localEulerAngles = arg_413_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["1020ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1020ui_story == nil then
				arg_413_1.var_.characterEffect1020ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1020ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1020ui_story then
				arg_413_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_416_4 = 0
			local var_416_5 = 0.2

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(320151100)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 8 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 8)

				if (8 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 8)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151100", "story_v_out_320151.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151100", "story_v_out_320151.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_out_320151", "320151100", "story_v_out_320151.awb")

						arg_413_1:RecordAudio("320151100", var_416_11)
						arg_413_1:RecordAudio("320151100", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_320151", "320151100", "story_v_out_320151.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_320151", "320151100", "story_v_out_320151.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play320151101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 320151101
		arg_417_1.duration_ = 4.8

		local var_417_0 = {
			zh = 4.8,
			ja = 4.633
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play320151102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1020ui_story"]) and arg_417_1.var_.characterEffect1020ui_story == nil then
				arg_417_1.var_.characterEffect1020ui_story = arg_417_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1020ui_story"]) then
				if arg_417_1.var_.characterEffect1020ui_story and not isNil(arg_417_1.actors_["1020ui_story"]) then
					arg_417_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1020ui_story"]) and arg_417_1.var_.characterEffect1020ui_story then
				arg_417_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.45

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(320151101)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_6 = 18 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_4) / 18)

				if (18 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_4) / 18)) > 0 and var_420_2 < var_420_6 then
					arg_417_1.talkMaxDuration = var_420_6

					if var_420_6 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_6 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151101", "story_v_out_320151.awb") ~= 0 then
					local var_420_7 = manager.audio:GetVoiceLength("story_v_out_320151", "320151101", "story_v_out_320151.awb") / 1000

					if var_420_7 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_1
					end

					if var_420_3.prefab_name ~= "" and arg_417_1.actors_[var_420_3.prefab_name] ~= nil then
						local var_420_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_3.prefab_name].transform, "story_v_out_320151", "320151101", "story_v_out_320151.awb")

						arg_417_1:RecordAudio("320151101", var_420_8)
						arg_417_1:RecordAudio("320151101", var_420_8)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_320151", "320151101", "story_v_out_320151.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_320151", "320151101", "story_v_out_320151.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_9 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_9 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_9

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_9 and arg_417_1.time_ < var_420_1 + var_420_9 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play320151102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 320151102
		arg_421_1.duration_ = 19.27

		local var_421_0 = {
			zh = 6.433,
			ja = 19.266
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play320151103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.65

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1025].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_wrestlingboss")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_1 = arg_421_1:GetWordFromCfg(320151102)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 26 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 26)

				if (26 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 26)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151102", "story_v_out_320151.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_320151", "320151102", "story_v_out_320151.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_320151", "320151102", "story_v_out_320151.awb")

						arg_421_1:RecordAudio("320151102", var_424_6)
						arg_421_1:RecordAudio("320151102", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_320151", "320151102", "story_v_out_320151.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_320151", "320151102", "story_v_out_320151.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play320151103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 320151103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play320151104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1020ui_story = arg_425_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1020ui_story"].transform.position).z)
				arg_425_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1020ui_story"].transform.localEulerAngles = arg_425_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_425_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1020ui_story"].transform.position).z)
				arg_425_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1020ui_story"].transform.localEulerAngles = arg_425_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1020ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1020ui_story == nil then
				arg_425_1.var_.characterEffect1020ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1020ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_2)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1020ui_story then
				arg_425_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_428_3 = 0
			local var_428_4 = 1.425

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_5 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(320151103).content)

				arg_425_1.text_.text = var_428_5

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_7 = 57 <= 0 and var_428_4 or var_428_4 * (utf8.len(var_428_5) / 57)

				if (57 <= 0 and var_428_4 or var_428_4 * (utf8.len(var_428_5) / 57)) > 0 and var_428_4 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_3 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_3
					end
				end

				arg_425_1.text_.text = var_428_5
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_8 = math.max(var_428_4, arg_425_1.talkMaxDuration)

			if var_428_3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_3 + var_428_8 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_3) / var_428_8

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_3 + var_428_8 and arg_425_1.time_ < var_428_3 + var_428_8 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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

		arg_425_1:InitPlayNodeList()
	end,
	Play320151104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 320151104
		arg_429_1.duration_ = 3.97

		local var_429_0 = {
			zh = 3.933,
			ja = 3.966
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
			arg_429_1.auto_ = false
		end

		function arg_429_1.playNext_(arg_431_0)
			arg_429_1.onStoryFinished_()
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos1020ui_story = arg_429_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_432_0 = 0.001

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 then
				arg_429_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_429_1.time_ - 0) / var_432_0)
				arg_429_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1020ui_story"].transform.position).z)
				arg_429_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1020ui_story"].transform.localEulerAngles = arg_429_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 then
				arg_429_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_429_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_429_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_429_1.actors_["1020ui_story"].transform.position).z)
				arg_429_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_429_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_429_1.actors_["1020ui_story"].transform.localEulerAngles = arg_429_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_432_1 = arg_429_1.actors_["1020ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1020ui_story == nil then
				arg_429_1.var_.characterEffect1020ui_story = var_432_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_2 and not isNil(var_432_1) then
				if arg_429_1.var_.characterEffect1020ui_story and not isNil(var_432_1) then
					arg_429_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_2 and arg_429_1.time_ < 0 + var_432_2 + arg_432_0 and not isNil(var_432_1) and arg_429_1.var_.characterEffect1020ui_story then
				arg_429_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_432_4 = 0
			local var_432_5 = 0.25

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_6 = arg_429_1:GetWordFromCfg(320151104)
				local var_432_7 = arg_429_1:FormatText(var_432_6.content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 10 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 10)

				if (10 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 10)) > 0 and var_432_5 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_4
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320151", "320151104", "story_v_out_320151.awb") ~= 0 then
					local var_432_10 = manager.audio:GetVoiceLength("story_v_out_320151", "320151104", "story_v_out_320151.awb") / 1000

					if var_432_10 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_4
					end

					if var_432_6.prefab_name ~= "" and arg_429_1.actors_[var_432_6.prefab_name] ~= nil then
						local var_432_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_6.prefab_name].transform, "story_v_out_320151", "320151104", "story_v_out_320151.awb")

						arg_429_1:RecordAudio("320151104", var_432_11)
						arg_429_1:RecordAudio("320151104", var_432_11)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_320151", "320151104", "story_v_out_320151.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_320151", "320151104", "story_v_out_320151.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_12 = math.max(var_432_5, arg_429_1.talkMaxDuration)

			if var_432_4 <= arg_429_1.time_ and arg_429_1.time_ < var_432_4 + var_432_12 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_4) / var_432_12

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_4 + var_432_12 and arg_429_1.time_ < var_432_4 + var_432_12 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
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

		arg_429_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L07k",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/ST05a",
		"TextureConfig/Background/L02f"
	},
	voices = {
		"story_v_out_320151.awb"
	}
}
