return {
	Play412121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412121001
		arg_1_1.duration_ = 4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I09h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I09h")
				var_4_0.name = "I09h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I09h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I09h

				arg_1_1.bgs_.I09h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I09h" then
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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_2_story_corridor_dream", "bgm_activity_3_2_story_corridor_dream")

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

			local var_4_15 = manager.ui.mainCamera.transform

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_15.localPosition
			end

			local var_4_16 = 0.6

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_16 then
				local var_4_17, var_4_18 = math.modf((arg_1_1.time_ - 1.9) / 0.066)

				var_4_15.localPosition = Vector3.New(var_4_18 * 0.13, var_4_18 * 0.13, var_4_18 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1.9 + var_4_16 and arg_1_1.time_ < 1.9 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_19 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_19 + 0.5 and arg_1_1.time_ < var_4_19 + 0.5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10078")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_23 = arg_1_1:GetWordFromCfg(412121001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 4 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 4)

				if (4 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 4)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121001", "story_v_out_412121.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_412121", "412121001", "story_v_out_412121.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_412121", "412121001", "story_v_out_412121.awb")

						arg_1_1:RecordAudio("412121001", var_4_28)
						arg_1_1:RecordAudio("412121001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412121", "412121001", "story_v_out_412121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412121", "412121001", "story_v_out_412121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play412121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 412121002
		arg_9_1.duration_ = 4.8

		local var_9_0 = {
			zh = 4.8,
			ja = 3.566
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
				arg_9_0:Play412121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["3043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3043ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "3043ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "3043ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["3043ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["3043ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["3043ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["3043ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["3043ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos3043ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos3043ui_story, Vector3.New(0, -1.41, -5.7), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.41, -5.7)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["3043ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect3043ui_story == nil then
				arg_9_1.var_.characterEffect3043ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect3043ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect3043ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect3043ui_story then
				arg_9_1.var_.characterEffect3043ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = "10078ui_story"

			if arg_9_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_12_9 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_9_1.stage_.transform)

				var_12_9.name = var_12_8
				var_12_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_[var_12_8] = var_12_9

				local var_12_10 = var_12_9:GetComponentInChildren(typeof(CharacterEffect))

				var_12_10.enabled = true

				local var_12_11 = GameObjectTools.GetOrAddComponent(var_12_9, typeof(DynamicBoneHelper))

				if var_12_11 then
					var_12_11:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_10.transform, false)

				arg_9_1.var_[var_12_8 .. "Animator"] = var_12_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_[var_12_8 .. "Animator"].applyRootMotion = true
				arg_9_1.var_[var_12_8 .. "LipSync"] = var_12_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_12 = arg_9_1.actors_["10078ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10078ui_story = var_12_12.localPosition
			end

			local var_12_13 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_13 then
				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_13)
				var_12_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_12.position).x, (manager.ui.mainCamera.transform.position - var_12_12.position).y, (manager.ui.mainCamera.transform.position - var_12_12.position).z)
				var_12_12.localEulerAngles.z = 0
				var_12_12.localEulerAngles.x = 0
				var_12_12.localEulerAngles = var_12_12.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_13 and arg_9_1.time_ < 0 + var_12_13 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(0, 100, 0)
				var_12_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_12.position).x, (manager.ui.mainCamera.transform.position - var_12_12.position).y, (manager.ui.mainCamera.transform.position - var_12_12.position).z)
				var_12_12.localEulerAngles.z = 0
				var_12_12.localEulerAngles.x = 0
				var_12_12.localEulerAngles = var_12_12.localEulerAngles
			end

			local var_12_14 = arg_9_1.actors_["10078ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10078ui_story == nil then
				arg_9_1.var_.characterEffect10078ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_15 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_15 and not isNil(var_12_14) then
				if arg_9_1.var_.characterEffect10078ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_15)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_15 and arg_9_1.time_ < 0 + var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect10078ui_story then
				arg_9_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_12_16 = 0
			local var_12_17 = 0.375

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[929].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_18 = arg_9_1:GetWordFromCfg(412121002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_21 = 15 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 15)

				if (15 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 15)) > 0 and var_12_17 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_16
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121002", "story_v_out_412121.awb") ~= 0 then
					local var_12_22 = manager.audio:GetVoiceLength("story_v_out_412121", "412121002", "story_v_out_412121.awb") / 1000

					if var_12_22 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_16
					end

					if var_12_18.prefab_name ~= "" and arg_9_1.actors_[var_12_18.prefab_name] ~= nil then
						local var_12_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_18.prefab_name].transform, "story_v_out_412121", "412121002", "story_v_out_412121.awb")

						arg_9_1:RecordAudio("412121002", var_12_23)
						arg_9_1:RecordAudio("412121002", var_12_23)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_412121", "412121002", "story_v_out_412121.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_412121", "412121002", "story_v_out_412121.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_24 = math.max(var_12_17, arg_9_1.talkMaxDuration)

			if var_12_16 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_24 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_16) / var_12_24

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_16 + var_12_24 and arg_9_1.time_ < var_12_16 + var_12_24 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
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
	Play412121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 412121003
		arg_13_1.duration_ = 5.67

		local var_13_0 = {
			zh = 4.966,
			ja = 5.666
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
				arg_13_0:Play412121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("3043ui_story", "StoryTimeline/CharAction/story3043/story3043action/3043action2_1")
			end

			local var_16_0 = 0
			local var_16_1 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[929].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(412121003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 14 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 14)

				if (14 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 14)) > 0 and var_16_1 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121003", "story_v_out_412121.awb") ~= 0 then
					local var_16_6 = manager.audio:GetVoiceLength("story_v_out_412121", "412121003", "story_v_out_412121.awb") / 1000

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end

					if var_16_2.prefab_name ~= "" and arg_13_1.actors_[var_16_2.prefab_name] ~= nil then
						local var_16_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_2.prefab_name].transform, "story_v_out_412121", "412121003", "story_v_out_412121.awb")

						arg_13_1:RecordAudio("412121003", var_16_7)
						arg_13_1:RecordAudio("412121003", var_16_7)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_412121", "412121003", "story_v_out_412121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_412121", "412121003", "story_v_out_412121.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play412121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 412121004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play412121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos3043ui_story = arg_17_1.actors_["3043ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["3043ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos3043ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["3043ui_story"].transform.position).z)
				arg_17_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["3043ui_story"].transform.localEulerAngles = arg_17_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["3043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["3043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["3043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["3043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["3043ui_story"].transform.position).z)
				arg_17_1.actors_["3043ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["3043ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["3043ui_story"].transform.localEulerAngles = arg_17_1.actors_["3043ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["3043ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect3043ui_story == nil then
				arg_17_1.var_.characterEffect3043ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect3043ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect3043ui_story.fillFlat = true
					arg_17_1.var_.characterEffect3043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect3043ui_story then
				arg_17_1.var_.characterEffect3043ui_story.fillFlat = true
				arg_17_1.var_.characterEffect3043ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.975

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(412121004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 39 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 39)

				if (39 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 39)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3043ui_story",
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
	Play412121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 412121005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play412121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.375

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(412121005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 15 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 15)

				if (15 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 15)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play412121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 412121006
		arg_25_1.duration_ = 8.4

		local var_25_0 = {
			zh = 4.733,
			ja = 8.4
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
				arg_25_0:Play412121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_28_0 = 1

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				local var_28_1, var_28_2 = math.modf((arg_25_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_28_2 * 0.13, var_28_2 * 0.13, var_28_2 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				manager.ui.mainCamera.transform.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_3 = manager.ui.mainCamera.transform

			if 1.2 < arg_25_1.time_ and arg_25_1.time_ <= 1.2 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_3.localPosition
			end

			local var_28_4 = 0.2

			if 1.2 <= arg_25_1.time_ and arg_25_1.time_ < 1.2 + var_28_4 then
				local var_28_5, var_28_6 = math.modf((arg_25_1.time_ - 1.2) / 0.066)

				var_28_3.localPosition = Vector3.New(var_28_6 * 0.13, var_28_6 * 0.13, var_28_6 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 1.2 + var_28_4 and arg_25_1.time_ < 1.2 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_7 = manager.ui.mainCamera.transform

			if 1.499999999999 < arg_25_1.time_ and arg_25_1.time_ <= 1.499999999999 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_7.localPosition
			end

			local var_28_8 = 0.200000000001

			if 1.499999999999 <= arg_25_1.time_ and arg_25_1.time_ < 1.499999999999 + var_28_8 then
				local var_28_9, var_28_10 = math.modf((arg_25_1.time_ - 1.499999999999) / 0.066)

				var_28_7.localPosition = Vector3.New(var_28_10 * 0.13, var_28_10 * 0.13, var_28_10 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 1.499999999999 + var_28_8 and arg_25_1.time_ < 1.499999999999 + var_28_8 + arg_28_0 then
				var_28_7.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_11 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_11 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_11 + 1.7 and arg_25_1.time_ < var_28_11 + 1.7 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_12 = 0
			local var_28_13 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[930].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_14 = arg_25_1:GetWordFromCfg(412121006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 12 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 12)

				if (12 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 12)) > 0 and var_28_13 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121006", "story_v_out_412121.awb") ~= 0 then
					local var_28_18 = manager.audio:GetVoiceLength("story_v_out_412121", "412121006", "story_v_out_412121.awb") / 1000

					if var_28_18 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_12
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_412121", "412121006", "story_v_out_412121.awb")

						arg_25_1:RecordAudio("412121006", var_28_19)
						arg_25_1:RecordAudio("412121006", var_28_19)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_412121", "412121006", "story_v_out_412121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_412121", "412121006", "story_v_out_412121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_20 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_20 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_20

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_20 and arg_25_1.time_ < var_28_12 + var_28_20 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play412121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 412121007
		arg_29_1.duration_ = 5.33

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play412121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.EN0104 == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "EN0104")
				var_32_0.name = "EN0104"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.EN0104 = var_32_0
			end

			if 0.299999999999 < arg_29_1.time_ and arg_29_1.time_ <= 0.299999999999 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.EN0104

				arg_29_1.bgs_.EN0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "EN0104" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 2.3

			if 2.3 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_4 + 0.3 and arg_29_1.time_ < var_32_4 + 0.3 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_5 = 0.3

			if 0.3 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_6 = 2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 then
				local var_32_7 = Color.New(1, 1, 1)

				var_32_7.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_5) / var_32_6)
				arg_29_1.mask_.color = var_32_7
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 then
				local var_32_8 = Color.New(1, 1, 1)

				arg_29_1.mask_.enabled = false
				var_32_8.a = 0
				arg_29_1.mask_.color = var_32_8
			end

			local var_32_9 = arg_29_1.bgs_.EN0104.transform

			if 0.316666666665666 < arg_29_1.time_ and arg_29_1.time_ <= 0.316666666665666 + arg_32_0 then
				arg_29_1.var_.moveOldPosEN0104 = var_32_9.localPosition
			end

			local var_32_10 = 0.001

			if 0.316666666665666 <= arg_29_1.time_ and arg_29_1.time_ < 0.316666666665666 + var_32_10 then
				var_32_9.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPosEN0104, Vector3.New(-2.5, 0.1, 3), (arg_29_1.time_ - 0.316666666665666) / var_32_10)
			end

			if arg_29_1.time_ >= 0.316666666665666 + var_32_10 and arg_29_1.time_ < 0.316666666665666 + var_32_10 + arg_32_0 then
				var_32_9.localPosition = Vector3.New(-2.5, 0.1, 3)
			end

			local var_32_11 = arg_29_1.bgs_.EN0104.transform

			if 0.333333333332333 < arg_29_1.time_ and arg_29_1.time_ <= 0.333333333332333 + arg_32_0 then
				arg_29_1.var_.moveOldPosEN0104 = var_32_11.localPosition
			end

			local var_32_12 = 5

			if 0.333333333332333 <= arg_29_1.time_ and arg_29_1.time_ < 0.333333333332333 + var_32_12 then
				var_32_11.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPosEN0104, Vector3.New(-3, 0.1, 3), (arg_29_1.time_ - 0.333333333332333) / var_32_12)
			end

			if arg_29_1.time_ >= 0.333333333332333 + var_32_12 and arg_29_1.time_ < 0.333333333332333 + var_32_12 + arg_32_0 then
				var_32_11.localPosition = Vector3.New(-3, 0.1, 3)
			end

			local var_32_13 = 2.3

			if 2.3 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_13 + 3.033333333331 and arg_29_1.time_ < var_32_13 + 3.033333333331 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_14 = 2.3
			local var_32_15 = 0.125

			if 2.3 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_16 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_16:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_17 = arg_29_1:GetWordFromCfg(412121007)
				local var_32_18 = arg_29_1:FormatText(var_32_17.content)

				arg_29_1.text_.text = var_32_18

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 5 <= 0 and var_32_15 or var_32_15 * (utf8.len(var_32_18) / 5)

				if (5 <= 0 and var_32_15 or var_32_15 * (utf8.len(var_32_18) / 5)) > 0 and var_32_15 < var_32_20 then
					arg_29_1.talkMaxDuration = var_32_20
					var_32_14 = var_32_14 + 0.3

					if var_32_20 + var_32_14 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_20 + var_32_14
					end
				end

				arg_29_1.text_.text = var_32_18
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121007", "story_v_out_412121.awb") ~= 0 then
					local var_32_21 = manager.audio:GetVoiceLength("story_v_out_412121", "412121007", "story_v_out_412121.awb") / 1000

					if var_32_21 + var_32_14 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_14
					end

					if var_32_17.prefab_name ~= "" and arg_29_1.actors_[var_32_17.prefab_name] ~= nil then
						local var_32_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_17.prefab_name].transform, "story_v_out_412121", "412121007", "story_v_out_412121.awb")

						arg_29_1:RecordAudio("412121007", var_32_22)
						arg_29_1:RecordAudio("412121007", var_32_22)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_412121", "412121007", "story_v_out_412121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_412121", "412121007", "story_v_out_412121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_23 = var_32_14 + 0.3
			local var_32_24 = math.max(var_32_15, arg_29_1.talkMaxDuration)

			if var_32_14 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_23) / var_32_24

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.316666666665666,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "EN0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0.333333333332333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play412121008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 412121008
		arg_35_1.duration_ = 3.72

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play412121009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0.2 < arg_35_1.time_ and arg_35_1.time_ <= 0.2 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_0 = 1

			if 0.2 <= arg_35_1.time_ and arg_35_1.time_ < 0.2 + var_38_0 then
				local var_38_1 = Color.New(1, 1, 1)

				var_38_1.a = Mathf.Lerp(1, 0, (arg_35_1.time_ - 0.2) / var_38_0)
				arg_35_1.mask_.color = var_38_1
			end

			if arg_35_1.time_ >= 0.2 + var_38_0 and arg_35_1.time_ < 0.2 + var_38_0 + arg_38_0 then
				local var_38_2 = Color.New(1, 1, 1)

				arg_35_1.mask_.enabled = false
				var_38_2.a = 0
				arg_35_1.mask_.color = var_38_2
			end

			local var_38_3 = arg_35_1.bgs_.EN0104.transform

			if 0.2 < arg_35_1.time_ and arg_35_1.time_ <= 0.2 + arg_38_0 then
				arg_35_1.var_.moveOldPosEN0104 = var_38_3.localPosition
			end

			local var_38_4 = 0.001

			if 0.2 <= arg_35_1.time_ and arg_35_1.time_ < 0.2 + var_38_4 then
				var_38_3.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPosEN0104, Vector3.New(0, 1, 8), (arg_35_1.time_ - 0.2) / var_38_4)
			end

			if arg_35_1.time_ >= 0.2 + var_38_4 and arg_35_1.time_ < 0.2 + var_38_4 + arg_38_0 then
				var_38_3.localPosition = Vector3.New(0, 1, 8)
			end

			local var_38_5 = arg_35_1.bgs_.EN0104.transform

			if 0.216666666666667 < arg_35_1.time_ and arg_35_1.time_ <= 0.216666666666667 + arg_38_0 then
				arg_35_1.var_.moveOldPosEN0104 = var_38_5.localPosition
			end

			local var_38_6 = 3.5

			if 0.216666666666667 <= arg_35_1.time_ and arg_35_1.time_ < 0.216666666666667 + var_38_6 then
				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPosEN0104, Vector3.New(0, 1, 10), (arg_35_1.time_ - 0.216666666666667) / var_38_6)
			end

			if arg_35_1.time_ >= 0.216666666666667 + var_38_6 and arg_35_1.time_ < 0.216666666666667 + var_38_6 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_38_7 = 1.2

			if 1.2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_7 + arg_38_0 then
				arg_35_1.allBtn_.enabled = false
			end

			if arg_35_1.time_ >= var_38_7 + 2.51666666666667 and arg_35_1.time_ < var_38_7 + 2.51666666666667 + arg_38_0 then
				arg_35_1.allBtn_.enabled = true
			end

			local var_38_8 = manager.ui.mainCamera.transform

			if 0.2 < arg_35_1.time_ and arg_35_1.time_ <= 0.2 + arg_38_0 then
				arg_35_1.var_.shakeOldPos = var_38_8.localPosition
			end

			local var_38_9 = 0.6

			if 0.2 <= arg_35_1.time_ and arg_35_1.time_ < 0.2 + var_38_9 then
				local var_38_10, var_38_11 = math.modf((arg_35_1.time_ - 0.2) / 0.066)

				var_38_8.localPosition = Vector3.New(var_38_11 * 0.13, var_38_11 * 0.13, var_38_11 * 0.13) + arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.time_ >= 0.2 + var_38_9 and arg_35_1.time_ < 0.2 + var_38_9 + arg_38_0 then
				var_38_8.localPosition = arg_35_1.var_.shakeOldPos
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_12 = 0.4
			local var_38_13 = 0.075

			if 0.4 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_14 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_14:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[930].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_15 = arg_35_1:GetWordFromCfg(412121008)
				local var_38_16 = arg_35_1:FormatText(var_38_15.content)

				arg_35_1.text_.text = var_38_16

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_18 = 3 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_16) / 3)

				if (3 <= 0 and var_38_13 or var_38_13 * (utf8.len(var_38_16) / 3)) > 0 and var_38_13 < var_38_18 then
					arg_35_1.talkMaxDuration = var_38_18
					var_38_12 = var_38_12 + 0.3

					if var_38_18 + var_38_12 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_18 + var_38_12
					end
				end

				arg_35_1.text_.text = var_38_16
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121008", "story_v_out_412121.awb") ~= 0 then
					local var_38_19 = manager.audio:GetVoiceLength("story_v_out_412121", "412121008", "story_v_out_412121.awb") / 1000

					if var_38_19 + var_38_12 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_19 + var_38_12
					end

					if var_38_15.prefab_name ~= "" and arg_35_1.actors_[var_38_15.prefab_name] ~= nil then
						local var_38_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_15.prefab_name].transform, "story_v_out_412121", "412121008", "story_v_out_412121.awb")

						arg_35_1:RecordAudio("412121008", var_38_20)
						arg_35_1:RecordAudio("412121008", var_38_20)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_412121", "412121008", "story_v_out_412121.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_412121", "412121008", "story_v_out_412121.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_21 = var_38_12 + 0.3
			local var_38_22 = math.max(var_38_13, arg_35_1.talkMaxDuration)

			if var_38_12 + 0.3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_21 + var_38_22 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_21) / var_38_22

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_21 + var_38_22 and arg_35_1.time_ < var_38_21 + var_38_22 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "EN0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.216666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play412121009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 412121009
		arg_41_1.duration_ = 2

		local var_41_0 = {
			zh = 1.7,
			ja = 2
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
				arg_41_0:Play412121010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[930].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(412121009)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 5 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 5)

				if (5 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 5)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121009", "story_v_out_412121.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_412121", "412121009", "story_v_out_412121.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_412121", "412121009", "story_v_out_412121.awb")

						arg_41_1:RecordAudio("412121009", var_44_6)
						arg_41_1:RecordAudio("412121009", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_412121", "412121009", "story_v_out_412121.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_412121", "412121009", "story_v_out_412121.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play412121010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 412121010
		arg_45_1.duration_ = 3.5

		local var_45_0 = {
			zh = 2.033,
			ja = 3.5
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
				arg_45_0:Play412121011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.175

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(412121010)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 7 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 7)

				if (7 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 7)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121010", "story_v_out_412121.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_412121", "412121010", "story_v_out_412121.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_412121", "412121010", "story_v_out_412121.awb")

						arg_45_1:RecordAudio("412121010", var_48_6)
						arg_45_1:RecordAudio("412121010", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_412121", "412121010", "story_v_out_412121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_412121", "412121010", "story_v_out_412121.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play412121011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 412121011
		arg_49_1.duration_ = 7.77

		local var_49_0 = {
			zh = 5.166,
			ja = 7.766
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
				arg_49_0:Play412121012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.625

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(412121011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 25 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 25)

				if (25 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 25)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121011", "story_v_out_412121.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_412121", "412121011", "story_v_out_412121.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_412121", "412121011", "story_v_out_412121.awb")

						arg_49_1:RecordAudio("412121011", var_52_6)
						arg_49_1:RecordAudio("412121011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_412121", "412121011", "story_v_out_412121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_412121", "412121011", "story_v_out_412121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play412121012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 412121012
		arg_53_1.duration_ = 5.87

		local var_53_0 = {
			zh = 3.5,
			ja = 5.866
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
				arg_53_0:Play412121013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(412121012)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 15 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 15)

				if (15 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 15)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121012", "story_v_out_412121.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_412121", "412121012", "story_v_out_412121.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_412121", "412121012", "story_v_out_412121.awb")

						arg_53_1:RecordAudio("412121012", var_56_6)
						arg_53_1:RecordAudio("412121012", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_412121", "412121012", "story_v_out_412121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_412121", "412121012", "story_v_out_412121.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play412121013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 412121013
		arg_57_1.duration_ = 12.33

		local var_57_0 = {
			zh = 12.333,
			ja = 11.2
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
				arg_57_0:Play412121014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.475

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(412121013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 59 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 59)

				if (59 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 59)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121013", "story_v_out_412121.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_412121", "412121013", "story_v_out_412121.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_412121", "412121013", "story_v_out_412121.awb")

						arg_57_1:RecordAudio("412121013", var_60_6)
						arg_57_1:RecordAudio("412121013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_412121", "412121013", "story_v_out_412121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_412121", "412121013", "story_v_out_412121.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play412121014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 412121014
		arg_61_1.duration_ = 9.1

		local var_61_0 = {
			zh = 3.7,
			ja = 9.1
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
				arg_61_0:Play412121015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.5

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(412121014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 20 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 20)

				if (20 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 20)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121014", "story_v_out_412121.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_412121", "412121014", "story_v_out_412121.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_412121", "412121014", "story_v_out_412121.awb")

						arg_61_1:RecordAudio("412121014", var_64_6)
						arg_61_1:RecordAudio("412121014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_412121", "412121014", "story_v_out_412121.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_412121", "412121014", "story_v_out_412121.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play412121015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 412121015
		arg_65_1.duration_ = 7.67

		local var_65_0 = {
			zh = 3.3,
			ja = 7.666
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
			arg_65_1.auto_ = false
		end

		function arg_65_1.playNext_(arg_67_0)
			arg_65_1.onStoryFinished_()
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(412121015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 14 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 14)

				if (14 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 14)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412121", "412121015", "story_v_out_412121.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_412121", "412121015", "story_v_out_412121.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_412121", "412121015", "story_v_out_412121.awb")

						arg_65_1:RecordAudio("412121015", var_68_6)
						arg_65_1:RecordAudio("412121015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_412121", "412121015", "story_v_out_412121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_412121", "412121015", "story_v_out_412121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I09h",
		"TextureConfig/Background/EN0104"
	},
	voices = {
		"story_v_out_412121.awb"
	}
}
