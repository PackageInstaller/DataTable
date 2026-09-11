return {
	Play115131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.G03a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "G03a")
				var_4_0.name = "G03a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.G03a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.G03a

				arg_1_1.bgs_.G03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "G03a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.875

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115131001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 35 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 35)

				if (35 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 35)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115131002
		arg_9_1.duration_ = 17.13

		local var_9_0 = {
			ja = 17.133,
			ko = 15.633,
			zh = 16,
			en = 13.4
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
				arg_9_0:Play115131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1052ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1052ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1052ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1052ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1052ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1052ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1052ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1052ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1052ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1052ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_12_5 = arg_9_1.actors_["1052ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1052ui_story == nil then
				arg_9_1.var_.characterEffect1052ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1052ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1052ui_story then
				arg_9_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_12_8 = "1024ui_story"

			if arg_9_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_12_9 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_9_1.stage_.transform)

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

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_12_12 = arg_9_1.actors_["1024ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_12) and arg_9_1.var_.characterEffect1024ui_story == nil then
				arg_9_1.var_.characterEffect1024ui_story = var_12_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_13 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_13 and not isNil(var_12_12) then
				if arg_9_1.var_.characterEffect1024ui_story and not isNil(var_12_12) then
					arg_9_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_13)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_13 and arg_9_1.time_ < 0 + var_12_13 + arg_12_0 and not isNil(var_12_12) and arg_9_1.var_.characterEffect1024ui_story then
				arg_9_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_12_14 = arg_9_1.actors_["1024ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1024ui_story = var_12_14.localPosition
			end

			local var_12_15 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_15 then
				var_12_14.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_9_1.time_ - 0) / var_12_15)
				var_12_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_14.position).x, (manager.ui.mainCamera.transform.position - var_12_14.position).y, (manager.ui.mainCamera.transform.position - var_12_14.position).z)
				var_12_14.localEulerAngles.z = 0
				var_12_14.localEulerAngles.x = 0
				var_12_14.localEulerAngles = var_12_14.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_15 and arg_9_1.time_ < 0 + var_12_15 + arg_12_0 then
				var_12_14.localPosition = Vector3.New(0.7, -1, -6.05)
				var_12_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_14.position).x, (manager.ui.mainCamera.transform.position - var_12_14.position).y, (manager.ui.mainCamera.transform.position - var_12_14.position).z)
				var_12_14.localEulerAngles.z = 0
				var_12_14.localEulerAngles.x = 0
				var_12_14.localEulerAngles = var_12_14.localEulerAngles
			end

			local var_12_16 = 0
			local var_12_17 = 1.45

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_18 = arg_9_1:GetWordFromCfg(115131002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_21 = 58 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 58)

				if (58 <= 0 and var_12_17 or var_12_17 * (utf8.len(var_12_19) / 58)) > 0 and var_12_17 < var_12_21 then
					arg_9_1.talkMaxDuration = var_12_21

					if var_12_21 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_21 + var_12_16
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131002", "story_v_out_115131.awb") ~= 0 then
					local var_12_22 = manager.audio:GetVoiceLength("story_v_out_115131", "115131002", "story_v_out_115131.awb") / 1000

					if var_12_22 + var_12_16 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_16
					end

					if var_12_18.prefab_name ~= "" and arg_9_1.actors_[var_12_18.prefab_name] ~= nil then
						local var_12_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_18.prefab_name].transform, "story_v_out_115131", "115131002", "story_v_out_115131.awb")

						arg_9_1:RecordAudio("115131002", var_12_23)
						arg_9_1:RecordAudio("115131002", var_12_23)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115131", "115131002", "story_v_out_115131.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115131", "115131002", "story_v_out_115131.awb")
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
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play115131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115131003
		arg_13_1.duration_ = 7.23

		local var_13_0 = {
			ja = 7.233,
			ko = 4.166,
			zh = 4.133,
			en = 3.8
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
				arg_13_0:Play115131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1052ui_story"]) and arg_13_1.var_.characterEffect1052ui_story == nil then
				arg_13_1.var_.characterEffect1052ui_story = arg_13_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1052ui_story"]) then
				if arg_13_1.var_.characterEffect1052ui_story and not isNil(arg_13_1.actors_["1052ui_story"]) then
					arg_13_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1052ui_story"]) and arg_13_1.var_.characterEffect1052ui_story then
				arg_13_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.4

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(115131003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 16 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 16)

				if (16 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 16)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131003", "story_v_out_115131.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_115131", "115131003", "story_v_out_115131.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_115131", "115131003", "story_v_out_115131.awb")

						arg_13_1:RecordAudio("115131003", var_16_8)
						arg_13_1:RecordAudio("115131003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115131", "115131003", "story_v_out_115131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115131", "115131003", "story_v_out_115131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115131004
		arg_17_1.duration_ = 16.87

		local var_17_0 = {
			ja = 16.866,
			ko = 11.266,
			zh = 13,
			en = 13.1
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
				arg_17_0:Play115131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1052ui_story"]) and arg_17_1.var_.characterEffect1052ui_story == nil then
				arg_17_1.var_.characterEffect1052ui_story = arg_17_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1052ui_story"]) then
				if arg_17_1.var_.characterEffect1052ui_story and not isNil(arg_17_1.actors_["1052ui_story"]) then
					arg_17_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1052ui_story"]) and arg_17_1.var_.characterEffect1052ui_story then
				arg_17_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_2 = "1017ui_story"

			if arg_17_1.actors_["1017ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1017ui_story"))) then
				local var_20_3 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_17_1.stage_.transform)

				var_20_3.name = var_20_2
				var_20_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_2] = var_20_3

				local var_20_4 = var_20_3:GetComponentInChildren(typeof(CharacterEffect))

				var_20_4.enabled = true

				local var_20_5 = GameObjectTools.GetOrAddComponent(var_20_3, typeof(DynamicBoneHelper))

				if var_20_5 then
					var_20_5:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_4.transform, false)

				arg_17_1.var_[var_20_2 .. "Animator"] = var_20_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_2 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_2 .. "LipSync"] = var_20_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_6 = arg_17_1.actors_["1017ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1017ui_story = var_20_6.localPosition
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_6.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_7)
				var_20_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_6.position).x, (manager.ui.mainCamera.transform.position - var_20_6.position).y, (manager.ui.mainCamera.transform.position - var_20_6.position).z)
				var_20_6.localEulerAngles.z = 0
				var_20_6.localEulerAngles.x = 0
				var_20_6.localEulerAngles = var_20_6.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_6.localPosition = Vector3.New(0, 100, 0)
				var_20_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_6.position).x, (manager.ui.mainCamera.transform.position - var_20_6.position).y, (manager.ui.mainCamera.transform.position - var_20_6.position).z)
				var_20_6.localEulerAngles.z = 0
				var_20_6.localEulerAngles.x = 0
				var_20_6.localEulerAngles = var_20_6.localEulerAngles
			end

			local var_20_8 = arg_17_1.actors_["1024ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1024ui_story = var_20_8.localPosition
			end

			local var_20_9 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				var_20_8.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_17_1.time_ - 0) / var_20_9)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 then
				var_20_8.localPosition = Vector3.New(0.7, -1, -6.05)
				var_20_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_8.position).x, (manager.ui.mainCamera.transform.position - var_20_8.position).y, (manager.ui.mainCamera.transform.position - var_20_8.position).z)
				var_20_8.localEulerAngles.z = 0
				var_20_8.localEulerAngles.x = 0
				var_20_8.localEulerAngles = var_20_8.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_20_10 = arg_17_1.actors_["1024ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1024ui_story == nil then
				arg_17_1.var_.characterEffect1024ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect1024ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1024ui_story then
				arg_17_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action4_2")
			end

			local var_20_12 = 0
			local var_20_13 = 1.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(115131004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 52 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 52)

				if (52 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 52)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131004", "story_v_out_115131.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_115131", "115131004", "story_v_out_115131.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_115131", "115131004", "story_v_out_115131.awb")

						arg_17_1:RecordAudio("115131004", var_20_19)
						arg_17_1:RecordAudio("115131004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115131", "115131004", "story_v_out_115131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115131", "115131004", "story_v_out_115131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play115131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115131005
		arg_21_1.duration_ = 8.6

		local var_21_0 = {
			ja = 6.533,
			ko = 8,
			zh = 8.6,
			en = 6.3
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
				arg_21_0:Play115131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_0 = 0
			local var_24_1 = 0.75

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(115131005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 30 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_3) / 30)

				if (30 <= 0 and var_24_1 or var_24_1 * (utf8.len(var_24_3) / 30)) > 0 and var_24_1 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131005", "story_v_out_115131.awb") ~= 0 then
					local var_24_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131005", "story_v_out_115131.awb") / 1000

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end

					if var_24_2.prefab_name ~= "" and arg_21_1.actors_[var_24_2.prefab_name] ~= nil then
						local var_24_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_2.prefab_name].transform, "story_v_out_115131", "115131005", "story_v_out_115131.awb")

						arg_21_1:RecordAudio("115131005", var_24_7)
						arg_21_1:RecordAudio("115131005", var_24_7)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115131", "115131005", "story_v_out_115131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115131", "115131005", "story_v_out_115131.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_8 and arg_21_1.time_ < var_24_0 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play115131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115131006
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play115131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1052ui_story"]) and arg_25_1.var_.characterEffect1052ui_story == nil then
				arg_25_1.var_.characterEffect1052ui_story = arg_25_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1052ui_story"]) then
				if arg_25_1.var_.characterEffect1052ui_story and not isNil(arg_25_1.actors_["1052ui_story"]) then
					arg_25_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1052ui_story"]) and arg_25_1.var_.characterEffect1052ui_story then
				arg_25_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_1 = arg_25_1.actors_["1024ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1024ui_story == nil then
				arg_25_1.var_.characterEffect1024ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1024ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1024ui_story then
				arg_25_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_28_4 = 0
			local var_28_5 = 0.175

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(115131006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 7 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 7)

				if (7 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 7)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131006", "story_v_out_115131.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131006", "story_v_out_115131.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_115131", "115131006", "story_v_out_115131.awb")

						arg_25_1:RecordAudio("115131006", var_28_11)
						arg_25_1:RecordAudio("115131006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115131", "115131006", "story_v_out_115131.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115131", "115131006", "story_v_out_115131.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115131007
		arg_29_1.duration_ = 18.7

		local var_29_0 = {
			ja = 18.7,
			ko = 15.133,
			zh = 17.9,
			en = 11.933
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
				arg_29_0:Play115131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1052ui_story"]) and arg_29_1.var_.characterEffect1052ui_story == nil then
				arg_29_1.var_.characterEffect1052ui_story = arg_29_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1052ui_story"]) then
				if arg_29_1.var_.characterEffect1052ui_story and not isNil(arg_29_1.actors_["1052ui_story"]) then
					arg_29_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1052ui_story"]) and arg_29_1.var_.characterEffect1052ui_story then
				arg_29_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["1024ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1024ui_story == nil then
				arg_29_1.var_.characterEffect1024ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect1024ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect1024ui_story then
				arg_29_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_32_4 = 0
			local var_32_5 = 1.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(115131007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 62 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 62)

				if (62 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 62)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131007", "story_v_out_115131.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131007", "story_v_out_115131.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_115131", "115131007", "story_v_out_115131.awb")

						arg_29_1:RecordAudio("115131007", var_32_11)
						arg_29_1:RecordAudio("115131007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115131", "115131007", "story_v_out_115131.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115131", "115131007", "story_v_out_115131.awb")
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

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115131008
		arg_33_1.duration_ = 10.7

		local var_33_0 = {
			ja = 7.833,
			ko = 10.5,
			zh = 10.7,
			en = 9.733
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
				arg_33_0:Play115131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1052ui_story"]) and arg_33_1.var_.characterEffect1052ui_story == nil then
				arg_33_1.var_.characterEffect1052ui_story = arg_33_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1052ui_story"]) then
				if arg_33_1.var_.characterEffect1052ui_story and not isNil(arg_33_1.actors_["1052ui_story"]) then
					arg_33_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1052ui_story"]) and arg_33_1.var_.characterEffect1052ui_story then
				arg_33_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 1.225

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(115131008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 49 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 49)

				if (49 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 49)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131008", "story_v_out_115131.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_115131", "115131008", "story_v_out_115131.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_115131", "115131008", "story_v_out_115131.awb")

						arg_33_1:RecordAudio("115131008", var_36_8)
						arg_33_1:RecordAudio("115131008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115131", "115131008", "story_v_out_115131.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115131", "115131008", "story_v_out_115131.awb")
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
	Play115131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115131009
		arg_37_1.duration_ = 2

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play115131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_40_0 = arg_37_1.actors_["1024ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1024ui_story == nil then
				arg_37_1.var_.characterEffect1024ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(var_40_0) then
				if arg_37_1.var_.characterEffect1024ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1024ui_story then
				arg_37_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_40_3 = 0
			local var_40_4 = 0.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(115131009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 2 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 2)

				if (2 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 2)) > 0 and var_40_4 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131009", "story_v_out_115131.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131009", "story_v_out_115131.awb") / 1000

					if var_40_9 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_3
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_out_115131", "115131009", "story_v_out_115131.awb")

						arg_37_1:RecordAudio("115131009", var_40_10)
						arg_37_1:RecordAudio("115131009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115131", "115131009", "story_v_out_115131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115131", "115131009", "story_v_out_115131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_11 and arg_37_1.time_ < var_40_3 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play115131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115131010
		arg_41_1.duration_ = 13.63

		local var_41_0 = {
			ja = 13.633,
			ko = 10.366,
			zh = 7.866,
			en = 9.133
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
				arg_41_0:Play115131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_1")
			end

			local var_44_0 = 0
			local var_44_1 = 1.05

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(115131010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 42 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 42)

				if (42 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 42)) > 0 and var_44_1 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131010", "story_v_out_115131.awb") ~= 0 then
					local var_44_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131010", "story_v_out_115131.awb") / 1000

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end

					if var_44_2.prefab_name ~= "" and arg_41_1.actors_[var_44_2.prefab_name] ~= nil then
						local var_44_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_2.prefab_name].transform, "story_v_out_115131", "115131010", "story_v_out_115131.awb")

						arg_41_1:RecordAudio("115131010", var_44_7)
						arg_41_1:RecordAudio("115131010", var_44_7)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115131", "115131010", "story_v_out_115131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115131", "115131010", "story_v_out_115131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play115131011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115131011
		arg_45_1.duration_ = 8.4

		local var_45_0 = {
			ja = 6.333,
			ko = 7.4,
			zh = 6.866,
			en = 8.4
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
				arg_45_0:Play115131012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action5_2")
			end

			local var_48_0 = 0
			local var_48_1 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(115131011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 37 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 37)

				if (37 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 37)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131011", "story_v_out_115131.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131011", "story_v_out_115131.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_115131", "115131011", "story_v_out_115131.awb")

						arg_45_1:RecordAudio("115131011", var_48_7)
						arg_45_1:RecordAudio("115131011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_115131", "115131011", "story_v_out_115131.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_115131", "115131011", "story_v_out_115131.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115131012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115131012
		arg_49_1.duration_ = 9.73

		local var_49_0 = {
			ja = 6.566,
			ko = 8.2,
			zh = 9.733,
			en = 8.7
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
				arg_49_0:Play115131013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1052ui_story"]) and arg_49_1.var_.characterEffect1052ui_story == nil then
				arg_49_1.var_.characterEffect1052ui_story = arg_49_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1052ui_story"]) then
				if arg_49_1.var_.characterEffect1052ui_story and not isNil(arg_49_1.actors_["1052ui_story"]) then
					arg_49_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1052ui_story"]) and arg_49_1.var_.characterEffect1052ui_story then
				arg_49_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1024ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1024ui_story == nil then
				arg_49_1.var_.characterEffect1024ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1024ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1024ui_story then
				arg_49_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action7_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_4 = 0
			local var_52_5 = 0.925

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(115131012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 37 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 37)

				if (37 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 37)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131012", "story_v_out_115131.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131012", "story_v_out_115131.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_115131", "115131012", "story_v_out_115131.awb")

						arg_49_1:RecordAudio("115131012", var_52_11)
						arg_49_1:RecordAudio("115131012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115131", "115131012", "story_v_out_115131.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115131", "115131012", "story_v_out_115131.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115131013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115131013
		arg_53_1.duration_ = 13.2

		local var_53_0 = {
			ja = 13.2,
			ko = 8.366,
			zh = 9.633,
			en = 7.666
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
				arg_53_0:Play115131014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_0 = 0
			local var_56_1 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(115131013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 33 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 33)

				if (33 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 33)) > 0 and var_56_1 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131013", "story_v_out_115131.awb") ~= 0 then
					local var_56_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131013", "story_v_out_115131.awb") / 1000

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end

					if var_56_2.prefab_name ~= "" and arg_53_1.actors_[var_56_2.prefab_name] ~= nil then
						local var_56_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_2.prefab_name].transform, "story_v_out_115131", "115131013", "story_v_out_115131.awb")

						arg_53_1:RecordAudio("115131013", var_56_7)
						arg_53_1:RecordAudio("115131013", var_56_7)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115131", "115131013", "story_v_out_115131.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115131", "115131013", "story_v_out_115131.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play115131014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115131014
		arg_57_1.duration_ = 12.03

		local var_57_0 = {
			ja = 12.033,
			ko = 6.566,
			zh = 5.8,
			en = 5.833
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
				arg_57_0:Play115131015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_60_0 = 0
			local var_60_1 = 0.425

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(115131014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 17 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 17)

				if (17 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 17)) > 0 and var_60_1 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131014", "story_v_out_115131.awb") ~= 0 then
					local var_60_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131014", "story_v_out_115131.awb") / 1000

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end

					if var_60_2.prefab_name ~= "" and arg_57_1.actors_[var_60_2.prefab_name] ~= nil then
						local var_60_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_2.prefab_name].transform, "story_v_out_115131", "115131014", "story_v_out_115131.awb")

						arg_57_1:RecordAudio("115131014", var_60_7)
						arg_57_1:RecordAudio("115131014", var_60_7)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_115131", "115131014", "story_v_out_115131.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_115131", "115131014", "story_v_out_115131.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play115131015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115131015
		arg_61_1.duration_ = 7.93

		local var_61_0 = {
			ja = 3.9,
			ko = 7.933,
			zh = 5.3,
			en = 5.2
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
				arg_61_0:Play115131016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1052ui_story"]) and arg_61_1.var_.characterEffect1052ui_story == nil then
				arg_61_1.var_.characterEffect1052ui_story = arg_61_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1052ui_story"]) then
				if arg_61_1.var_.characterEffect1052ui_story and not isNil(arg_61_1.actors_["1052ui_story"]) then
					arg_61_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1052ui_story"]) and arg_61_1.var_.characterEffect1052ui_story then
				arg_61_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.45

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(115131015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 18 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 18)

				if (18 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 18)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131015", "story_v_out_115131.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_115131", "115131015", "story_v_out_115131.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_115131", "115131015", "story_v_out_115131.awb")

						arg_61_1:RecordAudio("115131015", var_64_8)
						arg_61_1:RecordAudio("115131015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_115131", "115131015", "story_v_out_115131.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_115131", "115131015", "story_v_out_115131.awb")
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

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115131016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115131016
		arg_65_1.duration_ = 15.1

		local var_65_0 = {
			ja = 10.566,
			ko = 15.1,
			zh = 14.266,
			en = 13.2
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
				arg_65_0:Play115131017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1052ui_story"]) and arg_65_1.var_.characterEffect1052ui_story == nil then
				arg_65_1.var_.characterEffect1052ui_story = arg_65_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1052ui_story"]) then
				if arg_65_1.var_.characterEffect1052ui_story and not isNil(arg_65_1.actors_["1052ui_story"]) then
					arg_65_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1052ui_story"]) and arg_65_1.var_.characterEffect1052ui_story then
				arg_65_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_2 = 0
			local var_68_3 = 1.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(115131016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 52 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 52)

				if (52 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 52)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131016", "story_v_out_115131.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131016", "story_v_out_115131.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_115131", "115131016", "story_v_out_115131.awb")

						arg_65_1:RecordAudio("115131016", var_68_9)
						arg_65_1:RecordAudio("115131016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_115131", "115131016", "story_v_out_115131.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_115131", "115131016", "story_v_out_115131.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play115131017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115131017
		arg_69_1.duration_ = 2.33

		local var_69_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.333,
			en = 1.999999999999
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
				arg_69_0:Play115131018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_72_0 = arg_69_1.actors_["1024ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1024ui_story == nil then
				arg_69_1.var_.characterEffect1024ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_1 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 and not isNil(var_72_0) then
				if arg_69_1.var_.characterEffect1024ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1024ui_story then
				arg_69_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_72_3 = arg_69_1.actors_["1052ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1052ui_story == nil then
				arg_69_1.var_.characterEffect1052ui_story = var_72_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_4 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 and not isNil(var_72_3) then
				if arg_69_1.var_.characterEffect1052ui_story and not isNil(var_72_3) then
					arg_69_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_4)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 and not isNil(var_72_3) and arg_69_1.var_.characterEffect1052ui_story then
				arg_69_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_72_5 = 0
			local var_72_6 = 0.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(115131017)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 4 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 4)

				if (4 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 4)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131017", "story_v_out_115131.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131017", "story_v_out_115131.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_115131", "115131017", "story_v_out_115131.awb")

						arg_69_1:RecordAudio("115131017", var_72_12)
						arg_69_1:RecordAudio("115131017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115131", "115131017", "story_v_out_115131.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115131", "115131017", "story_v_out_115131.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_6, arg_69_1.talkMaxDuration)

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_5) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_5 + var_72_13 and arg_69_1.time_ < var_72_5 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play115131018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115131018
		arg_73_1.duration_ = 6.77

		local var_73_0 = {
			ja = 5.2,
			ko = 6,
			zh = 6.766,
			en = 4.466
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
				arg_73_0:Play115131019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1024ui_story"]) and arg_73_1.var_.characterEffect1024ui_story == nil then
				arg_73_1.var_.characterEffect1024ui_story = arg_73_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1024ui_story"]) then
				if arg_73_1.var_.characterEffect1024ui_story and not isNil(arg_73_1.actors_["1024ui_story"]) then
					arg_73_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1024ui_story"]) and arg_73_1.var_.characterEffect1024ui_story then
				arg_73_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_76_1 = arg_73_1.actors_["1052ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1052ui_story == nil then
				arg_73_1.var_.characterEffect1052ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1052ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1052ui_story then
				arg_73_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_76_4 = 0
			local var_76_5 = 0.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(115131018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 20 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 20)

				if (20 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 20)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131018", "story_v_out_115131.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131018", "story_v_out_115131.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_115131", "115131018", "story_v_out_115131.awb")

						arg_73_1:RecordAudio("115131018", var_76_11)
						arg_73_1:RecordAudio("115131018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_115131", "115131018", "story_v_out_115131.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_115131", "115131018", "story_v_out_115131.awb")
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

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play115131019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115131019
		arg_77_1.duration_ = 5.7

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play115131020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1052ui_story = arg_77_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1052ui_story"].transform.position).z)
				arg_77_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1052ui_story"].transform.localEulerAngles = arg_77_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1052ui_story"].transform.position).z)
				arg_77_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1052ui_story"].transform.localEulerAngles = arg_77_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1024ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1024ui_story = var_80_1.localPosition
			end

			local var_80_2 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_2)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_3 = arg_77_1.bgs_.G03a:GetComponent("SpriteRenderer")

				if var_80_3 then
					arg_77_1.var_.alphaOldValueG03a = var_80_3.color.a
					arg_77_1.var_.alphaMatValueG03a = var_80_3
				end

				arg_77_1.var_.alphaOldValueG03a = 1
			end

			local var_80_4 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				if arg_77_1.var_.alphaMatValueG03a then
					arg_77_1.var_.alphaMatValueG03a.color.a = Mathf.Lerp(arg_77_1.var_.alphaOldValueG03a, 0, (arg_77_1.time_ - 0) / var_80_4)
					arg_77_1.var_.alphaMatValueG03a.color = arg_77_1.var_.alphaMatValueG03a.color
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and arg_77_1.var_.alphaMatValueG03a then
				arg_77_1.var_.alphaMatValueG03a.color.a = 0
				arg_77_1.var_.alphaMatValueG03a.color = arg_77_1.var_.alphaMatValueG03a.color
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.fswbg_:SetActive(true)
				arg_77_1.dialog_:SetActive(false)

				arg_77_1.fswtw_.percent = 0
				arg_77_1.fswt_.text = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(115131019).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.fswt_)

				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_77_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_77_1.fswtw_:SetDirty()

				arg_77_1.typewritterCharCountI18N = 0

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_5 = 2

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.var_.oldValueTypewriter = arg_77_1.fswtw_.percent

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_6 = 32
			local var_80_7 = 2.13333333333333
			local var_80_8, var_80_9 = arg_77_1:GetPercentByPara(arg_77_1:FormatText(arg_77_1:GetWordFromCfg(115131019).content), 1)

			if var_80_5 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				local var_80_10 = var_80_6 <= 0 and var_80_7 or var_80_7 * ((var_80_9 - arg_77_1.typewritterCharCountI18N) / var_80_6)

				if (var_80_6 <= 0 and var_80_7 or var_80_7 * ((var_80_9 - arg_77_1.typewritterCharCountI18N) / var_80_6)) > 0 and var_80_7 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end
			end

			local var_80_11 = math.max(2.13333333333333, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_11 then
				arg_77_1.fswtw_.percent = Mathf.Lerp(arg_77_1.var_.oldValueTypewriter, var_80_8, (arg_77_1.time_ - var_80_5) / var_80_11)
				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_77_1.fswtw_:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_11 and arg_77_1.time_ < var_80_5 + var_80_11 + arg_80_0 then
				arg_77_1.fswtw_.percent = var_80_8

				arg_77_1.fswtw_:SetDirty()
				arg_77_1:ShowNextGo(true)

				arg_77_1.typewritterCharCountI18N = var_80_9
			end

			if 2 < arg_77_1.time_ and arg_77_1.time_ <= 2 + arg_80_0 then
				local var_80_12 = arg_77_1.fswbg_.transform:Find("textbox/adapt/content") or arg_77_1.fswbg_.transform:Find("textbox/content")
				local var_80_13 = arg_77_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_80_14 = var_80_12:GetComponent("RectTransform")

				var_80_12:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_80_14.offsetMin = Vector2.New(0, 0)
				var_80_14.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play115131020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115131020
		arg_81_1.duration_ = 7.12

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play115131021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.fswbg_:SetActive(true)
				arg_81_1.dialog_:SetActive(false)

				arg_81_1.fswtw_.percent = 0
				arg_81_1.fswt_.text = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(115131020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.fswt_)

				arg_81_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_81_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_81_1.fswtw_:SetDirty()

				arg_81_1.typewritterCharCountI18N = 0

				SetActive(arg_81_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_81_1:ShowNextGo(false)
			end

			local var_84_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.var_.oldValueTypewriter = arg_81_1.fswtw_.percent

				SetActive(arg_81_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_81_1:ShowNextGo(false)
			end

			local var_84_1 = 27
			local var_84_2 = 1.8
			local var_84_3, var_84_4 = arg_81_1:GetPercentByPara(arg_81_1:FormatText(arg_81_1:GetWordFromCfg(115131020).content), 1)

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				local var_84_5 = var_84_1 <= 0 and var_84_2 or var_84_2 * ((var_84_4 - arg_81_1.typewritterCharCountI18N) / var_84_1)

				if (var_84_1 <= 0 and var_84_2 or var_84_2 * ((var_84_4 - arg_81_1.typewritterCharCountI18N) / var_84_1)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_0
					end
				end
			end

			local var_84_6 = math.max(1.8, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_6 then
				arg_81_1.fswtw_.percent = Mathf.Lerp(arg_81_1.var_.oldValueTypewriter, var_84_3, (arg_81_1.time_ - var_84_0) / var_84_6)
				arg_81_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_81_1.fswtw_:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_6 and arg_81_1.time_ < var_84_0 + var_84_6 + arg_84_0 then
				arg_81_1.fswtw_.percent = var_84_3

				arg_81_1.fswtw_:SetDirty()
				arg_81_1:ShowNextGo(true)

				arg_81_1.typewritterCharCountI18N = var_84_4
			end

			local var_84_7 = 0
			local var_84_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131020", "story_v_out_115131.awb") / 1000

			if var_84_8 > 0 and 7.122 < var_84_8 and var_84_8 + var_84_7 > arg_81_1.duration_ then
				arg_81_1.duration_ = var_84_8 + var_84_7
			end

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 then
				arg_81_1:AudioAction("play", "voice", "story_v_out_115131", "115131020", "story_v_out_115131.awb")
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115131021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115131021
		arg_85_1.duration_ = 10.62

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play115131022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.fswbg_:SetActive(true)
				arg_85_1.dialog_:SetActive(false)

				arg_85_1.fswtw_.percent = 0
				arg_85_1.fswt_.text = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(115131021).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.fswt_)

				arg_85_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_85_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_85_1.fswtw_:SetDirty()

				arg_85_1.typewritterCharCountI18N = 0

				SetActive(arg_85_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_85_1:ShowNextGo(false)
			end

			local var_88_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.var_.oldValueTypewriter = arg_85_1.fswtw_.percent

				SetActive(arg_85_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_85_1:ShowNextGo(false)
			end

			local var_88_1 = 39
			local var_88_2 = 2.6
			local var_88_3, var_88_4 = arg_85_1:GetPercentByPara(arg_85_1:FormatText(arg_85_1:GetWordFromCfg(115131021).content), 1)

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				local var_88_5 = var_88_1 <= 0 and var_88_2 or var_88_2 * ((var_88_4 - arg_85_1.typewritterCharCountI18N) / var_88_1)

				if (var_88_1 <= 0 and var_88_2 or var_88_2 * ((var_88_4 - arg_85_1.typewritterCharCountI18N) / var_88_1)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end
			end

			local var_88_6 = math.max(2.6, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_6 then
				arg_85_1.fswtw_.percent = Mathf.Lerp(arg_85_1.var_.oldValueTypewriter, var_88_3, (arg_85_1.time_ - var_88_0) / var_88_6)
				arg_85_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_85_1.fswtw_:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_6 and arg_85_1.time_ < var_88_0 + var_88_6 + arg_88_0 then
				arg_85_1.fswtw_.percent = var_88_3

				arg_85_1.fswtw_:SetDirty()
				arg_85_1:ShowNextGo(true)

				arg_85_1.typewritterCharCountI18N = var_88_4
			end

			local var_88_7 = 0
			local var_88_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131021", "story_v_out_115131.awb") / 1000

			if var_88_8 > 0 and 10.621 < var_88_8 and var_88_8 + var_88_7 > arg_85_1.duration_ then
				arg_85_1.duration_ = var_88_8 + var_88_7
			end

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 then
				arg_85_1:AudioAction("play", "voice", "story_v_out_115131", "115131021", "story_v_out_115131.awb")
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play115131022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115131022
		arg_89_1.duration_ = 8.2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play115131023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.fswbg_:SetActive(true)
				arg_89_1.dialog_:SetActive(false)

				arg_89_1.fswtw_.percent = 0
				arg_89_1.fswt_.text = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(115131022).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.fswt_)

				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_89_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_89_1.fswtw_:SetDirty()

				arg_89_1.typewritterCharCountI18N = 0

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.var_.oldValueTypewriter = arg_89_1.fswtw_.percent

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_1 = 32
			local var_92_2 = 2.13333333333333
			local var_92_3, var_92_4 = arg_89_1:GetPercentByPara(arg_89_1:FormatText(arg_89_1:GetWordFromCfg(115131022).content), 1)

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				local var_92_5 = var_92_1 <= 0 and var_92_2 or var_92_2 * ((var_92_4 - arg_89_1.typewritterCharCountI18N) / var_92_1)

				if (var_92_1 <= 0 and var_92_2 or var_92_2 * ((var_92_4 - arg_89_1.typewritterCharCountI18N) / var_92_1)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_0
					end
				end
			end

			local var_92_6 = math.max(2.13333333333333, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_6 then
				arg_89_1.fswtw_.percent = Mathf.Lerp(arg_89_1.var_.oldValueTypewriter, var_92_3, (arg_89_1.time_ - var_92_0) / var_92_6)
				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_89_1.fswtw_:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_6 and arg_89_1.time_ < var_92_0 + var_92_6 + arg_92_0 then
				arg_89_1.fswtw_.percent = var_92_3

				arg_89_1.fswtw_:SetDirty()
				arg_89_1:ShowNextGo(true)

				arg_89_1.typewritterCharCountI18N = var_92_4
			end

			local var_92_7 = 0
			local var_92_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131022", "story_v_out_115131.awb") / 1000

			if var_92_8 > 0 and 8.203 < var_92_8 and var_92_8 + var_92_7 > arg_89_1.duration_ then
				arg_89_1.duration_ = var_92_8 + var_92_7
			end

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1:AudioAction("play", "voice", "story_v_out_115131", "115131022", "story_v_out_115131.awb")
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play115131023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115131023
		arg_93_1.duration_ = 6.5

		local var_93_0 = {
			ja = 5.766,
			ko = 5.233333333332,
			zh = 5.233333333332,
			en = 6.5
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
				arg_93_0:Play115131024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.bgs_.RO0201 == nil then
				local var_96_0 = Object.Instantiate(arg_93_1.paintGo_)

				var_96_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "RO0201")
				var_96_0.name = "RO0201"
				var_96_0.transform.parent = arg_93_1.stage_.transform
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.bgs_.RO0201 = var_96_0
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				local var_96_1 = arg_93_1.bgs_.RO0201

				arg_93_1.bgs_.RO0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_2 = var_96_1:GetComponent("SpriteRenderer")

				if var_96_2 and var_96_2.sprite then
					local var_96_3 = 2 * (var_96_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_1.transform.localScale = Vector3.New(var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, var_96_3 / var_96_2.sprite.bounds.size.y < var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x and var_96_3 * manager.ui.mainCameraCom_.aspect / var_96_2.sprite.bounds.size.x or var_96_3 / var_96_2.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "RO0201" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_4 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_5 = 2

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_5 then
				local var_96_6 = Color.New(0, 0, 0)

				var_96_6.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_4) / var_96_5)
				arg_93_1.mask_.color = var_96_6
			end

			if arg_93_1.time_ >= var_96_4 + var_96_5 and arg_93_1.time_ < var_96_4 + var_96_5 + arg_96_0 then
				local var_96_7 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_7.a = 0
				arg_93_1.mask_.color = var_96_7
			end

			local var_96_8 = "105201ui_story"

			if arg_93_1.actors_["105201ui_story"] == nil and not isNil((Asset.Load("Char/" .. "105201ui_story"))) then
				local var_96_9 = Object.Instantiate(Asset.Load("Char/" .. "105201ui_story"), arg_93_1.stage_.transform)

				var_96_9.name = var_96_8
				var_96_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_[var_96_8] = var_96_9

				local var_96_10 = var_96_9:GetComponentInChildren(typeof(CharacterEffect))

				var_96_10.enabled = true

				local var_96_11 = GameObjectTools.GetOrAddComponent(var_96_9, typeof(DynamicBoneHelper))

				if var_96_11 then
					var_96_11:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_10.transform, false)

				arg_93_1.var_[var_96_8 .. "Animator"] = var_96_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_[var_96_8 .. "Animator"].applyRootMotion = true
				arg_93_1.var_[var_96_8 .. "LipSync"] = var_96_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_12 = arg_93_1.actors_["105201ui_story"].transform

			if 2.1 < arg_93_1.time_ and arg_93_1.time_ <= 2.1 + arg_96_0 then
				arg_93_1.var_.moveOldPos105201ui_story = var_96_12.localPosition
			end

			local var_96_13 = 0.001

			if 2.1 <= arg_93_1.time_ and arg_93_1.time_ < 2.1 + var_96_13 then
				var_96_12.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos105201ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_93_1.time_ - 2.1) / var_96_13)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			if arg_93_1.time_ >= 2.1 + var_96_13 and arg_93_1.time_ < 2.1 + var_96_13 + arg_96_0 then
				var_96_12.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_96_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_12.position).x, (manager.ui.mainCamera.transform.position - var_96_12.position).y, (manager.ui.mainCamera.transform.position - var_96_12.position).z)
				var_96_12.localEulerAngles.z = 0
				var_96_12.localEulerAngles.x = 0
				var_96_12.localEulerAngles = var_96_12.localEulerAngles
			end

			if 2.1 < arg_93_1.time_ and arg_93_1.time_ <= 2.1 + arg_96_0 then
				arg_93_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 2.1 < arg_93_1.time_ and arg_93_1.time_ <= 2.1 + arg_96_0 then
				arg_93_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_14 = arg_93_1.actors_["105201ui_story"]

			if 2.1 < arg_93_1.time_ and arg_93_1.time_ <= 2.1 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.characterEffect105201ui_story == nil then
				arg_93_1.var_.characterEffect105201ui_story = var_96_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_15 = 0.2

			if 2.1 <= arg_93_1.time_ and arg_93_1.time_ < 2.1 + var_96_15 and not isNil(var_96_14) then
				if arg_93_1.var_.characterEffect105201ui_story and not isNil(var_96_14) then
					arg_93_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 2.1 + var_96_15 and arg_93_1.time_ < 2.1 + var_96_15 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.characterEffect105201ui_story then
				arg_93_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.fswbg_:SetActive(false)
				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_93_1:ShowNextGo(false)
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_17 = 2
			local var_96_18 = 0.35

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_17 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_19 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_19:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_20 = arg_93_1:GetWordFromCfg(115131023)
				local var_96_21 = arg_93_1:FormatText(var_96_20.content)

				arg_93_1.text_.text = var_96_21

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_23 = 14 <= 0 and var_96_18 or var_96_18 * (utf8.len(var_96_21) / 14)

				if (14 <= 0 and var_96_18 or var_96_18 * (utf8.len(var_96_21) / 14)) > 0 and var_96_18 < var_96_23 then
					arg_93_1.talkMaxDuration = var_96_23
					var_96_17 = var_96_17 + 0.3

					if var_96_23 + var_96_17 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_17
					end
				end

				arg_93_1.text_.text = var_96_21
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131023", "story_v_out_115131.awb") ~= 0 then
					local var_96_24 = manager.audio:GetVoiceLength("story_v_out_115131", "115131023", "story_v_out_115131.awb") / 1000

					if var_96_24 + var_96_17 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_24 + var_96_17
					end

					if var_96_20.prefab_name ~= "" and arg_93_1.actors_[var_96_20.prefab_name] ~= nil then
						local var_96_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_20.prefab_name].transform, "story_v_out_115131", "115131023", "story_v_out_115131.awb")

						arg_93_1:RecordAudio("115131023", var_96_25)
						arg_93_1:RecordAudio("115131023", var_96_25)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115131", "115131023", "story_v_out_115131.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115131", "115131023", "story_v_out_115131.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = var_96_17 + 0.3
			local var_96_27 = math.max(var_96_18, arg_93_1.talkMaxDuration)

			if var_96_17 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_26 + var_96_27 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_26) / var_96_27

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_26 + var_96_27 and arg_93_1.time_ < var_96_26 + var_96_27 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play115131024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 115131024
		arg_99_1.duration_ = 11.53

		local var_99_0 = {
			ja = 11.533,
			ko = 6.366,
			zh = 5.1,
			en = 7.3
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
				arg_99_0:Play115131025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["105201ui_story"]) and arg_99_1.var_.characterEffect105201ui_story == nil then
				arg_99_1.var_.characterEffect105201ui_story = arg_99_1.actors_["105201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["105201ui_story"]) then
				if arg_99_1.var_.characterEffect105201ui_story and not isNil(arg_99_1.actors_["105201ui_story"]) then
					arg_99_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_99_1.var_.characterEffect105201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["105201ui_story"]) and arg_99_1.var_.characterEffect105201ui_story then
				arg_99_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_99_1.var_.characterEffect105201ui_story.fillRatio = 0.5
			end

			local var_102_1 = "10014ui_story"

			if arg_99_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_102_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_99_1.stage_.transform)

				var_102_2.name = var_102_1
				var_102_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_[var_102_1] = var_102_2

				local var_102_3 = var_102_2:GetComponentInChildren(typeof(CharacterEffect))

				var_102_3.enabled = true

				local var_102_4 = GameObjectTools.GetOrAddComponent(var_102_2, typeof(DynamicBoneHelper))

				if var_102_4 then
					var_102_4:EnableDynamicBone(false)
				end

				arg_99_1:ShowWeapon(var_102_3.transform, false)

				arg_99_1.var_[var_102_1 .. "Animator"] = var_102_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_99_1.var_[var_102_1 .. "Animator"].applyRootMotion = true
				arg_99_1.var_[var_102_1 .. "LipSync"] = var_102_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_102_5 = arg_99_1.actors_["10014ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10014ui_story = var_102_5.localPosition
			end

			local var_102_6 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_6 then
				var_102_5.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_99_1.time_ - 0) / var_102_6)
				var_102_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_5.position).x, (manager.ui.mainCamera.transform.position - var_102_5.position).y, (manager.ui.mainCamera.transform.position - var_102_5.position).z)
				var_102_5.localEulerAngles.z = 0
				var_102_5.localEulerAngles.x = 0
				var_102_5.localEulerAngles = var_102_5.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_6 and arg_99_1.time_ < 0 + var_102_6 + arg_102_0 then
				var_102_5.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_102_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_5.position).x, (manager.ui.mainCamera.transform.position - var_102_5.position).y, (manager.ui.mainCamera.transform.position - var_102_5.position).z)
				var_102_5.localEulerAngles.z = 0
				var_102_5.localEulerAngles.x = 0
				var_102_5.localEulerAngles = var_102_5.localEulerAngles
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_102_7 = arg_99_1.actors_["10014ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_7) and arg_99_1.var_.characterEffect10014ui_story == nil then
				arg_99_1.var_.characterEffect10014ui_story = var_102_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_8 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_8 and not isNil(var_102_7) then
				if arg_99_1.var_.characterEffect10014ui_story and not isNil(var_102_7) then
					arg_99_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_8 and arg_99_1.time_ < 0 + var_102_8 + arg_102_0 and not isNil(var_102_7) and arg_99_1.var_.characterEffect10014ui_story then
				arg_99_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_102_10 = 0
			local var_102_11 = 0.575

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_12 = arg_99_1:GetWordFromCfg(115131024)
				local var_102_13 = arg_99_1:FormatText(var_102_12.content)

				arg_99_1.text_.text = var_102_13

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_15 = 23 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_13) / 23)

				if (23 <= 0 and var_102_11 or var_102_11 * (utf8.len(var_102_13) / 23)) > 0 and var_102_11 < var_102_15 then
					arg_99_1.talkMaxDuration = var_102_15

					if var_102_15 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_15 + var_102_10
					end
				end

				arg_99_1.text_.text = var_102_13
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131024", "story_v_out_115131.awb") ~= 0 then
					local var_102_16 = manager.audio:GetVoiceLength("story_v_out_115131", "115131024", "story_v_out_115131.awb") / 1000

					if var_102_16 + var_102_10 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_16 + var_102_10
					end

					if var_102_12.prefab_name ~= "" and arg_99_1.actors_[var_102_12.prefab_name] ~= nil then
						local var_102_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_12.prefab_name].transform, "story_v_out_115131", "115131024", "story_v_out_115131.awb")

						arg_99_1:RecordAudio("115131024", var_102_17)
						arg_99_1:RecordAudio("115131024", var_102_17)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_115131", "115131024", "story_v_out_115131.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_115131", "115131024", "story_v_out_115131.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_18 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_18 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_10) / var_102_18

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_10 + var_102_18 and arg_99_1.time_ < var_102_10 + var_102_18 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play115131025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 115131025
		arg_103_1.duration_ = 10.07

		local var_103_0 = {
			ja = 10.066,
			ko = 8.033,
			zh = 8.7,
			en = 9.333
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play115131026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_106_0 = arg_103_1.actors_["105201ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect105201ui_story == nil then
				arg_103_1.var_.characterEffect105201ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_1 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 and not isNil(var_106_0) then
				if arg_103_1.var_.characterEffect105201ui_story and not isNil(var_106_0) then
					arg_103_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect105201ui_story then
				arg_103_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_106_3 = arg_103_1.actors_["10014ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect10014ui_story == nil then
				arg_103_1.var_.characterEffect10014ui_story = var_106_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_4 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 and not isNil(var_106_3) then
				if arg_103_1.var_.characterEffect10014ui_story and not isNil(var_106_3) then
					arg_103_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_4)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 and not isNil(var_106_3) and arg_103_1.var_.characterEffect10014ui_story then
				arg_103_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_106_5 = 0
			local var_106_6 = 1.125

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(115131025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 45 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 45)

				if (45 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 45)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131025", "story_v_out_115131.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131025", "story_v_out_115131.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_115131", "115131025", "story_v_out_115131.awb")

						arg_103_1:RecordAudio("115131025", var_106_12)
						arg_103_1:RecordAudio("115131025", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_115131", "115131025", "story_v_out_115131.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_115131", "115131025", "story_v_out_115131.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play115131026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115131026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play115131027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos105201ui_story = arg_107_1.actors_["105201ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["105201ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos105201ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["105201ui_story"].transform.position).z)
				arg_107_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["105201ui_story"].transform.localEulerAngles = arg_107_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["105201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_107_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["105201ui_story"].transform.position).z)
				arg_107_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["105201ui_story"].transform.localEulerAngles = arg_107_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["10014ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10014ui_story = var_110_1.localPosition
			end

			local var_110_2 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 then
				var_110_1.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_2)
				var_110_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_1.position).x, (manager.ui.mainCamera.transform.position - var_110_1.position).y, (manager.ui.mainCamera.transform.position - var_110_1.position).z)
				var_110_1.localEulerAngles.z = 0
				var_110_1.localEulerAngles.x = 0
				var_110_1.localEulerAngles = var_110_1.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 then
				var_110_1.localPosition = Vector3.New(0, 100, 0)
				var_110_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_1.position).x, (manager.ui.mainCamera.transform.position - var_110_1.position).y, (manager.ui.mainCamera.transform.position - var_110_1.position).z)
				var_110_1.localEulerAngles.z = 0
				var_110_1.localEulerAngles.x = 0
				var_110_1.localEulerAngles = var_110_1.localEulerAngles
			end

			local var_110_3 = 0
			local var_110_4 = 1.275

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_5 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(115131026).content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 51 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 51)

				if (51 <= 0 and var_110_4 or var_110_4 * (utf8.len(var_110_5) / 51)) > 0 and var_110_4 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_3
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_8 = math.max(var_110_4, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_8 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_3) / var_110_8

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_8 and arg_107_1.time_ < var_110_3 + var_110_8 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play115131027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 115131027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play115131028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.025

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(115131027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 41 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 41)

				if (41 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 41)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play115131028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 115131028
		arg_115_1.duration_ = 14.93

		local var_115_0 = {
			ja = 10.866,
			ko = 14.933,
			zh = 11.666,
			en = 10.766
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play115131029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_118_0 = arg_115_1.actors_["10014ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10014ui_story = var_118_0.localPosition
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_115_1.time_ - 0) / var_118_1)
				var_118_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_0.position).x, (manager.ui.mainCamera.transform.position - var_118_0.position).y, (manager.ui.mainCamera.transform.position - var_118_0.position).z)
				var_118_0.localEulerAngles.z = 0
				var_118_0.localEulerAngles.x = 0
				var_118_0.localEulerAngles = var_118_0.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_118_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_0.position).x, (manager.ui.mainCamera.transform.position - var_118_0.position).y, (manager.ui.mainCamera.transform.position - var_118_0.position).z)
				var_118_0.localEulerAngles.z = 0
				var_118_0.localEulerAngles.x = 0
				var_118_0.localEulerAngles = var_118_0.localEulerAngles
			end

			local var_118_2 = arg_115_1.actors_["10014ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect10014ui_story == nil then
				arg_115_1.var_.characterEffect10014ui_story = var_118_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_3 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.characterEffect10014ui_story and not isNil(var_118_2) then
					arg_115_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.characterEffect10014ui_story then
				arg_115_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_118_5 = arg_115_1.actors_["105201ui_story"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos105201ui_story = var_118_5.localPosition
			end

			local var_118_6 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_6 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos105201ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_115_1.time_ - 0) / var_118_6)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_6 and arg_115_1.time_ < 0 + var_118_6 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_118_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_5.position).x, (manager.ui.mainCamera.transform.position - var_118_5.position).y, (manager.ui.mainCamera.transform.position - var_118_5.position).z)
				var_118_5.localEulerAngles.z = 0
				var_118_5.localEulerAngles.x = 0
				var_118_5.localEulerAngles = var_118_5.localEulerAngles
			end

			local var_118_7 = arg_115_1.actors_["105201ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect105201ui_story == nil then
				arg_115_1.var_.characterEffect105201ui_story = var_118_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_8 and not isNil(var_118_7) then
				if arg_115_1.var_.characterEffect105201ui_story and not isNil(var_118_7) then
					arg_115_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_115_1.var_.characterEffect105201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_8)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_8 and arg_115_1.time_ < 0 + var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect105201ui_story then
				arg_115_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_115_1.var_.characterEffect105201ui_story.fillRatio = 0.5
			end

			local var_118_9 = 0
			local var_118_10 = 1.275

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_11 = arg_115_1:GetWordFromCfg(115131028)
				local var_118_12 = arg_115_1:FormatText(var_118_11.content)

				arg_115_1.text_.text = var_118_12

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_14 = 51 <= 0 and var_118_10 or var_118_10 * (utf8.len(var_118_12) / 51)

				if (51 <= 0 and var_118_10 or var_118_10 * (utf8.len(var_118_12) / 51)) > 0 and var_118_10 < var_118_14 then
					arg_115_1.talkMaxDuration = var_118_14

					if var_118_14 + var_118_9 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_14 + var_118_9
					end
				end

				arg_115_1.text_.text = var_118_12
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131028", "story_v_out_115131.awb") ~= 0 then
					local var_118_15 = manager.audio:GetVoiceLength("story_v_out_115131", "115131028", "story_v_out_115131.awb") / 1000

					if var_118_15 + var_118_9 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_9
					end

					if var_118_11.prefab_name ~= "" and arg_115_1.actors_[var_118_11.prefab_name] ~= nil then
						local var_118_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_11.prefab_name].transform, "story_v_out_115131", "115131028", "story_v_out_115131.awb")

						arg_115_1:RecordAudio("115131028", var_118_16)
						arg_115_1:RecordAudio("115131028", var_118_16)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_115131", "115131028", "story_v_out_115131.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_115131", "115131028", "story_v_out_115131.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_17 = math.max(var_118_10, arg_115_1.talkMaxDuration)

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_17 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_9) / var_118_17

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_9 + var_118_17 and arg_115_1.time_ < var_118_9 + var_118_17 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play115131029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 115131029
		arg_119_1.duration_ = 7.5

		local var_119_0 = {
			ja = 6.8,
			ko = 5.666,
			zh = 5.333,
			en = 7.5
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
				arg_119_0:Play115131030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10014ui_story"]) and arg_119_1.var_.characterEffect10014ui_story == nil then
				arg_119_1.var_.characterEffect10014ui_story = arg_119_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10014ui_story"]) then
				if arg_119_1.var_.characterEffect10014ui_story and not isNil(arg_119_1.actors_["10014ui_story"]) then
					arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10014ui_story"]) and arg_119_1.var_.characterEffect10014ui_story then
				arg_119_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_122_1 = arg_119_1.actors_["105201ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect105201ui_story == nil then
				arg_119_1.var_.characterEffect105201ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect105201ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect105201ui_story then
				arg_119_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(115131029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 25 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 25)

				if (25 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 25)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131029", "story_v_out_115131.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131029", "story_v_out_115131.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_115131", "115131029", "story_v_out_115131.awb")

						arg_119_1:RecordAudio("115131029", var_122_11)
						arg_119_1:RecordAudio("115131029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_115131", "115131029", "story_v_out_115131.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_115131", "115131029", "story_v_out_115131.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play115131030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 115131030
		arg_123_1.duration_ = 13.23

		local var_123_0 = {
			ja = 13.233,
			ko = 9.5,
			zh = 9.833,
			en = 7.466
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
				arg_123_0:Play115131031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_126_0 = arg_123_1.actors_["10014ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10014ui_story == nil then
				arg_123_1.var_.characterEffect10014ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_1 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 and not isNil(var_126_0) then
				if arg_123_1.var_.characterEffect10014ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10014ui_story then
				arg_123_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_126_3 = arg_123_1.actors_["105201ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect105201ui_story == nil then
				arg_123_1.var_.characterEffect105201ui_story = var_126_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_4 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 and not isNil(var_126_3) then
				if arg_123_1.var_.characterEffect105201ui_story and not isNil(var_126_3) then
					arg_123_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_123_1.var_.characterEffect105201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_4)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect105201ui_story then
				arg_123_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_123_1.var_.characterEffect105201ui_story.fillRatio = 0.5
			end

			local var_126_5 = 0
			local var_126_6 = 1.1

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:GetWordFromCfg(115131030)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 44 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 44)

				if (44 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 44)) > 0 and var_126_6 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131030", "story_v_out_115131.awb") ~= 0 then
					local var_126_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131030", "story_v_out_115131.awb") / 1000

					if var_126_11 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_5
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_out_115131", "115131030", "story_v_out_115131.awb")

						arg_123_1:RecordAudio("115131030", var_126_12)
						arg_123_1:RecordAudio("115131030", var_126_12)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_115131", "115131030", "story_v_out_115131.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_115131", "115131030", "story_v_out_115131.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_13 and arg_123_1.time_ < var_126_5 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play115131031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 115131031
		arg_127_1.duration_ = 2.6

		local var_127_0 = {
			ja = 1.999999999999,
			ko = 2.6,
			zh = 2.066,
			en = 1.999999999999
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play115131032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_130_0 = arg_127_1.actors_["105201ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect105201ui_story == nil then
				arg_127_1.var_.characterEffect105201ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_1 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 and not isNil(var_130_0) then
				if arg_127_1.var_.characterEffect105201ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect105201ui_story then
				arg_127_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_130_3 = arg_127_1.actors_["10014ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect10014ui_story == nil then
				arg_127_1.var_.characterEffect10014ui_story = var_130_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_3) then
				if arg_127_1.var_.characterEffect10014ui_story and not isNil(var_130_3) then
					arg_127_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_4)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect10014ui_story then
				arg_127_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_130_5 = 0
			local var_130_6 = 0.225

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(115131031)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 9 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 9)

				if (9 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 9)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131031", "story_v_out_115131.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131031", "story_v_out_115131.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_115131", "115131031", "story_v_out_115131.awb")

						arg_127_1:RecordAudio("115131031", var_130_12)
						arg_127_1:RecordAudio("115131031", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_115131", "115131031", "story_v_out_115131.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_115131", "115131031", "story_v_out_115131.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play115131032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 115131032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play115131033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos105201ui_story = arg_131_1.actors_["105201ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["105201ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos105201ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["105201ui_story"].transform.position).z)
				arg_131_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["105201ui_story"].transform.localEulerAngles = arg_131_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["105201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["105201ui_story"].transform.position).z)
				arg_131_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["105201ui_story"].transform.localEulerAngles = arg_131_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["10014ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10014ui_story = var_134_1.localPosition
			end

			local var_134_2 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 then
				var_134_1.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_2)
				var_134_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_1.position).x, (manager.ui.mainCamera.transform.position - var_134_1.position).y, (manager.ui.mainCamera.transform.position - var_134_1.position).z)
				var_134_1.localEulerAngles.z = 0
				var_134_1.localEulerAngles.x = 0
				var_134_1.localEulerAngles = var_134_1.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 then
				var_134_1.localPosition = Vector3.New(0, 100, 0)
				var_134_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_1.position).x, (manager.ui.mainCamera.transform.position - var_134_1.position).y, (manager.ui.mainCamera.transform.position - var_134_1.position).z)
				var_134_1.localEulerAngles.z = 0
				var_134_1.localEulerAngles.x = 0
				var_134_1.localEulerAngles = var_134_1.localEulerAngles
			end

			local var_134_3 = 0
			local var_134_4 = 0.7

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_5 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(115131032).content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 28 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 28)

				if (28 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 28)) > 0 and var_134_4 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_3 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_3
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_4, arg_131_1.talkMaxDuration)

			if var_134_3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_3 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_3) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_3 + var_134_8 and arg_131_1.time_ < var_134_3 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play115131033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115131033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play115131034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.325

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(115131033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 53 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 53)

				if (53 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 53)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play115131034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115131034
		arg_139_1.duration_ = 12.07

		local var_139_0 = {
			ja = 12.066,
			ko = 7.3,
			zh = 9.466,
			en = 7.733
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
				arg_139_0:Play115131035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos105201ui_story = arg_139_1.actors_["105201ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["105201ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos105201ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["105201ui_story"].transform.position).z)
				arg_139_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["105201ui_story"].transform.localEulerAngles = arg_139_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["105201ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_139_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["105201ui_story"].transform.position).z)
				arg_139_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["105201ui_story"].transform.localEulerAngles = arg_139_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_142_1 = arg_139_1.actors_["105201ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect105201ui_story == nil then
				arg_139_1.var_.characterEffect105201ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect105201ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect105201ui_story then
				arg_139_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_142_4 = arg_139_1.actors_["10014ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10014ui_story = var_142_4.localPosition
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_139_1.time_ - 0) / var_142_5)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			local var_142_6 = arg_139_1.actors_["10014ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect10014ui_story == nil then
				arg_139_1.var_.characterEffect10014ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 and not isNil(var_142_6) then
				if arg_139_1.var_.characterEffect10014ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect10014ui_story then
				arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_142_8 = 0
			local var_142_9 = 0.525

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(115131034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 21 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 21)

				if (21 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 21)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131034", "story_v_out_115131.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131034", "story_v_out_115131.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_115131", "115131034", "story_v_out_115131.awb")

						arg_139_1:RecordAudio("115131034", var_142_15)
						arg_139_1:RecordAudio("115131034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115131", "115131034", "story_v_out_115131.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115131", "115131034", "story_v_out_115131.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115131035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115131035
		arg_143_1.duration_ = 17.6

		local var_143_0 = {
			ja = 17.6,
			ko = 15.7,
			zh = 11.466,
			en = 15.966
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
				arg_143_0:Play115131036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["105201ui_story"]) and arg_143_1.var_.characterEffect105201ui_story == nil then
				arg_143_1.var_.characterEffect105201ui_story = arg_143_1.actors_["105201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["105201ui_story"]) then
				if arg_143_1.var_.characterEffect105201ui_story and not isNil(arg_143_1.actors_["105201ui_story"]) then
					arg_143_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_143_1.var_.characterEffect105201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["105201ui_story"]) and arg_143_1.var_.characterEffect105201ui_story then
				arg_143_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_143_1.var_.characterEffect105201ui_story.fillRatio = 0.5
			end

			local var_146_1 = arg_143_1.actors_["10014ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10014ui_story == nil then
				arg_143_1.var_.characterEffect10014ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10014ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10014ui_story then
				arg_143_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_146_4 = 0
			local var_146_5 = 1.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(115131035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 53 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 53)

				if (53 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 53)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131035", "story_v_out_115131.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131035", "story_v_out_115131.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_115131", "115131035", "story_v_out_115131.awb")

						arg_143_1:RecordAudio("115131035", var_146_11)
						arg_143_1:RecordAudio("115131035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115131", "115131035", "story_v_out_115131.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115131", "115131035", "story_v_out_115131.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play115131036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115131036
		arg_147_1.duration_ = 9.6

		local var_147_0 = {
			ja = 9.6,
			ko = 6.533,
			zh = 5.966,
			en = 6.7
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
				arg_147_0:Play115131037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_150_0 = 0
			local var_150_1 = 0.725

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(115131036)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 29 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 29)

				if (29 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 29)) > 0 and var_150_1 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131036", "story_v_out_115131.awb") ~= 0 then
					local var_150_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131036", "story_v_out_115131.awb") / 1000

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end

					if var_150_2.prefab_name ~= "" and arg_147_1.actors_[var_150_2.prefab_name] ~= nil then
						local var_150_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_2.prefab_name].transform, "story_v_out_115131", "115131036", "story_v_out_115131.awb")

						arg_147_1:RecordAudio("115131036", var_150_7)
						arg_147_1:RecordAudio("115131036", var_150_7)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115131", "115131036", "story_v_out_115131.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115131", "115131036", "story_v_out_115131.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115131037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115131037
		arg_151_1.duration_ = 6.27

		local var_151_0 = {
			ja = 6.266,
			ko = 5.433,
			zh = 5.333,
			en = 5
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
				arg_151_0:Play115131038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_154_0 = arg_151_1.actors_["105201ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect105201ui_story == nil then
				arg_151_1.var_.characterEffect105201ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_1 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 and not isNil(var_154_0) then
				if arg_151_1.var_.characterEffect105201ui_story and not isNil(var_154_0) then
					arg_151_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.characterEffect105201ui_story then
				arg_151_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			local var_154_3 = arg_151_1.actors_["10014ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_3) and arg_151_1.var_.characterEffect10014ui_story == nil then
				arg_151_1.var_.characterEffect10014ui_story = var_154_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_4 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 and not isNil(var_154_3) then
				if arg_151_1.var_.characterEffect10014ui_story and not isNil(var_154_3) then
					arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_4)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 and not isNil(var_154_3) and arg_151_1.var_.characterEffect10014ui_story then
				arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_154_5 = 0
			local var_154_6 = 0.75

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(115131037)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 30 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 30)

				if (30 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 30)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131037", "story_v_out_115131.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131037", "story_v_out_115131.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_115131", "115131037", "story_v_out_115131.awb")

						arg_151_1:RecordAudio("115131037", var_154_12)
						arg_151_1:RecordAudio("115131037", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115131", "115131037", "story_v_out_115131.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115131", "115131037", "story_v_out_115131.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_13 and arg_151_1.time_ < var_154_5 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play115131038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115131038
		arg_155_1.duration_ = 15

		local var_155_0 = {
			ja = 14.2,
			ko = 12.633,
			zh = 13.133,
			en = 15
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
				arg_155_0:Play115131039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["105201ui_story"]) and arg_155_1.var_.characterEffect105201ui_story == nil then
				arg_155_1.var_.characterEffect105201ui_story = arg_155_1.actors_["105201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["105201ui_story"]) then
				if arg_155_1.var_.characterEffect105201ui_story and not isNil(arg_155_1.actors_["105201ui_story"]) then
					arg_155_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_155_1.var_.characterEffect105201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["105201ui_story"]) and arg_155_1.var_.characterEffect105201ui_story then
				arg_155_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_155_1.var_.characterEffect105201ui_story.fillRatio = 0.5
			end

			local var_158_1 = arg_155_1.actors_["10014ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10014ui_story == nil then
				arg_155_1.var_.characterEffect10014ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect10014ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10014ui_story then
				arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_158_4 = 0
			local var_158_5 = 1.3

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(115131038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 52 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 52)

				if (52 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 52)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131038", "story_v_out_115131.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131038", "story_v_out_115131.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_115131", "115131038", "story_v_out_115131.awb")

						arg_155_1:RecordAudio("115131038", var_158_11)
						arg_155_1:RecordAudio("115131038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_115131", "115131038", "story_v_out_115131.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_115131", "115131038", "story_v_out_115131.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play115131039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115131039
		arg_159_1.duration_ = 15.03

		local var_159_0 = {
			ja = 14.733,
			ko = 15.033,
			zh = 13,
			en = 14.066
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play115131040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_162_0 = 0
			local var_162_1 = 1.475

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(115131039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 59 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 59)

				if (59 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 59)) > 0 and var_162_1 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131039", "story_v_out_115131.awb") ~= 0 then
					local var_162_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131039", "story_v_out_115131.awb") / 1000

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end

					if var_162_2.prefab_name ~= "" and arg_159_1.actors_[var_162_2.prefab_name] ~= nil then
						local var_162_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_2.prefab_name].transform, "story_v_out_115131", "115131039", "story_v_out_115131.awb")

						arg_159_1:RecordAudio("115131039", var_162_7)
						arg_159_1:RecordAudio("115131039", var_162_7)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115131", "115131039", "story_v_out_115131.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115131", "115131039", "story_v_out_115131.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play115131040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115131040
		arg_163_1.duration_ = 10.8

		local var_163_0 = {
			ja = 10.066,
			ko = 7.9,
			zh = 7.7,
			en = 10.8
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
				arg_163_0:Play115131041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_166_0 = 0
			local var_166_1 = 0.925

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(115131040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 37 <= 0 and var_166_1 or var_166_1 * (utf8.len(var_166_3) / 37)

				if (37 <= 0 and var_166_1 or var_166_1 * (utf8.len(var_166_3) / 37)) > 0 and var_166_1 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131040", "story_v_out_115131.awb") ~= 0 then
					local var_166_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131040", "story_v_out_115131.awb") / 1000

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end

					if var_166_2.prefab_name ~= "" and arg_163_1.actors_[var_166_2.prefab_name] ~= nil then
						local var_166_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_2.prefab_name].transform, "story_v_out_115131", "115131040", "story_v_out_115131.awb")

						arg_163_1:RecordAudio("115131040", var_166_7)
						arg_163_1:RecordAudio("115131040", var_166_7)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115131", "115131040", "story_v_out_115131.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115131", "115131040", "story_v_out_115131.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play115131041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115131041
		arg_167_1.duration_ = 13.1

		local var_167_0 = {
			ja = 13.1,
			ko = 5.733,
			zh = 5.6,
			en = 7.466
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
				arg_167_0:Play115131042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_170_0 = 0
			local var_170_1 = 0.575

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_2 = arg_167_1:GetWordFromCfg(115131041)
				local var_170_3 = arg_167_1:FormatText(var_170_2.content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 23 <= 0 and var_170_1 or var_170_1 * (utf8.len(var_170_3) / 23)

				if (23 <= 0 and var_170_1 or var_170_1 * (utf8.len(var_170_3) / 23)) > 0 and var_170_1 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131041", "story_v_out_115131.awb") ~= 0 then
					local var_170_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131041", "story_v_out_115131.awb") / 1000

					if var_170_6 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_0
					end

					if var_170_2.prefab_name ~= "" and arg_167_1.actors_[var_170_2.prefab_name] ~= nil then
						local var_170_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_2.prefab_name].transform, "story_v_out_115131", "115131041", "story_v_out_115131.awb")

						arg_167_1:RecordAudio("115131041", var_170_7)
						arg_167_1:RecordAudio("115131041", var_170_7)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_115131", "115131041", "story_v_out_115131.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_115131", "115131041", "story_v_out_115131.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play115131042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115131042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play115131043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10014ui_story"]) and arg_171_1.var_.characterEffect10014ui_story == nil then
				arg_171_1.var_.characterEffect10014ui_story = arg_171_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10014ui_story"]) then
				if arg_171_1.var_.characterEffect10014ui_story and not isNil(arg_171_1.actors_["10014ui_story"]) then
					arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10014ui_story"]) and arg_171_1.var_.characterEffect10014ui_story then
				arg_171_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 1.475

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(115131042).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 59 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 59)

				if (59 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 59)) > 0 and var_174_2 < var_174_5 then
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
	Play115131043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 115131043
		arg_175_1.duration_ = 2.37

		local var_175_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.366
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
				arg_175_0:Play115131044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["105201ui_story"]) and arg_175_1.var_.characterEffect105201ui_story == nil then
				arg_175_1.var_.characterEffect105201ui_story = arg_175_1.actors_["105201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["105201ui_story"]) then
				if arg_175_1.var_.characterEffect105201ui_story and not isNil(arg_175_1.actors_["105201ui_story"]) then
					arg_175_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["105201ui_story"]) and arg_175_1.var_.characterEffect105201ui_story then
				arg_175_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_178_2 = 0
			local var_178_3 = 0.1

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_4 = arg_175_1:GetWordFromCfg(115131043)
				local var_178_5 = arg_175_1:FormatText(var_178_4.content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 4 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 4)

				if (4 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 4)) > 0 and var_178_3 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131043", "story_v_out_115131.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131043", "story_v_out_115131.awb") / 1000

					if var_178_8 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_2
					end

					if var_178_4.prefab_name ~= "" and arg_175_1.actors_[var_178_4.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_4.prefab_name].transform, "story_v_out_115131", "115131043", "story_v_out_115131.awb")

						arg_175_1:RecordAudio("115131043", var_178_9)
						arg_175_1:RecordAudio("115131043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_115131", "115131043", "story_v_out_115131.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_115131", "115131043", "story_v_out_115131.awb")
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
	Play115131044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 115131044
		arg_179_1.duration_ = 8.2

		local var_179_0 = {
			ja = 8.033,
			ko = 5.766,
			zh = 5.3,
			en = 8.2
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
				arg_179_0:Play115131045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["105201ui_story"]) and arg_179_1.var_.characterEffect105201ui_story == nil then
				arg_179_1.var_.characterEffect105201ui_story = arg_179_1.actors_["105201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["105201ui_story"]) then
				if arg_179_1.var_.characterEffect105201ui_story and not isNil(arg_179_1.actors_["105201ui_story"]) then
					arg_179_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_179_1.var_.characterEffect105201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["105201ui_story"]) and arg_179_1.var_.characterEffect105201ui_story then
				arg_179_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_179_1.var_.characterEffect105201ui_story.fillRatio = 0.5
			end

			local var_182_1 = arg_179_1.actors_["10014ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10014ui_story == nil then
				arg_179_1.var_.characterEffect10014ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect10014ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10014ui_story then
				arg_179_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_182_4 = 0
			local var_182_5 = 0.475

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(115131044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 19 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 19)

				if (19 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 19)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131044", "story_v_out_115131.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131044", "story_v_out_115131.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_115131", "115131044", "story_v_out_115131.awb")

						arg_179_1:RecordAudio("115131044", var_182_11)
						arg_179_1:RecordAudio("115131044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_115131", "115131044", "story_v_out_115131.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_115131", "115131044", "story_v_out_115131.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play115131045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 115131045
		arg_183_1.duration_ = 20.77

		local var_183_0 = {
			ja = 15.9,
			ko = 20.766,
			zh = 11.433,
			en = 10.666
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
				arg_183_0:Play115131046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_186_0 = 0
			local var_186_1 = 1.275

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(115131045)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 51 <= 0 and var_186_1 or var_186_1 * (utf8.len(var_186_3) / 51)

				if (51 <= 0 and var_186_1 or var_186_1 * (utf8.len(var_186_3) / 51)) > 0 and var_186_1 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131045", "story_v_out_115131.awb") ~= 0 then
					local var_186_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131045", "story_v_out_115131.awb") / 1000

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end

					if var_186_2.prefab_name ~= "" and arg_183_1.actors_[var_186_2.prefab_name] ~= nil then
						local var_186_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_2.prefab_name].transform, "story_v_out_115131", "115131045", "story_v_out_115131.awb")

						arg_183_1:RecordAudio("115131045", var_186_7)
						arg_183_1:RecordAudio("115131045", var_186_7)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_115131", "115131045", "story_v_out_115131.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_115131", "115131045", "story_v_out_115131.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play115131046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 115131046
		arg_187_1.duration_ = 6.1

		local var_187_0 = {
			ja = 6.1,
			ko = 5.266,
			zh = 5.533,
			en = 5.7
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
				arg_187_0:Play115131047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_190_0 = 0
			local var_190_1 = 0.5

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(115131046)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 20 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 20)

				if (20 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 20)) > 0 and var_190_1 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131046", "story_v_out_115131.awb") ~= 0 then
					local var_190_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131046", "story_v_out_115131.awb") / 1000

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end

					if var_190_2.prefab_name ~= "" and arg_187_1.actors_[var_190_2.prefab_name] ~= nil then
						local var_190_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_2.prefab_name].transform, "story_v_out_115131", "115131046", "story_v_out_115131.awb")

						arg_187_1:RecordAudio("115131046", var_190_7)
						arg_187_1:RecordAudio("115131046", var_190_7)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_115131", "115131046", "story_v_out_115131.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_115131", "115131046", "story_v_out_115131.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_8 and arg_187_1.time_ < var_190_0 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play115131047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 115131047
		arg_191_1.duration_ = 10.03

		local var_191_0 = {
			ja = 5.166,
			ko = 5.733,
			zh = 7.933,
			en = 10.033
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
				arg_191_0:Play115131048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0.325 < arg_191_1.time_ and arg_191_1.time_ <= 0.325 + arg_194_0 then
				arg_191_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_194_0 = 1

			if 0.325 <= arg_191_1.time_ and arg_191_1.time_ < 0.325 + var_194_0 then
				local var_194_1, var_194_2 = math.modf((arg_191_1.time_ - 0.325) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_194_2 * 0.13, var_194_2 * 0.13, var_194_2 * 0.13) + arg_191_1.var_.shakeOldPos
			end

			if arg_191_1.time_ >= 0.325 + var_194_0 and arg_191_1.time_ < 0.325 + var_194_0 + arg_194_0 then
				manager.ui.mainCamera.transform.localPosition = arg_191_1.var_.shakeOldPos
			end

			local var_194_3 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_3 + arg_194_0 then
				arg_191_1.allBtn_.enabled = false
			end

			if arg_191_1.time_ >= var_194_3 + 1.325 and arg_191_1.time_ < var_194_3 + 1.325 + arg_194_0 then
				arg_191_1.allBtn_.enabled = true
			end

			local var_194_4 = arg_191_1.actors_["105201ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos105201ui_story = var_194_4.localPosition
			end

			local var_194_5 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_5 then
				var_194_4.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos105201ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_5)
				var_194_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_4.position).x, (manager.ui.mainCamera.transform.position - var_194_4.position).y, (manager.ui.mainCamera.transform.position - var_194_4.position).z)
				var_194_4.localEulerAngles.z = 0
				var_194_4.localEulerAngles.x = 0
				var_194_4.localEulerAngles = var_194_4.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_5 and arg_191_1.time_ < 0 + var_194_5 + arg_194_0 then
				var_194_4.localPosition = Vector3.New(0, 100, 0)
				var_194_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_4.position).x, (manager.ui.mainCamera.transform.position - var_194_4.position).y, (manager.ui.mainCamera.transform.position - var_194_4.position).z)
				var_194_4.localEulerAngles.z = 0
				var_194_4.localEulerAngles.x = 0
				var_194_4.localEulerAngles = var_194_4.localEulerAngles
			end

			local var_194_6 = arg_191_1.actors_["10014ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10014ui_story = var_194_6.localPosition
			end

			local var_194_7 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				var_194_6.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_7)
				var_194_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_6.position).x, (manager.ui.mainCamera.transform.position - var_194_6.position).y, (manager.ui.mainCamera.transform.position - var_194_6.position).z)
				var_194_6.localEulerAngles.z = 0
				var_194_6.localEulerAngles.x = 0
				var_194_6.localEulerAngles = var_194_6.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				var_194_6.localPosition = Vector3.New(0, 100, 0)
				var_194_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_6.position).x, (manager.ui.mainCamera.transform.position - var_194_6.position).y, (manager.ui.mainCamera.transform.position - var_194_6.position).z)
				var_194_6.localEulerAngles.z = 0
				var_194_6.localEulerAngles.x = 0
				var_194_6.localEulerAngles = var_194_6.localEulerAngles
			end

			local var_194_8 = 0
			local var_194_9 = 0.325

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_105201")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_10 = arg_191_1:GetWordFromCfg(115131047)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 13 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 13)

				if (13 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 13)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131047", "story_v_out_115131.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131047", "story_v_out_115131.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_115131", "115131047", "story_v_out_115131.awb")

						arg_191_1:RecordAudio("115131047", var_194_15)
						arg_191_1:RecordAudio("115131047", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_115131", "115131047", "story_v_out_115131.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_115131", "115131047", "story_v_out_115131.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play115131048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 115131048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play115131049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.4

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(115131048).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 56 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 56)

				if (56 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 56)) > 0 and var_198_0 < var_198_3 then
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
	Play115131049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 115131049
		arg_199_1.duration_ = 11.97

		local var_199_0 = {
			ja = 6.166,
			ko = 5.333,
			zh = 11.966,
			en = 5.933
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
				arg_199_0:Play115131050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos105201ui_story = arg_199_1.actors_["105201ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["105201ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos105201ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["105201ui_story"].transform.position).z)
				arg_199_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["105201ui_story"].transform.localEulerAngles = arg_199_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["105201ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_199_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["105201ui_story"].transform.position).z)
				arg_199_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["105201ui_story"].transform.localEulerAngles = arg_199_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["105201ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect105201ui_story == nil then
				arg_199_1.var_.characterEffect105201ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect105201ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect105201ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect105201ui_story then
				arg_199_1.var_.characterEffect105201ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("105201ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			local var_202_4 = 0
			local var_202_5 = 0.325

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(115131049)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 13 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 13)

				if (13 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 13)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131049", "story_v_out_115131.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131049", "story_v_out_115131.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_115131", "115131049", "story_v_out_115131.awb")

						arg_199_1:RecordAudio("115131049", var_202_11)
						arg_199_1:RecordAudio("115131049", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_115131", "115131049", "story_v_out_115131.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_115131", "115131049", "story_v_out_115131.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play115131050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 115131050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play115131051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["105201ui_story"]) and arg_203_1.var_.characterEffect105201ui_story == nil then
				arg_203_1.var_.characterEffect105201ui_story = arg_203_1.actors_["105201ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["105201ui_story"]) then
				if arg_203_1.var_.characterEffect105201ui_story and not isNil(arg_203_1.actors_["105201ui_story"]) then
					arg_203_1.var_.characterEffect105201ui_story.fillFlat = true
					arg_203_1.var_.characterEffect105201ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["105201ui_story"]) and arg_203_1.var_.characterEffect105201ui_story then
				arg_203_1.var_.characterEffect105201ui_story.fillFlat = true
				arg_203_1.var_.characterEffect105201ui_story.fillRatio = 0.5
			end

			local var_206_1 = arg_203_1.actors_["10014ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10014ui_story = var_206_1.localPosition
			end

			local var_206_2 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 then
				var_206_1.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_203_1.time_ - 0) / var_206_2)
				var_206_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_1.position).x, (manager.ui.mainCamera.transform.position - var_206_1.position).y, (manager.ui.mainCamera.transform.position - var_206_1.position).z)
				var_206_1.localEulerAngles.z = 0
				var_206_1.localEulerAngles.x = 0
				var_206_1.localEulerAngles = var_206_1.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 then
				var_206_1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_206_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_1.position).x, (manager.ui.mainCamera.transform.position - var_206_1.position).y, (manager.ui.mainCamera.transform.position - var_206_1.position).z)
				var_206_1.localEulerAngles.z = 0
				var_206_1.localEulerAngles.x = 0
				var_206_1.localEulerAngles = var_206_1.localEulerAngles
			end

			local var_206_3 = arg_203_1.actors_["10014ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect10014ui_story == nil then
				arg_203_1.var_.characterEffect10014ui_story = var_206_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_4 = 0.0166666666666667

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 and not isNil(var_206_3) then
				if arg_203_1.var_.characterEffect10014ui_story and not isNil(var_206_3) then
					arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_4)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 and not isNil(var_206_3) and arg_203_1.var_.characterEffect10014ui_story then
				arg_203_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_206_5 = 0
			local var_206_6 = 0.375

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(115131050).content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 15 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_7) / 15)

				if (15 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_7) / 15)) > 0 and var_206_6 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_10 and arg_203_1.time_ < var_206_5 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play115131051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 115131051
		arg_207_1.duration_ = 6.3

		local var_207_0 = {
			ja = 2.566,
			ko = 4.133,
			zh = 4.966,
			en = 6.3
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
				arg_207_0:Play115131052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_210_0 = arg_207_1.actors_["10014ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10014ui_story == nil then
				arg_207_1.var_.characterEffect10014ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_1 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 and not isNil(var_210_0) then
				if arg_207_1.var_.characterEffect10014ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect10014ui_story then
				arg_207_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_210_3 = 0
			local var_210_4 = 0.45

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_3 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_5 = arg_207_1:GetWordFromCfg(115131051)
				local var_210_6 = arg_207_1:FormatText(var_210_5.content)

				arg_207_1.text_.text = var_210_6

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_8 = 18 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_6) / 18)

				if (18 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_6) / 18)) > 0 and var_210_4 < var_210_8 then
					arg_207_1.talkMaxDuration = var_210_8

					if var_210_8 + var_210_3 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_3
					end
				end

				arg_207_1.text_.text = var_210_6
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131051", "story_v_out_115131.awb") ~= 0 then
					local var_210_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131051", "story_v_out_115131.awb") / 1000

					if var_210_9 + var_210_3 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_3
					end

					if var_210_5.prefab_name ~= "" and arg_207_1.actors_[var_210_5.prefab_name] ~= nil then
						local var_210_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_5.prefab_name].transform, "story_v_out_115131", "115131051", "story_v_out_115131.awb")

						arg_207_1:RecordAudio("115131051", var_210_10)
						arg_207_1:RecordAudio("115131051", var_210_10)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_115131", "115131051", "story_v_out_115131.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_115131", "115131051", "story_v_out_115131.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_11 = math.max(var_210_4, arg_207_1.talkMaxDuration)

			if var_210_3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_3 + var_210_11 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_3) / var_210_11

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_3 + var_210_11 and arg_207_1.time_ < var_210_3 + var_210_11 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play115131052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 115131052
		arg_211_1.duration_ = 12.5

		local var_211_0 = {
			ja = 12.5,
			ko = 9,
			zh = 6.333,
			en = 7.833
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
				arg_211_0:Play115131053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_214_0 = 0
			local var_214_1 = 0.75

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(115131052)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 30 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 30)

				if (30 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 30)) > 0 and var_214_1 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131052", "story_v_out_115131.awb") ~= 0 then
					local var_214_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131052", "story_v_out_115131.awb") / 1000

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end

					if var_214_2.prefab_name ~= "" and arg_211_1.actors_[var_214_2.prefab_name] ~= nil then
						local var_214_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_2.prefab_name].transform, "story_v_out_115131", "115131052", "story_v_out_115131.awb")

						arg_211_1:RecordAudio("115131052", var_214_7)
						arg_211_1:RecordAudio("115131052", var_214_7)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_115131", "115131052", "story_v_out_115131.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_115131", "115131052", "story_v_out_115131.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play115131053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 115131053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play115131054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos105201ui_story = arg_215_1.actors_["105201ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["105201ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos105201ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["105201ui_story"].transform.position).z)
				arg_215_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["105201ui_story"].transform.localEulerAngles = arg_215_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["105201ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.actors_["105201ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["105201ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["105201ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["105201ui_story"].transform.position).z)
				arg_215_1.actors_["105201ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["105201ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["105201ui_story"].transform.localEulerAngles = arg_215_1.actors_["105201ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["10014ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10014ui_story = var_218_1.localPosition
			end

			local var_218_2 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 then
				var_218_1.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_2)
				var_218_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_1.position).x, (manager.ui.mainCamera.transform.position - var_218_1.position).y, (manager.ui.mainCamera.transform.position - var_218_1.position).z)
				var_218_1.localEulerAngles.z = 0
				var_218_1.localEulerAngles.x = 0
				var_218_1.localEulerAngles = var_218_1.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 then
				var_218_1.localPosition = Vector3.New(0, 100, 0)
				var_218_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_1.position).x, (manager.ui.mainCamera.transform.position - var_218_1.position).y, (manager.ui.mainCamera.transform.position - var_218_1.position).z)
				var_218_1.localEulerAngles.z = 0
				var_218_1.localEulerAngles.x = 0
				var_218_1.localEulerAngles = var_218_1.localEulerAngles
			end

			local var_218_3 = 0
			local var_218_4 = 0.85

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_5 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(115131053).content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 34 <= 0 and var_218_4 or var_218_4 * (utf8.len(var_218_5) / 34)

				if (34 <= 0 and var_218_4 or var_218_4 * (utf8.len(var_218_5) / 34)) > 0 and var_218_4 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_3 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_3
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_4, arg_215_1.talkMaxDuration)

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_3) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_3 + var_218_8 and arg_215_1.time_ < var_218_3 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "105201ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play115131054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 115131054
		arg_219_1.duration_ = 8.6

		local var_219_0 = {
			ja = 5,
			ko = 8.466,
			zh = 8.066,
			en = 8.6
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
				arg_219_0:Play115131055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.65

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_105201")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:GetWordFromCfg(115131054)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 26 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 26)

				if (26 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 26)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131054", "story_v_out_115131.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_115131", "115131054", "story_v_out_115131.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_115131", "115131054", "story_v_out_115131.awb")

						arg_219_1:RecordAudio("115131054", var_222_6)
						arg_219_1:RecordAudio("115131054", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_115131", "115131054", "story_v_out_115131.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_115131", "115131054", "story_v_out_115131.awb")
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
	Play115131055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 115131055
		arg_223_1.duration_ = 3.47

		local var_223_0 = {
			ja = 2.266,
			ko = 2.766,
			zh = 3.366,
			en = 3.466
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
				arg_223_0:Play115131056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10014ui_story = arg_223_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10014ui_story"].transform.position).z)
				arg_223_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10014ui_story"].transform.localEulerAngles = arg_223_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_223_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10014ui_story"].transform.position).z)
				arg_223_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10014ui_story"].transform.localEulerAngles = arg_223_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_226_1 = arg_223_1.actors_["10014ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10014ui_story == nil then
				arg_223_1.var_.characterEffect10014ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.208333333333333

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect10014ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect10014ui_story then
				arg_223_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_226_4 = 0
			local var_226_5 = 0.325

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(115131055)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 13 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 13)

				if (13 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 13)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131055", "story_v_out_115131.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131055", "story_v_out_115131.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_115131", "115131055", "story_v_out_115131.awb")

						arg_223_1:RecordAudio("115131055", var_226_11)
						arg_223_1:RecordAudio("115131055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_115131", "115131055", "story_v_out_115131.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_115131", "115131055", "story_v_out_115131.awb")
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
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play115131056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 115131056
		arg_227_1.duration_ = 10.7

		local var_227_0 = {
			ja = 10,
			ko = 10.7,
			zh = 10.6,
			en = 8.766
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
				arg_227_0:Play115131057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_230_0 = 0
			local var_230_1 = 1

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(115131056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 40 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 40)

				if (40 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 40)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131056", "story_v_out_115131.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131056", "story_v_out_115131.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_out_115131", "115131056", "story_v_out_115131.awb")

						arg_227_1:RecordAudio("115131056", var_230_7)
						arg_227_1:RecordAudio("115131056", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_115131", "115131056", "story_v_out_115131.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_115131", "115131056", "story_v_out_115131.awb")
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
	Play115131057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 115131057
		arg_231_1.duration_ = 23.1

		local var_231_0 = {
			ja = 21.1,
			ko = 17.366,
			zh = 23.1,
			en = 21.333
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
				arg_231_0:Play115131058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_0 = 2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				local var_234_1 = Color.New(0, 0, 0)

				var_234_1.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.mask_.color = var_234_1
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				local var_234_2 = Color.New(0, 0, 0)

				var_234_2.a = 1
				arg_231_1.mask_.color = var_234_2
			end

			local var_234_3 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_3 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_4 = 2

			if var_234_3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_3 + var_234_4 then
				local var_234_5 = Color.New(0, 0, 0)

				var_234_5.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_3) / var_234_4)
				arg_231_1.mask_.color = var_234_5
			end

			if arg_231_1.time_ >= var_234_3 + var_234_4 and arg_231_1.time_ < var_234_3 + var_234_4 + arg_234_0 then
				local var_234_6 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_6.a = 0
				arg_231_1.mask_.color = var_234_6
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_7 = arg_231_1.bgs_.G03a

				arg_231_1.bgs_.G03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_8 = var_234_7:GetComponent("SpriteRenderer")

				if var_234_8 and var_234_8.sprite then
					local var_234_9 = 2 * (var_234_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_7.transform.localScale = Vector3.New(var_234_9 / var_234_8.sprite.bounds.size.y < var_234_9 * manager.ui.mainCameraCom_.aspect / var_234_8.sprite.bounds.size.x and var_234_9 * manager.ui.mainCameraCom_.aspect / var_234_8.sprite.bounds.size.x or var_234_9 / var_234_8.sprite.bounds.size.y, var_234_9 / var_234_8.sprite.bounds.size.y < var_234_9 * manager.ui.mainCameraCom_.aspect / var_234_8.sprite.bounds.size.x and var_234_9 * manager.ui.mainCameraCom_.aspect / var_234_8.sprite.bounds.size.x or var_234_9 / var_234_8.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "G03a" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_10 = arg_231_1.actors_["1052ui_story"].transform

			if 3.8 < arg_231_1.time_ and arg_231_1.time_ <= 3.8 + arg_234_0 then
				arg_231_1.var_.moveOldPos1052ui_story = var_234_10.localPosition
			end

			local var_234_11 = 0.001

			if 3.8 <= arg_231_1.time_ and arg_231_1.time_ < 3.8 + var_234_11 then
				var_234_10.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1052ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_231_1.time_ - 3.8) / var_234_11)
				var_234_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_10.position).x, (manager.ui.mainCamera.transform.position - var_234_10.position).y, (manager.ui.mainCamera.transform.position - var_234_10.position).z)
				var_234_10.localEulerAngles.z = 0
				var_234_10.localEulerAngles.x = 0
				var_234_10.localEulerAngles = var_234_10.localEulerAngles
			end

			if arg_231_1.time_ >= 3.8 + var_234_11 and arg_231_1.time_ < 3.8 + var_234_11 + arg_234_0 then
				var_234_10.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_234_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_10.position).x, (manager.ui.mainCamera.transform.position - var_234_10.position).y, (manager.ui.mainCamera.transform.position - var_234_10.position).z)
				var_234_10.localEulerAngles.z = 0
				var_234_10.localEulerAngles.x = 0
				var_234_10.localEulerAngles = var_234_10.localEulerAngles
			end

			if 3.8 < arg_231_1.time_ and arg_231_1.time_ <= 3.8 + arg_234_0 then
				arg_231_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 3.8 < arg_231_1.time_ and arg_231_1.time_ <= 3.8 + arg_234_0 then
				arg_231_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_234_12 = arg_231_1.actors_["1052ui_story"]

			if 3.8 < arg_231_1.time_ and arg_231_1.time_ <= 3.8 + arg_234_0 and not isNil(var_234_12) and arg_231_1.var_.characterEffect1052ui_story == nil then
				arg_231_1.var_.characterEffect1052ui_story = var_234_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_13 = 0.2

			if 3.8 <= arg_231_1.time_ and arg_231_1.time_ < 3.8 + var_234_13 and not isNil(var_234_12) then
				if arg_231_1.var_.characterEffect1052ui_story and not isNil(var_234_12) then
					arg_231_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 3.8 + var_234_13 and arg_231_1.time_ < 3.8 + var_234_13 + arg_234_0 and not isNil(var_234_12) and arg_231_1.var_.characterEffect1052ui_story then
				arg_231_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				local var_234_15 = arg_231_1.bgs_.G03a:GetComponent("SpriteRenderer")

				if var_234_15 then
					arg_231_1.var_.alphaOldValueG03a = var_234_15.color.a
					arg_231_1.var_.alphaMatValueG03a = var_234_15
				end

				arg_231_1.var_.alphaOldValueG03a = 0
			end

			local var_234_16 = 0.0166666666666667

			if 2 <= arg_231_1.time_ and arg_231_1.time_ < 2 + var_234_16 then
				if arg_231_1.var_.alphaMatValueG03a then
					arg_231_1.var_.alphaMatValueG03a.color.a = Mathf.Lerp(arg_231_1.var_.alphaOldValueG03a, 1, (arg_231_1.time_ - 2) / var_234_16)
					arg_231_1.var_.alphaMatValueG03a.color = arg_231_1.var_.alphaMatValueG03a.color
				end
			end

			if arg_231_1.time_ >= 2 + var_234_16 and arg_231_1.time_ < 2 + var_234_16 + arg_234_0 and arg_231_1.var_.alphaMatValueG03a then
				arg_231_1.var_.alphaMatValueG03a.color.a = 1
				arg_231_1.var_.alphaMatValueG03a.color = arg_231_1.var_.alphaMatValueG03a.color
			end

			local var_234_17 = arg_231_1.actors_["1024ui_story"].transform

			if 3.8 < arg_231_1.time_ and arg_231_1.time_ <= 3.8 + arg_234_0 then
				arg_231_1.var_.moveOldPos1024ui_story = var_234_17.localPosition
			end

			local var_234_18 = 0.001

			if 3.8 <= arg_231_1.time_ and arg_231_1.time_ < 3.8 + var_234_18 then
				var_234_17.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_231_1.time_ - 3.8) / var_234_18)
				var_234_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_17.position).x, (manager.ui.mainCamera.transform.position - var_234_17.position).y, (manager.ui.mainCamera.transform.position - var_234_17.position).z)
				var_234_17.localEulerAngles.z = 0
				var_234_17.localEulerAngles.x = 0
				var_234_17.localEulerAngles = var_234_17.localEulerAngles
			end

			if arg_231_1.time_ >= 3.8 + var_234_18 and arg_231_1.time_ < 3.8 + var_234_18 + arg_234_0 then
				var_234_17.localPosition = Vector3.New(0.7, -1, -6.05)
				var_234_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_17.position).x, (manager.ui.mainCamera.transform.position - var_234_17.position).y, (manager.ui.mainCamera.transform.position - var_234_17.position).z)
				var_234_17.localEulerAngles.z = 0
				var_234_17.localEulerAngles.x = 0
				var_234_17.localEulerAngles = var_234_17.localEulerAngles
			end

			if 3.8 < arg_231_1.time_ and arg_231_1.time_ <= 3.8 + arg_234_0 then
				arg_231_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 3.8 < arg_231_1.time_ and arg_231_1.time_ <= 3.8 + arg_234_0 then
				arg_231_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_234_19 = arg_231_1.actors_["10014ui_story"].transform

			if 1.966 < arg_231_1.time_ and arg_231_1.time_ <= 1.966 + arg_234_0 then
				arg_231_1.var_.moveOldPos10014ui_story = var_234_19.localPosition
			end

			local var_234_20 = 0.001

			if 1.966 <= arg_231_1.time_ and arg_231_1.time_ < 1.966 + var_234_20 then
				var_234_19.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.966) / var_234_20)
				var_234_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_19.position).x, (manager.ui.mainCamera.transform.position - var_234_19.position).y, (manager.ui.mainCamera.transform.position - var_234_19.position).z)
				var_234_19.localEulerAngles.z = 0
				var_234_19.localEulerAngles.x = 0
				var_234_19.localEulerAngles = var_234_19.localEulerAngles
			end

			if arg_231_1.time_ >= 1.966 + var_234_20 and arg_231_1.time_ < 1.966 + var_234_20 + arg_234_0 then
				var_234_19.localPosition = Vector3.New(0, 100, 0)
				var_234_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_19.position).x, (manager.ui.mainCamera.transform.position - var_234_19.position).y, (manager.ui.mainCamera.transform.position - var_234_19.position).z)
				var_234_19.localEulerAngles.z = 0
				var_234_19.localEulerAngles.x = 0
				var_234_19.localEulerAngles = var_234_19.localEulerAngles
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_21 = 4
			local var_234_22 = 1.4

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_23 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_23:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_24 = arg_231_1:GetWordFromCfg(115131057)
				local var_234_25 = arg_231_1:FormatText(var_234_24.content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_27 = 56 <= 0 and var_234_22 or var_234_22 * (utf8.len(var_234_25) / 56)

				if (56 <= 0 and var_234_22 or var_234_22 * (utf8.len(var_234_25) / 56)) > 0 and var_234_22 < var_234_27 then
					arg_231_1.talkMaxDuration = var_234_27
					var_234_21 = var_234_21 + 0.3

					if var_234_27 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_27 + var_234_21
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131057", "story_v_out_115131.awb") ~= 0 then
					local var_234_28 = manager.audio:GetVoiceLength("story_v_out_115131", "115131057", "story_v_out_115131.awb") / 1000

					if var_234_28 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_21
					end

					if var_234_24.prefab_name ~= "" and arg_231_1.actors_[var_234_24.prefab_name] ~= nil then
						local var_234_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_24.prefab_name].transform, "story_v_out_115131", "115131057", "story_v_out_115131.awb")

						arg_231_1:RecordAudio("115131057", var_234_29)
						arg_231_1:RecordAudio("115131057", var_234_29)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_115131", "115131057", "story_v_out_115131.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_115131", "115131057", "story_v_out_115131.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_30 = var_234_21 + 0.3
			local var_234_31 = math.max(var_234_22, arg_231_1.talkMaxDuration)

			if var_234_21 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_30 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_30) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_30 + var_234_31 and arg_231_1.time_ < var_234_30 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play115131058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 115131058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play115131059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["1052ui_story"]) and arg_237_1.var_.characterEffect1052ui_story == nil then
				arg_237_1.var_.characterEffect1052ui_story = arg_237_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["1052ui_story"]) then
				if arg_237_1.var_.characterEffect1052ui_story and not isNil(arg_237_1.actors_["1052ui_story"]) then
					arg_237_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["1052ui_story"]) and arg_237_1.var_.characterEffect1052ui_story then
				arg_237_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.4

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(115131058).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 16 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 16)

				if (16 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 16)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play115131059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 115131059
		arg_241_1.duration_ = 2.3

		local var_241_0 = {
			ja = 2.1,
			ko = 2.066,
			zh = 1.8,
			en = 2.3
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play115131060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.175

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:GetWordFromCfg(115131059)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 7 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 7)

				if (7 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 7)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131059", "story_v_out_115131.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_115131", "115131059", "story_v_out_115131.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_115131", "115131059", "story_v_out_115131.awb")

						arg_241_1:RecordAudio("115131059", var_244_6)
						arg_241_1:RecordAudio("115131059", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_115131", "115131059", "story_v_out_115131.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_115131", "115131059", "story_v_out_115131.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play115131060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 115131060
		arg_245_1.duration_ = 1.37

		local var_245_0 = {
			ja = 1.366,
			ko = 1.366,
			zh = 1.366,
			en = 1.233
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
				arg_245_0:Play115131061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.075

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[266].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024_1")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_1 = arg_245_1:GetWordFromCfg(115131060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 3 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 3)

				if (3 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 3)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131060", "story_v_out_115131.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_115131", "115131060", "story_v_out_115131.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_115131", "115131060", "story_v_out_115131.awb")

						arg_245_1:RecordAudio("115131060", var_248_6)
						arg_245_1:RecordAudio("115131060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_115131", "115131060", "story_v_out_115131.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_115131", "115131060", "story_v_out_115131.awb")
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
	Play115131061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 115131061
		arg_249_1.duration_ = 16.17

		local var_249_0 = {
			ja = 16.166,
			ko = 8.9,
			zh = 11.466,
			en = 8.9
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
				arg_249_0:Play115131062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_252_0 = arg_249_1.actors_["1052ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1052ui_story == nil then
				arg_249_1.var_.characterEffect1052ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_1 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 and not isNil(var_252_0) then
				if arg_249_1.var_.characterEffect1052ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1052ui_story then
				arg_249_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_252_3 = 0
			local var_252_4 = 0.85

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_3 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_5 = arg_249_1:GetWordFromCfg(115131061)
				local var_252_6 = arg_249_1:FormatText(var_252_5.content)

				arg_249_1.text_.text = var_252_6

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_8 = 34 <= 0 and var_252_4 or var_252_4 * (utf8.len(var_252_6) / 34)

				if (34 <= 0 and var_252_4 or var_252_4 * (utf8.len(var_252_6) / 34)) > 0 and var_252_4 < var_252_8 then
					arg_249_1.talkMaxDuration = var_252_8

					if var_252_8 + var_252_3 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_3
					end
				end

				arg_249_1.text_.text = var_252_6
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131061", "story_v_out_115131.awb") ~= 0 then
					local var_252_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131061", "story_v_out_115131.awb") / 1000

					if var_252_9 + var_252_3 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_3
					end

					if var_252_5.prefab_name ~= "" and arg_249_1.actors_[var_252_5.prefab_name] ~= nil then
						local var_252_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_5.prefab_name].transform, "story_v_out_115131", "115131061", "story_v_out_115131.awb")

						arg_249_1:RecordAudio("115131061", var_252_10)
						arg_249_1:RecordAudio("115131061", var_252_10)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_115131", "115131061", "story_v_out_115131.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_115131", "115131061", "story_v_out_115131.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_11 = math.max(var_252_4, arg_249_1.talkMaxDuration)

			if var_252_3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_3 + var_252_11 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_3) / var_252_11

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_3 + var_252_11 and arg_249_1.time_ < var_252_3 + var_252_11 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play115131062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 115131062
		arg_253_1.duration_ = 15.8

		local var_253_0 = {
			ja = 6.4,
			ko = 11.866,
			zh = 14.1,
			en = 15.8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play115131063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_256_0 = 0
			local var_256_1 = 1.1

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(115131062)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 44 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_3) / 44)

				if (44 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_3) / 44)) > 0 and var_256_1 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131062", "story_v_out_115131.awb") ~= 0 then
					local var_256_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131062", "story_v_out_115131.awb") / 1000

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end

					if var_256_2.prefab_name ~= "" and arg_253_1.actors_[var_256_2.prefab_name] ~= nil then
						local var_256_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_2.prefab_name].transform, "story_v_out_115131", "115131062", "story_v_out_115131.awb")

						arg_253_1:RecordAudio("115131062", var_256_7)
						arg_253_1:RecordAudio("115131062", var_256_7)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_115131", "115131062", "story_v_out_115131.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_115131", "115131062", "story_v_out_115131.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play115131063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 115131063
		arg_257_1.duration_ = 1.73

		local var_257_0 = {
			ja = 1.466,
			ko = 1.233,
			zh = 1.4,
			en = 1.733
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
				arg_257_0:Play115131064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1052ui_story"]) and arg_257_1.var_.characterEffect1052ui_story == nil then
				arg_257_1.var_.characterEffect1052ui_story = arg_257_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1052ui_story"]) then
				if arg_257_1.var_.characterEffect1052ui_story and not isNil(arg_257_1.actors_["1052ui_story"]) then
					arg_257_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1052ui_story"]) and arg_257_1.var_.characterEffect1052ui_story then
				arg_257_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_260_1 = arg_257_1.actors_["1024ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1024ui_story == nil then
				arg_257_1.var_.characterEffect1024ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect1024ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect1024ui_story then
				arg_257_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_260_4 = 0
			local var_260_5 = 0.05

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(115131063)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 2 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 2)

				if (2 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 2)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131063", "story_v_out_115131.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131063", "story_v_out_115131.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_115131", "115131063", "story_v_out_115131.awb")

						arg_257_1:RecordAudio("115131063", var_260_11)
						arg_257_1:RecordAudio("115131063", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_115131", "115131063", "story_v_out_115131.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_115131", "115131063", "story_v_out_115131.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play115131064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 115131064
		arg_261_1.duration_ = 2.97

		local var_261_0 = {
			ja = 1.533,
			ko = 2.766,
			zh = 2.966,
			en = 2.266
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
				arg_261_0:Play115131065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1024ui_story"]) and arg_261_1.var_.characterEffect1024ui_story == nil then
				arg_261_1.var_.characterEffect1024ui_story = arg_261_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1024ui_story"]) then
				if arg_261_1.var_.characterEffect1024ui_story and not isNil(arg_261_1.actors_["1024ui_story"]) then
					arg_261_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1024ui_story"]) and arg_261_1.var_.characterEffect1024ui_story then
				arg_261_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.2

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(115131064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_6 = 8 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_4) / 8)

				if (8 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_4) / 8)) > 0 and var_264_2 < var_264_6 then
					arg_261_1.talkMaxDuration = var_264_6

					if var_264_6 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_6 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_4
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131064", "story_v_out_115131.awb") ~= 0 then
					local var_264_7 = manager.audio:GetVoiceLength("story_v_out_115131", "115131064", "story_v_out_115131.awb") / 1000

					if var_264_7 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_7 + var_264_1
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_115131", "115131064", "story_v_out_115131.awb")

						arg_261_1:RecordAudio("115131064", var_264_8)
						arg_261_1:RecordAudio("115131064", var_264_8)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_115131", "115131064", "story_v_out_115131.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_115131", "115131064", "story_v_out_115131.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_9 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_9 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_9

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_9 and arg_261_1.time_ < var_264_1 + var_264_9 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play115131065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 115131065
		arg_265_1.duration_ = 5.43

		local var_265_0 = {
			ja = 5.433,
			ko = 3,
			zh = 1.999999999999,
			en = 2.1
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
				arg_265_0:Play115131066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1024ui_story"]) and arg_265_1.var_.characterEffect1024ui_story == nil then
				arg_265_1.var_.characterEffect1024ui_story = arg_265_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1024ui_story"]) then
				if arg_265_1.var_.characterEffect1024ui_story and not isNil(arg_265_1.actors_["1024ui_story"]) then
					arg_265_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1024ui_story"]) and arg_265_1.var_.characterEffect1024ui_story then
				arg_265_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_268_2 = 0
			local var_268_3 = 0.225

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:GetWordFromCfg(115131065)
				local var_268_5 = arg_265_1:FormatText(var_268_4.content)

				arg_265_1.text_.text = var_268_5

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 9 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 9)

				if (9 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_5) / 9)) > 0 and var_268_3 < var_268_7 then
					arg_265_1.talkMaxDuration = var_268_7

					if var_268_7 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_5
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131065", "story_v_out_115131.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_115131", "115131065", "story_v_out_115131.awb") / 1000

					if var_268_8 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_2
					end

					if var_268_4.prefab_name ~= "" and arg_265_1.actors_[var_268_4.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_4.prefab_name].transform, "story_v_out_115131", "115131065", "story_v_out_115131.awb")

						arg_265_1:RecordAudio("115131065", var_268_9)
						arg_265_1:RecordAudio("115131065", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_115131", "115131065", "story_v_out_115131.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_115131", "115131065", "story_v_out_115131.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_10 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_10 and arg_265_1.time_ < var_268_2 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play115131066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 115131066
		arg_269_1.duration_ = 10.83

		local var_269_0 = {
			ja = 10.833,
			ko = 5.5,
			zh = 7.433,
			en = 6.833
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
				arg_269_0:Play115131067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1052ui_story"]) and arg_269_1.var_.characterEffect1052ui_story == nil then
				arg_269_1.var_.characterEffect1052ui_story = arg_269_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1052ui_story"]) then
				if arg_269_1.var_.characterEffect1052ui_story and not isNil(arg_269_1.actors_["1052ui_story"]) then
					arg_269_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1052ui_story"]) and arg_269_1.var_.characterEffect1052ui_story then
				arg_269_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_272_2 = arg_269_1.actors_["1024ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1024ui_story == nil then
				arg_269_1.var_.characterEffect1024ui_story = var_272_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.characterEffect1024ui_story and not isNil(var_272_2) then
					arg_269_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_3)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1024ui_story then
				arg_269_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_272_4 = 0
			local var_272_5 = 0.675

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(115131066)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 27 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 27)

				if (27 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 27)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131066", "story_v_out_115131.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131066", "story_v_out_115131.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_115131", "115131066", "story_v_out_115131.awb")

						arg_269_1:RecordAudio("115131066", var_272_11)
						arg_269_1:RecordAudio("115131066", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_115131", "115131066", "story_v_out_115131.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_115131", "115131066", "story_v_out_115131.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play115131067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 115131067
		arg_273_1.duration_ = 12.3

		local var_273_0 = {
			ja = 11.1,
			ko = 12.3,
			zh = 9.333,
			en = 9.533
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play115131068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_276_0 = arg_273_1.actors_["1024ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1024ui_story == nil then
				arg_273_1.var_.characterEffect1024ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_1 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 and not isNil(var_276_0) then
				if arg_273_1.var_.characterEffect1024ui_story and not isNil(var_276_0) then
					arg_273_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1024ui_story then
				arg_273_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_276_3 = arg_273_1.actors_["1052ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_3) and arg_273_1.var_.characterEffect1052ui_story == nil then
				arg_273_1.var_.characterEffect1052ui_story = var_276_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_4 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 and not isNil(var_276_3) then
				if arg_273_1.var_.characterEffect1052ui_story and not isNil(var_276_3) then
					arg_273_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_4)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 and not isNil(var_276_3) and arg_273_1.var_.characterEffect1052ui_story then
				arg_273_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_276_5 = 0
			local var_276_6 = 1.1

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:GetWordFromCfg(115131067)
				local var_276_8 = arg_273_1:FormatText(var_276_7.content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 45 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 45)

				if (45 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 45)) > 0 and var_276_6 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131067", "story_v_out_115131.awb") ~= 0 then
					local var_276_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131067", "story_v_out_115131.awb") / 1000

					if var_276_11 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_5
					end

					if var_276_7.prefab_name ~= "" and arg_273_1.actors_[var_276_7.prefab_name] ~= nil then
						local var_276_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_7.prefab_name].transform, "story_v_out_115131", "115131067", "story_v_out_115131.awb")

						arg_273_1:RecordAudio("115131067", var_276_12)
						arg_273_1:RecordAudio("115131067", var_276_12)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_115131", "115131067", "story_v_out_115131.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_115131", "115131067", "story_v_out_115131.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_13 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_13 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_13

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_13 and arg_273_1.time_ < var_276_5 + var_276_13 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play115131068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 115131068
		arg_277_1.duration_ = 14.1

		local var_277_0 = {
			ja = 14.1,
			ko = 12.066,
			zh = 11.633,
			en = 10.7
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
				arg_277_0:Play115131069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1024ui_story"]) and arg_277_1.var_.characterEffect1024ui_story == nil then
				arg_277_1.var_.characterEffect1024ui_story = arg_277_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1024ui_story"]) then
				if arg_277_1.var_.characterEffect1024ui_story and not isNil(arg_277_1.actors_["1024ui_story"]) then
					arg_277_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1024ui_story"]) and arg_277_1.var_.characterEffect1024ui_story then
				arg_277_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_280_1 = arg_277_1.actors_["1052ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1052ui_story == nil then
				arg_277_1.var_.characterEffect1052ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1052ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1052ui_story then
				arg_277_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action7_1")
			end

			local var_280_4 = 0
			local var_280_5 = 1.175

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(115131068)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 47 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 47)

				if (47 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 47)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131068", "story_v_out_115131.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131068", "story_v_out_115131.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_115131", "115131068", "story_v_out_115131.awb")

						arg_277_1:RecordAudio("115131068", var_280_11)
						arg_277_1:RecordAudio("115131068", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_115131", "115131068", "story_v_out_115131.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_115131", "115131068", "story_v_out_115131.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play115131069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 115131069
		arg_281_1.duration_ = 8.67

		local var_281_0 = {
			ja = 8.666,
			ko = 7.633,
			zh = 5.833,
			en = 5.166
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
				arg_281_0:Play115131070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_284_0 = arg_281_1.actors_["1024ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1024ui_story == nil then
				arg_281_1.var_.characterEffect1024ui_story = var_284_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_1 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 and not isNil(var_284_0) then
				if arg_281_1.var_.characterEffect1024ui_story and not isNil(var_284_0) then
					arg_281_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 and not isNil(var_284_0) and arg_281_1.var_.characterEffect1024ui_story then
				arg_281_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_284_3 = arg_281_1.actors_["1052ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1052ui_story == nil then
				arg_281_1.var_.characterEffect1052ui_story = var_284_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_4 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 and not isNil(var_284_3) then
				if arg_281_1.var_.characterEffect1052ui_story and not isNil(var_284_3) then
					arg_281_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_4)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect1052ui_story then
				arg_281_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_284_5 = 0
			local var_284_6 = 0.725

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(115131069)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 29 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 29)

				if (29 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 29)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131069", "story_v_out_115131.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131069", "story_v_out_115131.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_115131", "115131069", "story_v_out_115131.awb")

						arg_281_1:RecordAudio("115131069", var_284_12)
						arg_281_1:RecordAudio("115131069", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_115131", "115131069", "story_v_out_115131.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_115131", "115131069", "story_v_out_115131.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_13 and arg_281_1.time_ < var_284_5 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play115131070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 115131070
		arg_285_1.duration_ = 14

		local var_285_0 = {
			ja = 14,
			ko = 11.033,
			zh = 13.766,
			en = 9.666
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
				arg_285_0:Play115131071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_288_0 = arg_285_1.actors_["1024ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1024ui_story == nil then
				arg_285_1.var_.characterEffect1024ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_1 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 and not isNil(var_288_0) then
				if arg_285_1.var_.characterEffect1024ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_1)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1024ui_story then
				arg_285_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_288_2 = arg_285_1.actors_["1052ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1052ui_story == nil then
				arg_285_1.var_.characterEffect1052ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect1052ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1052ui_story then
				arg_285_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_288_5 = 0
			local var_288_6 = 1.3

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(115131070)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 52 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 52)

				if (52 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 52)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131070", "story_v_out_115131.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131070", "story_v_out_115131.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_115131", "115131070", "story_v_out_115131.awb")

						arg_285_1:RecordAudio("115131070", var_288_12)
						arg_285_1:RecordAudio("115131070", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_115131", "115131070", "story_v_out_115131.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_115131", "115131070", "story_v_out_115131.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_13 and arg_285_1.time_ < var_288_5 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play115131071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 115131071
		arg_289_1.duration_ = 17.57

		local var_289_0 = {
			ja = 16,
			ko = 12.466,
			zh = 13.233,
			en = 17.566
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
				arg_289_0:Play115131072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_292_0 = 0
			local var_292_1 = 1.225

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(115131071)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 49 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 49)

				if (49 <= 0 and var_292_1 or var_292_1 * (utf8.len(var_292_3) / 49)) > 0 and var_292_1 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131071", "story_v_out_115131.awb") ~= 0 then
					local var_292_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131071", "story_v_out_115131.awb") / 1000

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end

					if var_292_2.prefab_name ~= "" and arg_289_1.actors_[var_292_2.prefab_name] ~= nil then
						local var_292_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_2.prefab_name].transform, "story_v_out_115131", "115131071", "story_v_out_115131.awb")

						arg_289_1:RecordAudio("115131071", var_292_7)
						arg_289_1:RecordAudio("115131071", var_292_7)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_115131", "115131071", "story_v_out_115131.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_115131", "115131071", "story_v_out_115131.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_8 and arg_289_1.time_ < var_292_0 + var_292_8 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play115131072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 115131072
		arg_293_1.duration_ = 17.87

		local var_293_0 = {
			ja = 12.3,
			ko = 15.7,
			zh = 17.866,
			en = 12.4
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
				arg_293_0:Play115131073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052actionlink/1052action476")
			end

			local var_296_0 = 0
			local var_296_1 = 1.55

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(115131072)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 62 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 62)

				if (62 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 62)) > 0 and var_296_1 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131072", "story_v_out_115131.awb") ~= 0 then
					local var_296_6 = manager.audio:GetVoiceLength("story_v_out_115131", "115131072", "story_v_out_115131.awb") / 1000

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end

					if var_296_2.prefab_name ~= "" and arg_293_1.actors_[var_296_2.prefab_name] ~= nil then
						local var_296_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_2.prefab_name].transform, "story_v_out_115131", "115131072", "story_v_out_115131.awb")

						arg_293_1:RecordAudio("115131072", var_296_7)
						arg_293_1:RecordAudio("115131072", var_296_7)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_115131", "115131072", "story_v_out_115131.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_115131", "115131072", "story_v_out_115131.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play115131073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 115131073
		arg_297_1.duration_ = 18.3

		local var_297_0 = {
			ja = 18.3,
			ko = 17,
			zh = 12.8,
			en = 15.666
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
				arg_297_0:Play115131074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_300_0 = arg_297_1.actors_["1024ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1024ui_story == nil then
				arg_297_1.var_.characterEffect1024ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_1 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 and not isNil(var_300_0) then
				if arg_297_1.var_.characterEffect1024ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1024ui_story then
				arg_297_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_300_3 = arg_297_1.actors_["1052ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_3) and arg_297_1.var_.characterEffect1052ui_story == nil then
				arg_297_1.var_.characterEffect1052ui_story = var_300_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_4 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 and not isNil(var_300_3) then
				if arg_297_1.var_.characterEffect1052ui_story and not isNil(var_300_3) then
					arg_297_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_4)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 and not isNil(var_300_3) and arg_297_1.var_.characterEffect1052ui_story then
				arg_297_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_300_5 = 0
			local var_300_6 = 1.525

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_7 = arg_297_1:GetWordFromCfg(115131073)
				local var_300_8 = arg_297_1:FormatText(var_300_7.content)

				arg_297_1.text_.text = var_300_8

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_10 = 61 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 61)

				if (61 <= 0 and var_300_6 or var_300_6 * (utf8.len(var_300_8) / 61)) > 0 and var_300_6 < var_300_10 then
					arg_297_1.talkMaxDuration = var_300_10

					if var_300_10 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_5
					end
				end

				arg_297_1.text_.text = var_300_8
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131073", "story_v_out_115131.awb") ~= 0 then
					local var_300_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131073", "story_v_out_115131.awb") / 1000

					if var_300_11 + var_300_5 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_11 + var_300_5
					end

					if var_300_7.prefab_name ~= "" and arg_297_1.actors_[var_300_7.prefab_name] ~= nil then
						local var_300_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_7.prefab_name].transform, "story_v_out_115131", "115131073", "story_v_out_115131.awb")

						arg_297_1:RecordAudio("115131073", var_300_12)
						arg_297_1:RecordAudio("115131073", var_300_12)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_115131", "115131073", "story_v_out_115131.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_115131", "115131073", "story_v_out_115131.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_13 = math.max(var_300_6, arg_297_1.talkMaxDuration)

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_13 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_5) / var_300_13

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_5 + var_300_13 and arg_297_1.time_ < var_300_5 + var_300_13 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play115131074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 115131074
		arg_301_1.duration_ = 16

		local var_301_0 = {
			ja = 16,
			ko = 9.6,
			zh = 11.633,
			en = 7.833
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
				arg_301_0:Play115131075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_304_0 = arg_301_1.actors_["1024ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1024ui_story == nil then
				arg_301_1.var_.characterEffect1024ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_1 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_1 and not isNil(var_304_0) then
				if arg_301_1.var_.characterEffect1024ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_1)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_1 and arg_301_1.time_ < 0 + var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1024ui_story then
				arg_301_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_304_2 = arg_301_1.actors_["1052ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect1052ui_story == nil then
				arg_301_1.var_.characterEffect1052ui_story = var_304_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_3 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.characterEffect1052ui_story and not isNil(var_304_2) then
					arg_301_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect1052ui_story then
				arg_301_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_304_5 = 0
			local var_304_6 = 0.85

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_7 = arg_301_1:GetWordFromCfg(115131074)
				local var_304_8 = arg_301_1:FormatText(var_304_7.content)

				arg_301_1.text_.text = var_304_8

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_10 = 34 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 34)

				if (34 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 34)) > 0 and var_304_6 < var_304_10 then
					arg_301_1.talkMaxDuration = var_304_10

					if var_304_10 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_5
					end
				end

				arg_301_1.text_.text = var_304_8
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131074", "story_v_out_115131.awb") ~= 0 then
					local var_304_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131074", "story_v_out_115131.awb") / 1000

					if var_304_11 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_5
					end

					if var_304_7.prefab_name ~= "" and arg_301_1.actors_[var_304_7.prefab_name] ~= nil then
						local var_304_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_7.prefab_name].transform, "story_v_out_115131", "115131074", "story_v_out_115131.awb")

						arg_301_1:RecordAudio("115131074", var_304_12)
						arg_301_1:RecordAudio("115131074", var_304_12)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_115131", "115131074", "story_v_out_115131.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_115131", "115131074", "story_v_out_115131.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_13 = math.max(var_304_6, arg_301_1.talkMaxDuration)

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_13 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_5) / var_304_13

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_5 + var_304_13 and arg_301_1.time_ < var_304_5 + var_304_13 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play115131075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 115131075
		arg_305_1.duration_ = 10.43

		local var_305_0 = {
			ja = 9.8,
			ko = 8.266,
			zh = 7.9,
			en = 10.433
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
				arg_305_0:Play115131076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1052ui_story"]) and arg_305_1.var_.characterEffect1052ui_story == nil then
				arg_305_1.var_.characterEffect1052ui_story = arg_305_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1052ui_story"]) then
				if arg_305_1.var_.characterEffect1052ui_story and not isNil(arg_305_1.actors_["1052ui_story"]) then
					arg_305_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1052ui_story"]) and arg_305_1.var_.characterEffect1052ui_story then
				arg_305_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_308_1 = arg_305_1.actors_["1024ui_story"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1024ui_story = var_308_1.localPosition
			end

			local var_308_2 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 then
				var_308_1.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_305_1.time_ - 0) / var_308_2)
				var_308_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_1.position).x, (manager.ui.mainCamera.transform.position - var_308_1.position).y, (manager.ui.mainCamera.transform.position - var_308_1.position).z)
				var_308_1.localEulerAngles.z = 0
				var_308_1.localEulerAngles.x = 0
				var_308_1.localEulerAngles = var_308_1.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 then
				var_308_1.localPosition = Vector3.New(0, 100, 0)
				var_308_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_1.position).x, (manager.ui.mainCamera.transform.position - var_308_1.position).y, (manager.ui.mainCamera.transform.position - var_308_1.position).z)
				var_308_1.localEulerAngles.z = 0
				var_308_1.localEulerAngles.x = 0
				var_308_1.localEulerAngles = var_308_1.localEulerAngles
			end

			local var_308_3 = arg_305_1.actors_["1017ui_story"].transform

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.var_.moveOldPos1017ui_story = var_308_3.localPosition
			end

			local var_308_4 = 0.001

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				var_308_3.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1017ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_305_1.time_ - 0) / var_308_4)
				var_308_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_3.position).x, (manager.ui.mainCamera.transform.position - var_308_3.position).y, (manager.ui.mainCamera.transform.position - var_308_3.position).z)
				var_308_3.localEulerAngles.z = 0
				var_308_3.localEulerAngles.x = 0
				var_308_3.localEulerAngles = var_308_3.localEulerAngles
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				var_308_3.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_308_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_308_3.position).x, (manager.ui.mainCamera.transform.position - var_308_3.position).y, (manager.ui.mainCamera.transform.position - var_308_3.position).z)
				var_308_3.localEulerAngles.z = 0
				var_308_3.localEulerAngles.x = 0
				var_308_3.localEulerAngles = var_308_3.localEulerAngles
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_308_5 = arg_305_1.actors_["1017ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_5) and arg_305_1.var_.characterEffect1017ui_story == nil then
				arg_305_1.var_.characterEffect1017ui_story = var_308_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_6 = 0.2

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_6 and not isNil(var_308_5) then
				if arg_305_1.var_.characterEffect1017ui_story and not isNil(var_308_5) then
					arg_305_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_6 and arg_305_1.time_ < 0 + var_308_6 + arg_308_0 and not isNil(var_308_5) and arg_305_1.var_.characterEffect1017ui_story then
				arg_305_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_308_8 = 0
			local var_308_9 = 1.075

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_10 = arg_305_1:GetWordFromCfg(115131075)
				local var_308_11 = arg_305_1:FormatText(var_308_10.content)

				arg_305_1.text_.text = var_308_11

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_13 = 43 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 43)

				if (43 <= 0 and var_308_9 or var_308_9 * (utf8.len(var_308_11) / 43)) > 0 and var_308_9 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_8
					end
				end

				arg_305_1.text_.text = var_308_11
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131075", "story_v_out_115131.awb") ~= 0 then
					local var_308_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131075", "story_v_out_115131.awb") / 1000

					if var_308_14 + var_308_8 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_14 + var_308_8
					end

					if var_308_10.prefab_name ~= "" and arg_305_1.actors_[var_308_10.prefab_name] ~= nil then
						local var_308_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_10.prefab_name].transform, "story_v_out_115131", "115131075", "story_v_out_115131.awb")

						arg_305_1:RecordAudio("115131075", var_308_15)
						arg_305_1:RecordAudio("115131075", var_308_15)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_115131", "115131075", "story_v_out_115131.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_115131", "115131075", "story_v_out_115131.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_16 = math.max(var_308_9, arg_305_1.talkMaxDuration)

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_16 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_8) / var_308_16

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_8 + var_308_16 and arg_305_1.time_ < var_308_8 + var_308_16 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play115131076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 115131076
		arg_309_1.duration_ = 8.83

		local var_309_0 = {
			ja = 8.833,
			ko = 8.833,
			zh = 6.233,
			en = 7.366
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
				arg_309_0:Play115131077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1017ui_story"]) and arg_309_1.var_.characterEffect1017ui_story == nil then
				arg_309_1.var_.characterEffect1017ui_story = arg_309_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.2

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1017ui_story"]) then
				if arg_309_1.var_.characterEffect1017ui_story and not isNil(arg_309_1.actors_["1017ui_story"]) then
					arg_309_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_0)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1017ui_story"]) and arg_309_1.var_.characterEffect1017ui_story then
				arg_309_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_312_1 = 0
			local var_312_2 = 0.75

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(115131076)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_6 = 30 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_4) / 30)

				if (30 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_4) / 30)) > 0 and var_312_2 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131076", "story_v_out_115131.awb") ~= 0 then
					local var_312_7 = manager.audio:GetVoiceLength("story_v_out_115131", "115131076", "story_v_out_115131.awb") / 1000

					if var_312_7 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_1
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_115131", "115131076", "story_v_out_115131.awb")

						arg_309_1:RecordAudio("115131076", var_312_8)
						arg_309_1:RecordAudio("115131076", var_312_8)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_115131", "115131076", "story_v_out_115131.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_115131", "115131076", "story_v_out_115131.awb")
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
	Play115131077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 115131077
		arg_313_1.duration_ = 2.33

		local var_313_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.333
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
				arg_313_0:Play115131078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_316_0 = arg_313_1.actors_["1017ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1017ui_story == nil then
				arg_313_1.var_.characterEffect1017ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_1 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 and not isNil(var_316_0) then
				if arg_313_1.var_.characterEffect1017ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1017ui_story then
				arg_313_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_316_3 = 0
			local var_316_4 = 0.175

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_5 = arg_313_1:GetWordFromCfg(115131077)
				local var_316_6 = arg_313_1:FormatText(var_316_5.content)

				arg_313_1.text_.text = var_316_6

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_8 = 7 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_6) / 7)

				if (7 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_6) / 7)) > 0 and var_316_4 < var_316_8 then
					arg_313_1.talkMaxDuration = var_316_8

					if var_316_8 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_3
					end
				end

				arg_313_1.text_.text = var_316_6
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131077", "story_v_out_115131.awb") ~= 0 then
					local var_316_9 = manager.audio:GetVoiceLength("story_v_out_115131", "115131077", "story_v_out_115131.awb") / 1000

					if var_316_9 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_3
					end

					if var_316_5.prefab_name ~= "" and arg_313_1.actors_[var_316_5.prefab_name] ~= nil then
						local var_316_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_5.prefab_name].transform, "story_v_out_115131", "115131077", "story_v_out_115131.awb")

						arg_313_1:RecordAudio("115131077", var_316_10)
						arg_313_1:RecordAudio("115131077", var_316_10)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_115131", "115131077", "story_v_out_115131.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_115131", "115131077", "story_v_out_115131.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_11 = math.max(var_316_4, arg_313_1.talkMaxDuration)

			if var_316_3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_3 + var_316_11 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_3) / var_316_11

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_3 + var_316_11 and arg_313_1.time_ < var_316_3 + var_316_11 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play115131078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 115131078
		arg_317_1.duration_ = 10.03

		local var_317_0 = {
			ja = 9.4,
			ko = 7,
			zh = 10.033,
			en = 8.7
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
				arg_317_0:Play115131079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_2")
			end

			local var_320_0 = arg_317_1.actors_["1017ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1017ui_story == nil then
				arg_317_1.var_.characterEffect1017ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_1 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_1 and not isNil(var_320_0) then
				if arg_317_1.var_.characterEffect1017ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_1)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_1 and arg_317_1.time_ < 0 + var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1017ui_story then
				arg_317_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_320_2 = arg_317_1.actors_["1052ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1052ui_story == nil then
				arg_317_1.var_.characterEffect1052ui_story = var_320_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_3 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.characterEffect1052ui_story and not isNil(var_320_2) then
					arg_317_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect1052ui_story then
				arg_317_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_320_5 = 0
			local var_320_6 = 0.9

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_7 = arg_317_1:GetWordFromCfg(115131078)
				local var_320_8 = arg_317_1:FormatText(var_320_7.content)

				arg_317_1.text_.text = var_320_8

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 36 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 36)

				if (36 <= 0 and var_320_6 or var_320_6 * (utf8.len(var_320_8) / 36)) > 0 and var_320_6 < var_320_10 then
					arg_317_1.talkMaxDuration = var_320_10

					if var_320_10 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_5
					end
				end

				arg_317_1.text_.text = var_320_8
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131078", "story_v_out_115131.awb") ~= 0 then
					local var_320_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131078", "story_v_out_115131.awb") / 1000

					if var_320_11 + var_320_5 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_5
					end

					if var_320_7.prefab_name ~= "" and arg_317_1.actors_[var_320_7.prefab_name] ~= nil then
						local var_320_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_7.prefab_name].transform, "story_v_out_115131", "115131078", "story_v_out_115131.awb")

						arg_317_1:RecordAudio("115131078", var_320_12)
						arg_317_1:RecordAudio("115131078", var_320_12)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_115131", "115131078", "story_v_out_115131.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_115131", "115131078", "story_v_out_115131.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_13 = math.max(var_320_6, arg_317_1.talkMaxDuration)

			if var_320_5 <= arg_317_1.time_ and arg_317_1.time_ < var_320_5 + var_320_13 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_5) / var_320_13

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_5 + var_320_13 and arg_317_1.time_ < var_320_5 + var_320_13 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play115131079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 115131079
		arg_321_1.duration_ = 6.6

		local var_321_0 = {
			ja = 6.6,
			ko = 3.633,
			zh = 3.433,
			en = 3.866
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
				arg_321_0:Play115131080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_324_0 = arg_321_1.actors_["1017ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1017ui_story == nil then
				arg_321_1.var_.characterEffect1017ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_1 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_1 and not isNil(var_324_0) then
				if arg_321_1.var_.characterEffect1017ui_story and not isNil(var_324_0) then
					arg_321_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_1 and arg_321_1.time_ < 0 + var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1017ui_story then
				arg_321_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_324_3 = arg_321_1.actors_["1052ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1052ui_story == nil then
				arg_321_1.var_.characterEffect1052ui_story = var_324_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_4 = 0.2

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 and not isNil(var_324_3) then
				if arg_321_1.var_.characterEffect1052ui_story and not isNil(var_324_3) then
					arg_321_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_4)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1052ui_story then
				arg_321_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_2")
			end

			local var_324_5 = 0
			local var_324_6 = 0.4

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(115131079)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 16 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 16)

				if (16 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 16)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131079", "story_v_out_115131.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131079", "story_v_out_115131.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_115131", "115131079", "story_v_out_115131.awb")

						arg_321_1:RecordAudio("115131079", var_324_12)
						arg_321_1:RecordAudio("115131079", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_115131", "115131079", "story_v_out_115131.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_115131", "115131079", "story_v_out_115131.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_13 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_13

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_13 and arg_321_1.time_ < var_324_5 + var_324_13 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play115131080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 115131080
		arg_325_1.duration_ = 5.63

		local var_325_0 = {
			ja = 4.466,
			ko = 5.633,
			zh = 4.533,
			en = 4.5
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
				arg_325_0:Play115131081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_328_0 = arg_325_1.actors_["1017ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1017ui_story == nil then
				arg_325_1.var_.characterEffect1017ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_1 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_1 and not isNil(var_328_0) then
				if arg_325_1.var_.characterEffect1017ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_1)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_1 and arg_325_1.time_ < 0 + var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1017ui_story then
				arg_325_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_328_2 = arg_325_1.actors_["1052ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.characterEffect1052ui_story == nil then
				arg_325_1.var_.characterEffect1052ui_story = var_328_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_3 = 0.2

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_3 and not isNil(var_328_2) then
				if arg_325_1.var_.characterEffect1052ui_story and not isNil(var_328_2) then
					arg_325_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_3 and arg_325_1.time_ < 0 + var_328_3 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.characterEffect1052ui_story then
				arg_325_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_328_5 = 0
			local var_328_6 = 0.425

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_7 = arg_325_1:GetWordFromCfg(115131080)
				local var_328_8 = arg_325_1:FormatText(var_328_7.content)

				arg_325_1.text_.text = var_328_8

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_10 = 17 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 17)

				if (17 <= 0 and var_328_6 or var_328_6 * (utf8.len(var_328_8) / 17)) > 0 and var_328_6 < var_328_10 then
					arg_325_1.talkMaxDuration = var_328_10

					if var_328_10 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_5
					end
				end

				arg_325_1.text_.text = var_328_8
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131080", "story_v_out_115131.awb") ~= 0 then
					local var_328_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131080", "story_v_out_115131.awb") / 1000

					if var_328_11 + var_328_5 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_5
					end

					if var_328_7.prefab_name ~= "" and arg_325_1.actors_[var_328_7.prefab_name] ~= nil then
						local var_328_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_7.prefab_name].transform, "story_v_out_115131", "115131080", "story_v_out_115131.awb")

						arg_325_1:RecordAudio("115131080", var_328_12)
						arg_325_1:RecordAudio("115131080", var_328_12)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_115131", "115131080", "story_v_out_115131.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_115131", "115131080", "story_v_out_115131.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_13 = math.max(var_328_6, arg_325_1.talkMaxDuration)

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_13 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_5) / var_328_13

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_5 + var_328_13 and arg_325_1.time_ < var_328_5 + var_328_13 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play115131081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 115131081
		arg_329_1.duration_ = 7.3

		local var_329_0 = {
			ja = 4.333,
			ko = 3.666,
			zh = 2.7,
			en = 7.3
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
				arg_329_0:Play115131082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1052ui_story"]) and arg_329_1.var_.characterEffect1052ui_story == nil then
				arg_329_1.var_.characterEffect1052ui_story = arg_329_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1052ui_story"]) then
				if arg_329_1.var_.characterEffect1052ui_story and not isNil(arg_329_1.actors_["1052ui_story"]) then
					arg_329_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1052ui_story"]) and arg_329_1.var_.characterEffect1052ui_story then
				arg_329_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_332_1 = arg_329_1.actors_["1017ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1017ui_story = var_332_1.localPosition
			end

			local var_332_2 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 then
				var_332_1.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_2)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 then
				var_332_1.localPosition = Vector3.New(0, 100, 0)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			local var_332_3 = arg_329_1.actors_["1024ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1024ui_story = var_332_3.localPosition
			end

			local var_332_4 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				var_332_3.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_329_1.time_ - 0) / var_332_4)
				var_332_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_3.position).x, (manager.ui.mainCamera.transform.position - var_332_3.position).y, (manager.ui.mainCamera.transform.position - var_332_3.position).z)
				var_332_3.localEulerAngles.z = 0
				var_332_3.localEulerAngles.x = 0
				var_332_3.localEulerAngles = var_332_3.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_332_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_3.position).x, (manager.ui.mainCamera.transform.position - var_332_3.position).y, (manager.ui.mainCamera.transform.position - var_332_3.position).z)
				var_332_3.localEulerAngles.z = 0
				var_332_3.localEulerAngles.x = 0
				var_332_3.localEulerAngles = var_332_3.localEulerAngles
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_332_5 = arg_329_1.actors_["1024ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1024ui_story == nil then
				arg_329_1.var_.characterEffect1024ui_story = var_332_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_6 = 0.2

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_6 and not isNil(var_332_5) then
				if arg_329_1.var_.characterEffect1024ui_story and not isNil(var_332_5) then
					arg_329_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_6 and arg_329_1.time_ < 0 + var_332_6 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1024ui_story then
				arg_329_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_332_8 = 0
			local var_332_9 = 0.275

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(115131081)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 11 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 11)

				if (11 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 11)) > 0 and var_332_9 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131081", "story_v_out_115131.awb") ~= 0 then
					local var_332_14 = manager.audio:GetVoiceLength("story_v_out_115131", "115131081", "story_v_out_115131.awb") / 1000

					if var_332_14 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_8
					end

					if var_332_10.prefab_name ~= "" and arg_329_1.actors_[var_332_10.prefab_name] ~= nil then
						local var_332_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_10.prefab_name].transform, "story_v_out_115131", "115131081", "story_v_out_115131.awb")

						arg_329_1:RecordAudio("115131081", var_332_15)
						arg_329_1:RecordAudio("115131081", var_332_15)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_115131", "115131081", "story_v_out_115131.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_115131", "115131081", "story_v_out_115131.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_16 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_16 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_16

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_16 and arg_329_1.time_ < var_332_8 + var_332_16 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play115131082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 115131082
		arg_333_1.duration_ = 11.83

		local var_333_0 = {
			ja = 11.833,
			ko = 9.633,
			zh = 9.566,
			en = 8.2
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
				arg_333_0:Play115131083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_336_0 = arg_333_1.actors_["1024ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1024ui_story == nil then
				arg_333_1.var_.characterEffect1024ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_1 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_1 and not isNil(var_336_0) then
				if arg_333_1.var_.characterEffect1024ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_1)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_1 and arg_333_1.time_ < 0 + var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1024ui_story then
				arg_333_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_336_2 = arg_333_1.actors_["1052ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1052ui_story == nil then
				arg_333_1.var_.characterEffect1052ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.characterEffect1052ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1052ui_story then
				arg_333_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			local var_336_5 = 0
			local var_336_6 = 1.25

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_7 = arg_333_1:GetWordFromCfg(115131082)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 50 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 50)

				if (50 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 50)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131082", "story_v_out_115131.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131082", "story_v_out_115131.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_out_115131", "115131082", "story_v_out_115131.awb")

						arg_333_1:RecordAudio("115131082", var_336_12)
						arg_333_1:RecordAudio("115131082", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_115131", "115131082", "story_v_out_115131.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_115131", "115131082", "story_v_out_115131.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_13 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_13 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_13

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_13 and arg_333_1.time_ < var_336_5 + var_336_13 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play115131083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 115131083
		arg_337_1.duration_ = 9.1

		local var_337_0 = {
			ja = 9.1,
			ko = 8.266,
			zh = 5.6,
			en = 6.7
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
				arg_337_0:Play115131084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1024ui_story"]) and arg_337_1.var_.characterEffect1024ui_story == nil then
				arg_337_1.var_.characterEffect1024ui_story = arg_337_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1024ui_story"]) then
				if arg_337_1.var_.characterEffect1024ui_story and not isNil(arg_337_1.actors_["1024ui_story"]) then
					arg_337_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1024ui_story"]) and arg_337_1.var_.characterEffect1024ui_story then
				arg_337_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_340_2 = arg_337_1.actors_["1052ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect1052ui_story == nil then
				arg_337_1.var_.characterEffect1052ui_story = var_340_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_3 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.characterEffect1052ui_story and not isNil(var_340_2) then
					arg_337_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_3)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect1052ui_story then
				arg_337_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_340_4 = 0
			local var_340_5 = 0.6

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(115131083)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 24 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 24)

				if (24 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 24)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131083", "story_v_out_115131.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_out_115131", "115131083", "story_v_out_115131.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_out_115131", "115131083", "story_v_out_115131.awb")

						arg_337_1:RecordAudio("115131083", var_340_11)
						arg_337_1:RecordAudio("115131083", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_115131", "115131083", "story_v_out_115131.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_115131", "115131083", "story_v_out_115131.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play115131084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 115131084
		arg_341_1.duration_ = 8.83

		local var_341_0 = {
			ja = 8.833,
			ko = 5.4,
			zh = 6.4,
			en = 7.7
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
				arg_341_0:Play115131085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_344_0 = arg_341_1.actors_["1024ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1024ui_story == nil then
				arg_341_1.var_.characterEffect1024ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_1 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_1 and not isNil(var_344_0) then
				if arg_341_1.var_.characterEffect1024ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_1)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_1 and arg_341_1.time_ < 0 + var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect1024ui_story then
				arg_341_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_344_2 = arg_341_1.actors_["1052ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1052ui_story == nil then
				arg_341_1.var_.characterEffect1052ui_story = var_344_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_3 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.characterEffect1052ui_story and not isNil(var_344_2) then
					arg_341_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect1052ui_story then
				arg_341_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_344_5 = 0
			local var_344_6 = 0.625

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_7 = arg_341_1:GetWordFromCfg(115131084)
				local var_344_8 = arg_341_1:FormatText(var_344_7.content)

				arg_341_1.text_.text = var_344_8

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_10 = 25 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_8) / 25)

				if (25 <= 0 and var_344_6 or var_344_6 * (utf8.len(var_344_8) / 25)) > 0 and var_344_6 < var_344_10 then
					arg_341_1.talkMaxDuration = var_344_10

					if var_344_10 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_5
					end
				end

				arg_341_1.text_.text = var_344_8
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131084", "story_v_out_115131.awb") ~= 0 then
					local var_344_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131084", "story_v_out_115131.awb") / 1000

					if var_344_11 + var_344_5 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_11 + var_344_5
					end

					if var_344_7.prefab_name ~= "" and arg_341_1.actors_[var_344_7.prefab_name] ~= nil then
						local var_344_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_7.prefab_name].transform, "story_v_out_115131", "115131084", "story_v_out_115131.awb")

						arg_341_1:RecordAudio("115131084", var_344_12)
						arg_341_1:RecordAudio("115131084", var_344_12)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_115131", "115131084", "story_v_out_115131.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_115131", "115131084", "story_v_out_115131.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_13 = math.max(var_344_6, arg_341_1.talkMaxDuration)

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_13 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_5) / var_344_13

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_5 + var_344_13 and arg_341_1.time_ < var_344_5 + var_344_13 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play115131085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 115131085
		arg_345_1.duration_ = 4.17

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play115131086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1052ui_story"]) and arg_345_1.var_.characterEffect1052ui_story == nil then
				arg_345_1.var_.characterEffect1052ui_story = arg_345_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1052ui_story"]) then
				if arg_345_1.var_.characterEffect1052ui_story and not isNil(arg_345_1.actors_["1052ui_story"]) then
					arg_345_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1052ui_story"]) and arg_345_1.var_.characterEffect1052ui_story then
				arg_345_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_348_1 = arg_345_1.actors_["1024ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1024ui_story = var_348_1.localPosition
			end

			local var_348_2 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 then
				var_348_1.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_2)
				var_348_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_1.position).x, (manager.ui.mainCamera.transform.position - var_348_1.position).y, (manager.ui.mainCamera.transform.position - var_348_1.position).z)
				var_348_1.localEulerAngles.z = 0
				var_348_1.localEulerAngles.x = 0
				var_348_1.localEulerAngles = var_348_1.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 then
				var_348_1.localPosition = Vector3.New(0, 100, 0)
				var_348_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_1.position).x, (manager.ui.mainCamera.transform.position - var_348_1.position).y, (manager.ui.mainCamera.transform.position - var_348_1.position).z)
				var_348_1.localEulerAngles.z = 0
				var_348_1.localEulerAngles.x = 0
				var_348_1.localEulerAngles = var_348_1.localEulerAngles
			end

			local var_348_3 = arg_345_1.actors_["1052ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1052ui_story = var_348_3.localPosition
			end

			local var_348_4 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_4 then
				var_348_3.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_4)
				var_348_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_3.position).x, (manager.ui.mainCamera.transform.position - var_348_3.position).y, (manager.ui.mainCamera.transform.position - var_348_3.position).z)
				var_348_3.localEulerAngles.z = 0
				var_348_3.localEulerAngles.x = 0
				var_348_3.localEulerAngles = var_348_3.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_4 and arg_345_1.time_ < 0 + var_348_4 + arg_348_0 then
				var_348_3.localPosition = Vector3.New(0, 100, 0)
				var_348_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_3.position).x, (manager.ui.mainCamera.transform.position - var_348_3.position).y, (manager.ui.mainCamera.transform.position - var_348_3.position).z)
				var_348_3.localEulerAngles.z = 0
				var_348_3.localEulerAngles.x = 0
				var_348_3.localEulerAngles = var_348_3.localEulerAngles
			end

			local var_348_5 = 0
			local var_348_6 = 0.075

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[266].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024_1")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_7 = arg_345_1:GetWordFromCfg(115131085)
				local var_348_8 = arg_345_1:FormatText(var_348_7.content)

				arg_345_1.text_.text = var_348_8

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 3 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 3)

				if (3 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 3)) > 0 and var_348_6 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_5
					end
				end

				arg_345_1.text_.text = var_348_8
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115131", "115131085", "story_v_out_115131.awb") ~= 0 then
					local var_348_11 = manager.audio:GetVoiceLength("story_v_out_115131", "115131085", "story_v_out_115131.awb") / 1000

					if var_348_11 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_5
					end

					if var_348_7.prefab_name ~= "" and arg_345_1.actors_[var_348_7.prefab_name] ~= nil then
						local var_348_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_7.prefab_name].transform, "story_v_out_115131", "115131085", "story_v_out_115131.awb")

						arg_345_1:RecordAudio("115131085", var_348_12)
						arg_345_1:RecordAudio("115131085", var_348_12)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_115131", "115131085", "story_v_out_115131.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_115131", "115131085", "story_v_out_115131.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_6, arg_345_1.talkMaxDuration)

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_5) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_5 + var_348_13 and arg_345_1.time_ < var_348_5 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play115131086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 115131086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play115131087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.775

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(115131086).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 31 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 31)

				if (31 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 31)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play115131087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 115131087
		arg_353_1.duration_ = 7

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
			arg_353_1.auto_ = false
		end

		function arg_353_1.playNext_(arg_355_0)
			arg_353_1.onStoryFinished_()
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = false

				arg_353_1:SetGaussion(false)
			end

			local var_356_0 = 2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				local var_356_1 = Color.New(1, 1, 1)

				var_356_1.a = Mathf.Lerp(1, 0, (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.mask_.color = var_356_1
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				local var_356_2 = Color.New(1, 1, 1)

				arg_353_1.mask_.enabled = false
				var_356_2.a = 0
				arg_353_1.mask_.color = var_356_2
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_3 = 2
			local var_356_4 = 0.85

			if 2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_3 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_5 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_5:setOnUpdate(LuaHelper.FloatAction(function(arg_357_0)
					arg_353_1.dialogCg_.alpha = arg_357_0
				end))
				var_356_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(115131087).content)

				arg_353_1.text_.text = var_356_6

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_8 = 34 <= 0 and var_356_4 or var_356_4 * (utf8.len(var_356_6) / 34)

				if (34 <= 0 and var_356_4 or var_356_4 * (utf8.len(var_356_6) / 34)) > 0 and var_356_4 < var_356_8 then
					arg_353_1.talkMaxDuration = var_356_8
					var_356_3 = var_356_3 + 0.3

					if var_356_8 + var_356_3 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_3
					end
				end

				arg_353_1.text_.text = var_356_6
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_9 = var_356_3 + 0.3
			local var_356_10 = math.max(var_356_4, arg_353_1.talkMaxDuration)

			if var_356_3 + 0.3 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_9) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_9 + var_356_10 and arg_353_1.time_ < var_356_9 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/G03a",
		"TextureConfig/Background/RO0201"
	},
	voices = {
		"story_v_out_115131.awb"
	}
}
