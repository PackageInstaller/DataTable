return {
	Play321132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321132001
		arg_1_1.duration_ = 7.37

		local var_1_0 = {
			zh = 5.066,
			ja = 7.366
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
				arg_1_0:Play321132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L09h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09h")
				var_4_0.name = "L09h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L09h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L09h

				arg_1_1.bgs_.L09h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L09h" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_source", "bgm_activity_4_0_story_shashvat_source")

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
			local var_4_16 = 0.35

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(321132001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 14 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 14)

				if (14 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 14)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132001", "story_v_out_321132.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_321132", "321132001", "story_v_out_321132.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_321132", "321132001", "story_v_out_321132.awb")

						arg_1_1:RecordAudio("321132001", var_4_23)
						arg_1_1:RecordAudio("321132001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321132", "321132001", "story_v_out_321132.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321132", "321132001", "story_v_out_321132.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321132002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321132003(arg_9_1)
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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321132002).content)

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
	Play321132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321132003
		arg_13_1.duration_ = 4.2

		local var_13_0 = {
			zh = 4.2,
			ja = 1.999999999999
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
				arg_13_0:Play321132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1111ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1111ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1111ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1111ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1111ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1111ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1111ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1111ui_story == nil then
				arg_13_1.var_.characterEffect1111ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1111ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1111ui_story then
				arg_13_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(321132003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 7 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 7)

				if (7 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 7)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132003", "story_v_out_321132.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_321132", "321132003", "story_v_out_321132.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_321132", "321132003", "story_v_out_321132.awb")

						arg_13_1:RecordAudio("321132003", var_16_15)
						arg_13_1:RecordAudio("321132003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321132", "321132003", "story_v_out_321132.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321132", "321132003", "story_v_out_321132.awb")
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
				actorName = "1111ui_story",
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
	Play321132004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321132004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321132005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10131ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10131ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "10131ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10131ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["10131ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["10131ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["10131ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["10131ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10131ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0.83, -0.96, -5.8)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["10131ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10131ui_story == nil then
				arg_17_1.var_.characterEffect10131ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect10131ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10131ui_story then
				arg_17_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_20_8 = arg_17_1.actors_["1111ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.characterEffect1111ui_story == nil then
				arg_17_1.var_.characterEffect1111ui_story = var_20_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_9 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 and not isNil(var_20_8) then
				if arg_17_1.var_.characterEffect1111ui_story and not isNil(var_20_8) then
					arg_17_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_9)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and not isNil(var_20_8) and arg_17_1.var_.characterEffect1111ui_story then
				arg_17_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_20_10 = 0
			local var_20_11 = 0.1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(321132004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 4 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 4)

				if (4 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 4)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132004", "story_v_out_321132.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_321132", "321132004", "story_v_out_321132.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_321132", "321132004", "story_v_out_321132.awb")

						arg_17_1:RecordAudio("321132004", var_20_17)
						arg_17_1:RecordAudio("321132004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321132", "321132004", "story_v_out_321132.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321132", "321132004", "story_v_out_321132.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321132005
		arg_21_1.duration_ = 9.87

		local var_21_0 = {
			zh = 6.166,
			ja = 9.866
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
				arg_21_0:Play321132006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1111ui_story = arg_21_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1111ui_story"].transform.position).z)
				arg_21_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1111ui_story"].transform.localEulerAngles = arg_21_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_21_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1111ui_story"].transform.position).z)
				arg_21_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1111ui_story"].transform.localEulerAngles = arg_21_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1111ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1111ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1111ui_story then
				arg_21_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["10131ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10131ui_story == nil then
				arg_21_1.var_.characterEffect10131ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect10131ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect10131ui_story then
				arg_21_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_6 = 0
			local var_24_7 = 0.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(321132005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 26 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 26)

				if (26 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 26)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132005", "story_v_out_321132.awb") ~= 0 then
					local var_24_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132005", "story_v_out_321132.awb") / 1000

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end

					if var_24_8.prefab_name ~= "" and arg_21_1.actors_[var_24_8.prefab_name] ~= nil then
						local var_24_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_8.prefab_name].transform, "story_v_out_321132", "321132005", "story_v_out_321132.awb")

						arg_21_1:RecordAudio("321132005", var_24_13)
						arg_21_1:RecordAudio("321132005", var_24_13)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321132", "321132005", "story_v_out_321132.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321132", "321132005", "story_v_out_321132.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321132006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321132006
		arg_25_1.duration_ = 4.2

		local var_25_0 = {
			zh = 3.833,
			ja = 4.2
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
				arg_25_0:Play321132007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1111ui_story = arg_25_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(321132006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 17 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 17)

				if (17 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 17)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132006", "story_v_out_321132.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_321132", "321132006", "story_v_out_321132.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_321132", "321132006", "story_v_out_321132.awb")

						arg_25_1:RecordAudio("321132006", var_28_8)
						arg_25_1:RecordAudio("321132006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321132", "321132006", "story_v_out_321132.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321132", "321132006", "story_v_out_321132.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321132007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321132007
		arg_29_1.duration_ = 4.63

		local var_29_0 = {
			zh = 3.966,
			ja = 4.633
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
				arg_29_0:Play321132008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10131ui_story = arg_29_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10131ui_story"].transform.position).z)
				arg_29_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10131ui_story"].transform.localEulerAngles = arg_29_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_29_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10131ui_story"].transform.position).z)
				arg_29_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10131ui_story"].transform.localEulerAngles = arg_29_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10131ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10131ui_story == nil then
				arg_29_1.var_.characterEffect10131ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10131ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10131ui_story then
				arg_29_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["1111ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1111ui_story == nil then
				arg_29_1.var_.characterEffect1111ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_5 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 and not isNil(var_32_4) then
				if arg_29_1.var_.characterEffect1111ui_story and not isNil(var_32_4) then
					arg_29_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_5)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect1111ui_story then
				arg_29_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_32_6 = 0
			local var_32_7 = 0.375

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(321132007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 15 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 15)

				if (15 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 15)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132007", "story_v_out_321132.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132007", "story_v_out_321132.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_321132", "321132007", "story_v_out_321132.awb")

						arg_29_1:RecordAudio("321132007", var_32_13)
						arg_29_1:RecordAudio("321132007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321132", "321132007", "story_v_out_321132.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321132", "321132007", "story_v_out_321132.awb")
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
				actorName = "10131ui_story",
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
	Play321132008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321132008
		arg_33_1.duration_ = 9.83

		local var_33_0 = {
			zh = 8.3,
			ja = 9.833
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
				arg_33_0:Play321132009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1111ui_story = arg_33_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_33_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1111ui_story"].transform.position).z)
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1111ui_story"].transform.localEulerAngles = arg_33_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1111ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1111ui_story == nil then
				arg_33_1.var_.characterEffect1111ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1111ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1111ui_story then
				arg_33_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["10131ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10131ui_story == nil then
				arg_33_1.var_.characterEffect10131ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect10131ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10131ui_story then
				arg_33_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action442")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_36_6 = 0
			local var_36_7 = 0.95

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(321132008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 38 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 38)

				if (38 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 38)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132008", "story_v_out_321132.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132008", "story_v_out_321132.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_321132", "321132008", "story_v_out_321132.awb")

						arg_33_1:RecordAudio("321132008", var_36_13)
						arg_33_1:RecordAudio("321132008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321132", "321132008", "story_v_out_321132.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321132", "321132008", "story_v_out_321132.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play321132009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321132009
		arg_37_1.duration_ = 5.6

		local var_37_0 = {
			zh = 4.033,
			ja = 5.6
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
				arg_37_0:Play321132010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10131ui_story = arg_37_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).z)
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles = arg_37_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_37_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10131ui_story"].transform.position).z)
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10131ui_story"].transform.localEulerAngles = arg_37_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10131ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10131ui_story == nil then
				arg_37_1.var_.characterEffect10131ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10131ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10131ui_story then
				arg_37_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["1111ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1111ui_story == nil then
				arg_37_1.var_.characterEffect1111ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect1111ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect1111ui_story then
				arg_37_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_6 = 0
			local var_40_7 = 0.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(321132009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 16 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 16)

				if (16 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 16)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132009", "story_v_out_321132.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132009", "story_v_out_321132.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_321132", "321132009", "story_v_out_321132.awb")

						arg_37_1:RecordAudio("321132009", var_40_13)
						arg_37_1:RecordAudio("321132009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321132", "321132009", "story_v_out_321132.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321132", "321132009", "story_v_out_321132.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321132010
		arg_41_1.duration_ = 3.57

		local var_41_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_41_0:Play321132011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1111ui_story = arg_41_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).z)
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles = arg_41_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_41_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1111ui_story"].transform.position).z)
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1111ui_story"].transform.localEulerAngles = arg_41_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1111ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1111ui_story == nil then
				arg_41_1.var_.characterEffect1111ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1111ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1111ui_story then
				arg_41_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["10131ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10131ui_story == nil then
				arg_41_1.var_.characterEffect10131ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect10131ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10131ui_story then
				arg_41_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action425")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(321132010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 10 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 10)

				if (10 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 10)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132010", "story_v_out_321132.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132010", "story_v_out_321132.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_321132", "321132010", "story_v_out_321132.awb")

						arg_41_1:RecordAudio("321132010", var_44_13)
						arg_41_1:RecordAudio("321132010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321132", "321132010", "story_v_out_321132.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321132", "321132010", "story_v_out_321132.awb")
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
				actorName = "1111ui_story",
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
	Play321132011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321132011
		arg_45_1.duration_ = 12.97

		local var_45_0 = {
			zh = 11.166,
			ja = 12.966
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
				arg_45_0:Play321132012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10131ui_story = arg_45_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10131ui_story"].transform.position).z)
				arg_45_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10131ui_story"].transform.localEulerAngles = arg_45_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_45_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10131ui_story"].transform.position).z)
				arg_45_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10131ui_story"].transform.localEulerAngles = arg_45_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["10131ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect10131ui_story == nil then
				arg_45_1.var_.characterEffect10131ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect10131ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect10131ui_story then
				arg_45_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["1111ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1111ui_story == nil then
				arg_45_1.var_.characterEffect1111ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect1111ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect1111ui_story then
				arg_45_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_48_6 = 0
			local var_48_7 = 1.075

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(321132011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 43 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 43)

				if (43 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 43)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132011", "story_v_out_321132.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132011", "story_v_out_321132.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_321132", "321132011", "story_v_out_321132.awb")

						arg_45_1:RecordAudio("321132011", var_48_13)
						arg_45_1:RecordAudio("321132011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_321132", "321132011", "story_v_out_321132.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_321132", "321132011", "story_v_out_321132.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321132012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play321132013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10131ui_story"]) and arg_49_1.var_.characterEffect10131ui_story == nil then
				arg_49_1.var_.characterEffect10131ui_story = arg_49_1.actors_["10131ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10131ui_story"]) then
				if arg_49_1.var_.characterEffect10131ui_story and not isNil(arg_49_1.actors_["10131ui_story"]) then
					arg_49_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10131ui_story"]) and arg_49_1.var_.characterEffect10131ui_story then
				arg_49_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_52_1 = 0
			local var_52_2 = 0.725

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

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(321132012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 29 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 29)

				if (29 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 29)) > 0 and var_52_2 < var_52_5 then
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

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321132013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321132013
		arg_53_1.duration_ = 7.3

		local var_53_0 = {
			zh = 6.466,
			ja = 7.3
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
				arg_53_0:Play321132014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10131ui_story = arg_53_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10131ui_story"].transform.position).z)
				arg_53_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10131ui_story"].transform.localEulerAngles = arg_53_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_53_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10131ui_story"].transform.position).z)
				arg_53_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10131ui_story"].transform.localEulerAngles = arg_53_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10131ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10131ui_story == nil then
				arg_53_1.var_.characterEffect10131ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect10131ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10131ui_story then
				arg_53_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_56_4 = 0
			local var_56_5 = 0.75

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(321132013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 30 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 30)

				if (30 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 30)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132013", "story_v_out_321132.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_321132", "321132013", "story_v_out_321132.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_321132", "321132013", "story_v_out_321132.awb")

						arg_53_1:RecordAudio("321132013", var_56_11)
						arg_53_1:RecordAudio("321132013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_321132", "321132013", "story_v_out_321132.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_321132", "321132013", "story_v_out_321132.awb")
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
				actorName = "10131ui_story",
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
	Play321132014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321132014
		arg_57_1.duration_ = 5.8

		local var_57_0 = {
			zh = 3.333,
			ja = 5.8
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321132015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1111ui_story = arg_57_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1111ui_story"].transform.position).z)
				arg_57_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1111ui_story"].transform.localEulerAngles = arg_57_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_57_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1111ui_story"].transform.position).z)
				arg_57_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1111ui_story"].transform.localEulerAngles = arg_57_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1111ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1111ui_story == nil then
				arg_57_1.var_.characterEffect1111ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1111ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1111ui_story then
				arg_57_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_60_4 = arg_57_1.actors_["10131ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect10131ui_story == nil then
				arg_57_1.var_.characterEffect10131ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect10131ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect10131ui_story then
				arg_57_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 0.4

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:GetWordFromCfg(321132014)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 16 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 16)

				if (16 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 16)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132014", "story_v_out_321132.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132014", "story_v_out_321132.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_321132", "321132014", "story_v_out_321132.awb")

						arg_57_1:RecordAudio("321132014", var_60_13)
						arg_57_1:RecordAudio("321132014", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_321132", "321132014", "story_v_out_321132.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_321132", "321132014", "story_v_out_321132.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321132015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321132015
		arg_61_1.duration_ = 5.07

		local var_61_0 = {
			zh = 3.533,
			ja = 5.066
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
				arg_61_0:Play321132016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1111ui_story = arg_61_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1111ui_story"].transform.position).z)
				arg_61_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1111ui_story"].transform.localEulerAngles = arg_61_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_61_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1111ui_story"].transform.position).z)
				arg_61_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1111ui_story"].transform.localEulerAngles = arg_61_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_64_1 = 0
			local var_64_2 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(321132015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 17 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 17)

				if (17 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 17)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132015", "story_v_out_321132.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_321132", "321132015", "story_v_out_321132.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_321132", "321132015", "story_v_out_321132.awb")

						arg_61_1:RecordAudio("321132015", var_64_8)
						arg_61_1:RecordAudio("321132015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321132", "321132015", "story_v_out_321132.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321132", "321132015", "story_v_out_321132.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321132016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 321132016
		arg_65_1.duration_ = 3.33

		local var_65_0 = {
			zh = 2.366,
			ja = 3.333
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
				arg_65_0:Play321132017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10131ui_story = arg_65_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10131ui_story"].transform.position).z)
				arg_65_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10131ui_story"].transform.localEulerAngles = arg_65_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_65_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10131ui_story"].transform.position).z)
				arg_65_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10131ui_story"].transform.localEulerAngles = arg_65_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10131ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10131ui_story == nil then
				arg_65_1.var_.characterEffect10131ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect10131ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10131ui_story then
				arg_65_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_68_4 = arg_65_1.actors_["1111ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1111ui_story == nil then
				arg_65_1.var_.characterEffect1111ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect1111ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1111ui_story then
				arg_65_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action3_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_68_6 = 0
			local var_68_7 = 0.175

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(321132016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 7 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 7)

				if (7 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 7)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132016", "story_v_out_321132.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132016", "story_v_out_321132.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_321132", "321132016", "story_v_out_321132.awb")

						arg_65_1:RecordAudio("321132016", var_68_13)
						arg_65_1:RecordAudio("321132016", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_321132", "321132016", "story_v_out_321132.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_321132", "321132016", "story_v_out_321132.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321132017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play321132018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10131ui_story = arg_69_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).z)
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles = arg_69_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10131ui_story"].transform.position).z)
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10131ui_story"].transform.localEulerAngles = arg_69_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1111ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1111ui_story = var_72_1.localPosition
			end

			local var_72_2 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 then
				var_72_1.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_2)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 then
				var_72_1.localPosition = Vector3.New(0, 100, 0)
				var_72_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_1.position).x, (manager.ui.mainCamera.transform.position - var_72_1.position).y, (manager.ui.mainCamera.transform.position - var_72_1.position).z)
				var_72_1.localEulerAngles.z = 0
				var_72_1.localEulerAngles.x = 0
				var_72_1.localEulerAngles = var_72_1.localEulerAngles
			end

			local var_72_3 = arg_69_1.actors_["10131ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect10131ui_story == nil then
				arg_69_1.var_.characterEffect10131ui_story = var_72_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 and not isNil(var_72_3) then
				if arg_69_1.var_.characterEffect10131ui_story and not isNil(var_72_3) then
					arg_69_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_4)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect10131ui_story then
				arg_69_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			local var_72_5 = 0
			local var_72_6 = 1.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(321132017).content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 50 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_7) / 50)

				if (50 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_7) / 50)) > 0 and var_72_6 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_10 and arg_69_1.time_ < var_72_5 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321132018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321132018
		arg_73_1.duration_ = 4.47

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 4.466
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
				arg_73_0:Play321132019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10131ui_story = arg_73_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10131ui_story"].transform.position).z)
				arg_73_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10131ui_story"].transform.localEulerAngles = arg_73_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_73_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["10131ui_story"].transform.position).z)
				arg_73_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["10131ui_story"].transform.localEulerAngles = arg_73_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["10131ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10131ui_story == nil then
				arg_73_1.var_.characterEffect10131ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect10131ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect10131ui_story then
				arg_73_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action3_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_76_4 = 0
			local var_76_5 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(321132018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)

				if (8 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 8)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132018", "story_v_out_321132.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_321132", "321132018", "story_v_out_321132.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_321132", "321132018", "story_v_out_321132.awb")

						arg_73_1:RecordAudio("321132018", var_76_11)
						arg_73_1:RecordAudio("321132018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321132", "321132018", "story_v_out_321132.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321132", "321132018", "story_v_out_321132.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321132019
		arg_77_1.duration_ = 3.5

		local var_77_0 = {
			zh = 2.3,
			ja = 3.5
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
				arg_77_0:Play321132020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1111ui_story = arg_77_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).z)
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles = arg_77_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_77_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1111ui_story"].transform.position).z)
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1111ui_story"].transform.localEulerAngles = arg_77_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1111ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1111ui_story == nil then
				arg_77_1.var_.characterEffect1111ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1111ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1111ui_story then
				arg_77_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_80_4 = arg_77_1.actors_["10131ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect10131ui_story == nil then
				arg_77_1.var_.characterEffect10131ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_5 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 and not isNil(var_80_4) then
				if arg_77_1.var_.characterEffect10131ui_story and not isNil(var_80_4) then
					arg_77_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_5)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect10131ui_story then
				arg_77_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_80_6 = 0
			local var_80_7 = 0.25

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(321132019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 10 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 10)

				if (10 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 10)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132019", "story_v_out_321132.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132019", "story_v_out_321132.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_321132", "321132019", "story_v_out_321132.awb")

						arg_77_1:RecordAudio("321132019", var_80_13)
						arg_77_1:RecordAudio("321132019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_321132", "321132019", "story_v_out_321132.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_321132", "321132019", "story_v_out_321132.awb")
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
				actorName = "1111ui_story",
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
	Play321132020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 321132020
		arg_81_1.duration_ = 6.63

		local var_81_0 = {
			zh = 6.633,
			ja = 6.5
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
				arg_81_0:Play321132021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10131ui_story = arg_81_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).z)
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles = arg_81_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_81_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10131ui_story"].transform.position).z)
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10131ui_story"].transform.localEulerAngles = arg_81_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["10131ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10131ui_story == nil then
				arg_81_1.var_.characterEffect10131ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect10131ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10131ui_story then
				arg_81_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["1111ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1111ui_story == nil then
				arg_81_1.var_.characterEffect1111ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_5 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 and not isNil(var_84_4) then
				if arg_81_1.var_.characterEffect1111ui_story and not isNil(var_84_4) then
					arg_81_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_5)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1111ui_story then
				arg_81_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_84_6 = 0
			local var_84_7 = 0.625

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(321132020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 25 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 25)

				if (25 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 25)) > 0 and var_84_7 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132020", "story_v_out_321132.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132020", "story_v_out_321132.awb") / 1000

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_321132", "321132020", "story_v_out_321132.awb")

						arg_81_1:RecordAudio("321132020", var_84_13)
						arg_81_1:RecordAudio("321132020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_321132", "321132020", "story_v_out_321132.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_321132", "321132020", "story_v_out_321132.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 321132021
		arg_85_1.duration_ = 7.4

		local var_85_0 = {
			zh = 5.733,
			ja = 7.4
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
				arg_85_0:Play321132022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10131ui_story = arg_85_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).z)
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles = arg_85_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_85_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10131ui_story"].transform.position).z)
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10131ui_story"].transform.localEulerAngles = arg_85_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action4_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_88_1 = 0
			local var_88_2 = 0.475

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(321132021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 19 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 19)

				if (19 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 19)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132021", "story_v_out_321132.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_321132", "321132021", "story_v_out_321132.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_321132", "321132021", "story_v_out_321132.awb")

						arg_85_1:RecordAudio("321132021", var_88_8)
						arg_85_1:RecordAudio("321132021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_321132", "321132021", "story_v_out_321132.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_321132", "321132021", "story_v_out_321132.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321132022
		arg_89_1.duration_ = 3.53

		local var_89_0 = {
			zh = 2.7,
			ja = 3.533
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
				arg_89_0:Play321132023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1111ui_story = arg_89_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).z)
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles = arg_89_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_89_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1111ui_story"].transform.position).z)
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1111ui_story"].transform.localEulerAngles = arg_89_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1111ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1111ui_story == nil then
				arg_89_1.var_.characterEffect1111ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1111ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1111ui_story then
				arg_89_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_92_4 = arg_89_1.actors_["10131ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10131ui_story == nil then
				arg_89_1.var_.characterEffect10131ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect10131ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10131ui_story then
				arg_89_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action428")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_92_6 = 0
			local var_92_7 = 0.25

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(321132022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 10 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 10)

				if (10 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 10)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132022", "story_v_out_321132.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132022", "story_v_out_321132.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_321132", "321132022", "story_v_out_321132.awb")

						arg_89_1:RecordAudio("321132022", var_92_13)
						arg_89_1:RecordAudio("321132022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_321132", "321132022", "story_v_out_321132.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_321132", "321132022", "story_v_out_321132.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321132023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 321132023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play321132024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10131ui_story = arg_93_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10131ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10131ui_story"].transform.position).z)
				arg_93_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10131ui_story"].transform.localEulerAngles = arg_93_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10131ui_story"].transform.position).z)
				arg_93_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10131ui_story"].transform.localEulerAngles = arg_93_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1111ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1111ui_story = var_96_1.localPosition
			end

			local var_96_2 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 then
				var_96_1.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_2)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 then
				var_96_1.localPosition = Vector3.New(0, 100, 0)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			local var_96_3 = arg_93_1.actors_["1111ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1111ui_story == nil then
				arg_93_1.var_.characterEffect1111ui_story = var_96_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_4 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 and not isNil(var_96_3) then
				if arg_93_1.var_.characterEffect1111ui_story and not isNil(var_96_3) then
					arg_93_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_4)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1111ui_story then
				arg_93_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_96_5 = 0
			local var_96_6 = 1.15

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(321132023).content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 46 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_7) / 46)

				if (46 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_7) / 46)) > 0 and var_96_6 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_10 and arg_93_1.time_ < var_96_5 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play321132024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321132024
		arg_97_1.duration_ = 9.37

		local var_97_0 = {
			zh = 8.766,
			ja = 9.366
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
				arg_97_0:Play321132025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10131ui_story = arg_97_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10131ui_story"].transform.position).z)
				arg_97_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10131ui_story"].transform.localEulerAngles = arg_97_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_97_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10131ui_story"].transform.position).z)
				arg_97_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10131ui_story"].transform.localEulerAngles = arg_97_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10131ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10131ui_story == nil then
				arg_97_1.var_.characterEffect10131ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10131ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10131ui_story then
				arg_97_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action4_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_100_4 = 0
			local var_100_5 = 0.9

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(321132024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 36 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 36)

				if (36 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 36)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132024", "story_v_out_321132.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_321132", "321132024", "story_v_out_321132.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_321132", "321132024", "story_v_out_321132.awb")

						arg_97_1:RecordAudio("321132024", var_100_11)
						arg_97_1:RecordAudio("321132024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_321132", "321132024", "story_v_out_321132.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_321132", "321132024", "story_v_out_321132.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321132025
		arg_101_1.duration_ = 6.83

		local var_101_0 = {
			zh = 4.3,
			ja = 6.833
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
				arg_101_0:Play321132026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1111ui_story = arg_101_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).z)
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles = arg_101_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_101_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1111ui_story"].transform.position).z)
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1111ui_story"].transform.localEulerAngles = arg_101_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1111ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1111ui_story == nil then
				arg_101_1.var_.characterEffect1111ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1111ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1111ui_story then
				arg_101_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["10131ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10131ui_story == nil then
				arg_101_1.var_.characterEffect10131ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect10131ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10131ui_story then
				arg_101_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_6 = 0
			local var_104_7 = 0.525

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(321132025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 21 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 21)

				if (21 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 21)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132025", "story_v_out_321132.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132025", "story_v_out_321132.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_321132", "321132025", "story_v_out_321132.awb")

						arg_101_1:RecordAudio("321132025", var_104_13)
						arg_101_1:RecordAudio("321132025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321132", "321132025", "story_v_out_321132.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321132", "321132025", "story_v_out_321132.awb")
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
				actorName = "1111ui_story",
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
	Play321132026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321132026
		arg_105_1.duration_ = 6.5

		local var_105_0 = {
			zh = 5.366,
			ja = 6.5
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
				arg_105_0:Play321132027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10131ui_story = arg_105_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10131ui_story"].transform.position).z)
				arg_105_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10131ui_story"].transform.localEulerAngles = arg_105_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_105_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10131ui_story"].transform.position).z)
				arg_105_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10131ui_story"].transform.localEulerAngles = arg_105_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10131ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10131ui_story == nil then
				arg_105_1.var_.characterEffect10131ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10131ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10131ui_story then
				arg_105_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["1111ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1111ui_story == nil then
				arg_105_1.var_.characterEffect1111ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_5 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 and not isNil(var_108_4) then
				if arg_105_1.var_.characterEffect1111ui_story and not isNil(var_108_4) then
					arg_105_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_5)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1111ui_story then
				arg_105_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_108_6 = 0
			local var_108_7 = 0.5

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(321132026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 20 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 20)

				if (20 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 20)) > 0 and var_108_7 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132026", "story_v_out_321132.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132026", "story_v_out_321132.awb") / 1000

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_321132", "321132026", "story_v_out_321132.awb")

						arg_105_1:RecordAudio("321132026", var_108_13)
						arg_105_1:RecordAudio("321132026", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321132", "321132026", "story_v_out_321132.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321132", "321132026", "story_v_out_321132.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321132027
		arg_109_1.duration_ = 6.4

		local var_109_0 = {
			zh = 6.166,
			ja = 6.4
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
				arg_109_0:Play321132028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10131ui_story = arg_109_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10131ui_story"].transform.position).z)
				arg_109_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10131ui_story"].transform.localEulerAngles = arg_109_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_109_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10131ui_story"].transform.position).z)
				arg_109_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10131ui_story"].transform.localEulerAngles = arg_109_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_112_1 = 0
			local var_112_2 = 0.7

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(321132027)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 28 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 28)

				if (28 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 28)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132027", "story_v_out_321132.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_321132", "321132027", "story_v_out_321132.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_321132", "321132027", "story_v_out_321132.awb")

						arg_109_1:RecordAudio("321132027", var_112_8)
						arg_109_1:RecordAudio("321132027", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321132", "321132027", "story_v_out_321132.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321132", "321132027", "story_v_out_321132.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play321132028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321132028
		arg_113_1.duration_ = 11.83

		local var_113_0 = {
			zh = 8.333,
			ja = 11.833
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
				arg_113_0:Play321132029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1111ui_story = arg_113_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1111ui_story, Vector3.New(-0.79, -0.87, -5.7), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(-0.79, -0.87, -5.7)
				arg_113_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1111ui_story"].transform.position).z)
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1111ui_story"].transform.localEulerAngles = arg_113_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1111ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1111ui_story == nil then
				arg_113_1.var_.characterEffect1111ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1111ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1111ui_story then
				arg_113_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["10131ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10131ui_story == nil then
				arg_113_1.var_.characterEffect10131ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_5 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_4) then
				if arg_113_1.var_.characterEffect10131ui_story and not isNil(var_116_4) then
					arg_113_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10131ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_5)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10131ui_story then
				arg_113_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10131ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_116_6 = 0
			local var_116_7 = 0.975

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(321132028)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 39 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 39)

				if (39 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 39)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132028", "story_v_out_321132.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132028", "story_v_out_321132.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_321132", "321132028", "story_v_out_321132.awb")

						arg_113_1:RecordAudio("321132028", var_116_13)
						arg_113_1:RecordAudio("321132028", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321132", "321132028", "story_v_out_321132.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321132", "321132028", "story_v_out_321132.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play321132029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321132029
		arg_117_1.duration_ = 6.23

		local var_117_0 = {
			zh = 4.366,
			ja = 6.233
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
			arg_117_1.auto_ = false
		end

		function arg_117_1.playNext_(arg_119_0)
			arg_117_1.onStoryFinished_()
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10131ui_story = arg_117_1.actors_["10131ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10131ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10131ui_story, Vector3.New(0.83, -0.96, -5.8), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10131ui_story"].transform.position).z)
				arg_117_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10131ui_story"].transform.localEulerAngles = arg_117_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10131ui_story"].transform.localPosition = Vector3.New(0.83, -0.96, -5.8)
				arg_117_1.actors_["10131ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10131ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10131ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10131ui_story"].transform.position).z)
				arg_117_1.actors_["10131ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10131ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10131ui_story"].transform.localEulerAngles = arg_117_1.actors_["10131ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10131ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10131ui_story == nil then
				arg_117_1.var_.characterEffect10131ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10131ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10131ui_story then
				arg_117_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["1111ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1111ui_story == nil then
				arg_117_1.var_.characterEffect1111ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect1111ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1111ui_story then
				arg_117_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_120_6 = 0
			local var_120_7 = 0.4

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1178].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(321132029)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 16 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 16)

				if (16 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 16)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321132", "321132029", "story_v_out_321132.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_321132", "321132029", "story_v_out_321132.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_321132", "321132029", "story_v_out_321132.awb")

						arg_117_1:RecordAudio("321132029", var_120_13)
						arg_117_1:RecordAudio("321132029", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_321132", "321132029", "story_v_out_321132.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_321132", "321132029", "story_v_out_321132.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	assets = {
		"TextureConfig/Background/L09h"
	},
	voices = {
		"story_v_out_321132.awb"
	}
}
