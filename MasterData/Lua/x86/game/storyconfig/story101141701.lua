return {
	Play114171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114171001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F07 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F07")
				var_4_0.name = "F07"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F07 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F07

				arg_1_1.bgs_.F07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F07" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_14 = 2
			local var_4_15 = 1.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(114171001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 50 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 50)

				if (50 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 50)) > 0 and var_4_15 < var_4_19 then
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
	Play114171002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114171002
		arg_9_1.duration_ = 11.23

		local var_9_0 = {
			ja = 9.333,
			ko = 7.2,
			zh = 9.933,
			en = 11.233
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
				arg_9_0:Play114171003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.025

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(114171002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 41)

				if (41 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 41)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171002", "story_v_out_114171.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_114171", "114171002", "story_v_out_114171.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_114171", "114171002", "story_v_out_114171.awb")

						arg_9_1:RecordAudio("114171002", var_12_6)
						arg_9_1:RecordAudio("114171002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114171", "114171002", "story_v_out_114171.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114171", "114171002", "story_v_out_114171.awb")
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
	Play114171003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114171003
		arg_13_1.duration_ = 2

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114171004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1041ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1041ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1041ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1041ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1041ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1041ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1041ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_5 = arg_13_1.actors_["1041ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1041ui_story == nil then
				arg_13_1.var_.characterEffect1041ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1041ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1041ui_story then
				arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_16_8 = 0
			local var_16_9 = 0.1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(114171003)
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

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171003", "story_v_out_114171.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_114171", "114171003", "story_v_out_114171.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_114171", "114171003", "story_v_out_114171.awb")

						arg_13_1:RecordAudio("114171003", var_16_15)
						arg_13_1:RecordAudio("114171003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114171", "114171003", "story_v_out_114171.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114171", "114171003", "story_v_out_114171.awb")
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play114171004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114171004
		arg_17_1.duration_ = 10.43

		local var_17_0 = {
			ja = 8.7,
			ko = 10.433,
			zh = 9.966,
			en = 10.233
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
				arg_17_0:Play114171005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) and arg_17_1.var_.characterEffect1041ui_story == nil then
				arg_17_1.var_.characterEffect1041ui_story = arg_17_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) then
				if arg_17_1.var_.characterEffect1041ui_story and not isNil(arg_17_1.actors_["1041ui_story"]) then
					arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) and arg_17_1.var_.characterEffect1041ui_story then
				arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_20_1 = "1038ui_story"

			if arg_17_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_17_1.stage_.transform)

				var_20_2.name = var_20_1
				var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_1] = var_20_2

				local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

				var_20_3.enabled = true

				local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

				if var_20_4 then
					var_20_4:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_3.transform, false)

				arg_17_1.var_[var_20_1 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_1 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_1 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_5 = arg_17_1.actors_["1038ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1038ui_story = var_20_5.localPosition
			end

			local var_20_6 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_17_1.time_ - 0) / var_20_6)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_7 = arg_17_1.actors_["1038ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1038ui_story == nil then
				arg_17_1.var_.characterEffect1038ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect1038ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1038ui_story then
				arg_17_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_20_10 = 0
			local var_20_11 = 1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(114171004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 40 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 40)

				if (40 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 40)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171004", "story_v_out_114171.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_114171", "114171004", "story_v_out_114171.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_114171", "114171004", "story_v_out_114171.awb")

						arg_17_1:RecordAudio("114171004", var_20_17)
						arg_17_1:RecordAudio("114171004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114171", "114171004", "story_v_out_114171.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114171", "114171004", "story_v_out_114171.awb")
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
				actorName = "1038ui_story",
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
	Play114171005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114171005
		arg_21_1.duration_ = 12.37

		local var_21_0 = {
			ja = 10.333,
			ko = 11.733,
			zh = 12.366,
			en = 12.133
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
				arg_21_0:Play114171006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1038ui_story = arg_21_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).z)
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles = arg_21_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1038ui_story"].transform.position).z)
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1038ui_story"].transform.localEulerAngles = arg_21_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1041ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1041ui_story = var_24_1.localPosition
			end

			local var_24_2 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 then
				var_24_1.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_2)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 then
				var_24_1.localPosition = Vector3.New(0, 100, 0)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			local var_24_3 = 0
			local var_24_4 = 1.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_5 = arg_21_1:GetWordFromCfg(114171005)
				local var_24_6 = arg_21_1:FormatText(var_24_5.content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 51 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_6) / 51)

				if (51 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_6) / 51)) > 0 and var_24_4 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171005", "story_v_out_114171.awb") ~= 0 then
					local var_24_9 = manager.audio:GetVoiceLength("story_v_out_114171", "114171005", "story_v_out_114171.awb") / 1000

					if var_24_9 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_3
					end

					if var_24_5.prefab_name ~= "" and arg_21_1.actors_[var_24_5.prefab_name] ~= nil then
						local var_24_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_5.prefab_name].transform, "story_v_out_114171", "114171005", "story_v_out_114171.awb")

						arg_21_1:RecordAudio("114171005", var_24_10)
						arg_21_1:RecordAudio("114171005", var_24_10)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114171", "114171005", "story_v_out_114171.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114171", "114171005", "story_v_out_114171.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_11 and arg_21_1.time_ < var_24_3 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114171006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114171006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114171007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
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

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(114171006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 13)

				if (13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 13)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114171007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114171007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play114171008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.475

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(114171007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 19 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 19)

				if (19 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 19)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114171008
		arg_33_1.duration_ = 10.87

		local var_33_0 = {
			ja = 10.866,
			ko = 6.966,
			zh = 9.066,
			en = 8.1
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
				arg_33_0:Play114171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["10005ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10005ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "10005ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "10005ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["10005ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["10005ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["10005ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["10005ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["10005ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10005ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10005ui_story, Vector3.New(0, -0.95, -5.88), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_36_5 = "10005_tpose"

			if arg_33_1.actors_["10005_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10005_tpose"))) then
				local var_36_6 = Object.Instantiate(Asset.Load("Char/" .. "10005_tpose"), arg_33_1.stage_.transform)

				var_36_6.name = var_36_5
				var_36_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_[var_36_5] = var_36_6

				local var_36_7 = var_36_6:GetComponentInChildren(typeof(CharacterEffect))

				var_36_7.enabled = true

				local var_36_8 = GameObjectTools.GetOrAddComponent(var_36_6, typeof(DynamicBoneHelper))

				if var_36_8 then
					var_36_8:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_7.transform, false)

				arg_33_1.var_[var_36_5 .. "Animator"] = var_36_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_[var_36_5 .. "Animator"].applyRootMotion = true
				arg_33_1.var_[var_36_5 .. "LipSync"] = var_36_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_9 = arg_33_1.actors_["10005_tpose"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10005_tpose == nil then
				arg_33_1.var_.characterEffect10005_tpose = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_10 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_10 and not isNil(var_36_9) then
				if arg_33_1.var_.characterEffect10005_tpose and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_10 and arg_33_1.time_ < 0 + var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10005_tpose then
				arg_33_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_36_12 = 0
			local var_36_13 = 0.9

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(114171008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 36 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 36)

				if (36 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 36)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171008", "story_v_out_114171.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_114171", "114171008", "story_v_out_114171.awb") / 1000

					if var_36_18 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_12
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_114171", "114171008", "story_v_out_114171.awb")

						arg_33_1:RecordAudio("114171008", var_36_19)
						arg_33_1:RecordAudio("114171008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114171", "114171008", "story_v_out_114171.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114171", "114171008", "story_v_out_114171.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_20 and arg_33_1.time_ < var_36_12 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play114171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114171009
		arg_37_1.duration_ = 6.97

		local var_37_0 = {
			ja = 5.9,
			ko = 6.966,
			zh = 6.733,
			en = 5.433
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
				arg_37_0:Play114171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_40_0 = 0
			local var_40_1 = 0.775

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(114171009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 31 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 31)

				if (31 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 31)) > 0 and var_40_1 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171009", "story_v_out_114171.awb") ~= 0 then
					local var_40_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171009", "story_v_out_114171.awb") / 1000

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end

					if var_40_2.prefab_name ~= "" and arg_37_1.actors_[var_40_2.prefab_name] ~= nil then
						local var_40_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_2.prefab_name].transform, "story_v_out_114171", "114171009", "story_v_out_114171.awb")

						arg_37_1:RecordAudio("114171009", var_40_7)
						arg_37_1:RecordAudio("114171009", var_40_7)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114171", "114171009", "story_v_out_114171.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114171", "114171009", "story_v_out_114171.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114171010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114171010
		arg_41_1.duration_ = 3.37

		local var_41_0 = {
			ja = 2.366,
			ko = 3.333,
			zh = 3.366,
			en = 2.4
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
				arg_41_0:Play114171011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10005ui_story = arg_41_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10005ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10005ui_story"].transform.position).z)
				arg_41_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10005ui_story"].transform.localEulerAngles = arg_41_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10005ui_story"].transform.position).z)
				arg_41_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10005ui_story"].transform.localEulerAngles = arg_41_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			local var_44_1 = "10006ui_story"

			if arg_41_1.actors_["10006ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10006ui_story"))) then
				local var_44_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_41_1.stage_.transform)

				var_44_2.name = var_44_1
				var_44_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_[var_44_1] = var_44_2

				local var_44_3 = var_44_2:GetComponentInChildren(typeof(CharacterEffect))

				var_44_3.enabled = true

				local var_44_4 = GameObjectTools.GetOrAddComponent(var_44_2, typeof(DynamicBoneHelper))

				if var_44_4 then
					var_44_4:EnableDynamicBone(false)
				end

				arg_41_1:ShowWeapon(var_44_3.transform, false)

				arg_41_1.var_[var_44_1 .. "Animator"] = var_44_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_41_1.var_[var_44_1 .. "Animator"].applyRootMotion = true
				arg_41_1.var_[var_44_1 .. "LipSync"] = var_44_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_44_5 = arg_41_1.actors_["10006ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10006ui_story = var_44_5.localPosition
			end

			local var_44_6 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 then
				var_44_5.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10006ui_story, Vector3.New(0, -0.98, -5.65), (arg_41_1.time_ - 0) / var_44_6)
				var_44_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_5.position).x, (manager.ui.mainCamera.transform.position - var_44_5.position).y, (manager.ui.mainCamera.transform.position - var_44_5.position).z)
				var_44_5.localEulerAngles.z = 0
				var_44_5.localEulerAngles.x = 0
				var_44_5.localEulerAngles = var_44_5.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 then
				var_44_5.localPosition = Vector3.New(0, -0.98, -5.65)
				var_44_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_5.position).x, (manager.ui.mainCamera.transform.position - var_44_5.position).y, (manager.ui.mainCamera.transform.position - var_44_5.position).z)
				var_44_5.localEulerAngles.z = 0
				var_44_5.localEulerAngles.x = 0
				var_44_5.localEulerAngles = var_44_5.localEulerAngles
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_7 = arg_41_1.actors_["10006ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.characterEffect10006ui_story == nil then
				arg_41_1.var_.characterEffect10006ui_story = var_44_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_8 and not isNil(var_44_7) then
				if arg_41_1.var_.characterEffect10006ui_story and not isNil(var_44_7) then
					arg_41_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_8 and arg_41_1.time_ < 0 + var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.characterEffect10006ui_story then
				arg_41_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_44_10 = 0
			local var_44_11 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_12 = arg_41_1:GetWordFromCfg(114171010)
				local var_44_13 = arg_41_1:FormatText(var_44_12.content)

				arg_41_1.text_.text = var_44_13

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_15 = 10 <= 0 and var_44_11 or var_44_11 * (utf8.len(var_44_13) / 10)

				if (10 <= 0 and var_44_11 or var_44_11 * (utf8.len(var_44_13) / 10)) > 0 and var_44_11 < var_44_15 then
					arg_41_1.talkMaxDuration = var_44_15

					if var_44_15 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_15 + var_44_10
					end
				end

				arg_41_1.text_.text = var_44_13
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171010", "story_v_out_114171.awb") ~= 0 then
					local var_44_16 = manager.audio:GetVoiceLength("story_v_out_114171", "114171010", "story_v_out_114171.awb") / 1000

					if var_44_16 + var_44_10 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_16 + var_44_10
					end

					if var_44_12.prefab_name ~= "" and arg_41_1.actors_[var_44_12.prefab_name] ~= nil then
						local var_44_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_12.prefab_name].transform, "story_v_out_114171", "114171010", "story_v_out_114171.awb")

						arg_41_1:RecordAudio("114171010", var_44_17)
						arg_41_1:RecordAudio("114171010", var_44_17)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114171", "114171010", "story_v_out_114171.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114171", "114171010", "story_v_out_114171.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_18 = math.max(var_44_11, arg_41_1.talkMaxDuration)

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_18 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_10) / var_44_18

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_10 + var_44_18 and arg_41_1.time_ < var_44_10 + var_44_18 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play114171011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114171011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114171012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10006ui_story"]) and arg_45_1.var_.characterEffect10006ui_story == nil then
				arg_45_1.var_.characterEffect10006ui_story = arg_45_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10006ui_story"]) then
				if arg_45_1.var_.characterEffect10006ui_story and not isNil(arg_45_1.actors_["10006ui_story"]) then
					arg_45_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10006ui_story"]) and arg_45_1.var_.characterEffect10006ui_story then
				arg_45_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.925

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

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(114171011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 37 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 37)

				if (37 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 37)) > 0 and var_48_2 < var_48_5 then
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
	Play114171012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114171012
		arg_49_1.duration_ = 4.43

		local var_49_0 = {
			ja = 3.833,
			ko = 4.433,
			zh = 3.733,
			en = 3.1
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
				arg_49_0:Play114171013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_0 = arg_49_1.actors_["10006ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10006ui_story == nil then
				arg_49_1.var_.characterEffect10006ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(var_52_0) then
				if arg_49_1.var_.characterEffect10006ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10006ui_story then
				arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_52_3 = 0
			local var_52_4 = 0.325

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(114171012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 13 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 13)

				if (13 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 13)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171012", "story_v_out_114171.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_114171", "114171012", "story_v_out_114171.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_114171", "114171012", "story_v_out_114171.awb")

						arg_49_1:RecordAudio("114171012", var_52_10)
						arg_49_1:RecordAudio("114171012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114171", "114171012", "story_v_out_114171.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114171", "114171012", "story_v_out_114171.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_11 and arg_49_1.time_ < var_52_3 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114171013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114171013
		arg_53_1.duration_ = 2.8

		local var_53_0 = {
			ja = 2.8,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_53_0:Play114171014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10006ui_story = arg_53_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10006ui_story"].transform.position).z)
				arg_53_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10006ui_story"].transform.localEulerAngles = arg_53_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10006ui_story"].transform.position).z)
				arg_53_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10006ui_story"].transform.localEulerAngles = arg_53_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10005ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10005ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10005ui_story, Vector3.New(0, -0.95, -5.88), (arg_53_1.time_ - 0) / var_56_2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				var_56_1.localPosition = Vector3.New(0, -0.95, -5.88)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action1_1")
			end

			local var_56_3 = arg_53_1.actors_["10005_tpose"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect10005_tpose == nil then
				arg_53_1.var_.characterEffect10005_tpose = var_56_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_4 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 and not isNil(var_56_3) then
				if arg_53_1.var_.characterEffect10005_tpose and not isNil(var_56_3) then
					arg_53_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 and not isNil(var_56_3) and arg_53_1.var_.characterEffect10005_tpose then
				arg_53_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_6 = 0
			local var_56_7 = 0.125

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(114171013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 5 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 5)

				if (5 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 5)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171013", "story_v_out_114171.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_114171", "114171013", "story_v_out_114171.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_114171", "114171013", "story_v_out_114171.awb")

						arg_53_1:RecordAudio("114171013", var_56_13)
						arg_53_1:RecordAudio("114171013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114171", "114171013", "story_v_out_114171.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114171", "114171013", "story_v_out_114171.awb")
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
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play114171014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114171014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114171015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10005ui_story = arg_57_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10005ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10005ui_story"].transform.position).z)
				arg_57_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10005ui_story"].transform.localEulerAngles = arg_57_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10005ui_story"].transform.position).z)
				arg_57_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10005ui_story"].transform.localEulerAngles = arg_57_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			local var_60_1 = 0
			local var_60_2 = 1.025

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(114171014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 41 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 41)

				if (41 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 41)) > 0 and var_60_2 < var_60_5 then
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

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play114171015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114171015
		arg_61_1.duration_ = 5.77

		local var_61_0 = {
			ja = 5.766,
			ko = 3.233,
			zh = 5.3,
			en = 4.5
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
				arg_61_0:Play114171016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10005ui_story = arg_61_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10005ui_story, Vector3.New(0, -0.95, -5.88), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10005ui_story"].transform.position).z)
				arg_61_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10005ui_story"].transform.localEulerAngles = arg_61_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_61_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10005ui_story"].transform.position).z)
				arg_61_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10005ui_story"].transform.localEulerAngles = arg_61_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10005_tpose"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10005_tpose == nil then
				arg_61_1.var_.characterEffect10005_tpose = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10005_tpose and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10005_tpose then
				arg_61_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_64_4 = 0
			local var_64_5 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(114171015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 16 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 16)

				if (16 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 16)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171015", "story_v_out_114171.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171015", "story_v_out_114171.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_114171", "114171015", "story_v_out_114171.awb")

						arg_61_1:RecordAudio("114171015", var_64_11)
						arg_61_1:RecordAudio("114171015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114171", "114171015", "story_v_out_114171.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114171", "114171015", "story_v_out_114171.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play114171016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114171016
		arg_65_1.duration_ = 10.93

		local var_65_0 = {
			ja = 9.833,
			ko = 8.6,
			zh = 8.466,
			en = 10.933
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
				arg_65_0:Play114171017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_0 = 0
			local var_68_1 = 0.95

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(114171016)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 38 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 38)

				if (38 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 38)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171016", "story_v_out_114171.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171016", "story_v_out_114171.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_out_114171", "114171016", "story_v_out_114171.awb")

						arg_65_1:RecordAudio("114171016", var_68_7)
						arg_65_1:RecordAudio("114171016", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114171", "114171016", "story_v_out_114171.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114171", "114171016", "story_v_out_114171.awb")
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
	Play114171017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114171017
		arg_69_1.duration_ = 17.47

		local var_69_0 = {
			ja = 17.466,
			ko = 16.3,
			zh = 13.833,
			en = 15.3
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
				arg_69_0:Play114171018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005actionlink/10005action445")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_72_0 = 0
			local var_72_1 = 1.625

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(114171017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 65 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 65)

				if (65 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 65)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171017", "story_v_out_114171.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171017", "story_v_out_114171.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_out_114171", "114171017", "story_v_out_114171.awb")

						arg_69_1:RecordAudio("114171017", var_72_7)
						arg_69_1:RecordAudio("114171017", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114171", "114171017", "story_v_out_114171.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114171", "114171017", "story_v_out_114171.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114171018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114171018
		arg_73_1.duration_ = 19.73

		local var_73_0 = {
			ja = 14.4,
			ko = 15.166,
			zh = 19.633,
			en = 19.733
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
				arg_73_0:Play114171019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005actionlink/10005action457")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_76_0 = 0
			local var_76_1 = 1.375

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(114171018)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 55 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 55)

				if (55 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_3) / 55)) > 0 and var_76_1 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171018", "story_v_out_114171.awb") ~= 0 then
					local var_76_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171018", "story_v_out_114171.awb") / 1000

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end

					if var_76_2.prefab_name ~= "" and arg_73_1.actors_[var_76_2.prefab_name] ~= nil then
						local var_76_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_2.prefab_name].transform, "story_v_out_114171", "114171018", "story_v_out_114171.awb")

						arg_73_1:RecordAudio("114171018", var_76_7)
						arg_73_1:RecordAudio("114171018", var_76_7)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114171", "114171018", "story_v_out_114171.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114171", "114171018", "story_v_out_114171.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_8 and arg_73_1.time_ < var_76_0 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114171019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114171019
		arg_77_1.duration_ = 8.03

		local var_77_0 = {
			ja = 8.033,
			ko = 6.466,
			zh = 5.066,
			en = 5.9
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
				arg_77_0:Play114171020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10005_tpose"]) and arg_77_1.var_.characterEffect10005_tpose == nil then
				arg_77_1.var_.characterEffect10005_tpose = arg_77_1.actors_["10005_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10005_tpose"]) then
				if arg_77_1.var_.characterEffect10005_tpose and not isNil(arg_77_1.actors_["10005_tpose"]) then
					arg_77_1.var_.characterEffect10005_tpose.fillFlat = true
					arg_77_1.var_.characterEffect10005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10005_tpose"]) and arg_77_1.var_.characterEffect10005_tpose then
				arg_77_1.var_.characterEffect10005_tpose.fillFlat = true
				arg_77_1.var_.characterEffect10005_tpose.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.7

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(114171019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 28 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 28)

				if (28 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_4) / 28)) > 0 and var_80_2 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171019", "story_v_out_114171.awb") ~= 0 then
					local var_80_7 = manager.audio:GetVoiceLength("story_v_out_114171", "114171019", "story_v_out_114171.awb") / 1000

					if var_80_7 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_1
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_114171", "114171019", "story_v_out_114171.awb")

						arg_77_1:RecordAudio("114171019", var_80_8)
						arg_77_1:RecordAudio("114171019", var_80_8)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114171", "114171019", "story_v_out_114171.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114171", "114171019", "story_v_out_114171.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_9 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_9 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_9

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_9 and arg_77_1.time_ < var_80_1 + var_80_9 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114171020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114171020
		arg_81_1.duration_ = 7.23

		local var_81_0 = {
			ja = 3.766,
			ko = 5.266,
			zh = 7.233,
			en = 4.9
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
				arg_81_0:Play114171021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action7_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_84_0 = 0
			local var_84_1 = 0.525

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:GetWordFromCfg(114171020)
				local var_84_3 = arg_81_1:FormatText(var_84_2.content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 21 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 21)

				if (21 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_3) / 21)) > 0 and var_84_1 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171020", "story_v_out_114171.awb") ~= 0 then
					local var_84_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171020", "story_v_out_114171.awb") / 1000

					if var_84_6 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_6 + var_84_0
					end

					if var_84_2.prefab_name ~= "" and arg_81_1.actors_[var_84_2.prefab_name] ~= nil then
						local var_84_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_2.prefab_name].transform, "story_v_out_114171", "114171020", "story_v_out_114171.awb")

						arg_81_1:RecordAudio("114171020", var_84_7)
						arg_81_1:RecordAudio("114171020", var_84_7)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114171", "114171020", "story_v_out_114171.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114171", "114171020", "story_v_out_114171.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_8 and arg_81_1.time_ < var_84_0 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114171021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114171021
		arg_85_1.duration_ = 4.63

		local var_85_0 = {
			ja = 3.366,
			ko = 3.3,
			zh = 3.666,
			en = 4.633
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
				arg_85_0:Play114171022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10005ui_story = arg_85_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10005ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10005ui_story"].transform.position).z)
				arg_85_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10005ui_story"].transform.localEulerAngles = arg_85_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10005ui_story"].transform.position).z)
				arg_85_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10005ui_story"].transform.localEulerAngles = arg_85_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1038ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1038ui_story = var_88_1.localPosition
			end

			local var_88_2 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 then
				var_88_1.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_85_1.time_ - 0) / var_88_2)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 then
				var_88_1.localPosition = Vector3.New(0, -1.11, -5.9)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_88_3 = arg_85_1.actors_["1038ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1038ui_story == nil then
				arg_85_1.var_.characterEffect1038ui_story = var_88_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 and not isNil(var_88_3) then
				if arg_85_1.var_.characterEffect1038ui_story and not isNil(var_88_3) then
					arg_85_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1038ui_story then
				arg_85_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_88_6 = 0
			local var_88_7 = 0.35

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(114171021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 14 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 14)

				if (14 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 14)) > 0 and var_88_7 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171021", "story_v_out_114171.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_114171", "114171021", "story_v_out_114171.awb") / 1000

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_out_114171", "114171021", "story_v_out_114171.awb")

						arg_85_1:RecordAudio("114171021", var_88_13)
						arg_85_1:RecordAudio("114171021", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114171", "114171021", "story_v_out_114171.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114171", "114171021", "story_v_out_114171.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play114171022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114171022
		arg_89_1.duration_ = 12.63

		local var_89_0 = {
			ja = 9.333,
			ko = 12.633,
			zh = 9.866,
			en = 9.3
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
				arg_89_0:Play114171023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_92_0 = 0
			local var_92_1 = 1.225

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(114171022)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 49 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 49)

				if (49 <= 0 and var_92_1 or var_92_1 * (utf8.len(var_92_3) / 49)) > 0 and var_92_1 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171022", "story_v_out_114171.awb") ~= 0 then
					local var_92_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171022", "story_v_out_114171.awb") / 1000

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end

					if var_92_2.prefab_name ~= "" and arg_89_1.actors_[var_92_2.prefab_name] ~= nil then
						local var_92_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_2.prefab_name].transform, "story_v_out_114171", "114171022", "story_v_out_114171.awb")

						arg_89_1:RecordAudio("114171022", var_92_7)
						arg_89_1:RecordAudio("114171022", var_92_7)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114171", "114171022", "story_v_out_114171.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114171", "114171022", "story_v_out_114171.awb")
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
	Play114171023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114171023
		arg_93_1.duration_ = 11.03

		local var_93_0 = {
			ja = 7.966,
			ko = 8.4,
			zh = 11.033,
			en = 8.366
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
				arg_93_0:Play114171024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1038ui_story = arg_93_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1038ui_story"].transform.position).z)
				arg_93_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1038ui_story"].transform.localEulerAngles = arg_93_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1038ui_story"].transform.position).z)
				arg_93_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1038ui_story"].transform.localEulerAngles = arg_93_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["10005ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10005ui_story = var_96_1.localPosition
			end

			local var_96_2 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 then
				var_96_1.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10005ui_story, Vector3.New(0, -0.95, -5.88), (arg_93_1.time_ - 0) / var_96_2)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 then
				var_96_1.localPosition = Vector3.New(0, -0.95, -5.88)
				var_96_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_1.position).x, (manager.ui.mainCamera.transform.position - var_96_1.position).y, (manager.ui.mainCamera.transform.position - var_96_1.position).z)
				var_96_1.localEulerAngles.z = 0
				var_96_1.localEulerAngles.x = 0
				var_96_1.localEulerAngles = var_96_1.localEulerAngles
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_96_3 = arg_93_1.actors_["10005_tpose"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect10005_tpose == nil then
				arg_93_1.var_.characterEffect10005_tpose = var_96_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_4 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 and not isNil(var_96_3) then
				if arg_93_1.var_.characterEffect10005_tpose and not isNil(var_96_3) then
					arg_93_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect10005_tpose then
				arg_93_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_96_6 = 0
			local var_96_7 = 0.775

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(114171023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 31 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 31)

				if (31 <= 0 and var_96_7 or var_96_7 * (utf8.len(var_96_9) / 31)) > 0 and var_96_7 < var_96_11 then
					arg_93_1.talkMaxDuration = var_96_11

					if var_96_11 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171023", "story_v_out_114171.awb") ~= 0 then
					local var_96_12 = manager.audio:GetVoiceLength("story_v_out_114171", "114171023", "story_v_out_114171.awb") / 1000

					if var_96_12 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_6
					end

					if var_96_8.prefab_name ~= "" and arg_93_1.actors_[var_96_8.prefab_name] ~= nil then
						local var_96_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_8.prefab_name].transform, "story_v_out_114171", "114171023", "story_v_out_114171.awb")

						arg_93_1:RecordAudio("114171023", var_96_13)
						arg_93_1:RecordAudio("114171023", var_96_13)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114171", "114171023", "story_v_out_114171.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114171", "114171023", "story_v_out_114171.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play114171024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114171024
		arg_97_1.duration_ = 15.37

		local var_97_0 = {
			ja = 9.933,
			ko = 13.266,
			zh = 14.166,
			en = 15.366
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
				arg_97_0:Play114171025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_100_0 = 0
			local var_100_1 = 1.375

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(114171024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 55 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 55)

				if (55 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 55)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171024", "story_v_out_114171.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171024", "story_v_out_114171.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_114171", "114171024", "story_v_out_114171.awb")

						arg_97_1:RecordAudio("114171024", var_100_7)
						arg_97_1:RecordAudio("114171024", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_114171", "114171024", "story_v_out_114171.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_114171", "114171024", "story_v_out_114171.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114171025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114171025
		arg_101_1.duration_ = 9.77

		local var_101_0 = {
			ja = 9.766,
			ko = 4.833,
			zh = 5.866,
			en = 5.8
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
				arg_101_0:Play114171026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_104_0 = 0
			local var_104_1 = 0.575

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(114171025)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 23 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 23)

				if (23 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 23)) > 0 and var_104_1 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171025", "story_v_out_114171.awb") ~= 0 then
					local var_104_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171025", "story_v_out_114171.awb") / 1000

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_out_114171", "114171025", "story_v_out_114171.awb")

						arg_101_1:RecordAudio("114171025", var_104_7)
						arg_101_1:RecordAudio("114171025", var_104_7)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114171", "114171025", "story_v_out_114171.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114171", "114171025", "story_v_out_114171.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114171026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114171026
		arg_105_1.duration_ = 8.87

		local var_105_0 = {
			ja = 6.733,
			ko = 8.866,
			zh = 6.733,
			en = 6.4
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
				arg_105_0:Play114171027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10005ui_story = arg_105_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10005ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10005ui_story"].transform.position).z)
				arg_105_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10005ui_story"].transform.localEulerAngles = arg_105_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10005ui_story"].transform.position).z)
				arg_105_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10005ui_story"].transform.localEulerAngles = arg_105_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10006ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10006ui_story = var_108_1.localPosition
			end

			local var_108_2 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 then
				var_108_1.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10006ui_story, Vector3.New(0, -0.98, -5.65), (arg_105_1.time_ - 0) / var_108_2)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 then
				var_108_1.localPosition = Vector3.New(0, -0.98, -5.65)
				var_108_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_1.position).x, (manager.ui.mainCamera.transform.position - var_108_1.position).y, (manager.ui.mainCamera.transform.position - var_108_1.position).z)
				var_108_1.localEulerAngles.z = 0
				var_108_1.localEulerAngles.x = 0
				var_108_1.localEulerAngles = var_108_1.localEulerAngles
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_3 = arg_105_1.actors_["10006ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect10006ui_story == nil then
				arg_105_1.var_.characterEffect10006ui_story = var_108_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 and not isNil(var_108_3) then
				if arg_105_1.var_.characterEffect10006ui_story and not isNil(var_108_3) then
					arg_105_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect10006ui_story then
				arg_105_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_108_6 = 0
			local var_108_7 = 0.7

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(114171026)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 28 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 28)

				if (28 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 28)) > 0 and var_108_7 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171026", "story_v_out_114171.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_114171", "114171026", "story_v_out_114171.awb") / 1000

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_114171", "114171026", "story_v_out_114171.awb")

						arg_105_1:RecordAudio("114171026", var_108_13)
						arg_105_1:RecordAudio("114171026", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114171", "114171026", "story_v_out_114171.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114171", "114171026", "story_v_out_114171.awb")
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
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play114171027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114171027
		arg_109_1.duration_ = 2.2

		local var_109_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
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
				arg_109_0:Play114171028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10006ui_story = arg_109_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10006ui_story"].transform.position).z)
				arg_109_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10006ui_story"].transform.localEulerAngles = arg_109_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10006ui_story"].transform.position).z)
				arg_109_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10006ui_story"].transform.localEulerAngles = arg_109_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["10005ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10005ui_story = var_112_1.localPosition
			end

			local var_112_2 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10005ui_story, Vector3.New(0, -0.95, -5.88), (arg_109_1.time_ - 0) / var_112_2)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 then
				var_112_1.localPosition = Vector3.New(0, -0.95, -5.88)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_2")
			end

			local var_112_3 = arg_109_1.actors_["10005_tpose"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect10005_tpose == nil then
				arg_109_1.var_.characterEffect10005_tpose = var_112_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_4 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 and not isNil(var_112_3) then
				if arg_109_1.var_.characterEffect10005_tpose and not isNil(var_112_3) then
					arg_109_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect10005_tpose then
				arg_109_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_112_6 = 0
			local var_112_7 = 0.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(114171027)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 5 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 5)

				if (5 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 5)) > 0 and var_112_7 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171027", "story_v_out_114171.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_114171", "114171027", "story_v_out_114171.awb") / 1000

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_114171", "114171027", "story_v_out_114171.awb")

						arg_109_1:RecordAudio("114171027", var_112_13)
						arg_109_1:RecordAudio("114171027", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114171", "114171027", "story_v_out_114171.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114171", "114171027", "story_v_out_114171.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play114171028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114171028
		arg_113_1.duration_ = 8.83

		local var_113_0 = {
			ja = 8.833,
			ko = 7.766,
			zh = 6.033,
			en = 8.5
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
				arg_113_0:Play114171029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_1")
			end

			local var_116_0 = 0
			local var_116_1 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:GetWordFromCfg(114171028)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 27 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_3) / 27)

				if (27 <= 0 and var_116_1 or var_116_1 * (utf8.len(var_116_3) / 27)) > 0 and var_116_1 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171028", "story_v_out_114171.awb") ~= 0 then
					local var_116_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171028", "story_v_out_114171.awb") / 1000

					if var_116_6 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_0
					end

					if var_116_2.prefab_name ~= "" and arg_113_1.actors_[var_116_2.prefab_name] ~= nil then
						local var_116_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_2.prefab_name].transform, "story_v_out_114171", "114171028", "story_v_out_114171.awb")

						arg_113_1:RecordAudio("114171028", var_116_7)
						arg_113_1:RecordAudio("114171028", var_116_7)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114171", "114171028", "story_v_out_114171.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114171", "114171028", "story_v_out_114171.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114171029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114171029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play114171030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10005ui_story = arg_117_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10005ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10005ui_story"].transform.position).z)
				arg_117_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10005ui_story"].transform.localEulerAngles = arg_117_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10005ui_story"].transform.position).z)
				arg_117_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10005ui_story"].transform.localEulerAngles = arg_117_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			local var_120_1 = 0
			local var_120_2 = 1.125

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(114171029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 45 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 45)

				if (45 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 45)) > 0 and var_120_2 < var_120_5 then
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

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play114171030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114171030
		arg_121_1.duration_ = 13.3

		local var_121_0 = {
			ja = 13.3,
			ko = 6.6,
			zh = 5.466,
			en = 5.133
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
				arg_121_0:Play114171031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10005ui_story = arg_121_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10005ui_story, Vector3.New(0, -0.95, -5.88), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10005ui_story"].transform.position).z)
				arg_121_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10005ui_story"].transform.localEulerAngles = arg_121_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_121_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10005ui_story"].transform.position).z)
				arg_121_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10005ui_story"].transform.localEulerAngles = arg_121_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action1_1")
			end

			local var_124_1 = arg_121_1.actors_["10005_tpose"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10005_tpose == nil then
				arg_121_1.var_.characterEffect10005_tpose = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10005_tpose and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10005_tpose then
				arg_121_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.65

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(114171030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 26 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 26)

				if (26 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 26)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171030", "story_v_out_114171.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171030", "story_v_out_114171.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_114171", "114171030", "story_v_out_114171.awb")

						arg_121_1:RecordAudio("114171030", var_124_11)
						arg_121_1:RecordAudio("114171030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114171", "114171030", "story_v_out_114171.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114171", "114171030", "story_v_out_114171.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play114171031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114171031
		arg_125_1.duration_ = 9.03

		local var_125_0 = {
			ja = 7.1,
			ko = 9.033,
			zh = 6.8,
			en = 8.133
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
				arg_125_0:Play114171032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_128_0 = 0
			local var_128_1 = 0.9

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(114171031)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 36 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 36)

				if (36 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 36)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171031", "story_v_out_114171.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171031", "story_v_out_114171.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_out_114171", "114171031", "story_v_out_114171.awb")

						arg_125_1:RecordAudio("114171031", var_128_7)
						arg_125_1:RecordAudio("114171031", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114171", "114171031", "story_v_out_114171.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114171", "114171031", "story_v_out_114171.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114171032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114171032
		arg_129_1.duration_ = 6.3

		local var_129_0 = {
			ja = 6.3,
			ko = 6.066,
			zh = 3.366,
			en = 4.7
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
				arg_129_0:Play114171033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10005ui_story = arg_129_1.actors_["10005ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["10005ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10005ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10005ui_story"].transform.position).z)
				arg_129_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10005ui_story"].transform.localEulerAngles = arg_129_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["10005ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["10005ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10005ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10005ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10005ui_story"].transform.position).z)
				arg_129_1.actors_["10005ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10005ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10005ui_story"].transform.localEulerAngles = arg_129_1.actors_["10005ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1038ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1038ui_story = var_132_1.localPosition
			end

			local var_132_2 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 then
				var_132_1.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_129_1.time_ - 0) / var_132_2)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 then
				var_132_1.localPosition = Vector3.New(0, -1.11, -5.9)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_132_3 = arg_129_1.actors_["1038ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1038ui_story == nil then
				arg_129_1.var_.characterEffect1038ui_story = var_132_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_3) then
				if arg_129_1.var_.characterEffect1038ui_story and not isNil(var_132_3) then
					arg_129_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1038ui_story then
				arg_129_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_132_6 = 0
			local var_132_7 = 0.375

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(114171032)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 15 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 15)

				if (15 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 15)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171032", "story_v_out_114171.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_114171", "114171032", "story_v_out_114171.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_114171", "114171032", "story_v_out_114171.awb")

						arg_129_1:RecordAudio("114171032", var_132_13)
						arg_129_1:RecordAudio("114171032", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114171", "114171032", "story_v_out_114171.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114171", "114171032", "story_v_out_114171.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play114171033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114171033
		arg_133_1.duration_ = 11.27

		local var_133_0 = {
			ja = 6.733,
			ko = 5.433,
			zh = 8.533,
			en = 11.266
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
				arg_133_0:Play114171034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1038ui_story = arg_133_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1038ui_story"].transform.position).z)
				arg_133_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1038ui_story"].transform.localEulerAngles = arg_133_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1038ui_story"].transform.position).z)
				arg_133_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1038ui_story"].transform.localEulerAngles = arg_133_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10005ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10005ui_story = var_136_1.localPosition
			end

			local var_136_2 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10005ui_story, Vector3.New(0, -0.95, -5.88), (arg_133_1.time_ - 0) / var_136_2)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(0, -0.95, -5.88)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action5_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_136_3 = arg_133_1.actors_["10005_tpose"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect10005_tpose == nil then
				arg_133_1.var_.characterEffect10005_tpose = var_136_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 and not isNil(var_136_3) then
				if arg_133_1.var_.characterEffect10005_tpose and not isNil(var_136_3) then
					arg_133_1.var_.characterEffect10005_tpose.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect10005_tpose then
				arg_133_1.var_.characterEffect10005_tpose.fillFlat = false
			end

			local var_136_6 = 0
			local var_136_7 = 0.675

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(114171033)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 27 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 27)

				if (27 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 27)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171033", "story_v_out_114171.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_114171", "114171033", "story_v_out_114171.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_114171", "114171033", "story_v_out_114171.awb")

						arg_133_1:RecordAudio("114171033", var_136_13)
						arg_133_1:RecordAudio("114171033", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114171", "114171033", "story_v_out_114171.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114171", "114171033", "story_v_out_114171.awb")
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play114171034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114171034
		arg_137_1.duration_ = 7.37

		local var_137_0 = {
			ja = 5.2,
			ko = 5.8,
			zh = 5.5,
			en = 7.366
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
				arg_137_0:Play114171035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/story10005/story10005action/10005action4_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_140_0 = 0
			local var_140_1 = 0.525

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(114171034)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 21 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 21)

				if (21 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 21)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171034", "story_v_out_114171.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171034", "story_v_out_114171.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_out_114171", "114171034", "story_v_out_114171.awb")

						arg_137_1:RecordAudio("114171034", var_140_7)
						arg_137_1:RecordAudio("114171034", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114171", "114171034", "story_v_out_114171.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114171", "114171034", "story_v_out_114171.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play114171035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114171035
		arg_141_1.duration_ = 10.2

		local var_141_0 = {
			ja = 8.9,
			ko = 8.9,
			zh = 8.333,
			en = 10.2
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
				arg_141_0:Play114171036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10005ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_144_0 = 0
			local var_144_1 = 0.85

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(114171035)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 34 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 34)

				if (34 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 34)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171035", "story_v_out_114171.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_out_114171", "114171035", "story_v_out_114171.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_out_114171", "114171035", "story_v_out_114171.awb")

						arg_141_1:RecordAudio("114171035", var_144_7)
						arg_141_1:RecordAudio("114171035", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_114171", "114171035", "story_v_out_114171.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_114171", "114171035", "story_v_out_114171.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114171036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114171036
		arg_145_1.duration_ = 9

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play114171037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.bgs_.OM0214 == nil then
				local var_148_0 = Object.Instantiate(arg_145_1.paintGo_)

				var_148_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0214")
				var_148_0.name = "OM0214"
				var_148_0.transform.parent = arg_145_1.stage_.transform
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.bgs_.OM0214 = var_148_0
			end

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				local var_148_1 = arg_145_1.bgs_.OM0214

				arg_145_1.bgs_.OM0214.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_148_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_148_2 = var_148_1:GetComponent("SpriteRenderer")

				if var_148_2 and var_148_2.sprite then
					local var_148_3 = 2 * (var_148_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_148_1.transform.localScale = Vector3.New(var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, var_148_3 / var_148_2.sprite.bounds.size.y < var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x and var_148_3 * manager.ui.mainCameraCom_.aspect / var_148_2.sprite.bounds.size.x or var_148_3 / var_148_2.sprite.bounds.size.y, 0)
				end

				for iter_148_0, iter_148_1 in pairs(arg_145_1.bgs_) do
					if iter_148_0 ~= "OM0214" then
						iter_148_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_148_12 = arg_145_1.actors_["10005ui_story"].transform

			if 1.966 < arg_145_1.time_ and arg_145_1.time_ <= 1.966 + arg_148_0 then
				arg_145_1.var_.moveOldPos10005ui_story = var_148_12.localPosition
			end

			local var_148_13 = 0.001

			if 1.966 <= arg_145_1.time_ and arg_145_1.time_ < 1.966 + var_148_13 then
				var_148_12.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10005ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 1.966) / var_148_13)
				var_148_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_12.position).x, (manager.ui.mainCamera.transform.position - var_148_12.position).y, (manager.ui.mainCamera.transform.position - var_148_12.position).z)
				var_148_12.localEulerAngles.z = 0
				var_148_12.localEulerAngles.x = 0
				var_148_12.localEulerAngles = var_148_12.localEulerAngles
			end

			if arg_145_1.time_ >= 1.966 + var_148_13 and arg_145_1.time_ < 1.966 + var_148_13 + arg_148_0 then
				var_148_12.localPosition = Vector3.New(0, 100, 0)
				var_148_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_12.position).x, (manager.ui.mainCamera.transform.position - var_148_12.position).y, (manager.ui.mainCamera.transform.position - var_148_12.position).z)
				var_148_12.localEulerAngles.z = 0
				var_148_12.localEulerAngles.x = 0
				var_148_12.localEulerAngles = var_148_12.localEulerAngles
			end

			local var_148_14 = arg_145_1.bgs_.OM0214.transform

			if 2 < arg_145_1.time_ and arg_145_1.time_ <= 2 + arg_148_0 then
				arg_145_1.var_.moveOldPosOM0214 = var_148_14.localPosition
			end

			local var_148_15 = 0.001

			if 2 <= arg_145_1.time_ and arg_145_1.time_ < 2 + var_148_15 then
				var_148_14.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPosOM0214, Vector3.New(0, 1, 10), (arg_145_1.time_ - 2) / var_148_15)
			end

			if arg_145_1.time_ >= 2 + var_148_15 and arg_145_1.time_ < 2 + var_148_15 + arg_148_0 then
				var_148_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_148_16 = arg_145_1.bgs_.OM0214.transform

			if 2.034 < arg_145_1.time_ and arg_145_1.time_ <= 2.034 + arg_148_0 then
				arg_145_1.var_.moveOldPosOM0214 = var_148_16.localPosition
			end

			local var_148_17 = 2.5

			if 2.034 <= arg_145_1.time_ and arg_145_1.time_ < 2.034 + var_148_17 then
				var_148_16.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPosOM0214, Vector3.New(0, 1, 9.5), (arg_145_1.time_ - 2.034) / var_148_17)
			end

			if arg_145_1.time_ >= 2.034 + var_148_17 and arg_145_1.time_ < 2.034 + var_148_17 + arg_148_0 then
				var_148_16.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_148_18 = 4

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_18 + arg_148_0 then
				arg_145_1.allBtn_.enabled = false
			end

			if arg_145_1.time_ >= var_148_18 + 0.534000000000001 and arg_145_1.time_ < var_148_18 + 0.534000000000001 + arg_148_0 then
				arg_145_1.allBtn_.enabled = true
			end

			if arg_145_1.frameCnt_ <= 1 then
				arg_145_1.dialog_:SetActive(false)
			end

			local var_148_19 = 4
			local var_148_20 = 1.45

			if 4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				arg_145_1.dialog_:SetActive(true)

				arg_145_1.dialogCg_.alpha = 0

				local var_148_21 = LeanTween.value(arg_145_1.dialog_, 0, 1, 0.3)

				var_148_21:setOnUpdate(LuaHelper.FloatAction(function(arg_149_0)
					arg_145_1.dialogCg_.alpha = arg_149_0
				end))
				var_148_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_145_1.dialog_)
					var_148_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_145_1.duration_ = arg_145_1.duration_ + 0.3

				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_22 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(114171036).content)

				arg_145_1.text_.text = var_148_22

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_24 = 58 <= 0 and var_148_20 or var_148_20 * (utf8.len(var_148_22) / 58)

				if (58 <= 0 and var_148_20 or var_148_20 * (utf8.len(var_148_22) / 58)) > 0 and var_148_20 < var_148_24 then
					arg_145_1.talkMaxDuration = var_148_24
					var_148_19 = var_148_19 + 0.3

					if var_148_24 + var_148_19 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_24 + var_148_19
					end
				end

				arg_145_1.text_.text = var_148_22
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = var_148_19 + 0.3
			local var_148_26 = math.max(var_148_20, arg_145_1.talkMaxDuration)

			if var_148_19 + 0.3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_25 + var_148_26 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_25) / var_148_26

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_25 + var_148_26 and arg_145_1.time_ < var_148_25 + var_148_26 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10005ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "OM0214",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0214",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play114171037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114171037
		arg_151_1.duration_ = 5.93

		local var_151_0 = {
			ja = 5.933,
			ko = 3.9,
			zh = 3.733,
			en = 3.233
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
				arg_151_0:Play114171038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_154_0 = 0.6

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				local var_154_1, var_154_2 = math.modf((arg_151_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_154_2 * 0.13, var_154_2 * 0.13, var_154_2 * 0.13) + arg_151_1.var_.shakeOldPos
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				manager.ui.mainCamera.transform.localPosition = arg_151_1.var_.shakeOldPos
			end

			local var_154_3 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_3 + 0.6 and arg_151_1.time_ < var_154_3 + 0.6 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_4 = 0
			local var_154_5 = 0.325

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_6 = arg_151_1:GetWordFromCfg(114171037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 13 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 13)

				if (13 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 13)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171037", "story_v_out_114171.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_114171", "114171037", "story_v_out_114171.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_114171", "114171037", "story_v_out_114171.awb")

						arg_151_1:RecordAudio("114171037", var_154_11)
						arg_151_1:RecordAudio("114171037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_114171", "114171037", "story_v_out_114171.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_114171", "114171037", "story_v_out_114171.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114171038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114171038
		arg_155_1.duration_ = 7.57

		local var_155_0 = {
			ja = 7.566,
			ko = 5.333,
			zh = 5.433,
			en = 5.7
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
				arg_155_0:Play114171039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.425

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(114171038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 17 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 17)

				if (17 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 17)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171038", "story_v_out_114171.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_114171", "114171038", "story_v_out_114171.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_114171", "114171038", "story_v_out_114171.awb")

						arg_155_1:RecordAudio("114171038", var_158_6)
						arg_155_1:RecordAudio("114171038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114171", "114171038", "story_v_out_114171.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114171", "114171038", "story_v_out_114171.awb")
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
	Play114171039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114171039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114171040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPosOM0214 = arg_159_1.bgs_.OM0214.transform.localPosition
			end

			local var_162_0 = 2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.bgs_.OM0214.transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPosOM0214, Vector3.New(0, 1, 9), (arg_159_1.time_ - 0) / var_162_0)
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.bgs_.OM0214.transform.localPosition = Vector3.New(0, 1, 9)
			end

			local var_162_1 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= var_162_1 + 2 and arg_159_1.time_ < var_162_1 + 2 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_2 = 0
			local var_162_3 = 0.75

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(114171039).content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 30 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 30)

				if (30 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 30)) > 0 and var_162_3 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_7 and arg_159_1.time_ < var_162_2 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0214",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play114171040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114171040
		arg_163_1.duration_ = 6.17

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play114171041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 2.14166666666667 < arg_163_1.time_ and arg_163_1.time_ <= 2.14166666666667 + arg_166_0 then
				arg_163_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_166_0 = 0.5

			if 2.14166666666667 <= arg_163_1.time_ and arg_163_1.time_ < 2.14166666666667 + var_166_0 then
				local var_166_1, var_166_2 = math.modf((arg_163_1.time_ - 2.14166666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_166_2 * 0.13, var_166_2 * 0.13, var_166_2 * 0.13) + arg_163_1.var_.shakeOldPos
			end

			if arg_163_1.time_ >= 2.14166666666667 + var_166_0 and arg_163_1.time_ < 2.14166666666667 + var_166_0 + arg_166_0 then
				manager.ui.mainCamera.transform.localPosition = arg_163_1.var_.shakeOldPos
			end

			local var_166_3 = 2.14166666666667

			if 2.14166666666667 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= var_166_3 + 0.5 and arg_163_1.time_ < var_166_3 + 0.5 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_4 = 1.16666666666667
			local var_166_5 = 0.975

			if 1.16666666666667 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(114171040).content)

				arg_163_1.text_.text = var_166_6

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_8 = 39 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_6) / 39)

				if (39 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_6) / 39)) > 0 and var_166_5 < var_166_8 then
					arg_163_1.talkMaxDuration = var_166_8

					if var_166_8 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_6
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_9 and arg_163_1.time_ < var_166_4 + var_166_9 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114171041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114171041
		arg_167_1.duration_ = 11.5

		local var_167_0 = {
			ja = 10.333,
			ko = 4.8,
			zh = 11.5,
			en = 8.133
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
			arg_167_1.auto_ = false
		end

		function arg_167_1.playNext_(arg_169_0)
			arg_167_1.onStoryFinished_()
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.575

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(114171041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 23 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 23)

				if (23 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 23)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114171", "114171041", "story_v_out_114171.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_114171", "114171041", "story_v_out_114171.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_114171", "114171041", "story_v_out_114171.awb")

						arg_167_1:RecordAudio("114171041", var_170_6)
						arg_167_1:RecordAudio("114171041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_114171", "114171041", "story_v_out_114171.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_114171", "114171041", "story_v_out_114171.awb")
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
	assets = {
		"TextureConfig/Background/F07",
		"TextureConfig/Background/OM0214"
	},
	voices = {
		"story_v_out_114171.awb"
	}
}
