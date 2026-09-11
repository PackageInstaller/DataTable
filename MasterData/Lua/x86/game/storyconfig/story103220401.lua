return {
	Play322041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322041001
		arg_1_1.duration_ = 12.57

		local var_1_0 = {
			zh = 8.765999999999,
			ja = 12.565999999999
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
				arg_1_0:Play322041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L01h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01h")
				var_4_0.name = "L01h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L01h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L01h

				arg_1_1.bgs_.L01h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L01h" then
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily")

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
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.999999999999
			local var_4_17 = 0.55

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_1_1.callingController_:SetSelectedState("calling")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(322041001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 22 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 22)

				if (22 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 22)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041001", "story_v_out_322041.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_322041", "322041001", "story_v_out_322041.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_322041", "322041001", "story_v_out_322041.awb")

						arg_1_1:RecordAudio("322041001", var_4_24)
						arg_1_1:RecordAudio("322041001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322041", "322041001", "story_v_out_322041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322041", "322041001", "story_v_out_322041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
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
	Play322041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322041002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.225

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(322041002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 49 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 49)

				if (49 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 49)) > 0 and var_12_0 < var_12_3 then
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
	Play322041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322041003
		arg_13_1.duration_ = 2.87

		local var_13_0 = {
			zh = 1.999999999999,
			ja = 2.866
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
				arg_13_0:Play322041004(arg_13_1)
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
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.2

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

				local var_16_10 = arg_13_1:GetWordFromCfg(322041003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 8 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 8)

				if (8 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 8)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041003", "story_v_out_322041.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041003", "story_v_out_322041.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_322041", "322041003", "story_v_out_322041.awb")

						arg_13_1:RecordAudio("322041003", var_16_15)
						arg_13_1:RecordAudio("322041003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322041", "322041003", "story_v_out_322041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322041", "322041003", "story_v_out_322041.awb")
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
	Play322041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322041004
		arg_17_1.duration_ = 11.67

		local var_17_0 = {
			zh = 6.933,
			ja = 11.666
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
				arg_17_0:Play322041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
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

			local var_20_1 = 0
			local var_20_2 = 0.975

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_17_1.callingController_:SetSelectedState("calling")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(322041004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 39 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 39)

				if (39 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 39)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041004", "story_v_out_322041.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_out_322041", "322041004", "story_v_out_322041.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_322041", "322041004", "story_v_out_322041.awb")

						arg_17_1:RecordAudio("322041004", var_20_8)
						arg_17_1:RecordAudio("322041004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_322041", "322041004", "story_v_out_322041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_322041", "322041004", "story_v_out_322041.awb")
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
	Play322041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322041005
		arg_21_1.duration_ = 15.3

		local var_21_0 = {
			zh = 8.133,
			ja = 15.3
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
				arg_21_0:Play322041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_21_1.callingController_:SetSelectedState("calling")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(322041005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 43 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 43)

				if (43 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 43)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041005", "story_v_out_322041.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_322041", "322041005", "story_v_out_322041.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_322041", "322041005", "story_v_out_322041.awb")

						arg_21_1:RecordAudio("322041005", var_24_6)
						arg_21_1:RecordAudio("322041005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_322041", "322041005", "story_v_out_322041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_322041", "322041005", "story_v_out_322041.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322041006
		arg_25_1.duration_ = 4.47

		local var_25_0 = {
			zh = 2.933,
			ja = 4.466
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
				arg_25_0:Play322041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1284ui_story"]) and arg_25_1.var_.characterEffect1284ui_story == nil then
				arg_25_1.var_.characterEffect1284ui_story = arg_25_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1284ui_story"]) then
				if arg_25_1.var_.characterEffect1284ui_story and not isNil(arg_25_1.actors_["1284ui_story"]) then
					arg_25_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1284ui_story"]) and arg_25_1.var_.characterEffect1284ui_story then
				arg_25_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_28_2 = 0
			local var_28_3 = 0.4

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(322041006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 16 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 16)

				if (16 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 16)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041006", "story_v_out_322041.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041006", "story_v_out_322041.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_322041", "322041006", "story_v_out_322041.awb")

						arg_25_1:RecordAudio("322041006", var_28_9)
						arg_25_1:RecordAudio("322041006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322041", "322041006", "story_v_out_322041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322041", "322041006", "story_v_out_322041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_10 and arg_25_1.time_ < var_28_2 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322041007
		arg_29_1.duration_ = 9.13

		local var_29_0 = {
			zh = 5.466,
			ja = 9.133
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
				arg_29_0:Play322041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1284ui_story"]) and arg_29_1.var_.characterEffect1284ui_story == nil then
				arg_29_1.var_.characterEffect1284ui_story = arg_29_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1284ui_story"]) then
				if arg_29_1.var_.characterEffect1284ui_story and not isNil(arg_29_1.actors_["1284ui_story"]) then
					arg_29_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1284ui_story"]) and arg_29_1.var_.characterEffect1284ui_story then
				arg_29_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.675

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_29_1.callingController_:SetSelectedState("calling")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(322041007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 27 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 27)

				if (27 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 27)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041007", "story_v_out_322041.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_322041", "322041007", "story_v_out_322041.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_322041", "322041007", "story_v_out_322041.awb")

						arg_29_1:RecordAudio("322041007", var_32_8)
						arg_29_1:RecordAudio("322041007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322041", "322041007", "story_v_out_322041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322041", "322041007", "story_v_out_322041.awb")
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
	Play322041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322041008
		arg_33_1.duration_ = 4.73

		local var_33_0 = {
			zh = 4.566,
			ja = 4.733
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
				arg_33_0:Play322041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1284ui_story"]) and arg_33_1.var_.characterEffect1284ui_story == nil then
				arg_33_1.var_.characterEffect1284ui_story = arg_33_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1284ui_story"]) then
				if arg_33_1.var_.characterEffect1284ui_story and not isNil(arg_33_1.actors_["1284ui_story"]) then
					arg_33_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1284ui_story"]) and arg_33_1.var_.characterEffect1284ui_story then
				arg_33_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action6_1")
			end

			local var_36_2 = 0
			local var_36_3 = 0.65

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:GetWordFromCfg(322041008)
				local var_36_5 = arg_33_1:FormatText(var_36_4.content)

				arg_33_1.text_.text = var_36_5

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 26 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 26)

				if (26 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_5) / 26)) > 0 and var_36_3 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_5
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041008", "story_v_out_322041.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041008", "story_v_out_322041.awb") / 1000

					if var_36_8 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_2
					end

					if var_36_4.prefab_name ~= "" and arg_33_1.actors_[var_36_4.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_4.prefab_name].transform, "story_v_out_322041", "322041008", "story_v_out_322041.awb")

						arg_33_1:RecordAudio("322041008", var_36_9)
						arg_33_1:RecordAudio("322041008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_322041", "322041008", "story_v_out_322041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_322041", "322041008", "story_v_out_322041.awb")
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
	Play322041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322041009
		arg_37_1.duration_ = 5.77

		local var_37_0 = {
			zh = 4.566,
			ja = 5.766
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
				arg_37_0:Play322041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) and arg_37_1.var_.characterEffect1284ui_story == nil then
				arg_37_1.var_.characterEffect1284ui_story = arg_37_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) then
				if arg_37_1.var_.characterEffect1284ui_story and not isNil(arg_37_1.actors_["1284ui_story"]) then
					arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1284ui_story"]) and arg_37_1.var_.characterEffect1284ui_story then
				arg_37_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.55

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_37_1.callingController_:SetSelectedState("calling")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(322041009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 22 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 22)

				if (22 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 22)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041009", "story_v_out_322041.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_322041", "322041009", "story_v_out_322041.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_322041", "322041009", "story_v_out_322041.awb")

						arg_37_1:RecordAudio("322041009", var_40_8)
						arg_37_1:RecordAudio("322041009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322041", "322041009", "story_v_out_322041.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322041", "322041009", "story_v_out_322041.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play322041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322041010
		arg_41_1.duration_ = 9.87

		local var_41_0 = {
			zh = 6.5,
			ja = 9.866
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
				arg_41_0:Play322041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.8

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_41_1.callingController_:SetSelectedState("calling")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(322041010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 32 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 32)

				if (32 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 32)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041010", "story_v_out_322041.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_322041", "322041010", "story_v_out_322041.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_322041", "322041010", "story_v_out_322041.awb")

						arg_41_1:RecordAudio("322041010", var_44_6)
						arg_41_1:RecordAudio("322041010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322041", "322041010", "story_v_out_322041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322041", "322041010", "story_v_out_322041.awb")
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
	Play322041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322041011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1284ui_story = arg_45_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1284ui_story"].transform.position).z)
				arg_45_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1284ui_story"].transform.localEulerAngles = arg_45_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1284ui_story"].transform.position).z)
				arg_45_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1284ui_story"].transform.localEulerAngles = arg_45_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_45_1.time_ and arg_45_1.time_ <= 0.1 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_145", "se_story_145_ui01", "")
			end

			local var_48_2 = 0
			local var_48_3 = 1.325

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(322041011).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 53 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 53)

				if (53 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 53)) > 0 and var_48_3 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_7 and arg_45_1.time_ < var_48_2 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play322041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322041012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1284ui_story = arg_49_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1284ui_story"].transform.position).z)
				arg_49_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1284ui_story"].transform.localEulerAngles = arg_49_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_49_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1284ui_story"].transform.position).z)
				arg_49_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1284ui_story"].transform.localEulerAngles = arg_49_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1284ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1284ui_story == nil then
				arg_49_1.var_.characterEffect1284ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1284ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1284ui_story then
				arg_49_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_52_4 = 0
			local var_52_5 = 0.125

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(322041012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 5 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 5)

				if (5 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 5)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041012", "story_v_out_322041.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041012", "story_v_out_322041.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_322041", "322041012", "story_v_out_322041.awb")

						arg_49_1:RecordAudio("322041012", var_52_11)
						arg_49_1:RecordAudio("322041012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322041", "322041012", "story_v_out_322041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322041", "322041012", "story_v_out_322041.awb")
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

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play322041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322041013
		arg_53_1.duration_ = 6.2

		local var_53_0 = {
			zh = 4.8,
			ja = 6.2
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
				arg_53_0:Play322041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_56_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_53_1.stage_.transform)

				var_56_0.name = "1156ui_story"
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1156ui_story"] = var_56_0

				local var_56_1 = var_56_0:GetComponentInChildren(typeof(CharacterEffect))

				var_56_1.enabled = true

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_1.transform, false)

				arg_53_1.var_["1156ui_story" .. "Animator"] = var_56_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_53_1.var_["1156ui_story" .. "LipSync"] = var_56_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_3 = arg_53_1.actors_["1156ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1156ui_story = var_56_3.localPosition
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_53_1.time_ - 0) / var_56_4)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(0.9, -1.1, -6.18)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			local var_56_5 = arg_53_1.actors_["1156ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1156ui_story == nil then
				arg_53_1.var_.characterEffect1156ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.characterEffect1156ui_story and not isNil(var_56_5) then
					arg_53_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1156ui_story then
				arg_53_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_56_8 = arg_53_1.actors_["1284ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.characterEffect1284ui_story == nil then
				arg_53_1.var_.characterEffect1284ui_story = var_56_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_9 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_9 and not isNil(var_56_8) then
				if arg_53_1.var_.characterEffect1284ui_story and not isNil(var_56_8) then
					arg_53_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_9)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_9 and arg_53_1.time_ < 0 + var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.characterEffect1284ui_story then
				arg_53_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_10 = 0
			local var_56_11 = 0.625

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_12 = arg_53_1:GetWordFromCfg(322041013)
				local var_56_13 = arg_53_1:FormatText(var_56_12.content)

				arg_53_1.text_.text = var_56_13

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_15 = 25 <= 0 and var_56_11 or var_56_11 * (utf8.len(var_56_13) / 25)

				if (25 <= 0 and var_56_11 or var_56_11 * (utf8.len(var_56_13) / 25)) > 0 and var_56_11 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_10
					end
				end

				arg_53_1.text_.text = var_56_13
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041013", "story_v_out_322041.awb") ~= 0 then
					local var_56_16 = manager.audio:GetVoiceLength("story_v_out_322041", "322041013", "story_v_out_322041.awb") / 1000

					if var_56_16 + var_56_10 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_10
					end

					if var_56_12.prefab_name ~= "" and arg_53_1.actors_[var_56_12.prefab_name] ~= nil then
						local var_56_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_12.prefab_name].transform, "story_v_out_322041", "322041013", "story_v_out_322041.awb")

						arg_53_1:RecordAudio("322041013", var_56_17)
						arg_53_1:RecordAudio("322041013", var_56_17)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322041", "322041013", "story_v_out_322041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322041", "322041013", "story_v_out_322041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_18 = math.max(var_56_11, arg_53_1.talkMaxDuration)

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_18 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_10) / var_56_18

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_10 + var_56_18 and arg_53_1.time_ < var_56_10 + var_56_18 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322041014
		arg_57_1.duration_ = 2.9

		local var_57_0 = {
			zh = 2.7,
			ja = 2.9
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
				arg_57_0:Play322041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(322041014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 14 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 14)

				if (14 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 14)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041014", "story_v_out_322041.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_322041", "322041014", "story_v_out_322041.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_322041", "322041014", "story_v_out_322041.awb")

						arg_57_1:RecordAudio("322041014", var_60_6)
						arg_57_1:RecordAudio("322041014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_322041", "322041014", "story_v_out_322041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_322041", "322041014", "story_v_out_322041.awb")
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
	Play322041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322041015
		arg_61_1.duration_ = 11.13

		local var_61_0 = {
			zh = 7.866,
			ja = 11.133
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
				arg_61_0:Play322041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1284ui_story"]) and arg_61_1.var_.characterEffect1284ui_story == nil then
				arg_61_1.var_.characterEffect1284ui_story = arg_61_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1284ui_story"]) then
				if arg_61_1.var_.characterEffect1284ui_story and not isNil(arg_61_1.actors_["1284ui_story"]) then
					arg_61_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1284ui_story"]) and arg_61_1.var_.characterEffect1284ui_story then
				arg_61_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1156ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1156ui_story == nil then
				arg_61_1.var_.characterEffect1156ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1156ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1156ui_story then
				arg_61_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_4 = 0
			local var_64_5 = 0.875

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(322041015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 35 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 35)

				if (35 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 35)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041015", "story_v_out_322041.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041015", "story_v_out_322041.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_322041", "322041015", "story_v_out_322041.awb")

						arg_61_1:RecordAudio("322041015", var_64_11)
						arg_61_1:RecordAudio("322041015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322041", "322041015", "story_v_out_322041.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322041", "322041015", "story_v_out_322041.awb")
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

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play322041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322041016
		arg_65_1.duration_ = 2.8

		local var_65_0 = {
			zh = 2.6,
			ja = 2.8
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
				arg_65_0:Play322041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1156ui_story"]) and arg_65_1.var_.characterEffect1156ui_story == nil then
				arg_65_1.var_.characterEffect1156ui_story = arg_65_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1156ui_story"]) then
				if arg_65_1.var_.characterEffect1156ui_story and not isNil(arg_65_1.actors_["1156ui_story"]) then
					arg_65_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1156ui_story"]) and arg_65_1.var_.characterEffect1156ui_story then
				arg_65_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1284ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1284ui_story == nil then
				arg_65_1.var_.characterEffect1284ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1284ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1284ui_story then
				arg_65_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(322041016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 14 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 14)

				if (14 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 14)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041016", "story_v_out_322041.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041016", "story_v_out_322041.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_322041", "322041016", "story_v_out_322041.awb")

						arg_65_1:RecordAudio("322041016", var_68_11)
						arg_65_1:RecordAudio("322041016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322041", "322041016", "story_v_out_322041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322041", "322041016", "story_v_out_322041.awb")
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

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play322041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322041017
		arg_69_1.duration_ = 17.9

		local var_69_0 = {
			zh = 9.8,
			ja = 17.9
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
				arg_69_0:Play322041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(322041017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 52 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 52)

				if (52 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 52)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041017", "story_v_out_322041.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_322041", "322041017", "story_v_out_322041.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_322041", "322041017", "story_v_out_322041.awb")

						arg_69_1:RecordAudio("322041017", var_72_6)
						arg_69_1:RecordAudio("322041017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322041", "322041017", "story_v_out_322041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322041", "322041017", "story_v_out_322041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play322041018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322041018
		arg_73_1.duration_ = 13.4

		local var_73_0 = {
			zh = 10.3,
			ja = 13.4
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
				arg_73_0:Play322041019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(322041018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 48 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 48)

				if (48 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 48)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041018", "story_v_out_322041.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_322041", "322041018", "story_v_out_322041.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_322041", "322041018", "story_v_out_322041.awb")

						arg_73_1:RecordAudio("322041018", var_76_6)
						arg_73_1:RecordAudio("322041018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322041", "322041018", "story_v_out_322041.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322041", "322041018", "story_v_out_322041.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play322041019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322041019
		arg_77_1.duration_ = 9.83

		local var_77_0 = {
			zh = 7.033,
			ja = 9.833
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
				arg_77_0:Play322041020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			local var_80_0 = 0
			local var_80_1 = 0.875

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(322041019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 35 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 35)

				if (35 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 35)) > 0 and var_80_1 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041019", "story_v_out_322041.awb") ~= 0 then
					local var_80_6 = manager.audio:GetVoiceLength("story_v_out_322041", "322041019", "story_v_out_322041.awb") / 1000

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end

					if var_80_2.prefab_name ~= "" and arg_77_1.actors_[var_80_2.prefab_name] ~= nil then
						local var_80_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_2.prefab_name].transform, "story_v_out_322041", "322041019", "story_v_out_322041.awb")

						arg_77_1:RecordAudio("322041019", var_80_7)
						arg_77_1:RecordAudio("322041019", var_80_7)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_322041", "322041019", "story_v_out_322041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_322041", "322041019", "story_v_out_322041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play322041020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 322041020
		arg_81_1.duration_ = 9.57

		local var_81_0 = {
			zh = 8.599999999999,
			ja = 9.565999999999
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
				arg_81_0:Play322041021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.bgs_.L10g == nil then
				local var_84_0 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10g")
				var_84_0.name = "L10g"
				var_84_0.transform.parent = arg_81_1.stage_.transform
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_.L10g = var_84_0
			end

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= 2 + arg_84_0 then
				local var_84_1 = arg_81_1.bgs_.L10g

				arg_81_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_2 = var_84_1:GetComponent("SpriteRenderer")

				if var_84_2 and var_84_2.sprite then
					local var_84_3 = 2 * (var_84_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_1.transform.localScale = Vector3.New(var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "L10g" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_4 = 3.999999999999

			if 3.999999999999 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			if arg_81_1.time_ >= var_84_4 + 0.3 and arg_81_1.time_ < var_84_4 + 0.3 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_5 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_6 = 2

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 then
				local var_84_7 = Color.New(0, 0, 0)

				var_84_7.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_5) / var_84_6)
				arg_81_1.mask_.color = var_84_7
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 then
				local var_84_8 = Color.New(0, 0, 0)

				var_84_8.a = 1
				arg_81_1.mask_.color = var_84_8
			end

			local var_84_9 = 2

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_10 = 2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 then
				local var_84_11 = Color.New(0, 0, 0)

				var_84_11.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_9) / var_84_10)
				arg_81_1.mask_.color = var_84_11
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 then
				local var_84_12 = Color.New(0, 0, 0)

				arg_81_1.mask_.enabled = false
				var_84_12.a = 0
				arg_81_1.mask_.color = var_84_12
			end

			local var_84_13 = arg_81_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_81_1.time_ and arg_81_1.time_ <= 1.96599999815226 + arg_84_0 then
				arg_81_1.var_.moveOldPos1156ui_story = var_84_13.localPosition
			end

			local var_84_14 = 0.001

			if 1.96599999815226 <= arg_81_1.time_ and arg_81_1.time_ < 1.96599999815226 + var_84_14 then
				var_84_13.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 1.96599999815226) / var_84_14)
				var_84_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_13.position).x, (manager.ui.mainCamera.transform.position - var_84_13.position).y, (manager.ui.mainCamera.transform.position - var_84_13.position).z)
				var_84_13.localEulerAngles.z = 0
				var_84_13.localEulerAngles.x = 0
				var_84_13.localEulerAngles = var_84_13.localEulerAngles
			end

			if arg_81_1.time_ >= 1.96599999815226 + var_84_14 and arg_81_1.time_ < 1.96599999815226 + var_84_14 + arg_84_0 then
				var_84_13.localPosition = Vector3.New(0, 100, 0)
				var_84_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_13.position).x, (manager.ui.mainCamera.transform.position - var_84_13.position).y, (manager.ui.mainCamera.transform.position - var_84_13.position).z)
				var_84_13.localEulerAngles.z = 0
				var_84_13.localEulerAngles.x = 0
				var_84_13.localEulerAngles = var_84_13.localEulerAngles
			end

			local var_84_15 = arg_81_1.actors_["1156ui_story"].transform

			if 2.9666666696479 < arg_81_1.time_ and arg_81_1.time_ <= 2.9666666696479 + arg_84_0 then
				arg_81_1.var_.moveOldPos1156ui_story = var_84_15.localPosition
			end

			local var_84_16 = 0.001

			if 2.9666666696479 <= arg_81_1.time_ and arg_81_1.time_ < 2.9666666696479 + var_84_16 then
				var_84_15.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_81_1.time_ - 2.9666666696479) / var_84_16)
				var_84_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_15.position).x, (manager.ui.mainCamera.transform.position - var_84_15.position).y, (manager.ui.mainCamera.transform.position - var_84_15.position).z)
				var_84_15.localEulerAngles.z = 0
				var_84_15.localEulerAngles.x = 0
				var_84_15.localEulerAngles = var_84_15.localEulerAngles
			end

			if arg_81_1.time_ >= 2.9666666696479 + var_84_16 and arg_81_1.time_ < 2.9666666696479 + var_84_16 + arg_84_0 then
				var_84_15.localPosition = Vector3.New(0, -1.1, -6.18)
				var_84_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_15.position).x, (manager.ui.mainCamera.transform.position - var_84_15.position).y, (manager.ui.mainCamera.transform.position - var_84_15.position).z)
				var_84_15.localEulerAngles.z = 0
				var_84_15.localEulerAngles.x = 0
				var_84_15.localEulerAngles = var_84_15.localEulerAngles
			end

			local var_84_17 = arg_81_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_81_1.time_ and arg_81_1.time_ <= 1.96599999815226 + arg_84_0 then
				arg_81_1.var_.moveOldPos1284ui_story = var_84_17.localPosition
			end

			local var_84_18 = 0.001

			if 1.96599999815226 <= arg_81_1.time_ and arg_81_1.time_ < 1.96599999815226 + var_84_18 then
				var_84_17.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 1.96599999815226) / var_84_18)
				var_84_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_17.position).x, (manager.ui.mainCamera.transform.position - var_84_17.position).y, (manager.ui.mainCamera.transform.position - var_84_17.position).z)
				var_84_17.localEulerAngles.z = 0
				var_84_17.localEulerAngles.x = 0
				var_84_17.localEulerAngles = var_84_17.localEulerAngles
			end

			if arg_81_1.time_ >= 1.96599999815226 + var_84_18 and arg_81_1.time_ < 1.96599999815226 + var_84_18 + arg_84_0 then
				var_84_17.localPosition = Vector3.New(0, 100, 0)
				var_84_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_17.position).x, (manager.ui.mainCamera.transform.position - var_84_17.position).y, (manager.ui.mainCamera.transform.position - var_84_17.position).z)
				var_84_17.localEulerAngles.z = 0
				var_84_17.localEulerAngles.x = 0
				var_84_17.localEulerAngles = var_84_17.localEulerAngles
			end

			if 2.9666666696479 < arg_81_1.time_ and arg_81_1.time_ <= 2.9666666696479 + arg_84_0 then
				arg_81_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			if 2.9666666696479 < arg_81_1.time_ and arg_81_1.time_ <= 2.9666666696479 + arg_84_0 then
				arg_81_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_84_19 = arg_81_1.actors_["1156ui_story"]

			if 2.96666666666667 < arg_81_1.time_ and arg_81_1.time_ <= 2.96666666666667 + arg_84_0 and not isNil(var_84_19) and arg_81_1.var_.characterEffect1156ui_story == nil then
				arg_81_1.var_.characterEffect1156ui_story = var_84_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_20 = 0.200000002980232

			if 2.96666666666667 <= arg_81_1.time_ and arg_81_1.time_ < 2.96666666666667 + var_84_20 and not isNil(var_84_19) then
				if arg_81_1.var_.characterEffect1156ui_story and not isNil(var_84_19) then
					arg_81_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 2.96666666666667 + var_84_20 and arg_81_1.time_ < 2.96666666666667 + var_84_20 + arg_84_0 and not isNil(var_84_19) and arg_81_1.var_.characterEffect1156ui_story then
				arg_81_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_22 = 3.999999999999
			local var_84_23 = 0.55

			if 3.999999999999 < arg_81_1.time_ and arg_81_1.time_ <= var_84_22 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_24 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_24:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_25 = arg_81_1:GetWordFromCfg(322041020)
				local var_84_26 = arg_81_1:FormatText(var_84_25.content)

				arg_81_1.text_.text = var_84_26

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 22 <= 0 and var_84_23 or var_84_23 * (utf8.len(var_84_26) / 22)

				if (22 <= 0 and var_84_23 or var_84_23 * (utf8.len(var_84_26) / 22)) > 0 and var_84_23 < var_84_28 then
					arg_81_1.talkMaxDuration = var_84_28
					var_84_22 = var_84_22 + 0.3

					if var_84_28 + var_84_22 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_28 + var_84_22
					end
				end

				arg_81_1.text_.text = var_84_26
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041020", "story_v_out_322041.awb") ~= 0 then
					local var_84_29 = manager.audio:GetVoiceLength("story_v_out_322041", "322041020", "story_v_out_322041.awb") / 1000

					if var_84_29 + var_84_22 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_29 + var_84_22
					end

					if var_84_25.prefab_name ~= "" and arg_81_1.actors_[var_84_25.prefab_name] ~= nil then
						local var_84_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_25.prefab_name].transform, "story_v_out_322041", "322041020", "story_v_out_322041.awb")

						arg_81_1:RecordAudio("322041020", var_84_30)
						arg_81_1:RecordAudio("322041020", var_84_30)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_322041", "322041020", "story_v_out_322041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_322041", "322041020", "story_v_out_322041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_31 = var_84_22 + 0.3
			local var_84_32 = math.max(var_84_23, arg_81_1.talkMaxDuration)

			if var_84_22 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_31 + var_84_32 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_31) / var_84_32

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_31 + var_84_32 and arg_81_1.time_ < var_84_31 + var_84_32 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.9666666696479,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play322041021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322041021
		arg_87_1.duration_ = 6

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play322041022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_9000

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1156ui_story = arg_87_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).z)
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles = arg_87_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1156ui_story"].transform.position).z)
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1156ui_story"].transform.localEulerAngles = arg_87_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_87_1.time_ and arg_87_1.time_ <= 0.1 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_car01", "")
			end

			if 0.5 < arg_87_1.time_ and arg_87_1.time_ <= 0.5 + arg_90_0 then
				local var_90_2 = arg_87_1.var_.effect1021

				if not arg_87_1.var_.effect1021 then
					var_90_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_90_2.name = "1021"
					arg_87_1.var_.effect1021 = var_90_2
				else
					var_90_2.transform:SetParent(var_90_9000)
				end

				var_90_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_90_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_90_4 = manager.ui.mainCamera.transform

			if 0.5 < arg_87_1.time_ and arg_87_1.time_ <= 0.5 + arg_90_0 then
				arg_87_1.var_.shakeOldPos = var_90_4.localPosition
			end

			local var_90_5 = 0.466666666666667

			if 0.5 <= arg_87_1.time_ and arg_87_1.time_ < 0.5 + var_90_5 then
				local var_90_6, var_90_7 = math.modf((arg_87_1.time_ - 0.5) / 0.066)

				var_90_4.localPosition = Vector3.New(var_90_7 * 0.13, var_90_7 * 0.13, var_90_7 * 0.13) + arg_87_1.var_.shakeOldPos
			end

			if arg_87_1.time_ >= 0.5 + var_90_5 and arg_87_1.time_ < 0.5 + var_90_5 + arg_90_0 then
				var_90_4.localPosition = arg_87_1.var_.shakeOldPos
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_8 = 1
			local var_90_9 = 1.575

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_10 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_10:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_11 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(322041021).content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 63 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 63)

				if (63 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 63)) > 0 and var_90_9 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13
					var_90_8 = var_90_8 + 0.3

					if var_90_13 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = var_90_8 + 0.3
			local var_90_15 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_14 + var_90_15 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_14) / var_90_15

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_14 + var_90_15 and arg_87_1.time_ < var_90_14 + var_90_15 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322041022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 322041022
		arg_93_1.duration_ = 8.8

		local var_93_0 = {
			zh = 8.166,
			ja = 8.8
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
				arg_93_0:Play322041023(arg_93_1)
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
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				if arg_93_1.var_.effect1021 then
					Object.Destroy(arg_93_1.var_.effect1021)

					arg_93_1.var_.effect1021 = nil
				end
			end

			local var_96_5 = 0
			local var_96_6 = 1.025

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
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

				local var_96_7 = arg_93_1:GetWordFromCfg(322041022)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 41 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 41)

				if (41 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 41)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041022", "story_v_out_322041.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_322041", "322041022", "story_v_out_322041.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_322041", "322041022", "story_v_out_322041.awb")

						arg_93_1:RecordAudio("322041022", var_96_12)
						arg_93_1:RecordAudio("322041022", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_322041", "322041022", "story_v_out_322041.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_322041", "322041022", "story_v_out_322041.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_13 and arg_93_1.time_ < var_96_5 + var_96_13 + arg_96_0 then
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
	Play322041023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322041023
		arg_97_1.duration_ = 10.43

		local var_97_0 = {
			zh = 7.166,
			ja = 10.433
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
				arg_97_0:Play322041024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_100_0 = 0
			local var_100_1 = 1.1

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(322041023)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 44 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 44)

				if (44 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 44)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041023", "story_v_out_322041.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_322041", "322041023", "story_v_out_322041.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_322041", "322041023", "story_v_out_322041.awb")

						arg_97_1:RecordAudio("322041023", var_100_7)
						arg_97_1:RecordAudio("322041023", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_322041", "322041023", "story_v_out_322041.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_322041", "322041023", "story_v_out_322041.awb")
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
	Play322041024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322041024
		arg_101_1.duration_ = 4.5

		local var_101_0 = {
			zh = 3.8,
			ja = 4.5
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
				arg_101_0:Play322041025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1156ui_story = arg_101_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1156ui_story"].transform.position).z)
				arg_101_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1156ui_story"].transform.localEulerAngles = arg_101_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_101_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1156ui_story"].transform.position).z)
				arg_101_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1156ui_story"].transform.localEulerAngles = arg_101_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1284ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1284ui_story = var_104_1.localPosition
			end

			local var_104_2 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 then
				var_104_1.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_101_1.time_ - 0) / var_104_2)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 then
				var_104_1.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			local var_104_3 = arg_101_1.actors_["1156ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1156ui_story == nil then
				arg_101_1.var_.characterEffect1156ui_story = var_104_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 and not isNil(var_104_3) then
				if arg_101_1.var_.characterEffect1156ui_story and not isNil(var_104_3) then
					arg_101_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1156ui_story then
				arg_101_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_104_6 = arg_101_1.actors_["1284ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1284ui_story == nil then
				arg_101_1.var_.characterEffect1284ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect1284ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect1284ui_story then
				arg_101_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action7_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_8 = 0
			local var_104_9 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(322041024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 16 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 16)

				if (16 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 16)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041024", "story_v_out_322041.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041024", "story_v_out_322041.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_322041", "322041024", "story_v_out_322041.awb")

						arg_101_1:RecordAudio("322041024", var_104_15)
						arg_101_1:RecordAudio("322041024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322041", "322041024", "story_v_out_322041.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322041", "322041024", "story_v_out_322041.awb")
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
				actorName = "1156ui_story",
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
	Play322041025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322041025
		arg_105_1.duration_ = 7.17

		local var_105_0 = {
			zh = 5.366,
			ja = 7.166
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
				arg_105_0:Play322041026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1284ui_story"]) and arg_105_1.var_.characterEffect1284ui_story == nil then
				arg_105_1.var_.characterEffect1284ui_story = arg_105_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1284ui_story"]) then
				if arg_105_1.var_.characterEffect1284ui_story and not isNil(arg_105_1.actors_["1284ui_story"]) then
					arg_105_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1284ui_story"]) and arg_105_1.var_.characterEffect1284ui_story then
				arg_105_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["1156ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1156ui_story == nil then
				arg_105_1.var_.characterEffect1156ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect1156ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1156ui_story then
				arg_105_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_2")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.8

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(322041025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 32 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 32)

				if (32 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 32)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041025", "story_v_out_322041.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041025", "story_v_out_322041.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_322041", "322041025", "story_v_out_322041.awb")

						arg_105_1:RecordAudio("322041025", var_108_11)
						arg_105_1:RecordAudio("322041025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322041", "322041025", "story_v_out_322041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322041", "322041025", "story_v_out_322041.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play322041026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322041026
		arg_109_1.duration_ = 9.07

		local var_109_0 = {
			zh = 6.166,
			ja = 9.066
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
				arg_109_0:Play322041027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.75

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(322041026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 30 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 30)

				if (30 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 30)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041026", "story_v_out_322041.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_322041", "322041026", "story_v_out_322041.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_322041", "322041026", "story_v_out_322041.awb")

						arg_109_1:RecordAudio("322041026", var_112_6)
						arg_109_1:RecordAudio("322041026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322041", "322041026", "story_v_out_322041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322041", "322041026", "story_v_out_322041.awb")
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
	Play322041027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322041027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322041028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_116_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_113_1.stage_.transform)

				var_116_0.name = "10104ui_story"
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10104ui_story"] = var_116_0

				local var_116_1 = var_116_0:GetComponentInChildren(typeof(CharacterEffect))

				var_116_1.enabled = true

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end

				arg_113_1:ShowWeapon(var_116_1.transform, false)

				arg_113_1.var_["10104ui_story" .. "Animator"] = var_116_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_113_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_113_1.var_["10104ui_story" .. "LipSync"] = var_116_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_116_3 = arg_113_1.actors_["10104ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10104ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10104ui_story, Vector3.New(-0.88, -1.12, -5.99), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(-0.88, -1.12, -5.99)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = arg_113_1.actors_["1156ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1156ui_story = var_116_5.localPosition
			end

			local var_116_6 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 then
				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_6)
				var_116_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_5.position).x, (manager.ui.mainCamera.transform.position - var_116_5.position).y, (manager.ui.mainCamera.transform.position - var_116_5.position).z)
				var_116_5.localEulerAngles.z = 0
				var_116_5.localEulerAngles.x = 0
				var_116_5.localEulerAngles = var_116_5.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(0, 100, 0)
				var_116_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_5.position).x, (manager.ui.mainCamera.transform.position - var_116_5.position).y, (manager.ui.mainCamera.transform.position - var_116_5.position).z)
				var_116_5.localEulerAngles.z = 0
				var_116_5.localEulerAngles.x = 0
				var_116_5.localEulerAngles = var_116_5.localEulerAngles
			end

			local var_116_7 = arg_113_1.actors_["10104ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect10104ui_story == nil then
				arg_113_1.var_.characterEffect10104ui_story = var_116_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_8 and not isNil(var_116_7) then
				if arg_113_1.var_.characterEffect10104ui_story and not isNil(var_116_7) then
					arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_8 and arg_113_1.time_ < 0 + var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect10104ui_story then
				arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_116_10 = arg_113_1.actors_["1284ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect1284ui_story == nil then
				arg_113_1.var_.characterEffect1284ui_story = var_116_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_11 and not isNil(var_116_10) then
				if arg_113_1.var_.characterEffect1284ui_story and not isNil(var_116_10) then
					arg_113_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_11)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_11 and arg_113_1.time_ < 0 + var_116_11 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect1284ui_story then
				arg_113_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				if arg_113_1.var_.characterEffect10104ui_story == nil then
					arg_113_1.var_.characterEffect10104ui_story = arg_113_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_116_12 = arg_113_1.var_.characterEffect10104ui_story

				arg_113_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_116_12.interferenceEffect.enabled = true
				var_116_12.interferenceEffect.noise = 0.001
				var_116_12.interferenceEffect.simTimeScale = 1
				var_116_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				if arg_113_1.var_.characterEffect10104ui_story == nil then
					arg_113_1.var_.characterEffect10104ui_story = arg_113_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_113_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_116_14 = 0
			local var_116_15 = 0.15

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_16 = arg_113_1:GetWordFromCfg(322041027)
				local var_116_17 = arg_113_1:FormatText(var_116_16.content)

				arg_113_1.text_.text = var_116_17

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 6 <= 0 and var_116_15 or var_116_15 * (utf8.len(var_116_17) / 6)

				if (6 <= 0 and var_116_15 or var_116_15 * (utf8.len(var_116_17) / 6)) > 0 and var_116_15 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_14
					end
				end

				arg_113_1.text_.text = var_116_17
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041027", "story_v_out_322041.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_out_322041", "322041027", "story_v_out_322041.awb") / 1000

					if var_116_20 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_14
					end

					if var_116_16.prefab_name ~= "" and arg_113_1.actors_[var_116_16.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_16.prefab_name].transform, "story_v_out_322041", "322041027", "story_v_out_322041.awb")

						arg_113_1:RecordAudio("322041027", var_116_21)
						arg_113_1:RecordAudio("322041027", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_322041", "322041027", "story_v_out_322041.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_322041", "322041027", "story_v_out_322041.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_15, arg_113_1.talkMaxDuration)

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_14) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_22 and arg_113_1.time_ < var_116_14 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
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
	Play322041028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 322041028
		arg_117_1.duration_ = 2.63

		local var_117_0 = {
			zh = 2.433,
			ja = 2.633
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
				arg_117_0:Play322041029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1284ui_story = arg_117_1.actors_["1284ui_story"].transform.localPosition

				arg_117_1:ShowWeapon(arg_117_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1284ui_story"].transform.position).z)
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1284ui_story"].transform.localEulerAngles = arg_117_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
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

			local var_120_4 = arg_117_1.actors_["10104ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10104ui_story == nil then
				arg_117_1.var_.characterEffect10104ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect10104ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10104ui_story then
				arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_120_6 = 0
			local var_120_7 = 0.3

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
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

				local var_120_8 = arg_117_1:GetWordFromCfg(322041028)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 12 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 12)

				if (12 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 12)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041028", "story_v_out_322041.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_322041", "322041028", "story_v_out_322041.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_322041", "322041028", "story_v_out_322041.awb")

						arg_117_1:RecordAudio("322041028", var_120_13)
						arg_117_1:RecordAudio("322041028", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_322041", "322041028", "story_v_out_322041.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_322041", "322041028", "story_v_out_322041.awb")
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
	Play322041029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 322041029
		arg_121_1.duration_ = 2.57

		local var_121_0 = {
			zh = 2.566,
			ja = 2.3
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
				arg_121_0:Play322041030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_124_0 = 0
			local var_124_1 = 0.225

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(322041029)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 9 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 9)

				if (9 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 9)) > 0 and var_124_1 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041029", "story_v_out_322041.awb") ~= 0 then
					local var_124_6 = manager.audio:GetVoiceLength("story_v_out_322041", "322041029", "story_v_out_322041.awb") / 1000

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end

					if var_124_2.prefab_name ~= "" and arg_121_1.actors_[var_124_2.prefab_name] ~= nil then
						local var_124_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_2.prefab_name].transform, "story_v_out_322041", "322041029", "story_v_out_322041.awb")

						arg_121_1:RecordAudio("322041029", var_124_7)
						arg_121_1:RecordAudio("322041029", var_124_7)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_322041", "322041029", "story_v_out_322041.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_322041", "322041029", "story_v_out_322041.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play322041030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 322041030
		arg_125_1.duration_ = 9.43

		local var_125_0 = {
			zh = 5.933,
			ja = 9.433
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
				arg_125_0:Play322041031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10104ui_story"]) and arg_125_1.var_.characterEffect10104ui_story == nil then
				arg_125_1.var_.characterEffect10104ui_story = arg_125_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10104ui_story"]) then
				if arg_125_1.var_.characterEffect10104ui_story and not isNil(arg_125_1.actors_["10104ui_story"]) then
					arg_125_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10104ui_story"]) and arg_125_1.var_.characterEffect10104ui_story then
				arg_125_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["1284ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1284ui_story == nil then
				arg_125_1.var_.characterEffect1284ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect1284ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1284ui_story then
				arg_125_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				if arg_125_1.var_.characterEffect10104ui_story == nil then
					arg_125_1.var_.characterEffect10104ui_story = arg_125_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_128_4 = arg_125_1.var_.characterEffect10104ui_story

				arg_125_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_128_4.interferenceEffect.enabled = true
				var_128_4.interferenceEffect.noise = 0.001
				var_128_4.interferenceEffect.simTimeScale = 1
				var_128_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				if arg_125_1.var_.characterEffect10104ui_story == nil then
					arg_125_1.var_.characterEffect10104ui_story = arg_125_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_125_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_128_6 = 0
			local var_128_7 = 0.825

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:GetWordFromCfg(322041030)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 33 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 33)

				if (33 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 33)) > 0 and var_128_7 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041030", "story_v_out_322041.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_322041", "322041030", "story_v_out_322041.awb") / 1000

					if var_128_12 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_6
					end

					if var_128_8.prefab_name ~= "" and arg_125_1.actors_[var_128_8.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_8.prefab_name].transform, "story_v_out_322041", "322041030", "story_v_out_322041.awb")

						arg_125_1:RecordAudio("322041030", var_128_13)
						arg_125_1:RecordAudio("322041030", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_322041", "322041030", "story_v_out_322041.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_322041", "322041030", "story_v_out_322041.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play322041031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 322041031
		arg_129_1.duration_ = 7.27

		local var_129_0 = {
			zh = 4.999999999999,
			ja = 7.266
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
				arg_129_0:Play322041032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				if arg_129_1.var_.characterEffect10104ui_story == nil then
					arg_129_1.var_.characterEffect10104ui_story = arg_129_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_132_0 = arg_129_1.var_.characterEffect10104ui_story

				arg_129_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_132_0.interferenceEffect.enabled = true
				var_132_0.interferenceEffect.noise = 0.001
				var_132_0.interferenceEffect.simTimeScale = 1
				var_132_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				if arg_129_1.var_.characterEffect10104ui_story == nil then
					arg_129_1.var_.characterEffect10104ui_story = arg_129_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_129_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_132_2 = 0
			local var_132_3 = 0.6

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
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

				local var_132_4 = arg_129_1:GetWordFromCfg(322041031)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 24 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 24)

				if (24 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 24)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041031", "story_v_out_322041.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041031", "story_v_out_322041.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_322041", "322041031", "story_v_out_322041.awb")

						arg_129_1:RecordAudio("322041031", var_132_9)
						arg_129_1:RecordAudio("322041031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_322041", "322041031", "story_v_out_322041.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_322041", "322041031", "story_v_out_322041.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play322041032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 322041032
		arg_133_1.duration_ = 3.23

		local var_133_0 = {
			zh = 2.233,
			ja = 3.233
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
				arg_133_0:Play322041033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1284ui_story"]) and arg_133_1.var_.characterEffect1284ui_story == nil then
				arg_133_1.var_.characterEffect1284ui_story = arg_133_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1284ui_story"]) then
				if arg_133_1.var_.characterEffect1284ui_story and not isNil(arg_133_1.actors_["1284ui_story"]) then
					arg_133_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1284ui_story"]) and arg_133_1.var_.characterEffect1284ui_story then
				arg_133_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["10104ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10104ui_story == nil then
				arg_133_1.var_.characterEffect10104ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect10104ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10104ui_story then
				arg_133_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_136_4 = 0
			local var_136_5 = 0.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(322041032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 11 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 11)

				if (11 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 11)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041032", "story_v_out_322041.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041032", "story_v_out_322041.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_322041", "322041032", "story_v_out_322041.awb")

						arg_133_1:RecordAudio("322041032", var_136_11)
						arg_133_1:RecordAudio("322041032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_322041", "322041032", "story_v_out_322041.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_322041", "322041032", "story_v_out_322041.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play322041033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 322041033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play322041034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1284ui_story"]) and arg_137_1.var_.characterEffect1284ui_story == nil then
				arg_137_1.var_.characterEffect1284ui_story = arg_137_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1284ui_story"]) then
				if arg_137_1.var_.characterEffect1284ui_story and not isNil(arg_137_1.actors_["1284ui_story"]) then
					arg_137_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1284ui_story"]) and arg_137_1.var_.characterEffect1284ui_story then
				arg_137_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0.9 < arg_137_1.time_ and arg_137_1.time_ <= 0.9 + arg_140_0 then
				arg_137_1:AudioAction("play", "effect", "se_story_145", "se_story_145_ui02", "")
			end

			local var_140_2 = 0
			local var_140_3 = 1.25

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(322041033).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 50 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 50)

				if (50 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 50)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play322041034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 322041034
		arg_141_1.duration_ = 4.7

		local var_141_0 = {
			zh = 4.7,
			ja = 4.133
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
				arg_141_0:Play322041035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1284ui_story"]) and arg_141_1.var_.characterEffect1284ui_story == nil then
				arg_141_1.var_.characterEffect1284ui_story = arg_141_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1284ui_story"]) then
				if arg_141_1.var_.characterEffect1284ui_story and not isNil(arg_141_1.actors_["1284ui_story"]) then
					arg_141_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1284ui_story"]) and arg_141_1.var_.characterEffect1284ui_story then
				arg_141_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_144_2 = 0
			local var_144_3 = 0.5

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:GetWordFromCfg(322041034)
				local var_144_5 = arg_141_1:FormatText(var_144_4.content)

				arg_141_1.text_.text = var_144_5

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_7 = 20 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 20)

				if (20 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_5) / 20)) > 0 and var_144_3 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_5
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041034", "story_v_out_322041.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_322041", "322041034", "story_v_out_322041.awb") / 1000

					if var_144_8 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_2
					end

					if var_144_4.prefab_name ~= "" and arg_141_1.actors_[var_144_4.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_4.prefab_name].transform, "story_v_out_322041", "322041034", "story_v_out_322041.awb")

						arg_141_1:RecordAudio("322041034", var_144_9)
						arg_141_1:RecordAudio("322041034", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_322041", "322041034", "story_v_out_322041.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_322041", "322041034", "story_v_out_322041.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_10 and arg_141_1.time_ < var_144_2 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play322041035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 322041035
		arg_145_1.duration_ = 8.07

		local var_145_0 = {
			zh = 4.999999999999,
			ja = 8.066
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
				arg_145_0:Play322041036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10104ui_story"]) and arg_145_1.var_.characterEffect10104ui_story == nil then
				arg_145_1.var_.characterEffect10104ui_story = arg_145_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10104ui_story"]) then
				if arg_145_1.var_.characterEffect10104ui_story and not isNil(arg_145_1.actors_["10104ui_story"]) then
					arg_145_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10104ui_story"]) and arg_145_1.var_.characterEffect10104ui_story then
				arg_145_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_148_2 = arg_145_1.actors_["1284ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1284ui_story == nil then
				arg_145_1.var_.characterEffect1284ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect1284ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect1284ui_story then
				arg_145_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				if arg_145_1.var_.characterEffect10104ui_story == nil then
					arg_145_1.var_.characterEffect10104ui_story = arg_145_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_148_4 = arg_145_1.var_.characterEffect10104ui_story

				arg_145_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_148_4.interferenceEffect.enabled = true
				var_148_4.interferenceEffect.noise = 0.001
				var_148_4.interferenceEffect.simTimeScale = 1
				var_148_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				if arg_145_1.var_.characterEffect10104ui_story == nil then
					arg_145_1.var_.characterEffect10104ui_story = arg_145_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_145_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_148_6 = 0
			local var_148_7 = 0.5

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(322041035)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 20 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 20)

				if (20 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 20)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041035", "story_v_out_322041.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_322041", "322041035", "story_v_out_322041.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_322041", "322041035", "story_v_out_322041.awb")

						arg_145_1:RecordAudio("322041035", var_148_13)
						arg_145_1:RecordAudio("322041035", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_322041", "322041035", "story_v_out_322041.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_322041", "322041035", "story_v_out_322041.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play322041036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322041036
		arg_149_1.duration_ = 10.77

		local var_149_0 = {
			zh = 8.632999999999,
			ja = 10.765999999999
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play322041037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.bgs_.L15f == nil then
				local var_152_0 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15f")
				var_152_0.name = "L15f"
				var_152_0.transform.parent = arg_149_1.stage_.transform
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_.L15f = var_152_0
			end

			if 1.999999999999 < arg_149_1.time_ and arg_149_1.time_ <= 1.999999999999 + arg_152_0 then
				local var_152_1 = arg_149_1.bgs_.L15f

				arg_149_1.bgs_.L15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_2 = var_152_1:GetComponent("SpriteRenderer")

				if var_152_2 and var_152_2.sprite then
					local var_152_3 = 2 * (var_152_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_1.transform.localScale = Vector3.New(var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, var_152_3 / var_152_2.sprite.bounds.size.y < var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x and var_152_3 * manager.ui.mainCameraCom_.aspect / var_152_2.sprite.bounds.size.x or var_152_3 / var_152_2.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "L15f" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_4 = 3.999999999999

			if 3.999999999999 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_4 + 0.3 and arg_149_1.time_ < var_152_4 + 0.3 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			local var_152_5 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_6 = 2

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 then
				local var_152_7 = Color.New(0, 0, 0)

				var_152_7.a = Mathf.Lerp(0, 1, (arg_149_1.time_ - var_152_5) / var_152_6)
				arg_149_1.mask_.color = var_152_7
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 then
				local var_152_8 = Color.New(0, 0, 0)

				var_152_8.a = 1
				arg_149_1.mask_.color = var_152_8
			end

			local var_152_9 = 2

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_10 = 2

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_10 then
				local var_152_11 = Color.New(0, 0, 0)

				var_152_11.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - var_152_9) / var_152_10)
				arg_149_1.mask_.color = var_152_11
			end

			if arg_149_1.time_ >= var_152_9 + var_152_10 and arg_149_1.time_ < var_152_9 + var_152_10 + arg_152_0 then
				local var_152_12 = Color.New(0, 0, 0)

				arg_149_1.mask_.enabled = false
				var_152_12.a = 0
				arg_149_1.mask_.color = var_152_12
			end

			local var_152_13 = arg_149_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_149_1.time_ and arg_149_1.time_ <= 1.96599999815226 + arg_152_0 then
				arg_149_1.var_.moveOldPos10104ui_story = var_152_13.localPosition
			end

			local var_152_14 = 0.001

			if 1.96599999815226 <= arg_149_1.time_ and arg_149_1.time_ < 1.96599999815226 + var_152_14 then
				var_152_13.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 1.96599999815226) / var_152_14)
				var_152_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_13.position).x, (manager.ui.mainCamera.transform.position - var_152_13.position).y, (manager.ui.mainCamera.transform.position - var_152_13.position).z)
				var_152_13.localEulerAngles.z = 0
				var_152_13.localEulerAngles.x = 0
				var_152_13.localEulerAngles = var_152_13.localEulerAngles
			end

			if arg_149_1.time_ >= 1.96599999815226 + var_152_14 and arg_149_1.time_ < 1.96599999815226 + var_152_14 + arg_152_0 then
				var_152_13.localPosition = Vector3.New(0, 100, 0)
				var_152_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_13.position).x, (manager.ui.mainCamera.transform.position - var_152_13.position).y, (manager.ui.mainCamera.transform.position - var_152_13.position).z)
				var_152_13.localEulerAngles.z = 0
				var_152_13.localEulerAngles.x = 0
				var_152_13.localEulerAngles = var_152_13.localEulerAngles
			end

			local var_152_15 = arg_149_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_149_1.time_ and arg_149_1.time_ <= 1.96599999815226 + arg_152_0 then
				arg_149_1.var_.moveOldPos1284ui_story = var_152_15.localPosition
			end

			local var_152_16 = 0.001

			if 1.96599999815226 <= arg_149_1.time_ and arg_149_1.time_ < 1.96599999815226 + var_152_16 then
				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 1.96599999815226) / var_152_16)
				var_152_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_15.position).x, (manager.ui.mainCamera.transform.position - var_152_15.position).y, (manager.ui.mainCamera.transform.position - var_152_15.position).z)
				var_152_15.localEulerAngles.z = 0
				var_152_15.localEulerAngles.x = 0
				var_152_15.localEulerAngles = var_152_15.localEulerAngles
			end

			if arg_149_1.time_ >= 1.96599999815226 + var_152_16 and arg_149_1.time_ < 1.96599999815226 + var_152_16 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(0, 100, 0)
				var_152_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_15.position).x, (manager.ui.mainCamera.transform.position - var_152_15.position).y, (manager.ui.mainCamera.transform.position - var_152_15.position).z)
				var_152_15.localEulerAngles.z = 0
				var_152_15.localEulerAngles.x = 0
				var_152_15.localEulerAngles = var_152_15.localEulerAngles
			end

			local var_152_17 = "10103ui_story"

			if arg_149_1.actors_["10103ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10103ui_story"))) then
				local var_152_18 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_149_1.stage_.transform)

				var_152_18.name = var_152_17
				var_152_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_[var_152_17] = var_152_18

				local var_152_19 = var_152_18:GetComponentInChildren(typeof(CharacterEffect))

				var_152_19.enabled = true

				local var_152_20 = GameObjectTools.GetOrAddComponent(var_152_18, typeof(DynamicBoneHelper))

				if var_152_20 then
					var_152_20:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_19.transform, false)

				arg_149_1.var_[var_152_17 .. "Animator"] = var_152_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_[var_152_17 .. "Animator"].applyRootMotion = true
				arg_149_1.var_[var_152_17 .. "LipSync"] = var_152_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_152_21 = arg_149_1.actors_["10103ui_story"].transform

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1.var_.moveOldPos10103ui_story = var_152_21.localPosition

				local var_152_22 = GameObjectTools.GetOrAddComponent(var_152_21.gameObject, typeof(DynamicBoneHelper))

				if var_152_22 then
					var_152_22:EnableDynamicBone(false)
				end
			end

			local var_152_23 = 0.001

			if 3.8 <= arg_149_1.time_ and arg_149_1.time_ < 3.8 + var_152_23 then
				var_152_21.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_149_1.time_ - 3.8) / var_152_23)
				var_152_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_21.position).x, (manager.ui.mainCamera.transform.position - var_152_21.position).y, (manager.ui.mainCamera.transform.position - var_152_21.position).z)
				var_152_21.localEulerAngles.z = 0
				var_152_21.localEulerAngles.x = 0
				var_152_21.localEulerAngles = var_152_21.localEulerAngles
			end

			if arg_149_1.time_ >= 3.8 + var_152_23 and arg_149_1.time_ < 3.8 + var_152_23 + arg_152_0 then
				var_152_21.localPosition = Vector3.New(0, -0.95, -6.2)
				var_152_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_21.position).x, (manager.ui.mainCamera.transform.position - var_152_21.position).y, (manager.ui.mainCamera.transform.position - var_152_21.position).z)
				var_152_21.localEulerAngles.z = 0
				var_152_21.localEulerAngles.x = 0
				var_152_21.localEulerAngles = var_152_21.localEulerAngles

				local var_152_24 = GameObjectTools.GetOrAddComponent(var_152_21.gameObject, typeof(DynamicBoneHelper))

				if var_152_24 then
					var_152_24:EnableDynamicBone(true)
				end
			end

			local var_152_25 = arg_149_1.actors_["10103ui_story"]

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 and not isNil(var_152_25) and arg_149_1.var_.characterEffect10103ui_story == nil then
				arg_149_1.var_.characterEffect10103ui_story = var_152_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_26 = 0.200000002980232

			if 3.8 <= arg_149_1.time_ and arg_149_1.time_ < 3.8 + var_152_26 and not isNil(var_152_25) then
				if arg_149_1.var_.characterEffect10103ui_story and not isNil(var_152_25) then
					arg_149_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 3.8 + var_152_26 and arg_149_1.time_ < 3.8 + var_152_26 + arg_152_0 and not isNil(var_152_25) and arg_149_1.var_.characterEffect10103ui_story then
				arg_149_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				arg_149_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= 2 + arg_152_0 then
				if arg_149_1.var_.characterEffect10104ui_story == nil then
					arg_149_1.var_.characterEffect10104ui_story = arg_149_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_152_28 = arg_149_1.var_.characterEffect10104ui_story

				arg_149_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_152_28.interferenceEffect.enabled = false
				var_152_28.interferenceEffect.noise = 0.001
				var_152_28.interferenceEffect.simTimeScale = 1
				var_152_28.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 2 < arg_149_1.time_ and arg_149_1.time_ <= 2 + arg_152_0 then
				if arg_149_1.var_.characterEffect10104ui_story == nil then
					arg_149_1.var_.characterEffect10104ui_story = arg_149_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_149_1.var_.characterEffect10104ui_story.imageEffect:turnOff()
			end

			if 3.8 < arg_149_1.time_ and arg_149_1.time_ <= 3.8 + arg_152_0 then
				if not isNil(arg_149_1.actors_["10103ui_story"]) then
					local var_152_30 = GameObjectTools.GetOrAddComponent(arg_149_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_152_30 then
						var_152_30:EnableDynamicBone(true)
					end
				end
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_31 = 3.999999999999
			local var_152_32 = 0.475

			if 3.999999999999 < arg_149_1.time_ and arg_149_1.time_ <= var_152_31 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_33 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_33:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_34 = arg_149_1:GetWordFromCfg(322041036)
				local var_152_35 = arg_149_1:FormatText(var_152_34.content)

				arg_149_1.text_.text = var_152_35

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_37 = 19 <= 0 and var_152_32 or var_152_32 * (utf8.len(var_152_35) / 19)

				if (19 <= 0 and var_152_32 or var_152_32 * (utf8.len(var_152_35) / 19)) > 0 and var_152_32 < var_152_37 then
					arg_149_1.talkMaxDuration = var_152_37
					var_152_31 = var_152_31 + 0.3

					if var_152_37 + var_152_31 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_37 + var_152_31
					end
				end

				arg_149_1.text_.text = var_152_35
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041036", "story_v_out_322041.awb") ~= 0 then
					local var_152_38 = manager.audio:GetVoiceLength("story_v_out_322041", "322041036", "story_v_out_322041.awb") / 1000

					if var_152_38 + var_152_31 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_31
					end

					if var_152_34.prefab_name ~= "" and arg_149_1.actors_[var_152_34.prefab_name] ~= nil then
						local var_152_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_34.prefab_name].transform, "story_v_out_322041", "322041036", "story_v_out_322041.awb")

						arg_149_1:RecordAudio("322041036", var_152_39)
						arg_149_1:RecordAudio("322041036", var_152_39)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322041", "322041036", "story_v_out_322041.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322041", "322041036", "story_v_out_322041.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_40 = var_152_31 + 0.3
			local var_152_41 = math.max(var_152_32, arg_149_1.talkMaxDuration)

			if var_152_31 + 0.3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_40 + var_152_41 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_40) / var_152_41

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_40 + var_152_41 and arg_149_1.time_ < var_152_40 + var_152_41 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play322041037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322041037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play322041038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10103ui_story = arg_155_1.actors_["10103ui_story"].transform.localPosition

				local var_158_0 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_0 then
					var_158_0:EnableDynamicBone(false)
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_1)
				arg_155_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10103ui_story"].transform.position).z)
				arg_155_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10103ui_story"].transform.localEulerAngles = arg_155_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10103ui_story"].transform.position).z)
				arg_155_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10103ui_story"].transform.localEulerAngles = arg_155_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_158_2 = GameObjectTools.GetOrAddComponent(arg_155_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_158_2 then
					var_158_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_145", "se_story_145_police_car", "")
			end

			local var_158_4 = 0
			local var_158_5 = 0.975

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(322041037).content)

				arg_155_1.text_.text = var_158_6

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_8 = 39 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_6) / 39)

				if (39 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_6) / 39)) > 0 and var_158_5 < var_158_8 then
					arg_155_1.talkMaxDuration = var_158_8

					if var_158_8 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_6
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_9 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_9 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_9

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_9 and arg_155_1.time_ < var_158_4 + var_158_9 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322041038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322041038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322041039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.575

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(322041038).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 23 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 23)

				if (23 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 23)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322041039
		arg_163_1.duration_ = 8.73

		local var_163_0 = {
			zh = 5.1,
			ja = 8.733
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
				arg_163_0:Play322041040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10103ui_story = arg_163_1.actors_["10103ui_story"].transform.localPosition

				local var_166_0 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_0 then
					var_166_0:EnableDynamicBone(false)
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_163_1.time_ - 0) / var_166_1)
				arg_163_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10103ui_story"].transform.position).z)
				arg_163_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10103ui_story"].transform.localEulerAngles = arg_163_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_163_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["10103ui_story"].transform.position).z)
				arg_163_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["10103ui_story"].transform.localEulerAngles = arg_163_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_166_2 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(true)
				end
			end

			local var_166_3 = arg_163_1.actors_["10103ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect10103ui_story == nil then
				arg_163_1.var_.characterEffect10103ui_story = var_166_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_4 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 and not isNil(var_166_3) then
				if arg_163_1.var_.characterEffect10103ui_story and not isNil(var_166_3) then
					arg_163_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 and not isNil(var_166_3) and arg_163_1.var_.characterEffect10103ui_story then
				arg_163_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				if not isNil(arg_163_1.actors_["10103ui_story"]) then
					local var_166_6 = GameObjectTools.GetOrAddComponent(arg_163_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_166_6 then
						var_166_6:EnableDynamicBone(true)
					end
				end
			end

			local var_166_7 = 0
			local var_166_8 = 0.6

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_9 = arg_163_1:GetWordFromCfg(322041039)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_12 = 24 <= 0 and var_166_8 or var_166_8 * (utf8.len(var_166_10) / 24)

				if (24 <= 0 and var_166_8 or var_166_8 * (utf8.len(var_166_10) / 24)) > 0 and var_166_8 < var_166_12 then
					arg_163_1.talkMaxDuration = var_166_12

					if var_166_12 + var_166_7 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_7
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041039", "story_v_out_322041.awb") ~= 0 then
					local var_166_13 = manager.audio:GetVoiceLength("story_v_out_322041", "322041039", "story_v_out_322041.awb") / 1000

					if var_166_13 + var_166_7 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_7
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_out_322041", "322041039", "story_v_out_322041.awb")

						arg_163_1:RecordAudio("322041039", var_166_14)
						arg_163_1:RecordAudio("322041039", var_166_14)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_322041", "322041039", "story_v_out_322041.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_322041", "322041039", "story_v_out_322041.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_8, arg_163_1.talkMaxDuration)

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_7) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_7 + var_166_15 and arg_163_1.time_ < var_166_7 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322041040
		arg_167_1.duration_ = 2.8

		local var_167_0 = {
			zh = 2.566,
			ja = 2.8
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
				arg_167_0:Play322041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if arg_167_1.actors_["10150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10150ui_story"))) then
				local var_170_0 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_167_1.stage_.transform)

				var_170_0.name = "10150ui_story"
				var_170_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["10150ui_story"] = var_170_0

				local var_170_1 = var_170_0:GetComponentInChildren(typeof(CharacterEffect))

				var_170_1.enabled = true

				local var_170_2 = GameObjectTools.GetOrAddComponent(var_170_0, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(false)
				end

				arg_167_1:ShowWeapon(var_170_1.transform, false)

				arg_167_1.var_["10150ui_story" .. "Animator"] = var_170_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_167_1.var_["10150ui_story" .. "Animator"].applyRootMotion = true
				arg_167_1.var_["10150ui_story" .. "LipSync"] = var_170_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_170_3 = arg_167_1.actors_["10150ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10150ui_story = var_170_3.localPosition

				local var_170_4 = GameObjectTools.GetOrAddComponent(var_170_3.gameObject, typeof(DynamicBoneHelper))

				if var_170_4 then
					var_170_4:EnableDynamicBone(false)
				end
			end

			local var_170_5 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10150ui_story, Vector3.New(0.9, -1.73, -5.5), (arg_167_1.time_ - 0) / var_170_5)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0.9, -1.73, -5.5)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles

				local var_170_6 = GameObjectTools.GetOrAddComponent(var_170_3.gameObject, typeof(DynamicBoneHelper))

				if var_170_6 then
					var_170_6:EnableDynamicBone(true)
				end
			end

			local var_170_7 = arg_167_1.actors_["10150ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.characterEffect10150ui_story == nil then
				arg_167_1.var_.characterEffect10150ui_story = var_170_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_8 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_8 and not isNil(var_170_7) then
				if arg_167_1.var_.characterEffect10150ui_story and not isNil(var_170_7) then
					arg_167_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_8 and arg_167_1.time_ < 0 + var_170_8 + arg_170_0 and not isNil(var_170_7) and arg_167_1.var_.characterEffect10150ui_story then
				arg_167_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_170_10 = arg_167_1.actors_["10103ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_10) and arg_167_1.var_.characterEffect10103ui_story == nil then
				arg_167_1.var_.characterEffect10103ui_story = var_170_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_11 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_11 and not isNil(var_170_10) then
				if arg_167_1.var_.characterEffect10103ui_story and not isNil(var_170_10) then
					arg_167_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_11)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_11 and arg_167_1.time_ < 0 + var_170_11 + arg_170_0 and not isNil(var_170_10) and arg_167_1.var_.characterEffect10103ui_story then
				arg_167_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_170_12 = 0
			local var_170_13 = 0.275

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_12 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_14 = arg_167_1:GetWordFromCfg(322041040)
				local var_170_15 = arg_167_1:FormatText(var_170_14.content)

				arg_167_1.text_.text = var_170_15

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_17 = 11 <= 0 and var_170_13 or var_170_13 * (utf8.len(var_170_15) / 11)

				if (11 <= 0 and var_170_13 or var_170_13 * (utf8.len(var_170_15) / 11)) > 0 and var_170_13 < var_170_17 then
					arg_167_1.talkMaxDuration = var_170_17

					if var_170_17 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_12
					end
				end

				arg_167_1.text_.text = var_170_15
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041040", "story_v_out_322041.awb") ~= 0 then
					local var_170_18 = manager.audio:GetVoiceLength("story_v_out_322041", "322041040", "story_v_out_322041.awb") / 1000

					if var_170_18 + var_170_12 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_12
					end

					if var_170_14.prefab_name ~= "" and arg_167_1.actors_[var_170_14.prefab_name] ~= nil then
						local var_170_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_14.prefab_name].transform, "story_v_out_322041", "322041040", "story_v_out_322041.awb")

						arg_167_1:RecordAudio("322041040", var_170_19)
						arg_167_1:RecordAudio("322041040", var_170_19)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_322041", "322041040", "story_v_out_322041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_322041", "322041040", "story_v_out_322041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_20 = math.max(var_170_13, arg_167_1.talkMaxDuration)

			if var_170_12 <= arg_167_1.time_ and arg_167_1.time_ < var_170_12 + var_170_20 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_12) / var_170_20

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_12 + var_170_20 and arg_167_1.time_ < var_170_12 + var_170_20 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322041041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322041041
		arg_171_1.duration_ = 7.93

		local var_171_0 = {
			zh = 5.233,
			ja = 7.933
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
				arg_171_0:Play322041042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10103ui_story = arg_171_1.actors_["10103ui_story"].transform.localPosition

				local var_174_0 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_0 then
					var_174_0:EnableDynamicBone(false)
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_171_1.time_ - 0) / var_174_1)
				arg_171_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10103ui_story"].transform.position).z)
				arg_171_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10103ui_story"].transform.localEulerAngles = arg_171_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_171_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10103ui_story"].transform.position).z)
				arg_171_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10103ui_story"].transform.localEulerAngles = arg_171_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_174_2 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(true)
				end
			end

			local var_174_3 = arg_171_1.actors_["10103ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect10103ui_story == nil then
				arg_171_1.var_.characterEffect10103ui_story = var_174_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_4 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 and not isNil(var_174_3) then
				if arg_171_1.var_.characterEffect10103ui_story and not isNil(var_174_3) then
					arg_171_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 and not isNil(var_174_3) and arg_171_1.var_.characterEffect10103ui_story then
				arg_171_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_174_6 = arg_171_1.actors_["10150ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect10150ui_story == nil then
				arg_171_1.var_.characterEffect10150ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_7 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 and not isNil(var_174_6) then
				if arg_171_1.var_.characterEffect10150ui_story and not isNil(var_174_6) then
					arg_171_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_7)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect10150ui_story then
				arg_171_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				if not isNil(arg_171_1.actors_["10103ui_story"]) then
					local var_174_8 = GameObjectTools.GetOrAddComponent(arg_171_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_174_8 then
						var_174_8:EnableDynamicBone(true)
					end
				end
			end

			local var_174_9 = 0
			local var_174_10 = 0.45

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_9 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_11 = arg_171_1:GetWordFromCfg(322041041)
				local var_174_12 = arg_171_1:FormatText(var_174_11.content)

				arg_171_1.text_.text = var_174_12

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_14 = 18 <= 0 and var_174_10 or var_174_10 * (utf8.len(var_174_12) / 18)

				if (18 <= 0 and var_174_10 or var_174_10 * (utf8.len(var_174_12) / 18)) > 0 and var_174_10 < var_174_14 then
					arg_171_1.talkMaxDuration = var_174_14

					if var_174_14 + var_174_9 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_9
					end
				end

				arg_171_1.text_.text = var_174_12
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041041", "story_v_out_322041.awb") ~= 0 then
					local var_174_15 = manager.audio:GetVoiceLength("story_v_out_322041", "322041041", "story_v_out_322041.awb") / 1000

					if var_174_15 + var_174_9 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_15 + var_174_9
					end

					if var_174_11.prefab_name ~= "" and arg_171_1.actors_[var_174_11.prefab_name] ~= nil then
						local var_174_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_11.prefab_name].transform, "story_v_out_322041", "322041041", "story_v_out_322041.awb")

						arg_171_1:RecordAudio("322041041", var_174_16)
						arg_171_1:RecordAudio("322041041", var_174_16)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_322041", "322041041", "story_v_out_322041.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_322041", "322041041", "story_v_out_322041.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_17 = math.max(var_174_10, arg_171_1.talkMaxDuration)

			if var_174_9 <= arg_171_1.time_ and arg_171_1.time_ < var_174_9 + var_174_17 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_9) / var_174_17

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_9 + var_174_17 and arg_171_1.time_ < var_174_9 + var_174_17 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322041042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322041042
		arg_175_1.duration_ = 8.5

		local var_175_0 = {
			zh = 8.166,
			ja = 8.5
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
				arg_175_0:Play322041043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.8

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(322041042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 32 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 32)

				if (32 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 32)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041042", "story_v_out_322041.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_322041", "322041042", "story_v_out_322041.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_322041", "322041042", "story_v_out_322041.awb")

						arg_175_1:RecordAudio("322041042", var_178_6)
						arg_175_1:RecordAudio("322041042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322041", "322041042", "story_v_out_322041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322041", "322041042", "story_v_out_322041.awb")
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
	Play322041043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322041043
		arg_179_1.duration_ = 5.67

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322041044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_9000

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10103ui_story = arg_179_1.actors_["10103ui_story"].transform.localPosition

				local var_182_0 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_0 then
					var_182_0:EnableDynamicBone(false)
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_1)
				arg_179_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10103ui_story"].transform.position).z)
				arg_179_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10103ui_story"].transform.localEulerAngles = arg_179_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10103ui_story"].transform.position).z)
				arg_179_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10103ui_story"].transform.localEulerAngles = arg_179_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_182_2 = GameObjectTools.GetOrAddComponent(arg_179_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(true)
				end
			end

			local var_182_3 = arg_179_1.actors_["10150ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10150ui_story = var_182_3.localPosition

				local var_182_4 = GameObjectTools.GetOrAddComponent(var_182_3.gameObject, typeof(DynamicBoneHelper))

				if var_182_4 then
					var_182_4:EnableDynamicBone(false)
				end
			end

			local var_182_5 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 then
				var_182_3.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_5)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 then
				var_182_3.localPosition = Vector3.New(0, 100, 0)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles

				local var_182_6 = GameObjectTools.GetOrAddComponent(var_182_3.gameObject, typeof(DynamicBoneHelper))

				if var_182_6 then
					var_182_6:EnableDynamicBone(true)
				end
			end

			local var_182_7 = arg_179_1.actors_["10103ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.characterEffect10103ui_story == nil then
				arg_179_1.var_.characterEffect10103ui_story = var_182_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_8 = 0.400000005960464

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_8 and not isNil(var_182_7) then
				if arg_179_1.var_.characterEffect10103ui_story and not isNil(var_182_7) then
					arg_179_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_8)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_8 and arg_179_1.time_ < 0 + var_182_8 + arg_182_0 and not isNil(var_182_7) and arg_179_1.var_.characterEffect10103ui_story then
				arg_179_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0.400000005960464 < arg_179_1.time_ and arg_179_1.time_ <= 0.400000005960464 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car02", "")
			end

			if 0.766666666666667 < arg_179_1.time_ and arg_179_1.time_ <= 0.766666666666667 + arg_182_0 then
				local var_182_10 = arg_179_1.var_.effect1043

				if not arg_179_1.var_.effect1043 then
					var_182_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_182_10.name = "1043"
					arg_179_1.var_.effect1043 = var_182_10
				else
					var_182_10.transform:SetParent(var_182_9000)
				end

				var_182_10.transform.localPosition = Vector3.New(0, 0, -3.74)
				var_182_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.89999999701977 < arg_179_1.time_ and arg_179_1.time_ <= 1.89999999701977 + arg_182_0 then
				if arg_179_1.var_.effect1043 then
					Object.Destroy(arg_179_1.var_.effect1043)

					arg_179_1.var_.effect1043 = nil
				end
			end

			local var_182_13 = manager.ui.mainCamera.transform

			if 0.766666666666667 < arg_179_1.time_ and arg_179_1.time_ <= 0.766666666666667 + arg_182_0 then
				arg_179_1.var_.shakeOldPos = var_182_13.localPosition
			end

			local var_182_14 = 1

			if 0.766666666666667 <= arg_179_1.time_ and arg_179_1.time_ < 0.766666666666667 + var_182_14 then
				local var_182_15, var_182_16 = math.modf((arg_179_1.time_ - 0.766666666666667) / 0.132)

				var_182_13.localPosition = Vector3.New(var_182_16 * 0.04, var_182_16 * 0.04, var_182_16 * 0.04) + arg_179_1.var_.shakeOldPos
			end

			if arg_179_1.time_ >= 0.766666666666667 + var_182_14 and arg_179_1.time_ < 0.766666666666667 + var_182_14 + arg_182_0 then
				var_182_13.localPosition = arg_179_1.var_.shakeOldPos
			end

			local var_182_17 = 0.666666666666667
			local var_182_18 = 1.125

			if 0.666666666666667 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_19 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(322041043).content)

				arg_179_1.text_.text = var_182_19

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_21 = 45 <= 0 and var_182_18 or var_182_18 * (utf8.len(var_182_19) / 45)

				if (45 <= 0 and var_182_18 or var_182_18 * (utf8.len(var_182_19) / 45)) > 0 and var_182_18 < var_182_21 then
					arg_179_1.talkMaxDuration = var_182_21

					if var_182_21 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_21 + var_182_17
					end
				end

				arg_179_1.text_.text = var_182_19
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_22 = math.max(var_182_18, arg_179_1.talkMaxDuration)

			if var_182_17 <= arg_179_1.time_ and arg_179_1.time_ < var_182_17 + var_182_22 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_17) / var_182_22

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_17 + var_182_22 and arg_179_1.time_ < var_182_17 + var_182_22 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322041044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322041044
		arg_183_1.duration_ = 2

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322041045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1284ui_story = arg_183_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1284ui_story"].transform.position).z)
				arg_183_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1284ui_story"].transform.localEulerAngles = arg_183_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_183_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1284ui_story"].transform.position).z)
				arg_183_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1284ui_story"].transform.localEulerAngles = arg_183_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1284ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1284ui_story == nil then
				arg_183_1.var_.characterEffect1284ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1284ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1284ui_story then
				arg_183_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_4 = 0
			local var_186_5 = 0.175

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(322041044)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 7 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 7)

				if (7 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 7)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041044", "story_v_out_322041.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041044", "story_v_out_322041.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_322041", "322041044", "story_v_out_322041.awb")

						arg_183_1:RecordAudio("322041044", var_186_11)
						arg_183_1:RecordAudio("322041044", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_322041", "322041044", "story_v_out_322041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_322041", "322041044", "story_v_out_322041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play322041045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322041045
		arg_187_1.duration_ = 7.17

		local var_187_0 = {
			zh = 3.2,
			ja = 7.166
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
				arg_187_0:Play322041046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1284ui_story = arg_187_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1284ui_story"].transform.position).z)
				arg_187_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1284ui_story"].transform.localEulerAngles = arg_187_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1284ui_story"].transform.position).z)
				arg_187_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1284ui_story"].transform.localEulerAngles = arg_187_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["10103ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10103ui_story = var_190_1.localPosition

				local var_190_2 = GameObjectTools.GetOrAddComponent(var_190_1.gameObject, typeof(DynamicBoneHelper))

				if var_190_2 then
					var_190_2:EnableDynamicBone(false)
				end
			end

			local var_190_3 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 then
				var_190_1.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_187_1.time_ - 0) / var_190_3)
				var_190_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_1.position).x, (manager.ui.mainCamera.transform.position - var_190_1.position).y, (manager.ui.mainCamera.transform.position - var_190_1.position).z)
				var_190_1.localEulerAngles.z = 0
				var_190_1.localEulerAngles.x = 0
				var_190_1.localEulerAngles = var_190_1.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 then
				var_190_1.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				var_190_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_1.position).x, (manager.ui.mainCamera.transform.position - var_190_1.position).y, (manager.ui.mainCamera.transform.position - var_190_1.position).z)
				var_190_1.localEulerAngles.z = 0
				var_190_1.localEulerAngles.x = 0
				var_190_1.localEulerAngles = var_190_1.localEulerAngles

				local var_190_4 = GameObjectTools.GetOrAddComponent(var_190_1.gameObject, typeof(DynamicBoneHelper))

				if var_190_4 then
					var_190_4:EnableDynamicBone(true)
				end
			end

			local var_190_5 = arg_187_1.actors_["10103ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect10103ui_story == nil then
				arg_187_1.var_.characterEffect10103ui_story = var_190_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.characterEffect10103ui_story and not isNil(var_190_5) then
					arg_187_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect10103ui_story then
				arg_187_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_190_8 = arg_187_1.actors_["1284ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.characterEffect1284ui_story == nil then
				arg_187_1.var_.characterEffect1284ui_story = var_190_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_9 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_9 and not isNil(var_190_8) then
				if arg_187_1.var_.characterEffect1284ui_story and not isNil(var_190_8) then
					arg_187_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_9)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_9 and arg_187_1.time_ < 0 + var_190_9 + arg_190_0 and not isNil(var_190_8) and arg_187_1.var_.characterEffect1284ui_story then
				arg_187_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				if not isNil(arg_187_1.actors_["10103ui_story"]) then
					local var_190_10 = GameObjectTools.GetOrAddComponent(arg_187_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_190_10 then
						var_190_10:EnableDynamicBone(true)
					end
				end
			end

			local var_190_11 = 0
			local var_190_12 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_13 = arg_187_1:GetWordFromCfg(322041045)
				local var_190_14 = arg_187_1:FormatText(var_190_13.content)

				arg_187_1.text_.text = var_190_14

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_16 = 11 <= 0 and var_190_12 or var_190_12 * (utf8.len(var_190_14) / 11)

				if (11 <= 0 and var_190_12 or var_190_12 * (utf8.len(var_190_14) / 11)) > 0 and var_190_12 < var_190_16 then
					arg_187_1.talkMaxDuration = var_190_16

					if var_190_16 + var_190_11 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_16 + var_190_11
					end
				end

				arg_187_1.text_.text = var_190_14
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041045", "story_v_out_322041.awb") ~= 0 then
					local var_190_17 = manager.audio:GetVoiceLength("story_v_out_322041", "322041045", "story_v_out_322041.awb") / 1000

					if var_190_17 + var_190_11 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_17 + var_190_11
					end

					if var_190_13.prefab_name ~= "" and arg_187_1.actors_[var_190_13.prefab_name] ~= nil then
						local var_190_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_13.prefab_name].transform, "story_v_out_322041", "322041045", "story_v_out_322041.awb")

						arg_187_1:RecordAudio("322041045", var_190_18)
						arg_187_1:RecordAudio("322041045", var_190_18)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_322041", "322041045", "story_v_out_322041.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_322041", "322041045", "story_v_out_322041.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_19 = math.max(var_190_12, arg_187_1.talkMaxDuration)

			if var_190_11 <= arg_187_1.time_ and arg_187_1.time_ < var_190_11 + var_190_19 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_11) / var_190_19

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_11 + var_190_19 and arg_187_1.time_ < var_190_11 + var_190_19 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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
				actorName = "10103ui_story",
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
	Play322041046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322041046
		arg_191_1.duration_ = 2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322041047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10150ui_story = arg_191_1.actors_["10150ui_story"].transform.localPosition

				local var_194_0 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_0 then
					var_194_0:EnableDynamicBone(false)
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10150ui_story, Vector3.New(0.9, -1.73, -5.5), (arg_191_1.time_ - 0) / var_194_1)
				arg_191_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10150ui_story"].transform.position).z)
				arg_191_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10150ui_story"].transform.localEulerAngles = arg_191_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0.9, -1.73, -5.5)
				arg_191_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10150ui_story"].transform.position).z)
				arg_191_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10150ui_story"].transform.localEulerAngles = arg_191_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_194_2 = GameObjectTools.GetOrAddComponent(arg_191_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_194_2 then
					var_194_2:EnableDynamicBone(true)
				end
			end

			local var_194_3 = arg_191_1.actors_["10150ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect10150ui_story == nil then
				arg_191_1.var_.characterEffect10150ui_story = var_194_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 and not isNil(var_194_3) then
				if arg_191_1.var_.characterEffect10150ui_story and not isNil(var_194_3) then
					arg_191_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect10150ui_story then
				arg_191_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_194_6 = arg_191_1.actors_["10103ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect10103ui_story == nil then
				arg_191_1.var_.characterEffect10103ui_story = var_194_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_7 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 and not isNil(var_194_6) then
				if arg_191_1.var_.characterEffect10103ui_story and not isNil(var_194_6) then
					arg_191_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_7)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect10103ui_story then
				arg_191_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action4_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_194_8 = 0
			local var_194_9 = 0.175

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(322041046)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 7 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 7)

				if (7 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 7)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041046", "story_v_out_322041.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041046", "story_v_out_322041.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_322041", "322041046", "story_v_out_322041.awb")

						arg_191_1:RecordAudio("322041046", var_194_15)
						arg_191_1:RecordAudio("322041046", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322041", "322041046", "story_v_out_322041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322041", "322041046", "story_v_out_322041.awb")
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
				actorName = "10150ui_story",
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
	Play322041047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322041047
		arg_195_1.duration_ = 8.47

		local var_195_0 = {
			zh = 4.333,
			ja = 8.466
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
				arg_195_0:Play322041048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10103ui_story = arg_195_1.actors_["10103ui_story"].transform.localPosition

				local var_198_0 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_0 then
					var_198_0:EnableDynamicBone(false)
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_195_1.time_ - 0) / var_198_1)
				arg_195_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10103ui_story"].transform.position).z)
				arg_195_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10103ui_story"].transform.localEulerAngles = arg_195_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				arg_195_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10103ui_story"].transform.position).z)
				arg_195_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10103ui_story"].transform.localEulerAngles = arg_195_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_198_2 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(true)
				end
			end

			local var_198_3 = arg_195_1.actors_["10103ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect10103ui_story == nil then
				arg_195_1.var_.characterEffect10103ui_story = var_198_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_4 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 and not isNil(var_198_3) then
				if arg_195_1.var_.characterEffect10103ui_story and not isNil(var_198_3) then
					arg_195_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect10103ui_story then
				arg_195_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_198_6 = arg_195_1.actors_["10150ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_6) and arg_195_1.var_.characterEffect10150ui_story == nil then
				arg_195_1.var_.characterEffect10150ui_story = var_198_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_7 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 and not isNil(var_198_6) then
				if arg_195_1.var_.characterEffect10150ui_story and not isNil(var_198_6) then
					arg_195_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_7)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 and not isNil(var_198_6) and arg_195_1.var_.characterEffect10150ui_story then
				arg_195_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action3_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				if not isNil(arg_195_1.actors_["10103ui_story"]) then
					local var_198_8 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_198_8 then
						var_198_8:EnableDynamicBone(true)
					end
				end
			end

			local var_198_9 = 0
			local var_198_10 = 0.425

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_9 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_11 = arg_195_1:GetWordFromCfg(322041047)
				local var_198_12 = arg_195_1:FormatText(var_198_11.content)

				arg_195_1.text_.text = var_198_12

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_14 = 17 <= 0 and var_198_10 or var_198_10 * (utf8.len(var_198_12) / 17)

				if (17 <= 0 and var_198_10 or var_198_10 * (utf8.len(var_198_12) / 17)) > 0 and var_198_10 < var_198_14 then
					arg_195_1.talkMaxDuration = var_198_14

					if var_198_14 + var_198_9 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_9
					end
				end

				arg_195_1.text_.text = var_198_12
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041047", "story_v_out_322041.awb") ~= 0 then
					local var_198_15 = manager.audio:GetVoiceLength("story_v_out_322041", "322041047", "story_v_out_322041.awb") / 1000

					if var_198_15 + var_198_9 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_15 + var_198_9
					end

					if var_198_11.prefab_name ~= "" and arg_195_1.actors_[var_198_11.prefab_name] ~= nil then
						local var_198_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_11.prefab_name].transform, "story_v_out_322041", "322041047", "story_v_out_322041.awb")

						arg_195_1:RecordAudio("322041047", var_198_16)
						arg_195_1:RecordAudio("322041047", var_198_16)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_322041", "322041047", "story_v_out_322041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_322041", "322041047", "story_v_out_322041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_17 = math.max(var_198_10, arg_195_1.talkMaxDuration)

			if var_198_9 <= arg_195_1.time_ and arg_195_1.time_ < var_198_9 + var_198_17 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_9) / var_198_17

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_9 + var_198_17 and arg_195_1.time_ < var_198_9 + var_198_17 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play322041048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322041048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322041049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10103ui_story = arg_199_1.actors_["10103ui_story"].transform.localPosition

				local var_202_0 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_0 then
					var_202_0:EnableDynamicBone(false)
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_1)
				arg_199_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10103ui_story"].transform.position).z)
				arg_199_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10103ui_story"].transform.localEulerAngles = arg_199_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10103ui_story"].transform.position).z)
				arg_199_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10103ui_story"].transform.localEulerAngles = arg_199_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_202_2 = GameObjectTools.GetOrAddComponent(arg_199_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_202_2 then
					var_202_2:EnableDynamicBone(true)
				end
			end

			local var_202_3 = arg_199_1.actors_["10150ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10150ui_story = var_202_3.localPosition

				local var_202_4 = GameObjectTools.GetOrAddComponent(var_202_3.gameObject, typeof(DynamicBoneHelper))

				if var_202_4 then
					var_202_4:EnableDynamicBone(false)
				end
			end

			local var_202_5 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 then
				var_202_3.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_5)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 then
				var_202_3.localPosition = Vector3.New(0, 100, 0)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles

				local var_202_6 = GameObjectTools.GetOrAddComponent(var_202_3.gameObject, typeof(DynamicBoneHelper))

				if var_202_6 then
					var_202_6:EnableDynamicBone(true)
				end
			end

			local var_202_7 = 0
			local var_202_8 = 1.2

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_9 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(322041048).content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 48 <= 0 and var_202_8 or var_202_8 * (utf8.len(var_202_9) / 48)

				if (48 <= 0 and var_202_8 or var_202_8 * (utf8.len(var_202_9) / 48)) > 0 and var_202_8 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_7 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_7
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_8, arg_199_1.talkMaxDuration)

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_7) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_7 + var_202_12 and arg_199_1.time_ < var_202_7 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
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
	Play322041049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322041049
		arg_203_1.duration_ = 2

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322041050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1284ui_story = arg_203_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1284ui_story"].transform.position).z)
				arg_203_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1284ui_story"].transform.localEulerAngles = arg_203_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_203_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1284ui_story"].transform.position).z)
				arg_203_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1284ui_story"].transform.localEulerAngles = arg_203_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1284ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1284ui_story == nil then
				arg_203_1.var_.characterEffect1284ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1284ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1284ui_story then
				arg_203_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action8_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_4 = 0
			local var_206_5 = 0.15

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(322041049)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 6 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 6)

				if (6 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 6)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041049", "story_v_out_322041.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041049", "story_v_out_322041.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_322041", "322041049", "story_v_out_322041.awb")

						arg_203_1:RecordAudio("322041049", var_206_11)
						arg_203_1:RecordAudio("322041049", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_322041", "322041049", "story_v_out_322041.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_322041", "322041049", "story_v_out_322041.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play322041050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322041050
		arg_207_1.duration_ = 4.03

		local var_207_0 = {
			zh = 3.666,
			ja = 4.033
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
				arg_207_0:Play322041051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1156ui_story = arg_207_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1156ui_story"].transform.position).z)
				arg_207_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1156ui_story"].transform.localEulerAngles = arg_207_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_207_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1156ui_story"].transform.position).z)
				arg_207_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1156ui_story"].transform.localEulerAngles = arg_207_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1284ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1284ui_story = var_210_1.localPosition
			end

			local var_210_2 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 then
				var_210_1.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_207_1.time_ - 0) / var_210_2)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 then
				var_210_1.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			local var_210_3 = arg_207_1.actors_["1156ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1156ui_story == nil then
				arg_207_1.var_.characterEffect1156ui_story = var_210_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_4 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 and not isNil(var_210_3) then
				if arg_207_1.var_.characterEffect1156ui_story and not isNil(var_210_3) then
					arg_207_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1156ui_story then
				arg_207_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_210_6 = arg_207_1.actors_["1284ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1284ui_story == nil then
				arg_207_1.var_.characterEffect1284ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_7 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 and not isNil(var_210_6) then
				if arg_207_1.var_.characterEffect1284ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_7)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1284ui_story then
				arg_207_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_210_8 = 0
			local var_210_9 = 0.325

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(322041050)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 13 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 13)

				if (13 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 13)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041050", "story_v_out_322041.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_322041", "322041050", "story_v_out_322041.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_322041", "322041050", "story_v_out_322041.awb")

						arg_207_1:RecordAudio("322041050", var_210_15)
						arg_207_1:RecordAudio("322041050", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_322041", "322041050", "story_v_out_322041.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_322041", "322041050", "story_v_out_322041.awb")
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
				actorName = "1156ui_story",
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

		arg_207_1:InitPlayNodeList()
	end,
	Play322041051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322041051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play322041052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1156ui_story = arg_211_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1156ui_story"].transform.position).z)
				arg_211_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1156ui_story"].transform.localEulerAngles = arg_211_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1156ui_story"].transform.position).z)
				arg_211_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1156ui_story"].transform.localEulerAngles = arg_211_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1284ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1284ui_story = var_214_1.localPosition
			end

			local var_214_2 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 then
				var_214_1.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_2)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 then
				var_214_1.localPosition = Vector3.New(0, 100, 0)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			local var_214_3 = arg_211_1.actors_["1156ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1156ui_story == nil then
				arg_211_1.var_.characterEffect1156ui_story = var_214_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_4 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 and not isNil(var_214_3) then
				if arg_211_1.var_.characterEffect1156ui_story and not isNil(var_214_3) then
					arg_211_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_4)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 and not isNil(var_214_3) and arg_211_1.var_.characterEffect1156ui_story then
				arg_211_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_211_1.time_ and arg_211_1.time_ <= 0.3 + arg_214_0 then
				arg_211_1:AudioAction("play", "effect", "se_story_birthday3", "se_story_birthday3_flame", "")
			end

			local var_214_6 = 0
			local var_214_7 = 1.5

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(322041051).content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 60 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 60)

				if (60 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_8) / 60)) > 0 and var_214_7 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_11 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_11 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_11

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_11 and arg_211_1.time_ < var_214_6 + var_214_11 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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

		arg_211_1:InitPlayNodeList()
	end,
	Play322041052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322041052
		arg_215_1.duration_ = 2.03

		local var_215_0 = {
			zh = 1.999999999999,
			ja = 2.033
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
				arg_215_0:Play322041053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1156ui_story = arg_215_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1156ui_story"].transform.position).z)
				arg_215_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1156ui_story"].transform.localEulerAngles = arg_215_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_215_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1156ui_story"].transform.position).z)
				arg_215_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1156ui_story"].transform.localEulerAngles = arg_215_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1156ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1156ui_story == nil then
				arg_215_1.var_.characterEffect1156ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1156ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1156ui_story then
				arg_215_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_218_4 = 0
			local var_218_5 = 0.125

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_6 = arg_215_1:GetWordFromCfg(322041052)
				local var_218_7 = arg_215_1:FormatText(var_218_6.content)

				arg_215_1.text_.text = var_218_7

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_9 = 5 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 5)

				if (5 <= 0 and var_218_5 or var_218_5 * (utf8.len(var_218_7) / 5)) > 0 and var_218_5 < var_218_9 then
					arg_215_1.talkMaxDuration = var_218_9

					if var_218_9 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_9 + var_218_4
					end
				end

				arg_215_1.text_.text = var_218_7
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041052", "story_v_out_322041.awb") ~= 0 then
					local var_218_10 = manager.audio:GetVoiceLength("story_v_out_322041", "322041052", "story_v_out_322041.awb") / 1000

					if var_218_10 + var_218_4 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_4
					end

					if var_218_6.prefab_name ~= "" and arg_215_1.actors_[var_218_6.prefab_name] ~= nil then
						local var_218_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_6.prefab_name].transform, "story_v_out_322041", "322041052", "story_v_out_322041.awb")

						arg_215_1:RecordAudio("322041052", var_218_11)
						arg_215_1:RecordAudio("322041052", var_218_11)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322041", "322041052", "story_v_out_322041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322041", "322041052", "story_v_out_322041.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_5, arg_215_1.talkMaxDuration)

			if var_218_4 <= arg_215_1.time_ and arg_215_1.time_ < var_218_4 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_4) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_4 + var_218_12 and arg_215_1.time_ < var_218_4 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322041053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322041053
		arg_219_1.duration_ = 4.57

		local var_219_0 = {
			zh = 3.233,
			ja = 4.566
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
				arg_219_0:Play322041054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action2_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_222_0 = 0
			local var_222_1 = 0.55

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_2 = arg_219_1:GetWordFromCfg(322041053)
				local var_222_3 = arg_219_1:FormatText(var_222_2.content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 22 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 22)

				if (22 <= 0 and var_222_1 or var_222_1 * (utf8.len(var_222_3) / 22)) > 0 and var_222_1 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041053", "story_v_out_322041.awb") ~= 0 then
					local var_222_6 = manager.audio:GetVoiceLength("story_v_out_322041", "322041053", "story_v_out_322041.awb") / 1000

					if var_222_6 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_0
					end

					if var_222_2.prefab_name ~= "" and arg_219_1.actors_[var_222_2.prefab_name] ~= nil then
						local var_222_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_2.prefab_name].transform, "story_v_out_322041", "322041053", "story_v_out_322041.awb")

						arg_219_1:RecordAudio("322041053", var_222_7)
						arg_219_1:RecordAudio("322041053", var_222_7)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_322041", "322041053", "story_v_out_322041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_322041", "322041053", "story_v_out_322041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_8 = math.max(var_222_1, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_8 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_0) / var_222_8

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_8 and arg_219_1.time_ < var_222_0 + var_222_8 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play322041054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322041054
		arg_223_1.duration_ = 3.73

		local var_223_0 = {
			zh = 3.733,
			ja = 3.4
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
				arg_223_0:Play322041055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10150ui_story = arg_223_1.actors_["10150ui_story"].transform.localPosition

				local var_226_0 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_0 then
					var_226_0:EnableDynamicBone(false)
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["10150ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10150ui_story, Vector3.New(0, -1.73, -5.5), (arg_223_1.time_ - 0) / var_226_1)
				arg_223_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10150ui_story"].transform.position).z)
				arg_223_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10150ui_story"].transform.localEulerAngles = arg_223_1.actors_["10150ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["10150ui_story"].transform.localPosition = Vector3.New(0, -1.73, -5.5)
				arg_223_1.actors_["10150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["10150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["10150ui_story"].transform.position).z)
				arg_223_1.actors_["10150ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["10150ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["10150ui_story"].transform.localEulerAngles = arg_223_1.actors_["10150ui_story"].transform.localEulerAngles

				local var_226_2 = GameObjectTools.GetOrAddComponent(arg_223_1.actors_["10150ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_226_2 then
					var_226_2:EnableDynamicBone(true)
				end
			end

			local var_226_3 = arg_223_1.actors_["1156ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1156ui_story = var_226_3.localPosition
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_3.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_4)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_3.localPosition = Vector3.New(0, 100, 0)
				var_226_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_3.position).x, (manager.ui.mainCamera.transform.position - var_226_3.position).y, (manager.ui.mainCamera.transform.position - var_226_3.position).z)
				var_226_3.localEulerAngles.z = 0
				var_226_3.localEulerAngles.x = 0
				var_226_3.localEulerAngles = var_226_3.localEulerAngles
			end

			local var_226_5 = arg_223_1.actors_["10150ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect10150ui_story == nil then
				arg_223_1.var_.characterEffect10150ui_story = var_226_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_6 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_6 and not isNil(var_226_5) then
				if arg_223_1.var_.characterEffect10150ui_story and not isNil(var_226_5) then
					arg_223_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_6 and arg_223_1.time_ < 0 + var_226_6 + arg_226_0 and not isNil(var_226_5) and arg_223_1.var_.characterEffect10150ui_story then
				arg_223_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_226_8 = arg_223_1.actors_["1156ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.characterEffect1156ui_story == nil then
				arg_223_1.var_.characterEffect1156ui_story = var_226_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_9 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_9 and not isNil(var_226_8) then
				if arg_223_1.var_.characterEffect1156ui_story and not isNil(var_226_8) then
					arg_223_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_9)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_9 and arg_223_1.time_ < 0 + var_226_9 + arg_226_0 and not isNil(var_226_8) and arg_223_1.var_.characterEffect1156ui_story then
				arg_223_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_226_10 = 0
			local var_226_11 = 0.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_12 = arg_223_1:GetWordFromCfg(322041054)
				local var_226_13 = arg_223_1:FormatText(var_226_12.content)

				arg_223_1.text_.text = var_226_13

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_15 = 8 <= 0 and var_226_11 or var_226_11 * (utf8.len(var_226_13) / 8)

				if (8 <= 0 and var_226_11 or var_226_11 * (utf8.len(var_226_13) / 8)) > 0 and var_226_11 < var_226_15 then
					arg_223_1.talkMaxDuration = var_226_15

					if var_226_15 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_15 + var_226_10
					end
				end

				arg_223_1.text_.text = var_226_13
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041054", "story_v_out_322041.awb") ~= 0 then
					local var_226_16 = manager.audio:GetVoiceLength("story_v_out_322041", "322041054", "story_v_out_322041.awb") / 1000

					if var_226_16 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_10
					end

					if var_226_12.prefab_name ~= "" and arg_223_1.actors_[var_226_12.prefab_name] ~= nil then
						local var_226_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_12.prefab_name].transform, "story_v_out_322041", "322041054", "story_v_out_322041.awb")

						arg_223_1:RecordAudio("322041054", var_226_17)
						arg_223_1:RecordAudio("322041054", var_226_17)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_322041", "322041054", "story_v_out_322041.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_322041", "322041054", "story_v_out_322041.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_18 = math.max(var_226_11, arg_223_1.talkMaxDuration)

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_18 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_10) / var_226_18

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_10 + var_226_18 and arg_223_1.time_ < var_226_10 + var_226_18 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322041055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322041055
		arg_227_1.duration_ = 8.47

		local var_227_0 = {
			zh = 4.733,
			ja = 8.466
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
				arg_227_0:Play322041056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_230_0 = 0
			local var_230_1 = 0.375

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1361].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(322041055)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 15 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 15)

				if (15 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 15)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041055", "story_v_out_322041.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_out_322041", "322041055", "story_v_out_322041.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_out_322041", "322041055", "story_v_out_322041.awb")

						arg_227_1:RecordAudio("322041055", var_230_7)
						arg_227_1:RecordAudio("322041055", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_322041", "322041055", "story_v_out_322041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_322041", "322041055", "story_v_out_322041.awb")
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
	Play322041056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322041056
		arg_231_1.duration_ = 5.13

		local var_231_0 = {
			zh = 5.133,
			ja = 3.166
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
				arg_231_0:Play322041057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1156ui_story = arg_231_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1156ui_story"].transform.position).z)
				arg_231_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1156ui_story"].transform.localEulerAngles = arg_231_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_231_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1156ui_story"].transform.position).z)
				arg_231_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1156ui_story"].transform.localEulerAngles = arg_231_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["10150ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10150ui_story = var_234_1.localPosition

				local var_234_2 = GameObjectTools.GetOrAddComponent(var_234_1.gameObject, typeof(DynamicBoneHelper))

				if var_234_2 then
					var_234_2:EnableDynamicBone(false)
				end
			end

			local var_234_3 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 then
				var_234_1.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10150ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_3)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 then
				var_234_1.localPosition = Vector3.New(0, 100, 0)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles

				local var_234_4 = GameObjectTools.GetOrAddComponent(var_234_1.gameObject, typeof(DynamicBoneHelper))

				if var_234_4 then
					var_234_4:EnableDynamicBone(true)
				end
			end

			local var_234_5 = arg_231_1.actors_["1156ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1156ui_story == nil then
				arg_231_1.var_.characterEffect1156ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_6 and not isNil(var_234_5) then
				if arg_231_1.var_.characterEffect1156ui_story and not isNil(var_234_5) then
					arg_231_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_6 and arg_231_1.time_ < 0 + var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1156ui_story then
				arg_231_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_234_8 = arg_231_1.actors_["10150ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.characterEffect10150ui_story == nil then
				arg_231_1.var_.characterEffect10150ui_story = var_234_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_9 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_9 and not isNil(var_234_8) then
				if arg_231_1.var_.characterEffect10150ui_story and not isNil(var_234_8) then
					arg_231_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_9)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_9 and arg_231_1.time_ < 0 + var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.characterEffect10150ui_story then
				arg_231_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10150ui_story.fillRatio = 0.5
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156actionlink/1156action423")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_234_10 = 0
			local var_234_11 = 0.225

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_12 = arg_231_1:GetWordFromCfg(322041056)
				local var_234_13 = arg_231_1:FormatText(var_234_12.content)

				arg_231_1.text_.text = var_234_13

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_15 = 9 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 9)

				if (9 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 9)) > 0 and var_234_11 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15

					if var_234_15 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_10
					end
				end

				arg_231_1.text_.text = var_234_13
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322041", "322041056", "story_v_out_322041.awb") ~= 0 then
					local var_234_16 = manager.audio:GetVoiceLength("story_v_out_322041", "322041056", "story_v_out_322041.awb") / 1000

					if var_234_16 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_16 + var_234_10
					end

					if var_234_12.prefab_name ~= "" and arg_231_1.actors_[var_234_12.prefab_name] ~= nil then
						local var_234_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_12.prefab_name].transform, "story_v_out_322041", "322041056", "story_v_out_322041.awb")

						arg_231_1:RecordAudio("322041056", var_234_17)
						arg_231_1:RecordAudio("322041056", var_234_17)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_322041", "322041056", "story_v_out_322041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_322041", "322041056", "story_v_out_322041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = math.max(var_234_11, arg_231_1.talkMaxDuration)

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_18 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_10) / var_234_18

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_10 + var_234_18 and arg_231_1.time_ < var_234_10 + var_234_18 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play322041057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322041057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322041058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_9000

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1156ui_story = arg_235_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1156ui_story"].transform.position).z)
				arg_235_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1156ui_story"].transform.localEulerAngles = arg_235_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1156ui_story"].transform.position).z)
				arg_235_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1156ui_story"].transform.localEulerAngles = arg_235_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if 0.25 < arg_235_1.time_ and arg_235_1.time_ <= 0.25 + arg_238_0 then
				arg_235_1:AudioAction("play", "effect", "se_story_145", "se_story_145_thunder", "")
			end

			if 0.25 < arg_235_1.time_ and arg_235_1.time_ <= 0.25 + arg_238_0 then
				local var_238_2 = arg_235_1.var_.effect1057

				if not arg_235_1.var_.effect1057 then
					var_238_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_238_2.name = "1057"
					arg_235_1.var_.effect1057 = var_238_2
				else
					var_238_2.transform:SetParent(var_238_9000)
				end

				var_238_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_238_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.26666666666667 < arg_235_1.time_ and arg_235_1.time_ <= 1.26666666666667 + arg_238_0 then
				if arg_235_1.var_.effect1057 then
					Object.Destroy(arg_235_1.var_.effect1057)

					arg_235_1.var_.effect1057 = nil
				end
			end

			local var_238_5 = manager.ui.mainCamera.transform

			if 1.26666666666667 < arg_235_1.time_ and arg_235_1.time_ <= 1.26666666666667 + arg_238_0 then
				arg_235_1.var_.shakeOldPos = var_238_5.localPosition
			end

			local var_238_6 = 0.566666666666667

			if 1.26666666666667 <= arg_235_1.time_ and arg_235_1.time_ < 1.26666666666667 + var_238_6 then
				local var_238_7, var_238_8 = math.modf((arg_235_1.time_ - 1.26666666666667) / 0.066)

				var_238_5.localPosition = Vector3.New(var_238_8 * 0.13, var_238_8 * 0.13, var_238_8 * 0.13) + arg_235_1.var_.shakeOldPos
			end

			if arg_235_1.time_ >= 1.26666666666667 + var_238_6 and arg_235_1.time_ < 1.26666666666667 + var_238_6 + arg_238_0 then
				var_238_5.localPosition = arg_235_1.var_.shakeOldPos
			end

			local var_238_9 = 0
			local var_238_10 = 1.25

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_9 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_11 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(322041057).content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 50 <= 0 and var_238_10 or var_238_10 * (utf8.len(var_238_11) / 50)

				if (50 <= 0 and var_238_10 or var_238_10 * (utf8.len(var_238_11) / 50)) > 0 and var_238_10 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_9 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_9
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_10, arg_235_1.talkMaxDuration)

			if var_238_9 <= arg_235_1.time_ and arg_235_1.time_ < var_238_9 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_9) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_9 + var_238_14 and arg_235_1.time_ < var_238_9 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322041058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322041058
		arg_239_1.duration_ = 6.1

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
			arg_239_1.auto_ = false
		end

		function arg_239_1.playNext_(arg_241_0)
			arg_239_1.onStoryFinished_()
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_9000

			if 0.1 < arg_239_1.time_ and arg_239_1.time_ <= 0.1 + arg_242_0 then
				arg_239_1:AudioAction("play", "effect", "se_story_145", "se_story_145_explosion02", "")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				local var_242_1 = arg_239_1.var_.effect1058

				if not arg_239_1.var_.effect1058 then
					var_242_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_242_1.name = "1058"
					arg_239_1.var_.effect1058 = var_242_1
				else
					var_242_1.transform:SetParent(var_242_9000)
				end

				var_242_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_242_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_3 = 1.1
			local var_242_4 = 1.4

			if 1.1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_3 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_5 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_5:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(322041058).content)

				arg_239_1.text_.text = var_242_6

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_8 = 56 <= 0 and var_242_4 or var_242_4 * (utf8.len(var_242_6) / 56)

				if (56 <= 0 and var_242_4 or var_242_4 * (utf8.len(var_242_6) / 56)) > 0 and var_242_4 < var_242_8 then
					arg_239_1.talkMaxDuration = var_242_8
					var_242_3 = var_242_3 + 0.3

					if var_242_8 + var_242_3 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_3
					end
				end

				arg_239_1.text_.text = var_242_6
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_9 = var_242_3 + 0.3
			local var_242_10 = math.max(var_242_4, arg_239_1.talkMaxDuration)

			if var_242_3 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_9) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_9 + var_242_10 and arg_239_1.time_ < var_242_9 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/L15f"
	},
	voices = {
		"story_v_out_322041.awb"
	}
}
